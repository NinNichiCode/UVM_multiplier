class mul_golden extends uvm_monitor;
   `uvm_component_utils(mul_golden)

   uvm_analysis_port#(mul_item) item_golden_port;
   virtual mul_if vif;
   mul_item transaction;

   function new (string name = "mul_golden", uvm_component parent = null);
      super.new(name, parent);
      item_golden_port = new("item_golden_port", this);
   endfunction


   virtual function void build_phase(uvm_phase phase);
     super.build_phase(phase);
     
     if(!uvm_config_db#(virtual mul_if)::get(this, "", "vif", vif))
	 `uvm_fatal("GOLDEN", "cannot access interface");

     endfunction


   function void predict();
      transaction.y = transaction.a * transaction.b;
   endfunction

   virtual task run_phase(uvm_phase phase);
      forever begin
         @(posedge vif.clk);
         transaction = mul_item::type_id::create("transaction", this);
       transaction.a = vif.a;
	transaction.b = vif.b;
         predict();

        item_golden_port.write(transaction);
      end
   endtask

  endclass 


