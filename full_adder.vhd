LIBRARY ieee;
USE ieee.std_logic_1164.all;
--------------------------------------
ENTITY full_adder IS
	PORT	(x		:	IN		STD_LOGIC;
			 y		:	IN		STD_LOGIC;
			 cin	:	IN		STD_LOGIC;
			 s		:	OUT	STD_LOGIC;
			 cout	:	OUT	STD_LOGIC);
END ENTITY full_adder;
---------------------------------------
ARCHITECTURE gateLevel OF full_adder IS
BEGIN
	s		<=	x XOR y XOR cin;
	cout	<= (x AND y) OR (x AND cin) OR (y AND cin);

END ARCHITECTURE gateLevel;