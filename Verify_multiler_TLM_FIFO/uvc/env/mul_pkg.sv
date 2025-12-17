package mul_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  `include "../seq/mul_item.sv"
  `include "./mul_driver.sv"
  `include "./mul_monitor.sv"
  `include "./mul_golden.sv"
  `include "./mul_agent.sv"
  `include "./mul_scoreboard.sv"
  `include "./mul_env.sv"

  `include "../seq/mul_seq.sv"
  `include "../tests/base_test.sv"
  `include "../tests/mul_test.sv"

endpackage
