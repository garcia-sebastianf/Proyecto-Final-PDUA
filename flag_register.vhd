LIBRARY ieee;
USE ieee.std_logic_1164.all;
---------------------------------------
ENTITY flag_register IS
	GENERIC	(N			:	INTEGER	:=8);
	PORT		(clk		:	IN		STD_LOGIC;
				 rst		:	IN		STD_LOGIC;
				 enaf		:	IN		STD_LOGIC;
				 dataa	:	IN		STD_LOGIC_VECTOR(N-1 DOWNTO 0);
				 carry	:	IN		STD_LOGIC;
				 C,M,Z,P	:	OUT	STD_LOGIC);
END ENTITY flag_register;
----------------------------------------
ARCHITECTURE rtl OF flag_register IS
	CONSTANT ZEROS	:	STD_LOGIC_VECTOR(N-1 DOWNTO 0)	:=	(OTHERS =>	'0');
BEGIN
	PROCESS(clk,rst)
	BEGIN
		IF(rst='1') THEN
			C	<= '0';
			M	<= '0';
			Z	<= '0';
			P	<= '0';
		ELSIF(rising_edge(clk)) THEN
			IF	(enaf = '1') THEN
				M <= dataa(7);
				C <= carry;
				P <= not(dataa(7) xor dataa(6) xor dataa(5) xor dataa(4) xor dataa(3) xor dataa(2) xor dataa(1) xor dataa(0));
				IF dataa = ZEROS THEN
					Z <= '1';
				ELSE
					Z <= '0';
				END IF;
			END IF;
		END IF;
	END PROCESS;
END ARCHITECTURE;