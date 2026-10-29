class mem_bfm;
mem_tx tx;

virtual mem_if vif;

task run_bfm();
//$display("bfm on mission");
	vif = mem_tb.pif;
	forever begin
		mem_comm::gen2bfm.get(tx);
		drive_tx(tx);
		tx.print("gen2bfm_mem_bfm");
	end
endtask

task drive_tx(mem_tx tx);
//this is driving part it is important.
// why vif and bfm is get the data to the mem_txso we use tx,and send to the virtual interface so we use the vif.
//why i use line 21 insert of 20, we already mention the clk in mem_if in clocking .so we only use the line 21.
	//@(posedge vif.bfm_cb.clk);
	@(vif.bfm_cb);
	vif.bfm_cb.wr_rd<=tx.wr_rd;
	vif.bfm_cb.addr<=tx.addr;
	if(tx.wr_rd==1)vif.bfm_cb.wdata<=tx.wdata;
	else vif.bfm_cb.wdata<=0;
	// why not tx not used in valid, because of the valid not in mem_tx,so only used in the vif.bfm_cb.because valid and other arte used in the interface
	vif.bfm_cb.valid<=1;
	wait(vif.bfm_cb.ready==1);
	if(tx.wr_rd==0)begin
		@(vif.bfm_cb);
// tx.rdata not give the non-blocking because of the input are not a non-blocking element
		tx.rdata=vif.bfm_cb.rdata;
	end

	@(vif.bfm_cb);
	vif.bfm_cb.wr_rd<=0;
	vif.bfm_cb.addr<=0;
	vif.bfm_cb.wdata<=0;
	vif.bfm_cb.valid<=0;
endtask

endclass
