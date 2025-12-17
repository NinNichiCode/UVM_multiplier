// `include "uvm_macros.svh"
// import uvm_pkg::*;
// import mul_pkg::*;
class mul_seq extends uvm_sequence#(mul_item);
  `uvm_object_utils(mul_seq)

  function new (string name = "mul_seq");
    super.new(name);
  endfunction


  virtual task body();
    mul_item req;

    repeat(20) begin
  //     if(!randomize())
	//  `uvm_error("RAND FAIL", "Randomize failed");
      
      `uvm_do_with(req, {
	a == 4'd2;
	 });
      end

    `uvm_info("SEQ", "mul_seq complete", UVM_MEDIUM);

  endtask

  endclass
