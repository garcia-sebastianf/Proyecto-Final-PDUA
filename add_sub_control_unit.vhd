LIBRARY ieee;
USE	ieee.std_logic_1164.all;
-----------------------------------
ENTITY add_sub_control_unit IS
	GENERIC	(N			:	INTEGER	:=3);
	PORT		(a			:	IN		STD_LOGIC_VECTOR(N-1 DOWNTO 0);
				 b			:	IN		STD_LOGIC_VECTOR(N-1 DOWNTO 0);
				 addn_sub:	IN		STD_LOGIC;
				 s			:	OUT		STD_LOGIC_VECTOR(N-1 DOWNTO 0);
				cout		:	OUT		STD_LOGIC);
END ENTITY add_sub_control_unit;
------------------------
ARCHITECTURE rtl OF add_sub_control_unit IS
	SIGNAL	 bxor					: STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	SIGNAL	 add_nsub_vector	: STD_LOGIC_VECTOR(N-1 DOWNTO 0);
BEGIN
-- Create a vector with the value of addn_sub input
vector_generation: FOR i in N-1 DOWNTO 0 GENERATE
	add_nsub_vector(i) <= addn_sub;
	END GENERATE;
	
	bxor <= b XOR add_nsub_vector;
	
	--Adder instantiation
	adder: ENTITY work.nbit_adder
	GENERIC MAP (N		=> N)
	PORT MAP 	(a		=> a,
					 b		=> bxor,
					 cin	=> addn_sub,
					 s		=> s,
					 cout	=> cout);
	
END ARCHITECTURE;