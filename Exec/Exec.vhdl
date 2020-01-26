library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity EXec is
	port(
	-- Decode interface synchro
			dec2exe_empty	: in Std_logic;
			exe_pop			: out Std_logic;

	-- Decode interface operands
			dec_op1			: in Std_Logic_Vector(31 downto 0); -- first alu input
			dec_op2			: in Std_Logic_Vector(31 downto 0); -- shifter input
			dec_exe_dest	: in Std_Logic_Vector(3 downto 0); -- Rd destination
			dec_exe_wb		: in Std_Logic; -- Rd destination write back
			dec_flag_wb		: in Std_Logic; -- CSPR modifiy

	-- Decode to mem interface 
			dec_mem_data	: in Std_Logic_Vector(31 downto 0); -- data to MEM W
			dec_mem_dest	: in Std_Logic_Vector(3 downto 0); -- Destination MEM R
			dec_pre_index 	: in Std_logic;

			-- l: load, s:store
			dec_mem_lw		: in Std_Logic; 
			dec_mem_lb		: in Std_Logic;
			dec_mem_sw		: in Std_Logic;
			dec_mem_sb		: in Std_Logic;

	-- Shifter command
			dec_shift_lsl	: in Std_Logic;
			dec_shift_lsr	: in Std_Logic;
			dec_shift_asr	: in Std_Logic;
			dec_shift_ror	: in Std_Logic;
			dec_shift_rrx	: in Std_Logic;
			dec_shift_val	: in Std_Logic_Vector(4 downto 0);
			dec_cy			: in Std_Logic;

	-- Alu operand selection
			dec_comp_op1	: in Std_Logic;
			dec_comp_op2	: in Std_Logic;
			dec_alu_cy 		: in Std_Logic;

	-- Alu command
			dec_alu_cmd		: in Std_Logic_Vector(1 downto 0);

	-- Exe bypass to decod
			exe_res			: out Std_Logic_Vector(31 downto 0);

			exe_c			: out Std_Logic;
			exe_v			: out Std_Logic;
			exe_n			: out Std_Logic;
			exe_z			: out Std_Logic;

			exe_dest		: out Std_Logic_Vector(3 downto 0); -- Rd destination
			exe_wb			: out Std_Logic; -- Rd destination write back
			exe_flag_wb		: out Std_Logic; -- CSPR modifiy

	-- Mem interface
			exe_mem_adr		: out Std_Logic_Vector(31 downto 0); -- Alu res register
			exe_mem_data	: out Std_Logic_Vector(31 downto 0);
			exe_mem_dest	: out Std_Logic_Vector(3 downto 0);

			exe_mem_lw		: out Std_Logic;
			exe_mem_lb		: out Std_Logic;
			exe_mem_sw		: out Std_Logic;
			exe_mem_sb		: out Std_Logic;

			exe2mem_empty	: out Std_logic;
			mem_pop			: in Std_logic;

	-- global interface
			ck				: in Std_logic;
			reset_n			: in Std_logic;
			vdd				: in bit;
			vss				: in bit);
end EXec;

----------------------------------------------------------------------

architecture Behavior OF EXec is

component alu
    port ( op1			: in Std_Logic_Vector(31 downto 0);
           op2			: in Std_Logic_Vector(31 downto 0);
           cin			: in Std_Logic;

           cmd			: in Std_Logic_Vector(1 downto 0);

           res			: out Std_Logic_Vector(31 downto 0);
           cout			: out Std_Logic;
           z			: out Std_Logic;
           n			: out Std_Logic;
           v			: out Std_Logic;
			  
			vdd			: in bit;
			vss			: in bit);
end component;

component shifter 
	port(
		shift_lsl : in  Std_Logic;
		shift_lsr : in  Std_Logic;
		shift_asr : in  Std_Logic;
		shift_ror : in  Std_Logic;
		shift_rrx : in  Std_Logic;
		shift_val : in  Std_Logic_Vector(4 downto 0);
		din       : in  Std_Logic_Vector(31 downto 0);
		cin       : in  Std_Logic;
		dout      : out Std_Logic_Vector(31 downto 0);
		cout      : out Std_Logic;
		-- global interface
		vdd       : in  bit;
		vss       : in  bit );
end component;

component fifo_72b
	port(
		din		: in std_logic_vector(71 downto 0);
		dout	: out std_logic_vector(71 downto 0);

		-- commands
		push	: in std_logic;
		pop		: in std_logic;

		-- flags
		full		: out std_logic;
		empty		: out std_logic;

		reset_n	: in std_logic;
		ck		: in std_logic;
		vdd		: in bit;
		vss		: in bit
	);
end component;

-- signaux intermediaire de l'alu
signal alu_op1, alu_op2 : std_logic_vector(31 downto 0);
signal alu_cout: std_logic;

-- signaux intermediaire du shifter
signal shift_op2  : std_logic_vector(31 downto 0);
signal shift_dout : std_logic_vector(31 downto 0);
signal shift_cout : std_logic;

-- signaux dans le shifter
signal mem_adr  : std_logic_vector(31 downto 0); 
signal exe_push : std_logic;

signal exe2mem_full : std_logic;
signal res :  std_logic_vector(31 downto 0);

begin

--  Component instantiation.
	alu_inst : alu
	port map (	
		op1 	=> alu_op1,		
		op2		=> alu_op2,
		cin		=> dec_alu_cy,

		cmd		=> dec_alu_cmd,

		res		=> res,
		cout	=> alu_cout,
		z		=> exe_z,
		n		=> exe_n,
		v		=> exe_v,

		vdd 	=> vdd,
		vss		=> vss);

	shifter_inst: shifter 
	port map(
		shift_lsl 	=> dec_shift_lsl,
		shift_lsr 	=> dec_shift_lsr,
		shift_asr 	=> dec_shift_asr,
		shift_ror 	=> dec_shift_ror,
		shift_rrx 	=> dec_shift_rrx,
		shift_val 	=> dec_shift_val,

		din       	=> shift_op2,
		cin       	=> dec_cy,

		dout      	=> shift_dout,
		cout      	=> shift_cout,

		-- global interface
		vdd		=> vdd,
		vss    	=> vss);

	

	exec2mem : fifo_72b
	port map (		din(71)	 => dec_mem_lw,
					din(70)	 => dec_mem_lb,
					din(69)	 => dec_mem_sw,
					din(68)	 => dec_mem_sb,

					din(67 downto 64) 	=> dec_mem_dest,
					din(63 downto 32) 	=> dec_mem_data,
					din(31 downto 0)	=> mem_adr,

					dout(71)	 => exe_mem_lw,
					dout(70)	 => exe_mem_lb,
					dout(69)	 => exe_mem_sw,
					dout(68)	 => exe_mem_sb,

					dout(67 downto 64) => exe_mem_dest,
					dout(63 downto 32) => exe_mem_data,
					dout(31 downto 0)  => exe_mem_adr,

					push	=> exe_push,
					pop		=> mem_pop,

					empty	=> exe2mem_empty,
					full	=> exe2mem_full,

					reset_n	 => reset_n,
					ck		 => ck,
					vdd		 => vdd,
					vss		 => vss);


-- comportement de l'architecture

	-- shifter op2
	shift_op2 <=  dec_op2 xor X"FFFFFFFF" when dec_comp_op2 = '1' else dec_op2;

	-- operandes (l'ajout du 1 de complement se fera avec la retenu)
	alu_op1   <=  dec_op1 xor X"FFFFFFFF" when dec_comp_op1 = '1' else dec_op1;
	alu_op2   <= shift_dout; 

	mem_adr <=  res when dec_pre_index = '1' else alu_op1;

	-- bypass to decod
	exe_dest    <= dec_exe_dest;
	exe_wb 	    <= dec_exe_wb;
	exe_flag_wb <= dec_flag_wb;	

	-- quand la fifo qui alimente EXEC n'est pas vide
	exe_push <= '1' when dec2exe_empty = '0' and exe2mem_full  = '0' else '0'; -- remplir de EXE vers MEM
	exe_pop  <= exe_push;

	-- operation arithmetique ou logique
	exe_c <= alu_cout when dec_alu_cmd = "00" else shift_cout;

	exe_res <= res;

process (alu_op1, alu_op2, res, dec_comp_op1, dec_comp_op2)
begin

	report "OPPPP1 "& to_hstring(alu_op1);
	report "OPPPP2 "& to_hstring(alu_op2);
	report "OPPPPR "& to_hstring(res);

	report "COOMP1 "& std_logic'image(dec_comp_op1);
	report "COMMP2 "& std_logic'image(dec_comp_op2);

end process;

end Behavior;
