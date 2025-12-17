class mul_scoreboard extends uvm_scoreboard;
   `uvm_component_utils(mul_scoreboard)
    
    mul_item tr, tr_golden;

  //  uvm_analysis_imp #(mul_item, mul_scoreboard) item_got_imp;
    uvm_tlm_analysis_fifo #(mul_item) item_got_imp;
    uvm_tlm_analysis_fifo #(mul_item) item_golden_imp;

   function new (string name = "mul_scoreboard", uvm_component parent = null);
      super.new(name, parent);
    
      item_got_imp = new("item_got_imp", this);
      item_golden_imp = new("item_golden_imp", this);
   endfunction

//   virtual function void write(mul_item tr);
//      if(tr.y == (tr.a * tr.b))
//	  `uvm_info("SCO", $sformatf("Test Passed -> a = %0d, b = %0d, y = %0d", tr.a, tr.b, tr.y), UVM_NONE)
//      else 
//	  `uvm_error("SCO", $sformatf("Test Failed -> a = %0d, b= %0d, y = %0d", tr.a, tr.b, tr.y))
      
//      $display("-----------------------------------------------------------------");
//   endfunction
  
    virtual task run_phase(uvm_phase phase);
       forever begin
//          tr = mul_item::type_id::create("tr");
//	  tr_golden = mul_item::type_id::create("tr_golden");

	  item_got_imp.get(tr);
	  item_golden_imp.get(tr_golden);

	  if(tr.compare(tr_golden))
	    `uvm_info("SCO", $sformatf("Test Passed -> a = %0d, b = %0d, y = %0d \n ___________________________________________________________----------------------------_a_golden = %0d, b_golden = %0d, y_golden = %0d", tr.a, tr.b, tr.y, tr_golden.a, tr_golden.b, tr_golden.y), UVM_NONE)
          
	  else 
       	    `uvm_error("SCO", $sformatf("Test Failed -> a = %0d, b= %0d, y = %0d", tr.a, tr.b, tr.y))
        end
     endtask
 endclass
   
