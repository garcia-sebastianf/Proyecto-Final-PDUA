LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
--------------------------------------------
ENTITY my_regDFF IS
	GENERIC(MAX_WIDTH	:	INTEGER	:= 4);
	PORT (clk	:	IN	STD_LOGIC;
			rst	:	IN	STD_LOGIC;
			ena	:	IN	STD_LOGIC;
			d	:	IN	STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0);
			q	:	OUT	STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0));
END ENTITY;
--------------------------------------------
ARCHITECTURE structural OF my_regDFF IS
BEGIN
my_reg_gen:	FOR i IN 0 TO MAX_WIDTH-1 GENERATE
		DFFx:	ENTITY work.my_dff
				PORT MAP (clk	=> clk,
							rst	=> rst,
							ena	=> ena,
							d	=> d(i),
							q	=> q(i));
			END GENERATE;
END ARCHITECTURE;