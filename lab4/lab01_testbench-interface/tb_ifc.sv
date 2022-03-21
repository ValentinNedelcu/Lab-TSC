/***********************************************************************
 * A SystemVerilog testbench for an instruction register; This file
 * contains the interface to connect the testbench to the design
 **********************************************************************/
interface tb_ifc (input logic clk);
  //timeunit 1ns/1ns;

  // user-defined types are defined in instr_register_pkg.sv
  import instr_register_pkg::*;

  // ADD CODE TO DECLARE THE INTERFACE SIGNALS
  logic          load_en;
  logic          reset_n;
  opcode_t       opcode;
  operand_t      operand_a, operand_b;
  address_t      write_pointer, read_pointer;
  instruction_t  instruction_word;

 modport tb(
   clocking cb

  output  logic          clk,
 output load_en,
 output reset_n,
 output operand_a,
 output operand_b,
 output opcode,
 output write_pointer,
 output read_pointer,
 input instruction_word
 );

 modport dut(
   input  logic          clk,
 input  logic          load_en,
 input  logic          reset_n,
 input operand_t      operand_a,
 input operand_t      operand_b,
 input opcode_t       opcode,
 input address_t      write_pointer,
 input address_t      read_pointer,
 output instruction_t  instruction_word
 );

 clocking cb@(posedge clk);
  input reset_n;
  input reset_en;
  load_read_pointer;
  endclocking

  endinterface: tb_ifc

endinterface: tb_ifc