class mem_mon;
mem_tx tx;
virtual mem_if vif;


task run_mon();
vif=mem_tb.pif;

	forever begin
		@(vif.mon_cb );
	if(vif.mon_cb.valid==1&&vif.mon_cb.ready==1)begin
		tx=new();
		tx.wr_rd=vif.mon_cb.wr_rd;
		tx.addr =vif.mon_cb.addr;
		tx.wdata=vif.mon_cb.wdata;
		if(tx.wr_rd==0)begin
			@(vif.mon_cb);
			tx.rdata=vif.mon_cb.rdata;
		end
		else tx.rdata=0;
		tx.print("mem_mon");
		mem_comm::mon2cov.put(tx);
		mem_comm::mon2sbd.put(tx);
	end
	end
endtask

endclass
