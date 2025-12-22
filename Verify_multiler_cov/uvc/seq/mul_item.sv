class mul_item extends uvm_sequence_item;
  `uvm_object_utils(mul_item)

  randc bit [3:0] a;
  randc bit [3:0] b;
   bit [7:0] y;

  function new (string name = "mul_item");
     super.new(name);
  endfunction
 endclass


