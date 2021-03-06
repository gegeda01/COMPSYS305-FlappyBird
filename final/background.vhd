LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;
use ieee.numeric_std.all;

entity background is
  port(clock_25Mhz, vert_sync, ball_on : in	std_logic;
		 state_in : in std_logic_vector(1 downto 0);
       pixel_row, pixel_column	: in std_logic_vector(9 downto 0);
       red, green, blue : out std_logic_vector(3 downto 0);
		 mode : in std_logic;
		 click_n : in std_logic_vector(2 downto 0);
		 rom_mux : in std_logic;
		 mouse_Enable : in std_logic;
		 speed_up : in std_logic;
		 score_up : out std_logic;
		 background_address : in std_logic_vector(11 downto 0);
		 --pb2 : in std_logic;
		  ball_xpos: in std_logic_vector(10 DOWNTO 0);
		  ball_ypos: in std_logic_vector(9 DOWNTO 0);
		 --Pb2_Enable_out : out std_logic;
		  dead : out std_logic;
		  title_data : in std_logic_vector(11 downto 0);
		 eve_background_data : in std_logic_vector(11 downto 0);
		 sw9 : in std_logic;
		 lives: out std_logic_vector(3 downto 0);
		 doge_data : in std_logic_vector(11 downto 0);
		 reset : in std_logic
		 );
end entity background;

architecture behaviour of background is
  signal pipe_on, pipe2_on, pipe3_on : std_logic;
  signal gap_height : std_logic_vector(9 downto 0);
  signal gap_width : std_logic_vector(10 downto 0);
  signal pipe_y_pos				: std_logic_vector(9 DOWNTO 0);
  signal pipe_x_pos				: std_logic_vector(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(680,11);
  signal pipe2_y_pos				: std_logic_vector(9 DOWNTO 0);
  signal pipe2_x_pos				: std_logic_vector(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(680,11);
  signal pipe3_y_pos				: std_logic_vector(9 DOWNTO 0);
  signal pipe3_x_pos				: std_logic_vector(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(680,11);
  SIGNAL pipe_x_motion			: std_logic_vector(10 DOWNTO 0);
   signal ball_x_pos: std_logic_vector(10 DOWNTO 0);
	signal ball_y_pos: std_logic_vector(9 DOWNTO 0);
	signal ball_size: std_logic_vector(9 DOWNTO 0);
	signal lives_number : std_logic_vector(3 downto 0):="0001";
  signal gift_enable: std_logic:='1';
  signal gift_on : std_logic;
  signal gift_size :  std_logic_vector(9 DOWNTO 0);
  signal pipe2_Enable, pipe3_Enable : std_logic := '0';
  signal pipe1_Enable : std_logic := '1';
  signal random_cntr : std_logic_vector(7 downto 0);
  --signal pb2_Enable : std_logic := '0';
  signal speed : integer range -5 to 255 := 0;

begin

	--pb2_Enable_out <= pb2_Enable;
	--process(pb2)
	--begin

		--if(rising_edge(pb2)) then
			--pb2_Enable <= '1';
		--end if;
	--end process;
	
  gap_height <= CONV_STD_LOGIC_VECTOR(150 - speed *100,10) when (mode = '1') else
				  CONV_STD_LOGIC_VECTOR(150,10);
				  
  gap_width <= CONV_STD_LOGIC_VECTOR(80 + speed *100,11) when (mode = '1') else
				  CONV_STD_LOGIC_VECTOR(80,11);
  
  gift_size <= CONV_STD_LOGIC_VECTOR(5,10);
  
  ball_x_pos <= ball_xpos;
  ball_y_pos <= ball_ypos;
  ball_size <= CONV_STD_LOGIC_VECTOR(8,10);
  
  
  gift_on <='1' when ( ('0' & pipe_x_pos+conv_integer(gap_width)/2 <= '0' & pixel_column + gift_size) and ('0' & pixel_column <= '0' & pipe_x_pos+conv_integer(gap_width)/2 + gift_size) 	-- x_pos - size <= pixel_column <= x_pos + size
					and ('0' & pipe_y_pos +conv_integer(gap_width)/2 <= pixel_row + gift_size) and ('0' & pixel_row <= pipe_y_pos +conv_integer(gap_width)/2 + gift_size)and gift_enable = '1')  else	-- y_pos - size <= pixel_row <= y_pos + size
			'0';
  
  pipe_on <= '1' when (('0' & pixel_row <= '0' & pipe_y_pos) or ('0' & pixel_row >= '0' & pipe_y_pos + gap_height)) and
                      (('0' & pixel_column >= '0' & pipe_x_pos) and ('0' & pixel_column <= '0' & pipe_x_pos + gap_width) and
							  pipe1_Enable = '1') else
             '0';
				 
  pipe2_on <= '1' when (('0' & pixel_row <= '0' & pipe2_y_pos) or ('0' & pixel_row >= '0' & pipe2_y_pos + gap_height)) and
                       (('0' & pixel_column >= '0' & pipe2_x_pos) and ('0' & pixel_column <= '0' & pipe2_x_pos + gap_width) and
							   pipe2_Enable = '1') else
             '0';
				 
  pipe3_on <= '1' when (('0' & pixel_row <= '0' & pipe3_y_pos) or ('0' & pixel_row >= '0' & pipe3_y_pos + gap_height)) and
                       (('0' & pixel_column >= '0' & pipe3_x_pos) and ('0' & pixel_column <= '0' & pipe3_x_pos + gap_width) and
							   pipe3_Enable = '1') else
             '0';
				 
  random_cntr <= random_cntr + conv_integer(click_n) * 33;
  pipe_y_pos <= "00" & (random_cntr + 40) when pipe_x_pos = CONV_STD_LOGIC_VECTOR(680,11);
  pipe2_y_pos <= "00" & (random_cntr + 40) when pipe2_x_pos = CONV_STD_LOGIC_VECTOR(680,11);
  pipe3_y_pos <= "00" & (random_cntr + 40) when pipe3_x_pos = CONV_STD_LOGIC_VECTOR(680,11);
  
  score_up <= '1' when ('0' & pipe_x_pos + gap_width = CONV_STD_LOGIC_VECTOR(202,11)) else
				  '1' when ('0' & pipe2_x_pos + gap_width = CONV_STD_LOGIC_VECTOR(202,11)) else
				  '1' when ('0' & pipe3_x_pos + gap_width = CONV_STD_LOGIC_VECTOR(202,11)) else '0';
	lives <= lives_number;
   dead<='1' when lives_number ="0000" else'0';
     
 
			--end if;
	process(speed_up)
	begin
		if(speed_up = '1') then
			speed <= speed + 1;
		end if;
		if(speed <= 10)then
		   speed <= 0;
			end if;
	end process;
			
Colour_Setting: process(background_address, ball_on, pipe_on, pipe2_on, pipe3_on, mouse_Enable, rom_mux,gift_on, sw9)
begin
	if(ball_on = '1' and (state_in = "01" or state_in = "11") and doge_data /= "000000000000") then
		red <= doge_data(11 downto 8);
		green <= doge_data(7 downto 4);
		blue <= doge_data(3 downto 0);
	elsif(rom_mux = '1') then
		red <= "1111";
		green <= "1001";
		blue <= "0000";
	elsif((pipe_on = '1' or pipe2_on = '1' or pipe3_on = '1') and (state_in = "01" or state_in = "11") and sw9 = '0') then
		red <= "0000";
		green <= "1111";
		blue <= "0000";
	elsif((pipe_on = '1' or pipe2_on = '1' or pipe3_on = '1') and (state_in = "01" or state_in = "11") and sw9 = '1') then
		red <= "0010";
		green <= "1001";
		blue <= "0010";
	elsif(mouse_Enable = '1') then
		red <= "0000";
		green <= "0000";
		blue <= "0000";
	elsif((gift_on='1') and (state_in = "01" or state_in = "11")) then
		red<= "1110";
		green <= "1010";
		blue <= "0000";
	elsif(state_in = "00" and title_data <= CONV_STD_LOGIC_VECTOR(4095,12) and title_data /= "010111001101" ) then
		red <= title_data(11 downto 8);
		green <= title_data(7 downto 4);
		blue <= title_data(3 downto 0);
	elsif(sw9 = '1') then
		red <= eve_background_data(11 downto 8);
		green <= eve_background_data(7 downto 4);
		blue <= eve_background_data(3 downto 0);
	elsif(sw9 = '0') then
		red <= background_address(11 downto 8);
		green <= background_address(7 downto 4);
		blue <= background_address(3 downto 0);
	end if;
end process Colour_Setting;
			
Move_Pipe: process (reset, vert_sync, state_in)  	
begin
	--if((pb2_Enable = '1')) then
	if(state_in = "01") then
	
	if (reset = '1') then
			pipe3_x_pos <= CONV_STD_LOGIC_VECTOR(680,11);
			pipe2_x_pos <= CONV_STD_LOGIC_VECTOR(680,11);
			pipe_x_pos <= CONV_STD_LOGIC_VECTOR(680,11);
			pipe_x_motion <= CONV_STD_LOGIC_VECTOR(0,11);
			pipe1_Enable <= '1';
			pipe2_Enable <= '0';
			pipe3_Enable <= '0';
			
			else
			pipe_x_motion <= - CONV_STD_LOGIC_VECTOR(3,11);
			if (rising_edge(vert_sync)) then
		
				pipe_x_motion <= - CONV_STD_LOGIC_VECTOR(3,11);
				if(pipe_x_pos <= CONV_STD_LOGIC_VECTOR(380,11)) then
					pipe2_Enable <= '1';
				end if;
				if(pipe2_x_pos <= CONV_STD_LOGIC_VECTOR(380,11)) then
					pipe3_Enable <= '1';
				end if;
				if(pipe3_x_pos <= CONV_STD_LOGIC_VECTOR(380,11)) then
					pipe1_Enable <= '1';
				end if;
		
				if(pipe1_Enable = '1' ) then
					pipe_x_pos <= pipe_x_pos + pipe_x_motion;
				end if;
				if(pipe2_Enable = '1' ) then
					pipe2_x_pos <= pipe2_x_pos + pipe_x_motion;
				end if;
				if(pipe3_Enable = '1' ) then
					pipe3_x_pos <= pipe3_x_pos + pipe_x_motion;
				end if;
		
		if((pipe_x_pos <= - gap_width))then
			pipe_x_pos <= CONV_STD_LOGIC_VECTOR(680,11);
			pipe1_Enable <= '0';
		elsif((pipe2_x_pos <= - gap_width))then
			pipe2_x_pos <= CONV_STD_LOGIC_VECTOR(680,11);
			pipe2_Enable <= '0';
		elsif((pipe3_x_pos <= - gap_width))then
			pipe3_x_pos <= CONV_STD_LOGIC_VECTOR(680,11);
			pipe3_Enable <= '0';
		end if;
		
		
	end if;
		end if;
		
		
	
	
	end if;

end process Move_Pipe;


Dead_Gift: process(state_in,vert_sync,mode,ball_x_pos,ball_y_pos,pipe_x_pos,pipe_y_pos,ball_size,gap_width,gap_height,lives_number,gift_size,gift_enable)
begin
  if(state_in="01") then --When game started
 
   if (rising_edge(vert_sync)) then
     lives_number<=lives_number;
	if(mode='0' and reset='1') then--training
	  lives_number<="0101";
	elsif(mode='1' and reset='1') then--normal
	  lives_number<="0101";
	end if;
	
	if(ball_y_pos-ball_size<=pipe_y_pos)or(ball_y_pos+ball_size>=pipe_y_pos+gap_height) then
		if(((ball_x_pos+ball_size <= pipe_x_pos)AND((ball_x_pos+ball_size<= pipe_x_pos+ gap_width) and (ball_x_pos+ball_size>= pipe_x_pos)) ))then --check if top right edge is in the pipe
			lives_number<=lives_number-"0001";
		elsif(((ball_x_pos+ball_size >= pipe_x_pos)AND((ball_x_pos-ball_size<= pipe_x_pos+ gap_width) and (ball_x_pos-ball_size>= pipe_x_pos)) ))then--checking if back end is in the pipe 
			lives_number<=lives_number-"0001";
		elsif((ball_x_pos-ball_size> pipe_x_pos)AND(ball_x_pos+ball_size < pipe_x_pos+ gap_width))then--checking if the bird is in the middle of the pipe
			lives_number<=lives_number-"0001";
		end if;
	end if;
	if(ball_y_pos-ball_size<=pipe2_y_pos)or(ball_y_pos+ball_size>=pipe2_y_pos+gap_height) then
		if(((ball_x_pos-ball_size <= pipe2_x_pos)AND((ball_x_pos+ball_size<= pipe2_x_pos+ gap_width) and (ball_x_pos+ball_size>= pipe2_x_pos)) ))then --check if top right edge is in the pipe
			lives_number<=lives_number-"0001";
		elsif(((ball_x_pos+ball_size >= pipe2_x_pos)AND((ball_x_pos-ball_size<= pipe2_x_pos+ gap_width) and (ball_x_pos-ball_size>= pipe2_x_pos)) ))then--checking if back end is in the pipe 
			lives_number<=lives_number-"0001";
		elsif((ball_x_pos-ball_size> pipe2_x_pos)AND(ball_x_pos+ball_size < pipe2_x_pos+ gap_width))then--checking if the bird is in the middle of the pipe
			lives_number<=lives_number-"0001";
		end if;
	end if;
	if(ball_y_pos-ball_size<=pipe3_y_pos)or(ball_y_pos+ball_size>=pipe3_y_pos+gap_height) then
		if(((ball_x_pos-ball_size <= pipe3_x_pos)AND((ball_x_pos+ball_size<= pipe3_x_pos+ gap_width) and (ball_x_pos+ball_size>= pipe3_x_pos)) ))then --check if top right edge is in the pipe
			lives_number<=lives_number-"0001";
		elsif(((ball_x_pos+ball_size >= pipe3_x_pos)AND((ball_x_pos-ball_size<= pipe3_x_pos+ gap_width) and (ball_x_pos-ball_size>= pipe3_x_pos)) ))then--checking if back end is in the pipe 
			lives_number<=lives_number-"0001";
		elsif((ball_x_pos-ball_size> pipe3_x_pos)AND(ball_x_pos+ball_size < pipe3_x_pos+ gap_width))then--checking if the bird is in the middle of the pipe
			lives_number<=lives_number-"0001";
		end if;
	end if;
	if(ball_y_pos-ball_size<= pipe_y_pos +conv_integer(gap_width)/2)or(ball_y_pos+ball_size>= pipe_y_pos +conv_integer(gap_width)/2+gift_size) then
		if(((ball_x_pos+ball_size <= pipe_x_pos+conv_integer(gap_width)/2)AND((ball_x_pos+ball_size<= pipe_x_pos+conv_integer(gap_width)/2+ gift_size) and (ball_x_pos+ball_size>= pipe_x_pos+conv_integer(gap_width)/2)) ))then --check if top right edge is in the pipe
			lives_number<=lives_number+"0001";
			gift_enable<='0';
		elsif(((ball_x_pos+ball_size >= pipe_x_pos+conv_integer(gap_width)/2)AND((ball_x_pos-ball_size<= pipe_x_pos+conv_integer(gap_width)/2+ gift_size) and (ball_x_pos-ball_size>= pipe_x_pos+conv_integer(gap_width)/2)) ))then--checking if back end is in the pipe 
			lives_number<=lives_number+"0001";
			gift_enable<='0';
		elsif((ball_x_pos-ball_size> pipe_x_pos+conv_integer(gap_width)/2)AND(ball_x_pos+ball_size < pipe_x_pos+conv_integer(gap_width)/2+ gift_size))then--checking if the bird is in the middle of the pipe
			lives_number<=lives_number+"0001";
			gift_enable<='0';
		end if;
	end if;
	if ('0' & ball_y_pos >= CONV_STD_LOGIC_VECTOR(479,10) - ball_size) then
		lives_number<=lives_number-"0001";
	end if;
	if(pipe_x_pos <= - gap_width) then
			gift_enable<='1';
		end if;
	
   end if;
	
  end if;
    
  
  
end process Dead_Gift; 

end architecture behaviour;

