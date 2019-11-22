GHDL = /home/jeanlou/Outils/ghdl/bin/ghdl
all :
	ghdl -a -v --ieee=synopsys -fexplicit Shifter.vhdl
	ghdl -a -v --ieee=synopsys -fexplicit Shifter_tb.vhdl
	ghdl -e -v --ieee=synopsys -fexplicit Shifter_tb
	ghdl -r --ieee=synopsys -fexplicit Shifter_tb --vcd=Shifter.vcd
