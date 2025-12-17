`timescale 1ns/1ps

`include "uvm_macros.svh"
import uvm_pkg::*;
import mul_pkg::*;
// `include "../mul.v"
// `include "../tb/mul_if.sv"

module top;
logic clk;
 
 // Tạo clock
 initial begin 
   clk = 0;
   forever #5 clk = ~clk;
 end

 // Truyền clk vào interface
 mul_if vif(clk);
 mul dut(.a(vif.a), .b(vif.b), .y(vif.y));

 //initial begin 
 //  vif.clk = 0;
 //  forever #5 vif.clk = ~vif.clk;
 //end

 initial begin
    uvm_config_db #(virtual mul_if)::set(null,"*","vif", vif);
    run_test();
 end


 endmodule



