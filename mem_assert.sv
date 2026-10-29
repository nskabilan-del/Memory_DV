module mem_assert(clk,rst,addr,wr_rd,wdata,rdata,valid,ready);
	input clk,rst,wr_rd,valid,ready;
	input [`addr_width-1:0]addr;
	input [`width-1:0]wdata,rdata;

	property reset;
		@(posedge clk)(rst==1) |-> (addr==0 &&wr_rd==0 &&wdata==0 && rdata==0&& valid==0&&ready==0);
	endproperty
	RESET: assert property(reset);

	property preset;
		@(posedge clk)(rst==0) |->((!($isunknown(wr_rd))) &&(!($isunknown(addr)) ) &&(!($isunknown(wdata))) &&(!($isunknown(rdata))) &&(!($isunknown(valid))) &&(!($isunknown(ready))));  
	endproperty
	PRESET: assert property(preset);

	property handshaking;
		@(posedge clk) (valid==1) |=> (ready==1);
	endproperty

	HANDSHAKING:assert property(handshaking);

	property writes;
		@(posedge clk) (wr_rd==1) |=> (!($isunknown(addr))) && (!($isunknown(wdata)));
	endproperty

	WRITES:assert property(writes);

	property reads;
		@(posedge clk) (wr_rd==0) |=> (!($isunknown(addr))) && (!($isunknown(rdata)));
	endproperty

	READS:assert property(reads);

endmodule
     
