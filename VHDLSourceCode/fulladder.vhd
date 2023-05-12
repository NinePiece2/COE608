library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity fulladder is
port(
		a: in std_logic;
		b: in std_logic;
		cin: in std_logic;
		s: out std_logic;
		cout: out std_logic
);
end fulladder;


architecture behaviour of fulladder is
begin
	s <= a xor (b xor cin);
	cout <= (b and cin) or (a and b) or (a and cin);
end behaviour;