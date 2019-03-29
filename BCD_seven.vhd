LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
entity BCD_seven is
	port(
		cin: in std_logic_vector(3 downto 0);
		cout: out std_logic_vector(6 downto 0));
end BCD_seven;

architecture behave of BCD_seven is
begin
	with cin select
	cout <= "1111110" when "0000",
			"0110000" when "0001",
			"1101101" when "0010",
			"1111001" when "0011",
			"0110011" when "0100",
			"1011011" when "0101",
			"1011111" when "0110",
			"1110000" when "0111",
			"1111111" when "1000",
			"1111011" when "1001",
			"XXXXXXX" when others;
end behave;
		