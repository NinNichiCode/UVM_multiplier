// // interface mul_if;

// interface mul_if(input logic clk);
//   logic [3:0] a;
//   logic [3:0] b;
//   logic [7:0] y;
  
// endinterface

`timescale 1ns/1ps
interface mul_if(input logic clk);
  logic [3:0] a;
  logic [3:0] b;
  logic [7:0] y;

  // Clocking Block cho Driver
  // Lái tín hiệu sau cạnh lên 1ns (Output Skew)
//   bỏ dòng default đi là hoàn toàn hợp lệ về mặt cú pháp.
// Input: Vẫn an toàn tuyệt đối (#1step).
// Output: Trở về #0. Với code RTL mô phỏng chức năng thì OK, không vấn đề gì cả.


  clocking driver_cb @(posedge clk);
    // default input #1ns;
    output a;
    output b;
  endclocking

  // Clocking Block cho Monitor
  // Lấy mẫu tín hiệu trước cạnh lên (Input Skew)
  clocking monitor_cb @(posedge clk);
    // default input #1step;
    input a;
    input b;
    input y;
  endclocking

endinterface