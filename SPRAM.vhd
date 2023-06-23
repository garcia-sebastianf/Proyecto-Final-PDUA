LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.NUMERIC_STD.all;
--------------------------------------------
ENTITY SPRAM IS
	GENERIC(DATA_WIDTH	:	INTEGER	:= 8;
			  ADDR_WIDTH	:	INTEGER	:= 8);
			  
	PORT (clk		:	IN	   STD_LOGIC;
			wr_rdn	:	IN  	STD_LOGIC;
			addr	   :	IN   	STD_LOGIC_VECTOR(ADDR_WIDTH-1 DOWNTO 0);
			w_data	:	IN    STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
			r_data	:	OUT	STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0));
END ENTITY;
--------------------------------------------
ARCHITECTURE rtl OF SPRAM IS
	TYPE mem_type IS ARRAY (0 TO 2**ADDR_WIDTH-1) OF STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
	SIGNAL ram	:	mem_type;
	--ATTRIBUTE ram_init_file : STRING;
	--ATTRIBUTE ram_init_file OF ram : SIGNAL IS "my_init_file.hex";
	SIGNAL addr_reg	:	STD_LOGIC_VECTOR(ADDR_WIDTH-1 DOWNTO 0);
BEGIN
	--WRITE PROCESS
	write_process: PROCESS(clk)
	BEGIN
		IF (rising_edge(clk)) THEN
			IF (wr_rdn = '1') THEN
				ram(to_integer(unsigned(addr))) <= w_data;
			END IF;
			addr_reg <= addr;
		END IF;
	END PROCESS;
	--READ
	r_data <= ram(to_integer(unsigned(addr_reg)));
END ARCHITECTURE;