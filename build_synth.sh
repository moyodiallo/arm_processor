[ -d "build_synth" ] && rm -fr build
mkdir build_synth
cp Exec/exec.vhdl            build_synth/exec.vhdl
cp Makefile_synth.txt        build_synth/Makefile
cp Ram/ram.vhdl              build_synth/ram.vhdl
cp Icache/icache.vhdl        build_synth/icache.vhdl
cp Dcache/dcache.vhdl        build_synth/dcache.vhdl
cp Main/main_tb.vhdl         build_synth/main_tb.vhdl
cp Core/arm_core.vhdl        build_synth/arm_core.vhdl
cp Ifetch/ifetch.vhdl        build_synth/ifetch.vhdl
cp Decod/decod.vhdl          build_synth/decod.vhdl
cp Reg/reg.vhdl              build_synth/reg.vhdl
cp Fifo/fifo_72b.vhdl        build_synth/fifo_72b.vhdl
cp Fifo/fifo_127b.vhdl       build_synth/fifo_127b.vhdl
cp Fifo/fifo_32b.vhdl        build_synth/fifo_32b.vhdl
cp ALU/alu.vhdl              build_synth/alu.vhdl
cp Shifter/shifter.vhdl      build_synth/shifter.vhdl
cp Mem/mem.vhdl              build_synth/mem.vhdl
cp Arm_chip/arm_chip.vhdl    build_synth/arm_chip.vhdl
cp alliance-env.mk           build_synth/
echo "finished lookin build_synth!"
