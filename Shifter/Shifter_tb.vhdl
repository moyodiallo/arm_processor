library ieee;
use ieee.std_logic_1164.all;

entity Shifter_tb is
end entity;

architecture archi of Shifter_tb is
component Shifter
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

signal din,dout : std_logic_vector(31 downto 0);
signal shift_val : std_logic_vector(4 downto 0);
signal shift_lsl,shift_lsr,shift_asr,shift_ror ,shift_rrx,cout,cin : std_logic;
signal cmd : std_logic_vector(1 downto 0);
signal vdd,vss : bit;
begin
shifter1: Shifter
port map ( shift_lsl => shift_lsl,
    	   shift_lsr => shift_lsr,
	   shift_asr =>shift_asr,
	   shift_ror =>shift_ror,
	   shift_rrx =>shift_rrx,
	   shift_val =>shift_val,
	   din =>din,
	   cin =>cin,
	   dout =>dout,
	   cout =>cout,
	   vdd =>vdd,
	   vss =>vss);

process
	begin
	shift_lsl = '1';
	din<= "01111111111111111111111111111111";
	shift_val<= "00001";	
wait for 10 ms;
	
	assert dout="10000000000000000000000000000000" report "Erreur sur dout" severity error; 
	assert cout='0'report "Erreur sur Cout" severity error;	
	assert false report "end of test" severity note;
wait;
end process;
end archi;
	
