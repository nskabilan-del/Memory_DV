interface mem_if(input reg clk,rst);
	bit wr_rd;
	bit [`addr_width-1:0]addr;
	bit [`width-1:0]wdata,rdata;
	bit valid,ready;

	//clocking 
		clocking bfm_cb @(posedge clk);
			default input #0 output #1;
// why ready and rdata are input , because you will see in side of DUT,not see in bfm side.

			input ready ,rdata;
			output wr_rd,addr,wdata,valid;
		endclocking

		clocking mon_cb @(posedge clk);
			default input #1;
			input ready, rdata, wr_rd,addr,wdata,valid;
		endclocking

	endinterface
