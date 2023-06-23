LIBRARY ieee;
USE	ieee.std_logic_1164.all;
-----------------------------------
ENTITY Control_Unit IS
	GENERIC	(N			:	INTEGER	:=8);
	PORT		(	clk				:	IN		STD_LOGIC;
					rst				:	IN		STD_LOGIC;
					opcode			:	IN		STD_LOGIC_VECTOR(4 DOWNTO 0);
					Z					:	IN		STD_LOGIC;
					M					:	IN		STD_LOGIC;
					C					:	IN		STD_LOGIC;
					P					:	IN		STD_LOGIC;
					uInstruction	:	OUT	STD_LOGIC_VECTOR(20 DOWNTO 0));
END ENTITY Control_Unit;
-------------------------------------------------------
ARCHITECTURE RTL OF Control_Unit IS

SIGNAL load_s			:	STD_LOGIC;
SIGNAL D_s				:	STD_LOGIC_VECTOR(2  DOWNTO 0);
SIGNAL q_s				:	STD_LOGIC_VECTOR(2  DOWNTO 0);
SIGNAL result_s		:	STD_LOGIC_VECTOR(2  DOWNTO 0);
SIGNAL Op_offset_s	:  STD_LOGIC_VECTOR(7  DOWNTO 0);
SIGNAL uInstruction_s:  STD_LOGIC_VECTOR(28 DOWNTO 0);
-- Señales que envia uP-ROM para controlarse por si misma.
SIGNAL ena_UPC_s     :  STD_LOGIC;
SIGNAL sclr_UPC_s    :  STD_LOGIC;
SIGNAL jcond_s       :  STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL Offset_s      :  STD_LOGIC_VECTOR(2 DOWNTO 0);


BEGIN

Op_offset_s <= opcode & q_s;
uInstruction <= uInstruction_s(28 DOWNTO 8);
ena_UPC_s    <= uInstruction_s(7);
sclr_UPC_s   <= uInstruction_s(6);
jcond_s      <= uInstruction_s(5 downto 3);
Offset_s     <= uInstruction_s(2 downto 0);


	WITH jcond_s	SELECT
		load_s <='0'	WHEN	"000",
					'1'	WHEN	"001",
					 Z		WHEN	"010",
					 M		WHEN	"011",
					 C		WHEN	"100",
					 P		WHEN	"101",
					'0'	WHEN	"110",
					'0'	WHEN	OTHERS;

	WITH load_s SELECT 
		D_s <= result_s	WHEN	'0',
				 Offset_s	WHEN OTHERS;

	ADD:	ENTITY work.add_sub_control_unit
	PORT MAP(a			=>	q_s,
				b			=>	"001",
				addn_sub	=>	'0',
				s			=>	result_s);
					
	uPC:	ENTITY work.UPC
	PORT MAP(d_UPC		=>	D_s,
				clk		=>	clk,
				rst		=>	rst,
				ena_UPC	=>	ena_UPC_s,
				sclr_UPC	=>	sclr_UPC_s,
				q_UPC		=>	q_s);
				
	ROM:	ENTITY work.uProgramMemory
	PORT MAP(uaddr		=>	Op_offset_s,
	         UI       => uInstruction_s);


END ARCHITECTURE;