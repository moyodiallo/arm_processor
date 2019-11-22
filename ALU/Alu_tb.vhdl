library ieee;
use ieee.std_logic_1164.all;

entity Alu_tb is
end entity;

architecture archi of Alu_tb is
component Alu

	port ( op1  : in  Std_Logic_Vector(31 downto 0);
         op2  : in  Std_Logic_Vector(31 downto 0);
         cin  : in  Std_Logic;
         cmd  : in  Std_Logic_Vector(1 downto 0);
         res  : out Std_Logic_Vector(31 downto 0);
         cout : out Std_Logic;
         z    : out Std_Logic;
         n    : out Std_Logic;
         v    : out Std_Logic;
         vdd  : in  bit;
         vss  : in  bit );
end component;

signal op1,op2,res : std_logic_vector(31 downto 0);
signal cin,cout,z,n,v : std_logic;
signal cmd : std_logic_vector(1 downto 0);
signal vdd,vss : bit;
begin
alu1: Alu
	port map (op1 => op1,
		  op2 => op2,
		  res => res,
	          cin => cin,
		  cout => cout,
		  cmd => cmd,
		  z => z,
		  n => n,
		  v => v,
		  vdd => vdd,
		  vss => vss);

process
	begin
	cin <= '0';
	op1<= "10000000000000000000000000000111";--"00000000000000000000000000000000"  "11111111111111111111111111111111"
	op2<= "00000000000000000000000000001000";
	cmd<= "01";	
wait for 10 ms;
	
	assert res="10000000000000000000000000000001" report "Erreur sur res" severity error; 
	assert cout='0'report "Erreur sur Cout" severity error;	
	assert false report "end of test" severity note;
wait;
end process;
end archi;
	
