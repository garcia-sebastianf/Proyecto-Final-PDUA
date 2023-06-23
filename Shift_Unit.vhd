LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Shift_Unit IS
	GENERIC (N	:	INTEGER	:=8);
	PORT	(	shamt	  :	IN		STD_LOGIC_VECTOR(1 DOWNTO 0);
				dataa	  :	IN		STD_LOGIC_VECTOR(N-1 DOWNTO 0);
				dataout :	OUT	STD_LOGIC_VECTOR(N-1 DOWNTO 0));
				
END ENTITY;

-----------------------------------------------------------------------------------------------
ARCHITECTURE rtl OF Shift_Unit IS
BEGIN
	WITH shamt SELECT 
		dataout <= dataa							WHEN "00",		--No shift
					'0' & dataa(N-1 DOWNTO 1)	WHEN "01",		--slr
					dataa(N-2 DOWNTO 0 ) & '0'	WHEN "10",		--sll
					(OTHERS => '0')				WHEN OTHERS;	--NULL
END ARCHITECTURE;