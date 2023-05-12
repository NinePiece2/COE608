library ieee;
use ieee.std_logic_1164.all;

entity mux8to1 is
port(
	s: in std_logic_vector(2 downto 0); -- 3 bit selector
	w0, w1, w2, w3, w4, w5, w6, w7: in std_logic_vector(31 downto 0);
	f: out std_logic_vector(31 downto 0)
);
end mux8to1;

architecture behaviour of mux8to1 is
begin
	with s select
		f <= w0 when "000",
				w1 when "001",
				w2 when "010",
				w3 when "011",
				w4 when "100",
				w5 when "101",
				w6 when "110",
				w7 when "111",
				(others => '0') when others;
end behaviour;