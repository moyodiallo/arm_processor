library ieee;
use ieee.std_logic_1164.all;

entity reg_tb is
end entity;

architecture archi of reg_tb is
component reg

	port(
	-- Write Port 1 prioritaire--
		wdata1		: in Std_Logic_Vector(31 downto 0);
		wadr1		: in Std_Logic_Vector(3 downto 0);
		wen1		: in Std_Logic;

	-- Write Port 2 non prioritaire--
		wdata2		: in Std_Logic_Vector(31 downto 0);
		wadr2		: in Std_Logic_Vector(3 downto 0);
		wen2		: in Std_Logic;

	-- Write CSPR Port--
		wcry		: in Std_Logic;
		wzero		: in Std_Logic;
		wneg		: in Std_Logic;
		wovr		: in Std_Logic;
		cspr_wb		: in Std_Logic;
		
	-- Read Port 1 32 bits--
		reg_rd1		: out Std_Logic_Vector(31 downto 0);
		radr1			: in Std_Logic_Vector(3 downto 0);
		reg_v1		: out Std_Logic;

	-- Read Port 2 32 bits--
		reg_rd2		: out Std_Logic_Vector(31 downto 0);
		radr2			: in Std_Logic_Vector(3 downto 0);
		reg_v2		: out Std_Logic;

	-- Read Port 3 32 bits--
		reg_rd3		: out Std_Logic_Vector(31 downto 0);
		radr3			: in Std_Logic_Vector(3 downto 0);
		reg_v3		: out Std_Logic;

	-- read CSPR Port--
		reg_cry		: out Std_Logic;
		reg_zero	: out Std_Logic;
		reg_neg		: out Std_Logic;
		reg_cznv	: out Std_Logic;
		reg_ovr		: out Std_Logic;
		reg_vv		: out Std_Logic;
		
	-- Invalidate Port --
		inval_adr1	: in Std_Logic_Vector(3 downto 0);
		inval1		: in Std_Logic;

		inval_adr2	: in Std_Logic_Vector(3 downto 0);
		inval2		: in Std_Logic;

		inval_czn	: in Std_Logic;
		inval_ovr	: in Std_Logic;

	-- PC--
		reg_pc		: out Std_Logic_Vector(31 downto 0);
		reg_pcv		: out Std_Logic;
		inc_pc		: in Std_Logic;
	
	-- global interface--
		ck			: in Std_Logic;
		reset_n			: in Std_Logic;
		vdd			: in bit;
		vss			: in bit);
end component;

signal wdata1,wdata2,reg_rd1,reg_rd2,reg_rd3,reg_pc : std_logic_vector(31 downto 0);
signal wen1,wen2,wzero,wneg,wcry,wovr,cspr_wb,reg_v1,reg_v2,reg_v3,reg_cry,reg_zero,reg_neg,reg_cznv,reg_ovr,reg_vv,inval1,inval2,inval_czn,inval_ovr,reg_pcv,inc_pc,reset_n : std_logic;
signal ck : std_logic := '1';
signal wadr1,wadr2,radr1, radr2, radr3, inval_adr1, inval_adr2 : std_logic_vector(3 downto 0); 

signal vdd,vss : bit;
signal finished : std_logic;
begin
regs: reg port map (wdata1 => wdata1,
		  wdata2 => wdata2,
		  reg_rd1 => reg_rd1,
		  reg_rd2 => reg_rd2,
		  reg_rd3 => reg_rd3,
		  reg_pc => reg_pc,
		  wen1 => wen1,
		  wen2 => wen2,
		  wzero => wzero,
		  wneg => wneg,
		  wcry => wcry,
		  wovr => wovr,
		  cspr_wb => cspr_wb,
		  reg_v1 => reg_v1,
		  reg_v2 => reg_v2,
		  reg_v3 => reg_v3, 
		  reg_cry => reg_cry,
		  reg_zero => reg_zero,
		  reg_neg => reg_neg,
		  reg_cznv => reg_cznv,
		  reg_ovr => reg_ovr,
		  reg_vv => reg_vv,
		  inval1 => inval1,
		  inval2 => inval2,
		  inval_czn => inval_czn,
		  inval_ovr => inval_ovr,
		  reg_pcv => reg_pcv,
		  inc_pc => inc_pc,
		  ck => ck,
		  reset_n => reset_n,
		  wadr1 => wadr1,
		  wadr2 => wadr2,
		  radr1 => radr1,
		  radr2 => radr2,
		  radr3 => radr3,
		  inval_adr1 => inval_adr1,
		  inval_adr2 => inval_adr2,
		  vdd => vdd,
		  vss => vss);
finished <= '0';


process
begin
	for i in 0 to 20 loop
		ck <= not ck after 5 ms;
		wait for 5 ms;
	end loop; 	
wait;
end process;

process
	begin

	reset_n <= '0';
wait for 10 ms;
	reset_n <= '1';
	wdata1 <= "10000000110000011000000110000001";
	wadr1 <= "1111";
	wen1 <= '1';
	wdata2 <= "11111111111111000001111111111111";
	wadr2 <= "0001";
	wen2 <= '1';
wait for 10 ms;	
	wdata2 <= "00011111111111000001111111111001";
	wadr2 <= "0101";
	wen2 <= '1';
wait for 10 ms;
	wen1 <= '0';
	wen2 <= '0';
	radr1 <= "1111";
	radr2 <= "0000";
wait for 10 ms;
	radr2 <= "0001";
wait for 10 ms;
	radr2 <= "0010";
wait for 10 ms;
	radr2 <= "0011";
wait for 10 ms;
	radr2 <= "0100";
wait for 10 ms;
	radr2 <= "0101";
wait for 10 ms;
	radr2 <= "0110";
wait for 10 ms;
	radr2 <= "0111";
wait for 10 ms;
	radr2 <= "1000";
wait for 10 ms;
	radr2 <= "1001";
wait for 10 ms;
	radr2 <= "1010";
wait for 10 ms;
	radr2 <= "1011";
wait for 10 ms;
	radr2 <= "1100";
wait for 10 ms;
	radr2 <= "1101";
wait for 10 ms;
	radr2 <= "1110";
wait for 10 ms;
	radr2 <= "1111";
wait for 10 ms;
	assert reg_rd1="10000000110000011000000110000001" report "Erreur sur reg val" severity error; 
	assert reg_v1='0' report "Erreur sur validite" severity error;	
	assert false report "end of test" severity note;
wait;
end process;
end archi;
	
