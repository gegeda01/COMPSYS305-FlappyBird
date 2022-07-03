library ieee;
use ieee.std_logic_1164.all; 

entity game_state is
port(
	clk : in std_logic;
	pb1, pb2, dead : in std_logic;
	bt0, bt1, sw0 : in std_logic;
	state_out : out std_logic_vector(1 downto 0);
	mode : out std_logic;
	--pause	: out std_logic;
	reset	: out std_logic
);
end game_state;

architecture behavior of game_state is 
	type game_state is (menu, game, gg, paused); 
	signal current_state : game_state := menu;
	--signal pb1game : std_logic;
	
begin   


	 current_state <=  menu when ((current_state = menu) and pb1 ='0')else
							  game when ((current_state = menu) and pb1 ='1'and pb2 ='0'and bt0 ='1' and bt0 ='1')else
							  
							  game when ((current_state = game) and bt0 ='1' and dead = '0')else
							  paused when ((current_state = game) and bt0 ='0' )else
							  paused when ((current_state = paused) and  bt1 ='1')else
							  game when ((current_state = paused) and bt1 ='0' and bt0 ='1' )else
							  game when ((current_state = game) and dead ='0')else
							  gg when ((current_state = game) and dead ='1')else
							  gg when ((current_state = gg) and ((pb1 ='1' and pb2 ='1') or (pb2 ='0' and pb1 ='0')))else
							  game when ((current_state = gg) and pb1 ='1' and pb2 ='0')else
							  menu when ((current_state = gg) and pb2 ='1' and pb1 ='0')else gg;
       
       
							
							
							
							
							
							
							
							
							
	reset <= '1' when (current_state = gg or current_state = menu)else
				'0' when (current_state = game);
		
	

	process(current_state,sw0)
	begin 
		case current_state is 
			when menu =>  
					
					mode <= '0';
					
					if (sw0 = '1')then
						mode <= '1';
					end if;
					
					state_out <= "00";
			when game =>  
					state_out <= "01";
			when gg => 
					state_out <= "10";
			when paused => 
					state_out <= "11";
			end case; 
		end process;

end behavior; 