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
     transaction = mul_item::type_id::create("transaction");
     if(!uvm_config_db#(virtual mul_if)::get(this,"","vif", vif)) begin
	      `uvm_fatal("MON", "Unable to access interface");
      end
   endfunction


  //  virtual task run_phase(uvm_phase phase);
  //    forever begin 
  //      @(posedge vif.clk); 

  //      transaction.a = vif.a;
  //      transaction.b = vif.b;
  //      transaction.y = vif.y;
       
  //      item_send_port.write(transaction);
  //    end
  //   endtask

   virtual task run_phase(uvm_phase phase);
     // Tạo object transaction MỚI trong mỗi vòng lặp để tránh lỗi ghi đè dữ liệu
    //  mul_item trans_sampled; 

     forever begin 
       // 1. Đợi cạnh clock tiếp theo
       @(vif.monitor_cb); 

       // 2. Kiểm tra xem tín hiệu có valid không (nếu cần)
       // Ở đây ta cứ lấy mẫu liên tục
       
      //  trans_sampled = mul_item::type_id::create("trans_sampled");
       
       // Lấy mẫu qua clocking block (Input Skew - lấy giá trị ổn định trước cạnh clock)
       transaction.a = vif.monitor_cb.a;
       transaction.b = vif.monitor_cb.b;
       transaction.y = vif.monitor_cb.y;
       
       // 3. Gửi đi Scoreboard
       item_send_port.write(transaction);
     end
    endtask

 endclass

 