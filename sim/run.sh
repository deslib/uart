vlib work
vlog -l v.log +define+SIM -f compile.f 
vsim -l sim.log -novopt tb_uart -default_radix decimal -do vsim.do
