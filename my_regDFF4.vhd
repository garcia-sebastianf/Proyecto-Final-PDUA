LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
--------------------------------------------
ENTITY my_regDFF4 IS
	GENERIC(FOUR	:	INTEGER	:= 4);
	PORT (	clk	:	IN	STD_LOGIC;
			rst	   :	IN	STD_LOGIC;
			ena	   :	IN	STD_LOGIC;
			d4	      :	IN	STD_LOGIC_VECTOR(FOUR-1 DOWNTO 0);
			q4	      :	OUT	STD_LOGIC_VECTOR(FOUR-1 DOWNTO 0));
END ENTITY;
--------------------------------------------
ARCHITECTURE structural OF my_regDFF4 IS
BEGIN
DFF4:	ENTITY work.my_regDFF
		GENERIC MAP (MAX_WIDTH => FOUR)
		PORT MAP (	clk	=> clk,
					rst	=> rst,
					ena	=> ena,
					d	=> d4,
					q	=> q4);
END ARCHITECTURE;