LIBRARY ieee;
USE ieee.std_logic_1164.all;
---------------------------------------------------------------------------------------------------------------------------------
ENTITY SMPDUA IS

	PORT(	clk					:	IN  STD_LOGIC;
			rst               :  IN  STD_LOGIC);
			
END ENTITY;
---------------------------------------------------------------------------------------------------------------------------------
ARCHITECTURE Functional OF SMPDUA IS

	SIGNAL BusC_s 			   :	STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL bus_alu_s  	   :	STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL BUS_DATA_OUT_s   :	STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL BusA_s 		      :	STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL BusB_s 			   :	STD_LOGIC_VECTOR(7 DOWNTO 0);
   SIGNAL BUS_DATA_IN_s    :	STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL ADDRESS_BUS_s    :  STD_LOGIC_VECTOR(7 DOWNTO 0);
	
	--Señales de la unidad de control
	SIGNAL C_s                :  STD_LOGIC;
	SIGNAL M_s                :  STD_LOGIC;
	SIGNAL Z_s                :  STD_LOGIC;
	SIGNAL P_s                :  STD_LOGIC;
	SIGNAL To_Control_Unit_s  :  STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL uInstruction_s     :  STD_LOGIC_VECTOR(20 DOWNTO 0);
	
	SIGNAL enaf_s             :  STD_LOGIC;
	SIGNAL selop_s            :  STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL shamt_s            :  STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL BusB_addr_s        :  STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL BusC_addr_s        :  STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL bank_wr_en_s       :  STD_LOGIC;
	SIGNAL mar_en_s           :  STD_LOGIC;
	SIGNAL mdr_en_s           :  STD_LOGIC;
	SIGNAL mdr_alu_n_s        :  STD_LOGIC;
	SIGNAL wr_rdn_s           :  STD_LOGIC; 
	SIGNAL ir_en_s            :  STD_LOGIC;
	SIGNAL ir_clr_s           :  STD_LOGIC; 

BEGIN 

enaf_s         <= uInstruction_s(20);
selop_s        <= uInstruction_s(19 DOWNTO 17);  
shamt_s        <= uInstruction_s(16 DOWNTO 15);
BusB_addr_s    <= uInstruction_s(14 DOWNTO 12);   
BusC_addr_s    <= uInstruction_s(11 DOWNTO 9 );   
bank_wr_en_s   <= uInstruction_s(8);  
mar_en_s       <= uInstruction_s(7);
mdr_en_s       <= uInstruction_s(6);   
mdr_alu_n_s    <= uInstruction_s(5);    
wr_rdn_s       <= uInstruction_s(2);    
ir_en_s        <= uInstruction_s(1);   
ir_clr_s       <= uInstruction_s(0);
MDR_E: ENTITY work.MDR
			port map(		
						bus_alu      => bus_alu_s,
						DATA_EX_in   => BUS_DATA_IN_s,
		            mdr_alu_n    => mdr_alu_n_s,
						en           => mdr_en_s, 
						rst          => rst,
						clk          => clk,
                  busC         => BusC_s,
 						BUS_DATA_OUT => BUS_DATA_OUT_s);
						
MAR_E: ENTITY work.MAR
			port map(en		=> mar_en_s,
		            clk   => clk,
					   d     => BusC_s,
					   q     => ADDRESS_BUS_s,
						rst   => rst);
						
IR_E:  ENTITY work.IR
			port map(en		=> ir_en_s,
		            clk   => clk,
					   d     => BusC_s,
						sclr  => ir_clr_s,
						q     => To_Control_Unit_s,
						rst   => rst);
						
Register_bank_E: ENTITY work.Register_bank
			port map(
			         clk     => clk,
			         wr_data => BusC_s,
			         wr_en   => bank_wr_en_s,
						rd_addr => BusB_addr_s,
						wr_addr => BusC_addr_s,
						BusB    => BusB_s,
						BusA    => BusA_s,
						rst     => rst);
						
ALU_E: ENTITY work.ALU
			port map(clk   => clk,
			         rst   => rst,
						enaf  => enaf_s,
						selop => selop_s,
						shamt => shamt_s,
						BusB  => BusB_s,
						BusA  => BusA_s,
						BusC  => bus_alu_s,
						C     => C_s,
						M     => M_s,
						Z     => Z_s,
						P     => P_s);
						
SPRAM_E: ENTITY work.SPRAM
			port map(clk    => clk,
						wr_rdn => wr_rdn_s,
						addr   => ADDRESS_BUS_s,
						w_data => BUS_DATA_OUT_s,
						r_data => BUS_DATA_IN_s);
						
						
Contro_u:ENTITY work.Control_unit
			port map(clk    => clk,
						rst    => rst,
						opcode => To_Control_Unit_s,
						Z      => Z_s,
						M      => M_s,
						C      => C_s,
						P      => P_s,
						uInstruction => uInstruction_s);

END ARCHITECTURE;


	