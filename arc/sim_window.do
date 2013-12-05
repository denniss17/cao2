vlib work
vdel -all
vlib work
do compile_all_window.do
vsim -voptargs=+acc work.processor_with_memory(structure)
do wave.do