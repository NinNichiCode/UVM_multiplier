
`uvm_analysis_imp_decl(_dut)
`uvm_analysis_imp_decl(_golden)

class mul_scoreboard extends uvm_scoreboard;
   `uvm_component_utils(mul_scoreboard)

  uvm_analysis_imp_dut    #(mul_item, mul_scoreboard) dut_imp;
  uvm_analysis_imp_golden #(mul_item, mul_scoreboard) golden_imp;

  mul_item dut_q[$];
  mul_item golden_q[$];
  int pass = 0;
  int fail = 0;

  function new(string name="mul_scoreboard", uvm_component parent=null);
    super.new(name, parent);
    dut_imp    = new("dut_imp", this);
    golden_imp = new("golden_imp", this);
  endfunction

function void write_dut(mul_item t);
  mul_item c = mul_item::type_id::create("c");
  c.copy(t);
  dut_q.push_back(c);
  compare_if_ready();
endfunction

function void write_golden(mul_item t);
  mul_item c = mul_item::type_id::create("c");
  c.copy(t);
  golden_q.push_back(c);
  compare_if_ready();
endfunction

function void compare_if_ready();
  mul_item tr, tr_gol;

  if(dut_q.size() > 0 && golden_q.size() > 0) begin
    tr    = dut_q.pop_front();
    tr_gol = golden_q.pop_front();

    if(tr.compare(tr_gol)) begin
      `uvm_info("SCO_decl",
        $sformatf("PASS a=%0d b=%0d y=%0d", tr.a, tr.b, tr.y), UVM_NONE)
      pass++;
    end
    else begin
      `uvm_error("SCO_decl", $sformatf("FAIL a=%0d b=%0d y=%0d exp=%0d", tr.a, tr.b, tr.y, tr_gol.y))
      fail++;
    end
  end
endfunction


  function void check_phase(uvm_phase phase);
    super.check_phase(phase);
    if(dut_q.size() > 0 || golden_q.size() > 0) begin
      `uvm_error("SCO_PENDING", $sformatf("Test ended with items still in queue! DUT:%0d, GOLDEN:%0d", 
                dut_q.size(), golden_q.size()))
    end
    $display("**********************************");
    `uvm_info("SCO_REPORT", $sformatf("Final Report: PASS=%0d, FAIL=%0d", pass, fail), UVM_LOW)
    $display("**********************************");
  endfunction


endclass
   
