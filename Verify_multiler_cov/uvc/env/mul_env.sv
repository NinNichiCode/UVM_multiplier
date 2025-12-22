class mul_env extends uvm_env;
  `uvm_component_utils(mul_env)

  function new (string name = "mul_env", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  mul_agent agent;
  mul_scoreboard scoreboard;
  mul_coverage cov;

  virtual function void build_phase (uvm_phase phase);
     super.build_phase(phase);
     agent = mul_agent::type_id::create("agent", this);
     scoreboard = mul_scoreboard::type_id::create("scoreboard", this);
     cov = mul_coverage::type_id::create("cov", this);
 endfunction

  virtual function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
     agent.monitor.item_send_port.connect(scoreboard.item_got_imp);
     agent.monitor.item_send_port.connect(cov.analysis_export);
  endfunction
 
 endclass
