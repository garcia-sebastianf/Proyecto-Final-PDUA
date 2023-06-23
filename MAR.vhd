LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
--------------------------------------------
ENTITY MAR IS
	GENERIC(MAX_WIDTH	:	INTEGER	:= 8);
	PORT (	clk	:	IN		STD_LOGIC;
			   rst	:	IN		STD_LOGIC;
			   en 	:	IN		STD_LOGIC;
			   d		:	IN		STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0);
			   q		:	OUT	STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0));
END ENTITY;
--------------------------------------------
ARCHITECTURE structural OF MAR IS
BEGIN
my_reg_gen:	FOR i IN 0 TO MAX_WIDTH-1 GENERATE
		DFFx:	ENTITY work.my_dff
				PORT MAP (	clk	=> clk,
							   rst	=> rst,
							   ena	=> en,
							   d	=> d(i),
							   q	=> q(i));
			END GENERATE;
END ARCHITECTURE;