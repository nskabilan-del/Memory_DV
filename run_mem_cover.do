vlib work
vlog list.svh
vopt mem_tb +cover=fcbest -o Nwr_Nrd 
vsim -coverage Nwr_Nrd +testname=Nwr_Nrd +N=32 
coverage save -onexit Nwr_Nrd.ucdb
add wave -r sim:/mem_tb/pif/*
run -all
