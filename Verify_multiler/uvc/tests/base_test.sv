`include "uvm_macros.svh"
import uvm_pkg::*;
import mul_pkg::*;
class base_test extends uvm_test;
  `uvm_component_utils(base_test)

 mul_env env;
  bit test_pass;

  function new (string name = "base_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction


  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = mul_env::type_id::create("env", this);
  endfunction


  virtual task run_phase (uvm_phase phase);
     phase.raise_objection(this);
        run_test_sequence();
     phase.drop_objection(this);
  endtask


  virtual task run_test_sequence();

    `uvm_fatal("BASE_TEST", "Cannot run run_test_sequence");
  endtask


  function void end_of_elaboration();
    uvm_top.print_topology();
  endfunction


  function void report_phase(uvm_phase phase);
    int error_cnt;
    uvm_report_server server;
    server = uvm_report_server::get_server();
   
    error_cnt = server.get_severity_count(UVM_FATAL) +
                 server.get_severity_count(UVM_ERROR);

    // test_pass = (error_cnt == 0);

    if (error_cnt == 0)
      `uvm_info(get_type_name(), "** TEST PASSED **", UVM_NONE)
    else
      `uvm_error(get_type_name(), "** TEST FAILED **")
  endfunction

endclass

