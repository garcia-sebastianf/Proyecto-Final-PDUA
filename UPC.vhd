LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
----------------------------------
ENTITY UPC IS 
	PORT ( 	clk		:	IN 	STD_LOGIC;
	         rst		:	IN 	STD_LOGIC;
				ena_UPC	: 	IN 	STD_LOGIC;
				sclr_UPC	:	IN		STD_LOGIC;
				d_UPC		:  IN		STD_LOGIC_VECTOR( 2 DOWNTO 0);
				q_UPC		:	OUT 	STD_LOGIC_VECTOR( 2 DOWNTO 0));
			
END ENTITY;
----------------------------------
ARCHITECTURE rtl of UPC is 
BEGIN 

	dff_UPC: PROCESS(clk, rst, d_UPC)
	BEGIN
		IF(rst = '1') THEN 
			q_UPC <= (OTHERS => '0');
		ELSIF(rising_edge(clk))	THEN 
			IF	(ena_UPC = '1')	THEN
				IF (sclr_UPC = '1') THEN
					q_UPC <= (OTHERS  => '0');
				ELSE 
					q_UPC <= d_UPC;
				END IF;
			END IF;
		END IF;
	END PROCESS;
	
END ARCHITECTURE;