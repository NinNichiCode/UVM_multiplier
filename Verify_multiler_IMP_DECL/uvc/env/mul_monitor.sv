class mul_monitor extends uvm_monitor;
   `uvm_component_utils(mul_monitor)

   virtual mul_if vif;
   mul_item transaction;
   uvm_analysis_port #(mul_item) item_send_port;

   function new (string name = "mul_monitor", uvm_component parent = null);
     super.new(name, parent);
     item_send_port = new("item_send_port", this);
   endfunction


   virtual function void build_phase(uvm_phase phase);
     super.build_phase(phase);

     if(!uvm_config_db#(virtual mul_if)::get(this,"","vif", vif)) begin
	      `uvm_fatal("MON", "Unable to access interface");
      end
   endfunction


   virtual task run_phase(uvm_phase phase);
     forever begin 
           transaction = mul_item::type_id::create("transaction");
       @(posedge vif.clk); 

       transaction.a = vif.a;
       transaction.b = vif.b;
       transaction.y = vif.y;
       
       item_send_port.write(transaction);
     end
    endtask

 endclass
