class mul_driver extends uvm_driver#(mul_item);
  `uvm_component_utils(mul_driver)

   function new (string name = "mul_driver", uvm_component parent = null);
      super.new(name, parent);
   endfunction


  mul_item transaction;
  virtual mul_if vif;

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
       transaction = mul_item::type_id::create("transaction", this);
      if(!uvm_config_db#(virtual mul_if)::get(this, "", "vif", vif)) begin
         `uvm_fatal("DRV", "Unable to access interface")
      end
   endfunction


//    virtual task run_phase(uvm_phase phase);
//       forever begin
       
//            seq_item_port.get_next_item(transaction);
//  @(posedge vif.clk);

//       vif.a <= transaction.a;
// 	   vif.b <= transaction.b;
// 	   // vif.y <= transaction.y;
//            seq_item_port.item_done();
//       end

//    endtask

   virtual task run_phase(uvm_phase phase);
      forever begin
         // Lấy transaction từ Sequencer
         seq_item_port.get_next_item(transaction);
         
         // 1. Đợi cạnh clock thông qua clocking block
         @(vif.driver_cb);

         // 2. Lái tín hiệu (sẽ trễ 1ns so với cạnh clock thực tế)
         vif.driver_cb.a <= transaction.a;
         vif.driver_cb.b <= transaction.b;
         // KHÔNG lái vif.y vì y là output của DUT

         seq_item_port.item_done();
      end
   endtask

 endclass
