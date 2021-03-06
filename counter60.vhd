LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY counter60 IS
	PORT(clk,clr,stop,enable: IN std_logic;
	q1,q0: INOUT std_logic_vector(3 downto 0);
	C: OUT std_logic);
END counter60;

ARCHITECTURE behav OF counter60 IS
BEGIN
	process(clk,clr,stop,enable)
	BEGIN
		IF(enable = '1') THEN
			IF(clr='1') THEN q0 <= "0000"; q1 <= "0000";
			ELSIF(stop='1') THEN q0 <= q0; q1 <= q1;
			ELSIF(clk'event AND clk='1') THEN
					IF (q0 = "1001") THEN q0 <= "0000";
						IF (q1 = "0101") THEN q1 <= "0000"; C <= '1';
						ELSE q1 <= q1 + 1; C <= '0';
						END IF;
					ELSE q0 <= q0 + 1;
					END IF;
			END IF;
		END IF;
	END process;
END behav;