LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
--------------------------------------------
ENTITY MDR IS
	GENERIC(MAX_WIDTH	:	INTEGER	:= 8);
	PORT (clk		   :	IN		STD_LOGIC;
			rst			:	IN		STD_LOGIC;
			en		      :	IN		STD_LOGIC;
			mdr_alu_n	:	IN		STD_LOGIC;
			DATA_EX_in	:	IN		STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0);
			bus_alu		:	IN		STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0);
			busC		   :	OUT	STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0);
			BUS_DATA_OUT:	OUT	STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0));
END ENTITY;
--------------------------------------------
ARCHITECTURE rtl OF MDR IS
	SIGNAL q_s : STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0);
BEGIN

WITH mdr_alu_n SELECT
		busC <= bus_alu WHEN '0',
				  q_s     WHEN OTHERS;

BDI: FOR i IN 0 TO MAX_WIDTH-1 GENERATE
DE_in: 	ENTITY work.my_dff
				PORT MAP (	clk	=> clk,
								rst	=> rst,
								ena	=> en,
								d	=> DATA_EX_in(i),
								q	=> q_s(i));
					
bus_a: 	ENTITY work.my_dff
				PORT MAP (	clk	=> clk,
								rst	=> rst,
								ena	=> en,
								d	=> bus_alu(i),
								q	=> BUS_DATA_OUT(i));
	END GENERATE;
	
END ARCHITECTURE;