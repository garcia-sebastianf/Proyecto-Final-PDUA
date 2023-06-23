LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
--------------------------------------------
ENTITY my_dff_sclr IS

	PORT (clk 	:	IN	 STD_LOGIC;
			rst	:	IN	 STD_LOGIC;
			ena	:	IN	 STD_LOGIC;
			sclr  :  IN  STD_LOGIC;
			d	   :	IN	 STD_LOGIC;
			q	   :	OUT STD_LOGIC);
END my_dff_sclr;
--------------------------------------------
ARCHITECTURE rtl OF my_dff_sclr IS
BEGIN

	dff_sclr: PROCESS(clk, rst, d)
	BEGIN
		IF(rst = '1') THEN 
			q <= '0';
		ELSIF (rising_edge(clk)) THEN
			IF(ena = '1') THEN
				IF(sclr = '1') THEN 
					q <= '0';
			   ELSE 
					q <= d;
				END IF;
			END IF;
		END IF;
	END PROCESS;
	
END ARCHITECTURE;