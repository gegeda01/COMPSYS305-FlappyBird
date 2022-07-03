library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;


entity lifeto7seg is
	port(Clk : in std_logic;
	     life : in std_logic_vector(3 downto 0);
		  state_in : in std_logic_vector(1 downto 0);
	     lifeout : out bit_vector(7 downto 0)
	);
end entity;

architecture behaviour of lifeto7seg is
	signal tmp : bit_vector(7 downto 0) := "11111111" ;
	signal timer : std_logic:= '0' ;
begin

	tmp <=  "10000110"  when timer = '0' else
		"11111001"  when life = "0001" and (state_in = "01" or state_in = "11") and timer = '1' else -- 1
		"10100100"  when life = "0010" and (state_in = "01" or state_in = "11") and timer = '1' else -- 2
		"10110000"  when life = "0011" and (state_in = "01" or state_in = "11") and timer = '1' else -- 3
		"10011001"  when life = "0100" and (state_in = "01" or state_in = "11") and timer = '1' else -- 4
		"10010010"  when life = "0101" and (state_in = "01" or state_in = "11") and timer = '1' else -- 5
		"10000010"  when life = "0110" and (state_in = "01" or state_in = "11") and timer = '1' else -- 6
		"11111000"  when life = "0111" and (state_in = "01" or state_in = "11") and timer = '1' else -- 7
		"10000000"  when life = "1000" and (state_in = "01" or state_in = "11") and timer = '1' else -- 8
		"10010000"  when life = "1001" and (state_in = "01" or state_in = "11") and timer = '1' else -- 9
		"11000000"  when life = "0000" and (state_in = "01" or state_in = "11") and timer = '1' else -- 0
		--"10000110"  when timer = '0' else -- 0
		"11111111";
	lifeout <= tmp when (state_in = "01" or state_in = "11") else "11111111";
process(Clk)	
begin
	if (rising_edge(Clk)) then	
	    if(timer = '0')then
			timer <= '1';
		 elsif(timer = '1')then
			timer <= '0';
		 end if;
	end if;
end process;
		 
end architecture behaviour; 