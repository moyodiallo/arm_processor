library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Shifter is
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
end Shifter;

architecture archi of Shifter is
signal shift : std_logic_vector(4 downto 0);
begin
	shift <=  shift_rrx & shift_ror & shift_asr & shift_lsr &  shift_lsl;
	
process(shift, din, shift_val, shift_asr, shift_lsl, shift_lsr, shift_ror, shift_rrx, cin)
begin
		

	if(shift = "00001") then --LSL
		if    shift_val = "00001" then cout <= din(31) ; dout <= din(30 downto 0) & "0"; 
		elsif shift_val = "00010" then cout <= din(30) ; dout <= din(29 downto 0) & "00"; 
		elsif shift_val = "00011" then cout <= din(29) ; dout <= din(28 downto 0) & "000"; 
		elsif shift_val = "00100" then cout <= din(28) ; dout <= din(27 downto 0) & "0000"; 
		elsif shift_val = "00101" then cout <= din(27) ; dout <= din(26 downto 0) & "00000"; 
		elsif shift_val = "00110" then cout <= din(26) ; dout <= din(25 downto 0) & "000000"; 
		elsif shift_val = "00111" then cout <= din(25) ; dout <= din(24 downto 0) & "0000000"; 
		elsif shift_val = "01000" then cout <= din(24) ; dout <= din(23 downto 0) & "00000000"; 
		elsif shift_val = "01001" then cout <= din(23) ; dout <= din(22 downto 0) & "000000000"; 
		elsif shift_val = "01010" then cout <= din(22) ; dout <= din(21 downto 0) & "0000000000"; 
		elsif shift_val = "01011" then cout <= din(21) ; dout <= din(20 downto 0) & "00000000000";
		elsif shift_val = "01100" then cout <= din(20) ; dout <= din(19 downto 0) & "000000000000";
		elsif shift_val = "01101" then cout <= din(19) ; dout <= din(18 downto 0) & "0000000000000";
		elsif shift_val = "01110" then cout <= din(18) ; dout <= din(17 downto 0) & "00000000000000";
		elsif shift_val = "01111" then cout <= din(17) ; dout <= din(16 downto 0) & "000000000000000";
		elsif shift_val = "10000" then cout <= din(16) ; dout <= din(15 downto 0) & "0000000000000000";
		elsif shift_val = "10001" then cout <= din(15) ; dout <= din(14 downto 0) & "00000000000000000";
		elsif shift_val = "10010" then cout <= din(14) ; dout <= din(13 downto 0) & "000000000000000000";
		elsif shift_val = "10011" then cout <= din(13) ; dout <= din(12 downto 0) & "0000000000000000000";
		elsif shift_val = "10100" then cout <= din(12) ; dout <= din(11 downto 0) & "00000000000000000000";
		elsif shift_val = "10101" then cout <= din(11) ; dout <= din(10 downto 0) & "000000000000000000000";
		elsif shift_val = "10110" then cout <= din(10) ; dout <= din(9 downto 0)  & "0000000000000000000000"; 
		elsif shift_val = "10111" then cout <= din(9) ; dout <= din(8 downto 0)   & "00000000000000000000000"; 
		elsif shift_val = "11000" then cout <= din(8) ; dout <= din(7 downto 0)   & "000000000000000000000000"; 
		elsif shift_val = "11001" then cout <= din(7) ; dout <= din(6 downto 0)   & "0000000000000000000000000"; 
		elsif shift_val = "11010" then cout <= din(6) ; dout <= din(5 downto 0)   & "00000000000000000000000000"; 
		elsif shift_val = "11011" then cout <= din(5) ; dout <= din(4 downto 0)   & "000000000000000000000000000"; 
		elsif shift_val = "11100" then cout <= din(4) ; dout <= din(3 downto 0)   & "0000000000000000000000000000"; 
		elsif shift_val = "11101" then cout <= din(3) ; dout <= din(2 downto 0)   & "00000000000000000000000000000"; 
		elsif shift_val = "11110" then cout <= din(2) ; dout <= din(1 downto 0)   & "000000000000000000000000000000"; 
		elsif shift_val = "11111" then cout <= din(1) ; dout <= din(0 downto 0)   & "0000000000000000000000000000000"; 
		else  cout<=cin; dout<=din;
		end if;

		report "shift_lsl";

	elsif(shift = "00010") then  --LSR
			if shift_val = "00001" then cout <= din(0) ; dout <= "0" & din(31 downto 1);
		elsif shift_val = "00010" then cout <= din(1) ;  dout <= "00" & din(31 downto 2);
		elsif shift_val = "00011" then cout <= din(2) ;  dout <= "000" & din(31 downto 3);
		elsif shift_val = "00100" then cout <= din(3) ;  dout <= "0000" & din(31 downto 4);
		elsif shift_val = "00101" then cout <= din(4) ;  dout <= "00000" & din(31 downto 5);
		elsif shift_val = "00110" then cout <= din(5) ;  dout <= "000000" & din(31 downto 6);
		elsif shift_val = "00111" then cout <= din(6) ;  dout <= "0000000" & din(31 downto 7);
		elsif shift_val = "01000" then cout <= din(7) ;  dout <= "00000000" & din(31 downto 8);
		elsif shift_val = "01001" then cout <= din(8) ;  dout <= "000000000" & din(31 downto 9);
		elsif shift_val = "01010" then cout <= din(9) ;  dout <= "0000000000" & din(31 downto 10);
		elsif shift_val = "01011" then cout <= din(10) ; dout <= "00000000000" & din(31 downto 11);
		elsif shift_val = "01100" then cout <= din(11) ; dout <= "000000000000" & din(31 downto 12);
		elsif shift_val = "01101" then cout <= din(12) ; dout <= "0000000000000" & din(31 downto 13);
		elsif shift_val = "01110" then cout <= din(13) ; dout <= "00000000000000" & din(31 downto 14);
		elsif shift_val = "01111" then cout <= din(14) ; dout <= "000000000000000" & din(31 downto 15);
		elsif shift_val = "10000" then cout <= din(15) ; dout <= "0000000000000000" & din(31 downto 16);
		elsif shift_val = "10001" then cout <= din(16) ; dout <= "00000000000000000" & din(31 downto 17);
		elsif shift_val = "10010" then cout <= din(17) ; dout <= "000000000000000000" & din(31 downto 18);
		elsif shift_val = "10011" then cout <= din(18) ; dout <= "0000000000000000000" & din(31 downto 19);
		elsif shift_val = "10100" then cout <= din(19) ; dout <= "00000000000000000000" & din(31 downto 20);
		elsif shift_val = "10101" then cout <= din(20) ; dout <= "000000000000000000000" & din(31 downto 21);
		elsif shift_val = "10110" then cout <= din(21) ; dout <= "0000000000000000000000" & din(31 downto 22);
		elsif shift_val = "10111" then cout <= din(22) ; dout <= "00000000000000000000000" & din(31 downto 23);
		elsif shift_val = "11000" then cout <= din(23) ; dout <= "000000000000000000000000" & din(31 downto 24);
		elsif shift_val = "11001" then cout <= din(24) ; dout <= "0000000000000000000000000" & din(31 downto 25);
		elsif shift_val = "11010" then cout <= din(25) ; dout <= "00000000000000000000000000" & din(31 downto 26);
		elsif shift_val = "11011" then cout <= din(26) ; dout <= "000000000000000000000000000" & din(31 downto 27);
		elsif shift_val = "11100" then cout <= din(27) ; dout <= "0000000000000000000000000000" & din(31 downto 28);
		elsif shift_val = "11101" then cout <= din(28) ; dout <= "00000000000000000000000000000" & din(31 downto 29);
		elsif shift_val = "11110" then cout <= din(29) ; dout <= "000000000000000000000000000000" & din(31 downto 30);
		elsif shift_val = "11111" then cout <= din(30) ; dout <= "0000000000000000000000000000000" & din(31 downto 31);
		else  cout<=cin; dout<=din;
		end if;

		report "shitf_lsr";

	elsif(shift = "00100")  then  --ASR
			if shift_val = "00001" then cout <= din(0) ;  if din(31) = '0' then dout <= "00" & din(30 downto 1); else dout <= "11" & din(30 downto 1);  end if;
		elsif shift_val = "00010" then cout <= din(1) ;  if din(31) = '0' then dout <= "000" & din(30 downto 2);   else dout <= "111" & din(30 downto 2);  end if;
		elsif shift_val = "00011" then cout <= din(2) ;  if din(31) = '0' then dout <= "0000" & din(30 downto 3);   else dout <= "1111" & din(30 downto 3);  end if;
		elsif shift_val = "00100" then cout <= din(3) ;  if din(31) = '0' then dout <= "00000" & din(30 downto 4);   else dout <= "11111" & din(30 downto 4);  end if;
		elsif shift_val = "00101" then cout <= din(4) ;  if din(31) = '0' then dout <= "000000" & din(30 downto 5);   else dout <= "111111" & din(30 downto 5);  end if;
		elsif shift_val = "00110" then cout <= din(5) ;  if din(31) = '0' then dout <= "0000000" & din(30 downto 6);   else dout <= "1111111" & din(30 downto 6);  end if;
		elsif shift_val = "00111" then cout <= din(6) ;  if din(31) = '0' then dout <= "00000000" & din(30 downto 7);   else dout <= "11111111" & din(30 downto 7);  end if;
		elsif shift_val = "01000" then cout <= din(7) ;  if din(31) = '0' then dout <= "000000000" & din(30 downto 8);   else dout <= "111111111" & din(30 downto 8);  end if;
		elsif shift_val = "01001" then cout <= din(8) ;  if din(31) = '0' then dout <= "0000000000" & din(30 downto 9);   else dout <= "1111111111" & din(30 downto 9);  end if;
		elsif shift_val = "01010" then cout <= din(9) ;  if din(31) = '0' then dout <= "00000000000" & din(30 downto 10);  else dout <= "11111111111" & din(30 downto 10);  end if;
		elsif shift_val = "01011" then cout <= din(10) ; if din(31) = '0' then dout <= "000000000000" & din(30 downto 11);  else dout <= "111111111111" & din(30 downto 11);  end if;
		elsif shift_val = "01100" then cout <= din(11) ; if din(31) = '0' then dout <= "0000000000000" & din(30 downto 12);  else dout <= "1111111111111" & din(30 downto 12);  end if;
		elsif shift_val = "01101" then cout <= din(12) ; if din(31) = '0' then dout <= "00000000000000" & din(30 downto 13);  else dout <= "11111111111111" & din(30 downto 13);  end if;
		elsif shift_val = "01110" then cout <= din(13) ; if din(31) = '0' then dout <= "000000000000000" & din(30 downto 14);  else dout <= "111111111111111" & din(30 downto 14);  end if;
		elsif shift_val = "01111" then cout <= din(14) ; if din(31) = '0' then dout <= "0000000000000000" & din(30 downto 15);  else dout <= "1111111111111111" & din(30 downto 15);  end if;
		elsif shift_val = "10000" then cout <= din(15) ; if din(31) = '0' then dout <= "00000000000000000" & din(30 downto 16);  else dout <= "11111111111111111" & din(30 downto 16);  end if;
		elsif shift_val = "10001" then cout <= din(16) ; if din(31) = '0' then dout <= "000000000000000000" & din(30 downto 17);  else dout <= "111111111111111111" & din(30 downto 17);  end if;
		elsif shift_val = "10010" then cout <= din(17) ; if din(31) = '0' then dout <= "0000000000000000000" & din(30 downto 18);  else dout <= "1111111111111111111" & din(30 downto 18);  end if;
		elsif shift_val = "10011" then cout <= din(18) ; if din(31) = '0' then dout <= "00000000000000000000" & din(30 downto 19);  else dout <= "11111111111111111111" & din(30 downto 19);  end if;
		elsif shift_val = "10100" then cout <= din(19) ; if din(31) = '0' then dout <= "000000000000000000000" & din(30 downto 20);  else dout <= "111111111111111111111" & din(30 downto 20);  end if;
		elsif shift_val = "10101" then cout <= din(20) ;  if din(31) = '0' then dout <= "0000000000000000000000" & din(30 downto 21); else dout <= "1111111111111111111111" & din(30 downto 21);  end if;
		elsif shift_val = "10110" then cout <= din(21) ;  if din(31) = '0' then dout <= "00000000000000000000000" & din(30 downto 22);  else dout <= "11111111111111111111111" & din(30 downto 22);  end if;
		elsif shift_val = "10111" then cout <= din(22) ;  if din(31) = '0' then dout <= "000000000000000000000000" & din(30 downto 23); else dout <= "111111111111111111111111" & din(30 downto 23);  end if;
		elsif shift_val = "11000" then cout <= din(23) ;  if din(31) = '0' then dout <= "0000000000000000000000000" & din(30 downto 24); else dout <= "1111111111111111111111111" & din(30 downto 24);  end if;
		elsif shift_val = "11001" then cout <= din(24) ;  if din(31) = '0' then dout <= "00000000000000000000000000" & din(30 downto 25); else dout <= "11111111111111111111111111" & din(30 downto 25);  end if;
		elsif shift_val = "11010" then cout <= din(25) ;  if din(31) = '0' then dout <= "000000000000000000000000000" & din(30 downto 26);  else dout <= "111111111111111111111111111" & din(30 downto 26);  end if;
		elsif shift_val = "11011" then cout <= din(26) ;  if din(31) = '0' then dout <= "0000000000000000000000000000" & din(30 downto 27);  else dout <= "1111111111111111111111111111" & din(30 downto 27);  end if;
		elsif shift_val = "11100" then cout <= din(27) ;  if din(31) = '0' then dout <= "00000000000000000000000000000" & din(30 downto 28); else dout <= "11111111111111111111111111111" & din(30 downto 28);  end if;
		elsif shift_val = "11101" then cout <= din(28) ;  if din(31) = '0' then dout <= "000000000000000000000000000000" & din(30 downto 29);  else dout <= "111111111111111111111111111111" & din(30 downto 29);  end if;
		elsif shift_val = "11110" then cout <= din(29) ;  if din(31) = '0' then dout <= "0000000000000000000000000000000" & din(30 downto 30);  else dout <= "1111111111111111111111111111111" & din(30 downto 30);  end if;
		elsif shift_val = "11111" then cout <= din(30) ;  if din(31) = '0' then dout <= "00000000000000000000000000000000"; else dout <= "11111111111111111111111111111111" ; end if;
		else  
			cout<=cin; 
			dout<=din;
		end if;

		report "shift_asr";
		
	elsif(shift = "01000") then  --ROR
		if    shift_val = "00001" then cout <= din(0) ;   dout <=  din(0 downto 0)  & din(31 downto 1);  
		elsif shift_val = "00010" then cout <= din(1) ;   dout <=  din(1 downto 0)  & din(31 downto 2);  
		elsif shift_val = "00011" then cout <= din(2) ;   dout <=  din(2 downto 0)  & din(31 downto 3);  
		elsif shift_val = "00100" then cout <= din(3) ;   dout <=  din(3 downto 0)  & din(31 downto 4);  
		elsif shift_val = "00101" then cout <= din(4) ;   dout <=  din(4 downto 0)  & din(31 downto 5);  
		elsif shift_val = "00110" then cout <= din(5) ;   dout <=  din(5 downto 0)  & din(31 downto 6);  
		elsif shift_val = "00111" then cout <= din(6) ;   dout <=  din(6 downto 0)  & din(31 downto 7);  
		elsif shift_val = "01000" then cout <= din(7) ;   dout <=  din(7 downto 0)  & din(31 downto 8);  
		elsif shift_val = "01001" then cout <= din(8) ;   dout <=  din(8 downto 0)  & din(31 downto 9);  
		elsif shift_val = "01010" then cout <= din(9) ;   dout <=  din(9 downto 0)  & din(31 downto 10); 
		elsif shift_val = "01011" then cout <= din(10) ;  dout <=  din(10 downto 0) & din(31 downto 11); 
		elsif shift_val = "01100" then cout <= din(11) ;  dout <=  din(11 downto 0) & din(31 downto 12); 
		elsif shift_val = "01101" then cout <= din(12) ;  dout <=  din(12 downto 0) & din(31 downto 13); 
		elsif shift_val = "01110" then cout <= din(13) ;  dout <=  din(13 downto 0) & din(31 downto 14); 
		elsif shift_val = "01111" then cout <= din(14) ;  dout <=  din(14 downto 0) & din(31 downto 15); 
		elsif shift_val = "10000" then cout <= din(15) ;  dout <=  din(15 downto 0) & din(31 downto 16); 
		elsif shift_val = "10001" then cout <= din(16) ;  dout <=  din(16 downto 0) & din(31 downto 17); 
		elsif shift_val = "10010" then cout <= din(17) ;  dout <=  din(17 downto 0) & din(31 downto 18); 
		elsif shift_val = "10011" then cout <= din(18) ;  dout <=  din(18 downto 0) & din(31 downto 19); 
		elsif shift_val = "10100" then cout <= din(19) ;  dout <=  din(19 downto 0) & din(31 downto 20); 
		elsif shift_val = "10101" then cout <= din(20) ;  dout <=  din(20 downto 0) & din(31 downto 21); 
		elsif shift_val = "10110" then cout <= din(21) ;  dout <=  din(21 downto 0) & din(31 downto 22); 
		elsif shift_val = "10111" then cout <= din(22) ;  dout <=  din(22 downto 0) & din(31 downto 23); 
		elsif shift_val = "11000" then cout <= din(23) ;  dout <=  din(23 downto 0) & din(31 downto 24); 
		elsif shift_val = "11001" then cout <= din(24) ;  dout <=  din(24 downto 0) & din(31 downto 25); 
		elsif shift_val = "11010" then cout <= din(25) ;  dout <=  din(25 downto 0) & din(31 downto 26); 
		elsif shift_val = "11011" then cout <= din(26) ;  dout <=  din(26 downto 0) & din(31 downto 27); 
		elsif shift_val = "11100" then cout <= din(27) ;  dout <=  din(27 downto 0) & din(31 downto 28); 
		elsif shift_val = "11101" then cout <= din(28) ;  dout <=  din(28 downto 0) & din(31 downto 29); 
		elsif shift_val = "11110" then cout <= din(29) ;  dout <=  din(29 downto 0) & din(31 downto 30); 
		elsif shift_val = "11110" then cout <= din(30) ;  dout <=  din(30 downto 0) & din(31 downto 31); 
		else  
			cout<=cin; 
			dout<=din;
		end if;

		report "shift_ror";
	
elsif(shift = "10000") then  --RRX
	cout <= din(0) ;  
	dout <= cin & din(31 downto 1);

	report "shift_rrx";
	
else  
	cout<=cin; 
	dout<=din;

	report "shift_nothing";

	
end if;
end process;
end archi;