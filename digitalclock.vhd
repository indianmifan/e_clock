library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
entity DigitalClock is port(
	soundclk:in std_logic;	--输入时钟频率 目前�?00K
	turnOn1:in std_logic;		--启动信号 高有效，默认应当�? 
	turnOn2:in std_logic;
	spk:out std_logic			--扬声器频率输�?
);
end entity;

architecture behav of DigitalClock is
signal clk: std_logic_vector(5 downto 0):="000000";		--音频输出时间计数�?
signal reset: std_logic:='0'; 	--复位信号 低有�?
signal waveout: std_logic;       --输出信号
signal freq: std_logic_vector(1 downto 0);
signal soundcnt:std_logic_vector(1 downto 0);				--clk周期计数�?
signal dotcnt:std_logic_vector(2 downto 0) ;		--音符序号计数
signal melody:std_logic;

constant spkout:std_logic_vector(5 downto 0):="111111"; --闹钟10Hz,2.5K
constant do:std_logic_vector(1 downto 0):="10";
constant mi:std_logic_vector(1 downto 0):="11";
constant non:std_logic_vector(1 downto 0):="00"; --无频率�?

begin
	spk <= waveout;

	process(soundclk)
	begin
		if (soundclk'event and soundclk='1') then
		
		--音调控制
			if ((turnOn1 = '1' or turnOn2 = '1') and reset = '0') then reset <= '1'; dotcnt <= "000";		--开始播�?

				
				
					case turnOn1 is			
						when '1' => melody<= '0'; 
						when others => melody<= '1'; 
					end case;
				
				
				
				
			end if;
				--闹钟单音
			if clk = spkout 		--输出计数器达到周期，开始更改音�?
				then clk <= "000000";
			
				if reset = '1' then
				case melody is
					when '0' =>																	--如果处于播放状态，开始更改音�?
					case dotcnt is			
						when "000" => freq <= mi; dotcnt <= dotcnt + 1;
						when "001" => freq <= do; dotcnt <= dotcnt + 1;
						when "010" => freq <= mi; dotcnt <= dotcnt + 1;
						when "011" => freq <= do; dotcnt <= dotcnt + 1;
						when "100" => freq <= mi; dotcnt <= dotcnt + 1;
						when "101" => freq <= do; dotcnt <= dotcnt + 1;
						when "110" => freq <= mi; dotcnt <= dotcnt + 1;
						when "111" => freq <= do; dotcnt <="000"; reset <= '0';
						when others => freq <= non; dotcnt <= "000"; reset <= '0';
					end case;
				
				 	when others =>																--如果处于播放状态，开始更改音�?
					case dotcnt is			
						when "000" => freq <= mi; dotcnt <= dotcnt + 1;
						when "001" => freq <= do; dotcnt <= dotcnt + 1;
						when "010" => freq <= mi; dotcnt <= dotcnt + 1;

						when "100" => freq <= mi; dotcnt <= dotcnt + 1;
						when "101" => freq <= do; dotcnt <= dotcnt + 1;
						when "111" => freq <= do;dotcnt <= "000"; reset <= '0';
						when others => freq <= non; dotcnt <= "000"; reset <= '0';
					end case;
				end case;
				
				end if;
			else clk <= clk + 1;
			end if;
		--结束
		
		--音频输出
			if reset = '1' then 
				if freq = non 			--没有输入则不�?
					then waveout <= '0';			--假设输出低则蜂鸣器不�?
				else
					if soundcnt = freq 		--计数器达到周�?
						then soundcnt <= "00";
						waveout <= not waveout;	--输出取反，输出方�?
					else soundcnt <= soundcnt + 1;
					end if;
				end if;
			
			else --复位信号有效�?
				waveout <= '0';
				soundcnt <= "00";
			end if;
		--结束
		end if;
	end process;
end architecture;