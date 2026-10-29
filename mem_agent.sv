class mem_agent;
mem_gen gen;
mem_bfm bfm;
mem_mon mon;
mem_cov cov;

task run_agent();
//	$display("AGENT on Mission");
	gen=new();
	bfm=new();
	mon=new();
	cov=new();

fork
	gen.run_gen();
	bfm.run_bfm();
	mon.run_mon();
	cov.run_cov();
join
endtask

endclass
