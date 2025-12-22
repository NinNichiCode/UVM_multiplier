class mul_scoreboard extends uvm_scoreboard;
   `uvm_component_utils(mul_scoreboard)
    
    uvm_analysis_imp #(mul_item, mul_scoreboard) item_got_imp;

   function new (string name = "mul_scoreboard", uvm_component parent = null);
      super.new(name, parent);
      item_got_imp = new("item_got_imp", this);
   endfunction

   virtual function void write(mul_item tr);
      if(tr.y == (tr.a * tr.b))
	  `uvm_info("SCO", $sformatf("Test Passed -> a = %0d, b = %0d, y = %0d", tr.a, tr.b, tr.y), UVM_NONE)
      else 
	  `uvm_error("SCO", $sformatf("Test Failed -> a = %0d, b= %0d, y = %0d", tr.a, tr.b, tr.y))
      
      $display("-----------------------------------------------------------------");
   endfunction

 endclass
   
