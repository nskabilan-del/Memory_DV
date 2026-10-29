`define width 8
`define depth 32
`define addr_width $clog2(`depth)


module memory(clk,rst,addr,wr_rd,wdata,rdata,valid,ready);
input clk,rst,wr_rd,valid;
input [`addr_width-1:0]addr;
input [`width-1:0]wdata;
output reg [`width-1:0]rdata;
output  reg ready;
reg [`width-1:0]mem[`depth-1:0];
integer i;
	always @(posedge clk)begin
		if(rst==1)begin
			rdata=0;
			ready=0;
			for(i=0;i<`depth;i=i+1) mem[i]=0;
		end
		else begin
			if(valid==1)begin
				ready=1;
				if(wr_rd==1)begin
					mem[addr]=wdata;
				end
				else begin
					rdata=mem[addr];
				end
			end
			else begin
				ready=0;
			end
		end
	end
endmodule
