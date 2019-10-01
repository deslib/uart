vlib work
vlog -l v.log +define+SIM -f compile.f 
vsim -c -l sim.log -novopt tb_uart -default_radix decimal -do vsim_noprobe.do
