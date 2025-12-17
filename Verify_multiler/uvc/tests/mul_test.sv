`include "uvm_macros.svh"
import uvm_pkg::*;
import mul_pkg::*;
class mul_test extends base_test;
  `uvm_component_utils(mul_test)

  function new(string name = "mul_test", uvm_component parent = null);
     super.new(name, parent);
  endfunction

  virtual task run_test_sequence();
      mul_seq seq;
      seq = mul_seq::type_id::create("seq");
      seq.start(env.agent.seqr);
  endtask

 endclass
  
