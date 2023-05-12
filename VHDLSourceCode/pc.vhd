LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY pc IS
PORT (
		clr : IN STD_LOGIC ; 
		clk : IN STD_LOGIC ;
		ld  : IN STD_LOGIC ;
		inc : IN STD_LOGIC ;
		d   : IN STD_LOGIC_VECTOR(31 downto 0) ; 
		q   : INOUT STD_LOGIC_VECTOR(31 downto 0) ) ;
END pc;

ARCHITECTURE Behavior OF pc IS 
COMPONENT add
PORT (
		A : IN STD_LOGIC_VECTOR(31 DOWNTO 0) ;
		B : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) ) ;
END COMPONENT;

COMPONENT mux
PORT (
		s : IN STD_LOGIC ; 
		w0, w1 : STD_LOGIC_VECTOR(31 DOWNTO 0) ; 
		f : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) ) ; 
END COMPONENT;

COMPONENT register32
PORT (
		d : IN STD_LOGIC_VECTOR(31 DOWNTO 0) ;
		ld : IN STD_LOGIC ;
		clr : IN STD_LOGIC ; 
		clk : IN STD_LOGIC ;
		Q : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)) ;
END COMPONENT;

SIGNAL add_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL mux_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL reg_out : STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN
	add0 : add PORT MAP(reg_out, add_out);
	mux0: mux PORT MAP(inc, d, add_out, mux_out);
	reg0: register32 PORT MAP(mux_out, ld, clr, clk, reg_out);
	q <= reg_out;
END Behavior;