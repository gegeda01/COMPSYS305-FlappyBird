LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;


ENTITY bouncy_ball IS
	PORT
		( 
		  pb1, pb2, clk, vert_sync	: IN std_logic;
        pixel_row, pixel_column	: IN std_logic_vector(9 DOWNTO 0);
		  ball_on_out, start_out : OUT std_logic;
		  click_n_out : out std_logic_vector(2 downto 0);
		  state_in : in std_logic_vector(1 downto 0);
		  --pb2_Enable : in std_logic;
		   ball_xpos: out std_logic_vector(10 DOWNTO 0);
		  ball_ypos: out std_logic_vector(9 DOWNTO 0);
		  doge_row_address_init : out std_logic_vector(7 downto 0);
		  mode : in std_logic;
		  speed_up : in std_logic;
		  reset : in std_logic
		 );		
END bouncy_ball;

architecture behavior of bouncy_ball is

SIGNAL ball_on					: std_logic;
SIGNAL size 					: std_logic_vector(9 DOWNTO 0);  
SIGNAL ball_y_pos				: std_logic_vector(9 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(240,10);
SiGNAL ball_x_pos				: std_logic_vector(10 DOWNTO 0) := CONV_STD_LOGIC_VECTOR(210,11);
SIGNAL ball_y_motion			: std_logic_vector(9 DOWNTO 0);
signal pre_pb1 : std_logic := pb1;
signal start : std_logic := '0';
signal fly : std_logic_vector(9 DOWNTO 0);
signal click_n : std_logic_vector(2 downto 0);
signal downspeed : integer range -5 to 255 := 1;

BEGIN           

doge_row_address_init <= CONV_STD_LOGIC_VECTOR(conv_integer(unsigned(ball_y_pos)) - conv_integer(unsigned(size)),8);

--start_out <= start;
size <= CONV_STD_LOGIC_VECTOR(8,10);
fly <= - CONV_STD_LOGIC_VECTOR(100,10);
-- ball_x_pos and ball_y_pos show the (x,y) for the centre of ball

ball_on <= '1' when ( ('0' & ball_x_pos <= '0' & pixel_column + size) and ('0' & pixel_column <= '0' & ball_x_pos + size) 	-- x_pos - size <= pixel_column <= x_pos + size
					and ('0' & ball_y_pos <= pixel_row + size) and ('0' & pixel_row <= ball_y_pos + size) )  else	-- y_pos - size <= pixel_row <= y_pos + size
			'0';
ball_on_out <= ball_on;
click_n_out <= click_n;

ball_xpos <= ball_x_pos;
ball_ypos <= ball_y_pos;

process(speed_up,reset)
	begin
		if (reset = '1') then
		downspeed <= 0;
		end if;
		if(speed_up = '1') then
			downspeed <= downspeed + 1;
		end if;
		if(downspeed = 21)then
		   downspeed <= 21;
			end if;
	end process;

Move_Ball: process (vert_sync, state_in,mode, reset)  	
begin
	-- Move ball once every vertical sync
	if (rising_edge(vert_sync)) then			
	   if (pb1 /= pre_pb1) then
		  if(pb1 = '1' and state_in = "01") then
			 ball_y_motion <= fly;
			 click_n <= click_n + 1;
			 if(start = '0' and state_in = "01") then
				start <= '1';
			 end if;
		  end if;
		  pre_pb1 <= pb1;
		else
			if(start = '1' ) then
				if(state_in = "01") then
					if(mode = '0')then
						ball_y_motion <= CONV_STD_LOGIC_VECTOR(1,10);
						elsif(mode = '1') then
						if(downspeed <= 10)then
						ball_y_motion <= CONV_STD_LOGIC_VECTOR(2  ,10);
						elsif(downspeed <= 20 and downspeed > 10)then
						ball_y_motion <= CONV_STD_LOGIC_VECTOR(3  ,10);
						else
						ball_y_motion <= CONV_STD_LOGIC_VECTOR(4  ,10);
						end if;
						end if;
				elsif(state_in = "11") then
				ball_y_motion <= CONV_STD_LOGIC_VECTOR(0,10);
				end if;
			end if;
		end if;
		-- Compute next ball Y position
		if (reset = '1') then
			ball_y_pos <=  CONV_STD_LOGIC_VECTOR(240,10);
		else
			ball_y_pos <= ball_y_pos + ball_y_motion;
			if (ball_y_pos <= 0) then
				ball_y_pos <= size;
			elsif ('0' & ball_y_pos >= CONV_STD_LOGIC_VECTOR(479,10) - size) then
				ball_y_pos <= size;
			end if;
		end if;
	end if;
end process Move_Ball;
END behavior;


