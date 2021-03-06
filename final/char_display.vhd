LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_SIGNED.all;
use  ieee.math_real.all;

entity char_display is
port(
		state_in : in std_logic_vector(1 downto 0);
      pixel_row, pixel_column : in std_logic_vector(9 downto 0);
      character_address : out std_logic_vector(5 downto 0);
      font_row, font_column : out std_logic_vector(2 downto 0);
		--start : in std_logic;
		score_up : in std_logic;
		background_address : out std_logic_vector(12 downto 0);
		--pb2_Enable : in std_logic;
		speed_up : out std_logic;
		ball_on : in std_logic;
		doge_row_address_init : in std_logic_vector(7 downto 0);
		reset:in std_logic;
		title_address : out std_logic_vector(12 downto 0);
		doge_address : out std_logic_vector(7 downto 0));
end entity char_display;

architecture behaviour of char_display is
  signal temp_address : std_logic_vector(5 downto 0) := CONV_STD_LOGIC_VECTOR(0,6);
  signal temp_address_2 : std_logic_vector(5 downto 0) := CONV_STD_LOGIC_VECTOR(0,6);
  signal temp_address_3 : std_logic_vector(12 downto 0) := CONV_STD_LOGIC_VECTOR(0,13);
  signal temp_address_4 : std_logic_vector(12 downto 0) := CONV_STD_LOGIC_VECTOR(0,13);
  signal temp_address_5 : std_logic_vector(5 downto 0) := CONV_STD_LOGIC_VECTOR(0,6);
  signal temp_address_6 : std_logic_vector(5 downto 0) := CONV_STD_LOGIC_VECTOR(0,6);    
  signal temp_address_7 : std_logic_vector(7 downto 0) := CONV_STD_LOGIC_VECTOR(0,8);    
  signal oneth_score_address : std_logic_vector(5 downto 0) := CONV_STD_LOGIC_VECTOR(48,6);
  signal tenth_score_address : std_logic_vector(5 downto 0) := CONV_STD_LOGIC_VECTOR(48,6);
  signal tenth_score_Enable : std_logic := '0';
  signal hundred_score_address : std_logic_vector(5 downto 0) := CONV_STD_LOGIC_VECTOR(48,6);
  signal hundred_score_Enable : std_logic := '0';
  signal score_limit_reached : std_logic := '0';
  
begin
	 character_address <= temp_address when state_in = "00" else
								 temp_address_2 when state_in = "01" else
								 --temp_address_4 when state_in = "00" else
								 temp_address_5 when state_in = "10" else
								 temp_address_6 when state_in = "11";
								 
	 speed_up <= score_up;							 
	 background_address <= temp_address_3;
	 title_address <= temp_address_4;
	 doge_address <= temp_address_7;
	 
	 font_row <= pixel_row(3 downto 1) ;--when (state_in = "01") else
	            -- pixel_row(4 downto 2) when (state_in = "00");
	 font_column <= pixel_column(3 downto 1); --when (state_in = "01")else
	               -- pixel_column(4 downto 2) when (state_in = "00");
	 
    temp_address <=CONV_STD_LOGIC_VECTOR(3,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(160,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(175,10)) and        --C
	                                                 ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(224,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(239,10)) else
																	 
					     CONV_STD_LOGIC_VECTOR(12,6)  when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(160,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(175,10)) and       --L
	                                                 ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(240,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(255,10)) else
																	 
					     CONV_STD_LOGIC_VECTOR(9,6)  when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(160,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(175,10)) and         --I
	                                                 ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(256,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(271,10)) else
																
					     CONV_STD_LOGIC_VECTOR(3,6)	 when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(160,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(175,10)) and      --C
	                                                 ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(272,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(287,10)) else
																	 
					     CONV_STD_LOGIC_VECTOR(11,6)	 when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(160,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(175,10)) and      --K
	                                                 ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(288,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(303,10)) else
																	 
						  CONV_STD_LOGIC_VECTOR(20,6)	 when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(160,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(175,10)) and        --T
	                                                 ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(320,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(335,10)) else
																	 
					     CONV_STD_LOGIC_VECTOR(15,6)	 when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(160,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(175,10)) and      --O
	                                                 ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(336,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(351,10)) else
																	 
						  CONV_STD_LOGIC_VECTOR(19,6)  when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(160,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(175,10)) and       --S
	                                                 ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(368,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(383,10)) else
																
					     CONV_STD_LOGIC_VECTOR(20,6)	 when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(160,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(175,10)) and       --T
	                                                 ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(384,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(399,10)) else
																	 
					     CONV_STD_LOGIC_VECTOR(1,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(160,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(175,10)) and       --A
	                                                 ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(400,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(415,10)) else
																	 
						  CONV_STD_LOGIC_VECTOR(18,6)	 when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(160,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(175,10)) and      --R
	                                                 ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(416,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(431,10)) else
																	 
					     CONV_STD_LOGIC_VECTOR(20,6)	 when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(160,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(175,10)) and       --T
	                                                 ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(432,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(447,10)) else
						



							CONV_STD_LOGIC_VECTOR(19,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(288,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(303,10)) and  --S
	                                             ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(64,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(79,10))  else
																
							CONV_STD_LOGIC_VECTOR(23,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(288,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(303,10)) and  --W
	                                             ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(80,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(95,10))  else
																
							CONV_STD_LOGIC_VECTOR(57,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(288,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(303,10)) and  --9
	                                            ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(96,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(111,10))  else
															  
					      CONV_STD_LOGIC_VECTOR(45,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(288,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(303,10)) and  --'-'
	                                             ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(112,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(127,10))  else
																
							CONV_STD_LOGIC_VECTOR(2,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(288,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(303,10)) and  --B
	                                           ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(128,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(143,10)) else
																
	                  				CONV_STD_LOGIC_VECTOR(1,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(288,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(303,10)) and  --A
	                                             ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(144,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(159,10)) else
																
							CONV_STD_LOGIC_VECTOR(3,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(288,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(303,10)) and  --C
	                                      ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(160,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(175,10)) else
																
							CONV_STD_LOGIC_VECTOR(11,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(288,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(303,10)) and  --K
	                                            ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(176,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(191,10)) else
																
							CONV_STD_LOGIC_VECTOR(7,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(288,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(303,10)) and   --G
	                                             ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(192,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(207,10)) else
																
							CONV_STD_LOGIC_VECTOR(18,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(288,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(303,10)) and   --R
	                                            ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(208,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(223,10)) else
																
							CONV_STD_LOGIC_VECTOR(15,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(288,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(303,10)) and   --O
	                                            ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(224,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(239,10)) else 
																
							CONV_STD_LOGIC_VECTOR(21,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(288,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(303,10)) and   --U
	                                           ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(240,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(255,10)) else 
																
							CONV_STD_LOGIC_VECTOR(14,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(288,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(303,10)) and   --N
	                                            ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(256,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(271,10)) else 
																
	                 				 CONV_STD_LOGIC_VECTOR(4,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(288,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(303,10)) and   --D
	                                             ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(272,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(287,10)) else                         
								
								
							CONV_STD_LOGIC_VECTOR(19,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(384,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(399,10)) and  --S
	                                             ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(64,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(79,10))  else
																
							CONV_STD_LOGIC_VECTOR(23,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(384,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(399,10)) and  --W
	                                             ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(80,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(95,10))  else
																
							CONV_STD_LOGIC_VECTOR(48,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(384,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(399,10)) and  --0
	                                             ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(96,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(111,10))  else
																
							CONV_STD_LOGIC_VECTOR(45,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(384,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(399,10)) and  --'-'
	                                             ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(112,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(127,10))  else
																
							CONV_STD_LOGIC_VECTOR(19,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(384,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(399,10)) and  --S
	                                             ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(128,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(143,10)) else
	                                             
							CONV_STD_LOGIC_VECTOR(5,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(384,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(399,10)) and  --E
	                                             ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(144,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(159,10)) else
	                                             
							CONV_STD_LOGIC_VECTOR(12,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(384,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(399,10)) and  --L
	                                             ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(160,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(175,10)) else
	                                             
							CONV_STD_LOGIC_VECTOR(5,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(384,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(399,10)) and  --E
	                                             ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(176,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(191,10)) else
	                                             
							CONV_STD_LOGIC_VECTOR(3,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(384,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(399,10)) and  --C
	                                             ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(192,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(207,10)) else
	                                             
							CONV_STD_LOGIC_VECTOR(20,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(384,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(399,10)) and  --T
	                                             ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(208,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(223,10)) else
	                                             
							CONV_STD_LOGIC_VECTOR(32,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(384,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(399,10)) and  --
	                                             ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(224,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(239,10)) else                                
	                                             
							CONV_STD_LOGIC_VECTOR(13,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(384,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(399,10)) and  -- 
	                                             ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(240,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(255,10)) else
	                                             
							CONV_STD_LOGIC_VECTOR(15,6)  when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(384,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(399,10)) and  --M
	                                             ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(256,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(271,10)) else
	                                             
							CONV_STD_LOGIC_VECTOR(4,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(384,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(399,10)) and  --O
	                                             ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(272,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(287,10)) else
	                                             
							CONV_STD_LOGIC_VECTOR(5,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(384,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(399,10)) and  --D
	                                             ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(288,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(303,10)) else
																
												
															   CONV_STD_LOGIC_VECTOR(0,6);  
                    
    temp_address_2 <= CONV_STD_LOGIC_VECTOR(19,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(48,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(63,10)) and        --S
	                                                 ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(192,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(207,10)) else
	                    CONV_STD_LOGIC_VECTOR(3,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(48,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(63,10)) and        --C
	                                                 ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(208,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(223,10)) else
	                    CONV_STD_LOGIC_VECTOR(15,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(48,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(63,10)) and        --O
	                                                 ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(224,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(239,10)) else
	                    CONV_STD_LOGIC_VECTOR(18,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(48,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(63,10)) and        --R
	                                                 ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(240,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(255,10)) else
	                    CONV_STD_LOGIC_VECTOR(5,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(48,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(63,10)) and        --E
	                                                 ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(256,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(271,10)) else


                oneth_score_address	when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(48,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(63,10)) and
																		  ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(320,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(335,10)) else
																		  
							 tenth_score_address	when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(48,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(63,10)) and
																		  ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(304,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(319,10)) and tenth_score_Enable = '1' else
																		  
							 hundred_score_address	when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(48,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(63,10)) and
																		  ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(288,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(303,10)) and hundred_score_Enable = '1' else
																		  
							 CONV_STD_LOGIC_VECTOR(43,6)	when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(48,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(63,10)) and                                       --Maximum socre output: 999+
																		  ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(336,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(351,10)) and score_limit_reached = '1' else
																		  
														         CONV_STD_LOGIC_VECTOR(0,6); 
		

	temp_address_3 <= (CONV_STD_LOGIC_VECTOR(conv_integer(unsigned(pixel_column))/8,13)) + conv_integer(unsigned(pixel_row))/8 * 85  when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(0,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(479,10)) and 
																																														('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(0,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(679,10)) else (others => '1');
		

	temp_address_4 <= (CONV_STD_LOGIC_VECTOR((conv_integer(unsigned(pixel_column))-131)/4,13)) + (conv_integer(unsigned(pixel_row))-31)/4*100  when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(31,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(223,10)) and 
																																														('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(131,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(530,10)) else (others => '1');
	
	
	temp_address_5 <= CONV_STD_LOGIC_VECTOR(7,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(208,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(223,10)) and  --G
																('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(192,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(207,10)) else
																
							CONV_STD_LOGIC_VECTOR(1,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(208,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(223,10)) and  --A
																('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(208,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(223,10)) else
																
							CONV_STD_LOGIC_VECTOR(13,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(208,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(223,10)) and --M
																('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(224,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(239,10)) else
																
							CONV_STD_LOGIC_VECTOR(5,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(208,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(223,10)) and --E 
																('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(240,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(255,10)) else
																
							CONV_STD_LOGIC_VECTOR(15,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(208,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(223,10)) and --O
																('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(272,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(287,10)) else
																
							CONV_STD_LOGIC_VECTOR(22,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(208,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(223,10)) and --V
																('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(288,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(303,10)) else
																
							CONV_STD_LOGIC_VECTOR(5,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(208,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(223,10)) and --E
																('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(304,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(319,10)) else
																
							CONV_STD_LOGIC_VECTOR(18,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(208,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(223,10)) and --R
																('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(320,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(335,10)) else 
                                    
                                    CONV_STD_LOGIC_VECTOR(0,6); 
	temp_address_6 <=  CONV_STD_LOGIC_VECTOR(16,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(240,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(255,10)) and     --P
                                                ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(288,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(303,10)) else
                                                
							 CONV_STD_LOGIC_VECTOR(1,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(240,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(255,10)) and     --A
                                                ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(304,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(319,10)) else
                                                                                 
							 CONV_STD_LOGIC_VECTOR(21,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(240,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(255,10)) and     --U
                                                ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(320,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(335,10)) else
																
							 CONV_STD_LOGIC_VECTOR(19,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(240,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(255,10)) and     --S
                                                ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(336,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(351,10)) else
                                                
							 CONV_STD_LOGIC_VECTOR(5,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(240,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(255,10)) and     --E
                                                ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(352,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(367,10)) else 
                                                
							 CONV_STD_LOGIC_VECTOR(4,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(240,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(255,10)) and     --U
                                                ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(368,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(383,10)) else 
                                                
                CONV_STD_LOGIC_VECTOR(16,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(288,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(303,10)) and     --P
                                                ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(240,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(255,10)) else

					CONV_STD_LOGIC_VECTOR(2,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(288,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(303,10)) and     --B
                                                ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(256,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(271,10)) else
					
					CONV_STD_LOGIC_VECTOR(49,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(288,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(303,10)) and     --1
                                                ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(272,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(287,10)) else
						
					CONV_STD_LOGIC_VECTOR(3,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(288,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(303,10)) and     --C
                                                ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(304,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(319,10)) else	

					CONV_STD_LOGIC_VECTOR(15,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(288,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(303,10)) and     --O
                                                ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(320,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(335,10)) else

					CONV_STD_LOGIC_VECTOR(14,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(288,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(303,10)) and     --N
                                                ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(336,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(351,10)) else

					CONV_STD_LOGIC_VECTOR(20,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(288,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(303,10)) and     --T
                                                ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(352,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(367,10)) else

					CONV_STD_LOGIC_VECTOR(9,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(288,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(303,10)) and     --I
                                                ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(368,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(383,10)) else

					CONV_STD_LOGIC_VECTOR(14,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(288,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(303,10)) and     --N
                                                ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(384,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(399,10)) else

					CONV_STD_LOGIC_VECTOR(21,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(288,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(303,10)) and     --U
                                                ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(400,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(415,10)) else

					CONV_STD_LOGIC_VECTOR(5,6) when ('0' & pixel_row >= '0' & CONV_STD_LOGIC_VECTOR(288,10)) and ('0' & pixel_row <= '0' & CONV_STD_LOGIC_VECTOR(303,10)) and     --E
                                                ('0' & pixel_column >= '0' & CONV_STD_LOGIC_VECTOR(416,10)) and ('0' & pixel_column <= '0' & CONV_STD_LOGIC_VECTOR(431,10)) else

                                
                  
												CONV_STD_LOGIC_VECTOR(0,6); 
										
	temp_address_7  <=  (CONV_STD_LOGIC_VECTOR((conv_integer(unsigned(pixel_column))-202),8)) + (conv_integer(unsigned(pixel_row))-conv_integer(unsigned(doge_row_address_init)))*16  when  ball_on = '1' else (others => '1');
	
process(score_up,reset)
	begin
	  if(reset='0') then
		if(rising_edge(score_up)) then
			if(oneth_score_address <= CONV_STD_LOGIC_VECTOR(56,6)) then
				oneth_score_address <=  oneth_score_address + 1;
			else
				oneth_score_address <= CONV_STD_LOGIC_VECTOR(48,6);
				if(tenth_score_address <= CONV_STD_LOGIC_VECTOR(56,6)) then
					tenth_score_address <=  tenth_score_address + 1;
				else
					tenth_score_address <= CONV_STD_LOGIC_VECTOR(48,6);
					if(hundred_score_address <= CONV_STD_LOGIC_VECTOR(56,6)) then
						hundred_score_address <=  hundred_score_address + 1;
					else
						score_limit_reached <= '1';
					end if;
					hundred_score_Enable <= '1';
				end if;
				tenth_score_Enable <= '1';
			end if;
		end if;
		else
		  oneth_score_address <= CONV_STD_LOGIC_VECTOR(48,6);
		  tenth_score_address <= CONV_STD_LOGIC_VECTOR(48,6);
		  tenth_score_Enable <= '0';
		  hundred_score_address <= CONV_STD_LOGIC_VECTOR(48,6);
		  hundred_score_Enable <= '0';
		  score_limit_reached <= '0';
		 end if;
	end process;
end architecture behaviour;