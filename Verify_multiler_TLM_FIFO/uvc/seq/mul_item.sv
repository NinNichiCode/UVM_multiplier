class mul_item extends uvm_sequence_item;

  rand bit [3:0] a;
  rand bit [3:0] b;
  rand bit [7:0] y;

`uvm_object_utils_begin(mul_item)
  `uvm_field_int(a, UVM_DEFAULT)
  `uvm_field_int(b, UVM_DEFAULT)
  `uvm_field_int(y, UVM_DEFAULT)
`uvm_object_utils_end

  function new (string name = "mul_item");
     super.new(name);
  endfunction
 endclass


