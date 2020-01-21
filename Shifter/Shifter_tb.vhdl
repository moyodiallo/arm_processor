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
	cin <='0';
	shift_lsl <= '1';
	shift_asr <= '0';
	shift_ror <= '0';
	shift_rrx <= '0';
	shift_lsr <= '0';
	din<= "00000000000000000000000000000100";--00000000000000000000000000000000  11111111111111111111111111111111
	shift_val<= "00010";	
wait for 15 ms;
	cin <='0';
	shift_lsl <= '0';
	shift_asr <= '0';
	shift_ror <= '0';
	shift_rrx <= '1';
	shift_lsr <= '0';
	din<= "11111111111111111111111111110000";
	shift_val<= "00011";	
wait for 15 ms;
	cin <='0';
	shift_lsl <= '0';
	shift_asr <= '0';
	shift_ror <= '0';
	shift_rrx <= '1';
	shift_lsr <= '0';
	din<= "11111111111111111111111111111111";
	shift_val<= "00011";	
wait for 15 ms;
	cin <='0';
	shift_lsl <= '0';
	shift_asr <= '0';
	shift_ror <= '0';
	shift_rrx <= '1';
	shift_lsr <= '0';
	din<= "11111111111110000111111111111111";
	shift_val<= "00000";	
wait for 15 ms;
	assert dout="10000000000000000000000000000000" report "Erreur sur dout" severity error; 
	assert cout='0'report "erreur" severity error;	
	assert false report "end of test" severity note;
wait;
end process;
end archi;
	
