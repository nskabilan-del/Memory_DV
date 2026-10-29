class mem_env;
mem_agent agent;
mem_sbd sbd;

task run_env();
	agent=new();
	sbd=new();

fork
	agent.run_agent();
	sbd.run_sbd();
join
endtask

endclass
