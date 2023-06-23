LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
----------------------------------
ENTITY ALU IS
	GENERIC	(MAX_WIDTH	:	INTEGER	:=8);
	PORT		(clk			:	IN		STD_LOGIC;
				 rst			:	IN		STD_LOGIC;
				 busA			:	IN		STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0);
				 busB			:	IN		STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0);
				 selop		:	IN		STD_LOGIC_VECTOR(2 DOWNTO 0);
				 shamt		:	IN		STD_LOGIC_VECTOR(1 DOWNTO 0);
				 enaf			:	IN		STD_LOGIC;
				 busC			:	OUT	STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0);
				 C,M,P,Z		:	OUT	STD_LOGIC);
END ENTITY ALU;
----------------------------------
ARCHITECTURE rtl OF ALU IS

SIGNAL result	:	STD_LOGIC_VECTOR(MAX_WIDTH-1 DOWNTO 0);
SIGNAL cout		:	STD_LOGIC;

BEGIN	
	ProcessingUnit:	ENTITY work.processing_unit
	GENERIC MAP	(N			=> MAX_WIDTH)
	PORT MAP		(dataa	=>	busA,
					 datab	=>	busB,
					 selop	=>	selop,
					 result	=> result,
					 cout		=>	cout);
	
	FlagRegister:		ENTITY work.flag_register
	GENERIC MAP	(N			=> MAX_WIDTH)
	PORT MAP		(rst		=>	rst,
					 clk		=>	clk,
					 carry	=>	cout,
					 dataa	=> result,
					 enaf		=>	enaf,
					 C			=>	C,
					 M			=> M,
					 P			=> P,
					 Z			=> Z);
	
	ShiftUnit:			ENTITY work.Shift_Unit
	GENERIC MAP	(N			=>	MAX_WIDTH)
	PORT MAP		(dataa	=>	result,
					 shamt	=> shamt,
					 dataout	=> busC);
					 
END ARCHITECTURE;