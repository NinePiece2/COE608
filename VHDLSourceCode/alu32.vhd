library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity alu32 is
port(
	a, b: in std_logic_vector(31 downto 0);
	op: in std_logic_vector(2 downto 0);
	result: inout std_logic_vector(31 downto 0);
	cout: out std_logic; -- carry flag
	zero: out std_logic -- zero flag
);
end alu32;

architecture behaviour of alu32 is
	component mux2to1 is
		port(
			s: in std_logic;
			w0, w1: in std_logic_vector(31 downto 0);
			f: out std_logic_vector(31 downto 0)
		);
	end component;
	
	component mux8to1 is
		port(
			s: in std_logic_vector(2 downto 0); -- 3 bit selector
			w0, w1, w2, w3, w4, w5, w6, w7: in std_logic_vector(31 downto 0);
			f: out std_logic_vector(31 downto 0)
		);
	end component;
	
	component fulladder32 is
		port(
			a: in std_logic_vector(31 downto 0);
			b: in std_logic_vector(31 downto 0);
			cin: in std_logic;
			s: out std_logic_vector(31 downto 0);
			cout: out std_logic
		);
	end component;
	
	component rol32 is
		port(
			a: in std_logic_vector(31 downto 0);
			result: out std_logic_vector(31 downto 0)
		);
	end component;
	
	component ror32 is
		port(
			a: in std_logic_vector(31 downto 0);
			result: out std_logic_vector(31 downto 0)
		);
	end component;
	
	component or32 is
		port(
			a: in std_logic_vector(31 downto 0);
			result: out std_logic
		);
	end component;

	signal adder_res: std_logic_vector(31 downto 0);
	signal and_res: std_logic_vector(31 downto 0);
	signal or_res: std_logic;
	signal rol_res: std_logic_vector(31 downto 0);
	signal ror_res: std_logic_vector(31 downto 0);
	signal mux2to1_res: std_logic_vector(31 downto 0);
	signal mux8to1_res: std_logic_vector(31 downto 0);
	signal cout_res: std_logic;
	signal zero_res: std_logic;
	
begin	
	mux8to1_0: mux8to1 
		port map(op,
					a and b,
					a or b,
					adder_res,
					(others=>'0'),
					rol_res,
					ror_res,
					adder_res,
					(others=>'0'),
					mux8to1_res);
					
	adder_0: fulladder32
		port map(a,
					mux2to1_res,
					op(2), -- Neg bit in op code
					adder_res,
					cout_res);
					
	mux2to1_0: mux2to1
		port map(op(2),
					b,
					not b,
					mux2to1_res);
	
	rol_0: rol32 port map(a, rol_res);
	ror_0: ror32 port map(a, ror_res);
	
	result <= mux8to1_res;
	cout <= cout_res;
	
	or_0: or32 port map(result, or_res);
	zero <= not(or_res);
	
end behaviour;