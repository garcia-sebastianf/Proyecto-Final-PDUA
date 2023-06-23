LIBRARY ieee;
USE ieee.std_logic_1164.all;
---------------------------------
ENTITY SMPDUA_tb IS
END ENTITY SMPDUA_tb;
---------------------------------
ARCHITECTURE testbench OF SMPDUA_tb IS
	SIGNAL	clk_tb		   :	STD_LOGIC :=	'0';
	SIGNAL   rst_tb         :  STD_LOGIC :=   '1';                  

BEGIN
-------CLOCK GENERATION:---------
	clk_tb <= not clk_tb after 10ns;
------SIGNAL GENERATION:---------

   rst_tb <= '0' after 10ns;
					 
	PMAR:	ENTITY WORK.SMPDUA
	PORT MAP (clk	  	=> clk_tb,
			    rst     => rst_tb);
					
	
END ARCHITECTURE;