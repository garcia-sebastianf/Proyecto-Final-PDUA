LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
--------------------------------------------
ENTITY IR IS
	GENERIC(MAX_WIDTH	:	INTEGER	:= 8);
	PORT (	clk	:	IN		STD_LOGIC;
			   rst	:	IN		STD_LOGIC;
			   en 	:	IN		STD_LOGIC;
				sclr  :  IN    STD_LOGIC;
			   d		:	IN		STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0);
			   q		:	OUT	STD_LOGIC_VECTOR(MAX_WIDTH-4 DOWNTO 0));
END ENTITY;
--------------------------------------------
ARCHITECTURE structural OF IR IS

SIGNAL q_s 	:	STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN
my_reg_gen:	FOR i IN 0 TO MAX_WIDTH-1 GENERATE
		DFFx:	ENTITY work.my_dff_sclr
				PORT MAP (	clk	=> clk,
							   rst	=> rst,
							   ena	=> en,
								sclr  => sclr,
							   d	=> d(i),
							   q	=> q_s(i));
			END GENERATE;
			
q <= q_s(MAX_WIDTH-1 DOWNTO MAX_WIDTH-5);

END ARCHITECTURE;