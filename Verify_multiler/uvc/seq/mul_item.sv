class mul_item extends uvm_sequence_item;
  `uvm_object_utils(mul_item)

  rand bit [3:0] a;
  rand bit [3:0] b;
  rand bit [7:0] y;

  function new (string name = "mul_item");
     super.new(name);
  endfunction
 endclass


