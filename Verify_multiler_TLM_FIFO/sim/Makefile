LIB = work_multiplier

TB_DIR = ../tb
UVC_DIR = ../uvc
RTL_DIR = ../

INCDIRS = +incdir+$(UVC_DIR)/env +incdir+$(UVC_DIR)/seq +incdir+$(UVC_DIR)/tests 

TESTS = mul_test

all: compile regress assumary

compile: 
	@echo "compiling"
	vlib $(LIB)
	vmap work $(LIB)
	vlog -work work -sv $(TB_DIR)/mul_if.sv $(RTL_DIR)/mul.v
	vlog -work work -sv $(INCDIRS) $(UVC_DIR)/env/mul_pkg.sv
	vlog -work work -sv $(TB_DIR)/top.sv

regress:
	@echo "regress"
	mkdir -p logs
	@for t in $(TESTS); do \
	vsim -c top +UVM_TESTNAME=$$t -l logs/$$t.log -do "run -all;quit -f"; \
	done

assumary:
	@echo ""
	@echo "PASS"
	@grep -l "TEST PASSED" logs/*.log | sed 's#.*/##'
	@echo ""
	@echo "FAIL"
	@grep -L "TEST PASSED" logs/*.log | sed 's#.*/##'

clean:
	rm -rf $(LIB) transcript logs *.log modelsim.ini

.PHONY: all compile regress assumary clean



