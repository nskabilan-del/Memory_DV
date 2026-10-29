class mem_sbd;
mem_tx tx;

int asso[*];

task run_sbd();
	forever begin
		mem_comm::mon2sbd.get(tx);
		tx.print("mem_sbd");
		if(tx.wr_rd==1) asso[tx.addr]=tx.wdata;
		else begin
		if(tx.rdata ==asso[tx.addr]) mem_comm::matching++;
		else mem_comm::mismatching++;
		end
	end

endtask
endclass
