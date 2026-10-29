class mem_tx;
	rand bit wr_rd;
	randc bit[`addr_width-1:0]addr;
	rand bit[`width-1:0]wdata;
	bit[`width-1:0]rdata;

	function void print (string str="mem_tx" );
		$display("%0t:---------%0s--------",$time,str);
		$display("wr_rd=%0d",wr_rd);
		$display("addr=%0d",addr);
		$display("wdata=%0d",wdata);
		$display("rdata=%0d",rdata);
	endfunction
endclass
