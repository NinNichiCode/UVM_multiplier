
class mul_seq extends uvm_sequence#(mul_item);
  `uvm_object_utils(mul_seq)

  function new (string name = "mul_seq");
    super.new(name);
  endfunction


  virtual task body();
    mul_item req;

   req = mul_item::type_id::create("req");

//    repeat(50) begin
//      `uvm_do(req)
//      end
repeat (1000) begin
  start_item(req);
  assert(req.randomize());
  `uvm_info("SEQ_DBG", $sformatf("a = %0d", req.a), UVM_NONE)
  finish_item(req);
end

 

    `uvm_info("SEQ", "mul_seq complete", UVM_MEDIUM);

  endtask

  endclass
