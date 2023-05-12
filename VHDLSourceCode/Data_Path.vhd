LIBRARY ieee;
USE ieee.std_logic_1164.ALL; 
USE ieee.std_logic_arith.ALL; 
USE ieee.std_logic_unsigned.ALL;

ENTITY Data_Path IS
PORT( Clk, mClk : 		IN STD_LOGIC; -- clock Signal

--Memory Signals
WEN, EN : 					IN STD_LOGIC;

-- Register Control Signals (CLR and LD). 
Clr_A , Ld_A : 			IN STD_LOGIC;
Clr_B , Ld_B : 			IN STD_LOGIC;
Clr_C , Ld_C : 			IN STD_LOGIC;
Clr_Z , Ld_Z : 			IN STD_LOGIC;
Clr_PC , Ld_PC :			IN STD_LOGIC;
Clr_IR , Ld_IR : 			IN STD_LOGIC;

-- Register outputs (Some needed to feed back to control unit. Others pulled out for testing. 
Out_A :                 OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
Out_B : 						OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
Out_C : 						OUT STD_LOGIC;
Out_Z : 						OUT STD_LOGIC;
Out_PC : 					OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
Out_IR : 					OUT STD_LOGIC_VECTOR(31 DOWNTO 0);

-- Special inputs to PC.
Inc_PC : 					IN STD_LOGIC;

-- Address and Data Bus signals for debugging.
ADDR_OUT : 							OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
DATA_IN : 							IN STD_LOGIC_VECTOR(31 DOWNTO 0); 
DATA_OUT, MEM_OUT, MEM_IN : 	OUT STD_LOGIC_VECTOR(31 DOWNTO 0); 
MEM_ADDR : 							OUT STD_LOGIC_VECTOR(7 DOWNTO 0);

-- Various MUX controls.
DATA_Mux: 					IN STD_LOGIC_VECTOR(1 DOWNTO 0);
REG_Mux : 					IN STD_LOGIC; 
A_MUX, B_MUX : 			IN STD_LOGIC; 
IM_MUX1 : 					IN STD_LOGIC;
IM_MUX2 : 					IN STD_LOGIC_VECTOR(1 DOWNTO 0);

-- ALU Operations.
ALU_Op : IN STD_LOGIC_VECTOR(2 DOWNTO 0));

END Data_Path;
------------------------------------------------
ARCHITECTURE Behavior OF Data_Path IS
-- Component instantiations 	-- you figure this out
-- Internal signals 				-- you decide what you need

COMPONENT register32 
PORT (
		d   : IN STD_LOGIC_VECTOR(31 DOWNTO 0) ;
		ld  : IN STD_LOGIC ;
		clr : IN STD_LOGIC ; 
		clk : IN STD_LOGIC ;
		Q   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)) ;
END COMPONENT;		

COMPONENT mux2to1
PORT (
		s : IN std_logic ; 
		w0, w1 : in std_logic_vector(31 DOWNTO 0) ; 
		f : OUT std_logic_vector(31 DOWNTO 0) ) ; 
END COMPONENT;

COMPONENT LZE
PORT(
		lze_input : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		lze_output: OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END COMPONENT;

COMPONENT UZE
PORT(
		uze_input : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		uze_output: OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END COMPONENT;

COMPONENT RED
PORT(
		red_input : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		red_output: OUT UNSIGNED(7 DOWNTO 0));
END COMPONENT;

COMPONENT data_mem
PORT(
		clk		:IN STD_LOGIC;
		addr		:IN UNSIGNED(7 DOWNTO 0);
		data_in	:IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		wen		:IN STD_LOGIC;
		en			:IN STD_LOGIC;
		data_out :OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END COMPONENT;

COMPONENT pc
PORT (
		clr : IN STD_LOGIC; 
		clk : IN STD_LOGIC;
		ld  : IN STD_LOGIC;
		inc : IN STD_LOGIC;
		d   : IN STD_LOGIC_VECTOR(31 downto 0); 
		q   : INOUT STD_LOGIC_VECTOR(31 downto 0));
END COMPONENT;

COMPONENT mux3to1
PORT (
		s: in std_logic_vector(1 downto 0);
		w0, w1, w2 : in std_logic_vector(31 downto 0);
		f: out std_logic_vector(31 downto 0));
END COMPONENT;

COMPONENT alu32
PORT(
	a, b: in std_logic_vector(31 downto 0);
	op: in std_logic_vector(2 downto 0);
	result: inout std_logic_vector(31 downto 0);
	cout: out std_logic; -- carry flag
	zero: out std_logic -- zero flag
);
END COMPONENT;


SIGNAL DATA_BUS : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL AMuxLZE_OUT : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL BMuxLZE_OUT : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL AMux_OUT : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL BMux_OUT : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL AddrIn : UNSIGNED(7 downto 0);
SIGNAL IR_OUT : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL A_OUT : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL B_OUT : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL MEMORY_IN : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL MEMORY_OUT : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL PC_IN : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL ADDRESS_OUT : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL DATA_INPUT : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL AluInputMux1UZEOUT : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL AluInputMux1OUT : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL AluInputMux2LZEOUT : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL one : STD_LOGIC_VECTOR(30 DOWNTO 0) := (OTHERS => '0');
SIGNAL AluInputMux2OUT : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL cout_flag: STD_LOGIC;
SIGNAL zero_flag: STD_LOGIC;
SIGNAL AluOUT : STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN
-- you fill in the details END description;
AInMux : mux2to1 PORT MAP (A_Mux, DATA_BUS, AMuxLZE_OUT, AMux_OUT);
BInMux : mux2to1 PORT MAP (B_Mux, DATA_BUS, BMuxLZE_OUT, BMux_OUT);
AMuxLZE : LZE PORT MAP (IR_OUT, AMuxLZE_OUT);
BMuxLZE : LZE PORT MAP (IR_OUT, BMuxLZE_OUT);

MemInMux : mux2to1 PORT MAP(REG_Mux, A_OUT, B_OUT, MEMORY_IN);
DataMemory : data_mem PORT MAP(mClk, AddrIn, MEMORY_IN, WEN, EN, MEMORY_OUT);

AddrRED : RED PORT MAP (IR_OUT, AddrIn);
PCLZE : LZE PORT MAP (IR_OUT, PC_IN);
A : register32 PORT MAP (AMux_OUT, Ld_A, CLR_A, Clk, A_OUT);
B : register32 PORT MAP (BMux_OUT, LD_B, CLR_B, Clk, B_OUT);
IR : register32 PORT MAP (DATA_BUS, LD_IR, CLR_IR, Clk, IR_OUT);

PCCOMPONENT : pc PORT MAP (CLR_PC, Clk, Ld_PC, INC_PC, PC_IN, ADDRESS_OUT);

AluInputMux1UZE : UZE PORT MAP (IR_OUT, AluInputMux1UZEOUT);
AluInputMux1 : mux2to1 PORT MAP (IM_MUX1, A_OUT, AluInputMux1UZEOUT, AluInputMux1OUT);

AluInputMux2LZE : LZE PORT MAP (IR_OUT, AluInputMux2LZEOUT);
AluInputMux2 : mux3to1 PORT MAP (IM_MUX2, B_OUT, AluInputMux2LZEOUT, (one & '1'), AluInputMux2OUT);

ALU : alu32 PORT MAP (AluInputMux1OUT, AluInputMux2OUT, ALU_Op, AluOUT, cout_flag, zero_flag);

DataMux : mux3to1 PORT MAP (DATA_Mux, DATA_INPUT, MEMORY_OUT, AluOUT, DATA_BUS);

--DATA_INPUT <= ADDRESS_OUT;
DATA_INPUT <= DATA_IN;

ADDR_OUT <= ADDRESS_OUT;
MEM_IN <= MEMORY_IN;
MEM_OUT <= MEMORY_OUT;
MEM_ADDR <= STD_LOGIC_VECTOR(AddrIn);
OUT_A <= A_OUT;
OUT_B <= B_OUT;
DATA_OUT <= DATA_BUS;
OUT_PC <= ADDRESS_OUT;
OUT_IR <= IR_OUT;

END Behavior;
------------------------------------------------

-- Questions
-- How does this data-path implement the INCA, ADDI, LDBI and LDA operations?
-- INCA = 1 + A using the ALU, AluInputMux2 where IM_MUX2 = "10" and AluInputMux1 
--	  where IM_MUX1 = "00"
-- ADDI = IR[15..0] + A using the ALU, AluInputMux2 where IM_MUX2 = "01" and AluInputMux1
--   where IM_MUX1 = "00"
-- LDBI = IR[15..0] using B_mux = "01"
-- LDA = M[Adddress], Address = IR[15..0] by loading data from a memory location given in the IR 
--   EN = "1", DATA_Mux = "01"
-- 
-- The data-path has a maximum reliable operating speed (Clk). What determines this speed? 
--   (i.e. how would you estimate the data-path circuit clock)?
-- The data-path circuit clock can be estimated by running a timeQuest Timing Analyzer
--  and using the worst case slack as the Clock Period.
-- Clock Period = Max Data Path Delay - Min Clock Path Delay + Setup Time,
--   Clock Frequency = 1/Clock Period
--
-- What is a reliable limit for your data-path clock?
-- After running a TimeQuest Timing Analyzer the worst case slack was -14.423 ns
--   meaning the Clock Period = 1-(-14.423 ns) = 15.423 ns
--   So the Clock Frequency = 64.84 MHz



