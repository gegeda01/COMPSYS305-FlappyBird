library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;


entity ito7seg is
	port(Clk : in std_logic;
		state_in : in std_logic_vector(1 downto 0);
	     lifeout : out bit_vector(7 downto 0)
	);
end entity;

architecture behaviour of ito7seg is
	signal tmp : bit_vector(7 downto 0) := "11111111" ;
	signal timer : std_logic:= '0' ;
begin

	tmp <=  "11001111"  when timer = '0' else -- 0
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