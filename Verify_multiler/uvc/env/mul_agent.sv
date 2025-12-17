class mul_agent extends uvm_agent;
  `uvm_component_utils(mul_agent)

  mul_driver driver;
  mul_monitor monitor;
  uvm_sequencer#(mul_item) seqr;

  function new (string name = "mul_agent", uvm_component parent = null);
     super.new(name, parent);
  endfunction


  virtual function void build_phase (uvm_phase phase);
     super.build_phase(phase);
     driver = mul_driver::type_id::create("driver", this);
     monitor = mul_monitor::type_id::create("monitor", this);
     seqr = uvm_sequencer#(mul_item)::type_id::create("seqr", this);
  endfunction

  virtual function void connect_phase (uvm_phase phase);
     super.connect_phase(phase);
     driver.seq_item_port.connect(seqr.seq_item_export);
  endfunction

endclass


