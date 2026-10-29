module mem_tb;
mem_env env;
reg clk,rst;
mem_if pif(clk,rst);

memory dut (.clk(pif.clk),
			.rst(pif.rst),
			.addr(pif.addr),
			.wr_rd(pif.wr_rd),
			.wdata(pif.wdata),
			.rdata(pif.rdata),
			.valid(pif.valid),
			.ready(pif.ready));

mem_assert uut (.clk(pif.clk),
			    .rst(pif.rst),
				.addr(pif.addr),
				.wr_rd(pif.wr_rd),
				.wdata(pif.wdata),
				.rdata(pif.rdata),
				.valid(pif.valid),
				.ready(pif.ready));

always #5 clk=~clk;

initial begin
clk=0;
rst=1;
repeat(2)@(posedge clk);
rst=0;
$value$plusargs("testname=%0s",mem_comm::testname);
$value$plusargs("N=%0d",mem_comm::N);
	env=new();
	env.run_env();
end
initial begin
#2500;
if(mem_comm::matching !=0 && mem_comm::mismatching==0) begin
	$display("*********TEST PASSED*********");
	$display("matching=%0d,mismatching=%0d",mem_comm::matching,mem_comm::mismatching);
end
else begin
	$display("*********TEST FAILED*********");
	$display("matching=%0d,mismatching=%0d",mem_comm::matching,mem_comm::mismatching);
	
end
$finish;
end
endmodule

