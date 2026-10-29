class mem_gen;
mem_tx tx,temp,txQ[$];
task run_gen();
case(mem_comm::testname)
	"1wr":begin
		tx=new();
		tx.randomize() with{tx.wr_rd==1;};
		tx.print("mem_gen");
		//$fdisplay(file,"Write_addr=%0d",tx.addr);
		temp=new tx;
		mem_comm::gen2bfm.put(temp);
	end
	"5wr":begin
		tx=new();
	repeat(5)begin
		tx.randomize() with{tx.wr_rd==1;};
		tx.print("mem_gen");
		//$fdisplay(file,"read_addr=%0d",tx.addr);
		temp=new tx;
		mem_comm::gen2bfm.put(temp);
	end	
	end
	"1wr_1rd":begin
		//write 
		tx=new();
		tx.randomize() with{tx.wr_rd==1;};
		tx.print("mem_gen");
		temp=new tx;
		mem_comm::gen2bfm.put(temp);
		//read
		tx=new();
		tx.randomize()with {tx.wr_rd==0;tx.addr==temp.addr;tx.wdata==0;};
		tx.print("mem_gen");
		mem_comm::gen2bfm.put(tx);
	end
	"5wr_5rd":begin
		tx=new();
		repeat(5)begin
		tx.randomize() with{tx.wr_rd==1;};
		tx.print("5wr_5rd");
		temp=new tx;
		mem_comm::gen2bfm.put(temp);
		txQ.push_back(temp);
		end
		//reads
		repeat(5)begin
		temp=txQ.pop_front();
		tx=new();
		tx.randomize()with{tx.wr_rd==0;tx.addr==temp.addr;tx.wdata==0;};
		tx.print("5wr_rd");
		mem_comm::gen2bfm.put(tx);
		end
	end
	"Nwr_Nrd":begin
		//writes
		//for(i=0;i<mem_comm::N;i++)begin
		tx=new();
		repeat(mem_comm::N)begin
		tx.randomize() with{tx.wr_rd==1;/*tx.addr=i*/};
		tx.print("Nwr");
		temp=new tx;
		txQ.push_back(temp);
		mem_comm::gen2bfm.put(temp);
		end
		//end
		//reads
		repeat(mem_comm::N)begin
		temp=txQ.pop_front();
		tx=new();
		tx.randomize()with{tx.wr_rd==0;tx.addr==temp.addr;tx.wdata==0;};
		tx.print("Nrd");
		mem_comm::gen2bfm.put(tx);
		end
		
	end
	   default: $display("GEN: unknown testname %s", mem_comm::testname);
endcase	
//$fclose(file);
endtask

endclass
