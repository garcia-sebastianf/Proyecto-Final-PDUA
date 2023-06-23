LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.NUMERIC_STD.all;
--------------------------------------------
ENTITY Register_bank IS
	GENERIC(DATA_WIDTH	:	INTEGER	:= 8;
			  ADDR_WIDTH	:	INTEGER	:= 3);
	PORT (clk		:	IN		STD_LOGIC;
			wr_en	   :	IN		STD_LOGIC;
			rst      :  IN    STD_LOGIC;
			wr_addr	:	IN		STD_LOGIC_VECTOR(ADDR_WIDTH-1 DOWNTO 0);
			rd_addr	:	IN		STD_LOGIC_VECTOR(ADDR_WIDTH-1 DOWNTO 0);
			wr_data	:	IN		STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
			BusB  	:	OUT	STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
			BusA     :  OUT   STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0));
END ENTITY;
--------------------------------------------
ARCHITECTURE rtl OF Register_bank IS
	TYPE mem_type IS ARRAY (0 TO 2**ADDR_WIDTH-1) OF STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
	SIGNAL array_reg : mem_type;
BEGIN
	--WRITE PROCESS
	write_process: PROCESS(clk,rst)
	BEGIN
		IF(rst = '1') then
		      array_reg(0) <= "00000000"; -- PC
			   array_reg(1) <= "11111111"; -- SP
				array_reg(2) <= "00000001"; -- DPTR
				array_reg(3) <= "00000000"; -- A
				array_reg(4) <= "00000000"; -- AVI
				array_reg(5) <= "00000000"; -- Temp 
				array_reg(6) <= "11111111"; --Cte1
				array_reg(7) <= "00011010"; --ACC

		ELSIF (rising_edge(clk)) THEN
			IF (wr_en = '1') THEN
				array_reg(to_integer(unsigned(wr_addr))) <= wr_data;
			END IF;
		END IF;
	END PROCESS;
	--READ
	BusB <= array_reg(to_integer(unsigned(rd_addr)));
	BusA <= array_reg(7);
END ARCHITECTURE;