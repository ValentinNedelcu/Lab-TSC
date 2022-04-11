/***********************************************************************
 * A SystemVerilog testbench for an instruction register.
 * The course labs will convert this to an object-oriented testbench
 * with constrained random test generation, functional coverage, and
 * a scoreboard for self-verification.
 **********************************************************************/

module instr_register_test
// user-defined types are defined in instr_register_pkg.sv
  import instr_register_pkg::*;  
  (
	tb_ifc.TB intf_lab 
  );

  

  //timeunit 1ns/1ns;
  //seed-ul reprezinta valoarea initiala cu care se va incepe randomizarea


class Transaction;
virtual tb_ifc.TB intf_lab;

parameter number_of_op <= 100;

function new(virtual tb_ifc.TB interfata_lab);
intf_lab = interfata_lab;
endfunction



  //int seed = 555;

//aici vom lucra cu semnale incepem cu 0
  //initial begin 
  


  
  task run();
    $display("\n\n***********************************************************");
    $display(    "***  THIS IS NOT A SELF-CHECKING TESTBENCH (YET).  YOU  ***");
    $display(    "***  NEED TO VISUALLY VERIFY THAT THE OUTPUT VALUES     ***");
    $display(    "***  MATCH THE INPUT VALUES FOR EACH REGISTER LOCATION  ***");
    $display(    "***********************************************************");


    $display("\nReseting the instruction register...");
    intf_lab.cb.write_pointer  <= 5'h00;         // initialize write pointer
    intf_lab.cb.read_pointer   <= 5'h1F;         // initialize read pointer
    intf_lab.cb.load_en        <= 1'b0;          // initialize load control line
    intf_lab.cb.reset_n       <= 1'b0;          // assert reset_n (active low)
    repeat (50) @(posedge intf_lab.cb) ;     // hold in reset for 2 clock cycles
    intf_lab.cb.reset_n        <= 1'b1;          // deassert reset_n (active low)

    $display("\nWriting values to register stack...");
    @(posedge intf_lab.cb) intf_lab.cb.load_en <= 1'b1;  // enable writing to register
    repeat (50) begin
      @(posedge intf_lab.cb) randomize_transaction;
      @(negedge intf_lab.cb) print_transaction;   //printeaza in transcript consola
    end
    @(posedge intf_lab.cb) intf_lab.cb.load_en <= 1'b0;  // turn-off writing to register

    // read back and display same three register locations
    $display("\nReading back the same register locations written...");
    for (int i=0; i<=9; i++) begin
      // later labs will replace this loop with iterating through a
      // scoreboard to determine which addresses were written and
      // the expected values to be read back
      @(posedge intf_lab.cb) intf_lab.cb.read_pointer <= i;
      @(negedge intf_lab.cb) print_results;
    end

    @(posedge intf_lab.cb) ;
    $display("\n***********************************************************");
    $display(  "***  THIS IS NOT A SELF-CHECKING TESTBENCH (YET).  YOU  ***");
    $display(  "***  NEED TO VISUALLY VERIFY THAT THE OUTPUT VALUES     ***");
    $display(  "***  MATCH THE INPUT VALUES FOR EACH REGISTER LOCATION  ***");
    $display(  "***********************************************************\n");
    $finish;
  //end
    endtask

  function void randomize_transaction;
    // A later lab will replace this function with SystemVerilog
    // constrained random values
    //
    // The stactic temp variable is required in order to write to fixed
    // addresses of 0, 1 and 2.  This will be replaceed with randomizeed
    // write_pointer values in a later lab
    //
    static int temp = 0;
    intf_lab.cb.operand_a     <= $urandom;                 // between -15 and 15
    intf_lab.cb.operand_b     <= $unsigned($urandom)%16;            // between 0 and 15
    intf_lab.cb.opcode        <= opcode_t'($unsigned($urandom)%8);  // between 0 and 7, cast to opcode_t type
    intf_lab.cb.write_pointer <= temp++;
  endfunction: randomize_transaction

  function void print_transaction;
    $display("Writing to register location %0d: ", intf_lab.cb.write_pointer);
    $display("  opcode = %0d (%s)", intf_lab.cb.opcode, intf_lab.cb.opcode.name);
    $display("  operand_a = %0d",   intf_lab.cb.operand_a);
    $display("  operand_b = %0d\n", intf_lab.cb.operand_b);
  endfunction: print_transaction

  function void print_results;
    $display("Read from register location %0d: ", intf_lab.cb.read_pointer);
    $display("  opcode = %0d (%s)", intf_lab.cb.instruction_word.opc, intf_lab.cb.instruction_word.opc.name);
    $display("  operand_a = %0d",   intf_lab.cb.instruction_word.op_a); // accesam semnalelel din packege
    $display("  operand_b = %0d\n", intf_lab.cb.instruction_word.op_b);
    $display("  result    = %0d\n", intf_lab.cb.instruction_word.op_res);
  endfunction: print_results

covergroup my_cov;
  coverpoint op_a{
  bins neg = {[-15:-1]};
  bins zero = {0};
  bins pos = {[1:15]}; 
  }

coverpoint (op_b) {
bins zero = {0};
bins pos = {1:15};
} 

coverpoint (opcode) {
  bins 
}


endclass: Transaction

initial begin

Transaction tr;
tr = new(intf_lab);

tr.run(); 
  end

endmodule: instr_register_test