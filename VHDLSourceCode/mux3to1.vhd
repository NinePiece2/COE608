library ieee;
use ieee.std_logic_1164.all;

entity mux3to1 is
port(
	s: in std_logic_vector(1 downto 0); -- 2 bit selector
	w0, w1, w2 : in std_logic_vector(31 downto 0);
	f: out std_logic_vector(31 downto 0)
);
end mux3to1;

architecture behaviour of mux3to1 is
begin
	with s select
		f <= w0 when "00",
			  w1 when "01",
			  w2 when "10",
			  (others => '0') when others;
end behaviour;