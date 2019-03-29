library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity count_byly is
	port(
		clk: in std_logic;
		q1,q0: inout std_logic_vector(3 downto 0));
end  count_byly;

architecture behave of  count_byly is
begin
	process(clk)
	begin
		if(clk'event and clk = '1') then
			
				if(q0 = "1001") then 
					q0 <= "0000"; 
					if(q1 = "0101") then q1 <= "0000";
					else q1 <= q1 + 1; 
					end if;
				else q0 <= q0 + 1; 
				end if;
		
		end if;
	end process;
end behave;