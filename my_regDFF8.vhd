LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
--------------------------------------------
ENTITY my_regDFF8 IS 
	GENERIC(EIGHT	:	INTEGER	:= 8);
	PORT (	clk	:	IN	STD_LOGIC;
			rst	:	IN	STD_LOGIC;
			ena	:	IN	STD_LOGIC;
			d8	:	IN	STD_LOGIC_VECTOR(EIGHT-1 DOWNTO 0);
			q8	:	OUT	STD_LOGIC_VECTOR(EIGHT-1 DOWNTO 0));
END ENTITY;
--------------------------------------------
ARCHITECTURE structural OF my_regDFF8 IS
BEGIN
DFF8:	ENTITY work.my_regDFF
		GENERIC MAP (MAX_WIDTH => EIGHT)
		PORT MAP (	clk	=> clk,
					rst	=> rst,
					ena	=> ena,
					d	=> d8,
					q	=> q8);
END ARCHITECTURE;