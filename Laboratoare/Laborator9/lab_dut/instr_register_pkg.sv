/***********************************************************************
 * A SystemVerilog RTL model of an instruction regisgter:
 * User-defined type definitions
 **********************************************************************/
package instr_register_pkg;
  //timeunit 1ns;1ns;

  typedef enum logic [3:0] {
  	ZERO,
    PASSA, //ia val lui A
    PASSB, // ia val lui B
    ADD, //aduna valoarile
    SUB, //scadere
    MULT, // inmultire
    DIV, //divizare
    MOD
  } opcode_t;

  typedef logic signed [31:0] operand_t;
  typedef logic signed [63:0] result_t;
  
  typedef logic [4:0] address_t;
  

  typedef struct {
    opcode_t  opc; // ne spune ce operatie vom face
    operand_t op_a;
    operand_t op_b;
    result_t result;

  } instruction_t; // instruction_t-UN package

endpackage: instr_register_pkg
