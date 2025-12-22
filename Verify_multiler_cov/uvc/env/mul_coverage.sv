class mul_coverage extends uvm_subscriber #(mul_item);
   `uvm_component_utils(mul_coverage)
   mul_item trans;

   covergroup cov_inst ;
       option.per_instance = 1;

       CP_A : coverpoint trans.a{
		bins a_corners[] = {4'h0, 4'h1, 4'hf, 4'ha, 4'h5};
		bins a_ranges[4] = {[4'h0:4'hf]};
	}

       CP_B : coverpoint trans.b{
		bins b_corners[] = {4'h0, 4'h1, 4'hf, 4'ha, 4'h5};
		bins b_ranges[4] = {[4'h0:4'hf]};
	}

CROSS_CORNERS: cross CP_A, CP_B {
    // 1. Kiểm tra 0 nhân với mọi corner khác (và ngược lại)
    bins mul_by_zero = binsof(CP_A.a_corners) intersect {0} || 
                       binsof(CP_B.b_corners) intersect {0};

    // 2. Kiểm tra 1 nhân với mọi corner khác (kiểm tra tính nguyên vẹn)
    bins mul_by_one  = binsof(CP_A.a_corners) intersect {1} || 
                       binsof(CP_B.b_corners) intersect {1};

    // 3. Trường hợp khó nhất: Max * Max
    bins max_mult    = binsof(CP_A.a_corners) intersect {4'hF} && 
                       binsof(CP_B.b_corners) intersect {4'hF};
}

CP_Y : coverpoint trans.y {
    bins y_zero   = {8'h00};
    bins y_max    = {8'hE1}; // 15 * 15 = 225 (E1)
    bins y_mid[4] = {[1:224]};
}

   endgroup
   function new(string name = "mul_coverage", uvm_component parent = null);
      super.new(name, parent);
      cov_inst = new();
   endfunction


   virtual function void write(mul_item t);
       trans = t;
       cov_inst.sample();
   endfunction

 endclass
