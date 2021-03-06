library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
entity DigitalClock is port(
	soundclk:in std_logic;	--输入时钟频率 目前为100K
	turnOn:in std_logic;		--启动信号 高有效，默认应当为0 
	spk:out std_logic			--扬声器频率输出
);
end entity;

architecture behav of DigitalClock is
signal clk: std_logic_vector(15 downto 0):="0000000000000000";		--音频输出时间计数器
signal reset: std_logic:='0'; 	--复位信号 低有效
signal waveout: std_logic;       --输出信号
signal freq: std_logic_vector(7 downto 0);
signal soundcnt:std_logic_vector(7 downto 0);				--clk周期计数器 
signal dotcnt:std_logic_vector(3 downto 0) ;		--音符序号计数
signal songcnt:std_logic_vector(2 downto 0);  	--播放循环次数计数

constant spkout:std_logic_vector(15 downto 0):="1001110001000000"; --闹钟用10Hz,10K
constant do:std_logic_vector(7 downto 0):="10111111";	--do的频率100KHz/261.6Hz/2=191.1(方波周期)，二进制10111111
constant re:std_logic_vector(7 downto 0):="10101010";	--re的频率293.7Hz，计算同上
constant mi:std_logic_vector(7 downto 0):="10010111";	--mi的频率329.6Hz，计算同上
constant fa:std_logic_vector(7 downto 0):="10001111";	--fa的频率349.2Hz，计算同上
constant so:std_logic_vector(7 downto 0):="01111111";	--so的频率392Hz，计算同上
constant la:std_logic_vector(7 downto 0):="01110001";	--la的频率440Hz，计算同上
constant si:std_logic_vector(7 downto 0):="01100101";	--la的频率493.9Hz，计算同上
constant non:std_logic_vector(7 downto 0):="00000000"; --无频率值

begin
	spk <= waveout;

	process(soundclk,turnOn)
	begin
		if (soundclk'event and soundclk='1') then
		
		--音调控制
			if turnOn = '1' then reset <= '1'; songcnt <= "000"; dotcnt <= "0000";		--开始播放
			end if;
				--闹钟单音型(当前)
			if clk = spkout 		--输出计数器达到周期，开始更改音调
				then clk <= "0000000000000000";
			
				if songcnt = "100" then freq <= non; songcnt <= "000"; reset <= '0';		--播放循环次数已达，停止
				end if;
			
				if reset = '1' then																		--如果处于播放状态，开始更改音调
					case dotcnt is			
						when "0000" => freq <= do; dotcnt <= dotcnt + 1;
						when "0001" => freq <= re; dotcnt <= dotcnt + 1;
						when "0010" => freq <= mi; dotcnt <= dotcnt + 1;
						when "0011" => freq <= do; dotcnt <= dotcnt + 1;
						when "0100" => freq <= do; dotcnt <= dotcnt + 1;
						when "0101" => freq <= re; dotcnt <= dotcnt + 1;
						when "0110" => freq <= mi; dotcnt <= dotcnt + 1;
						when "0111" => freq <= do; dotcnt <= dotcnt + 1;
						when "1000" => freq <= mi; dotcnt <= dotcnt + 1;
						when "1001" => freq <= fa; dotcnt <= dotcnt + 1;
						when "1010" => freq <= so; dotcnt <= dotcnt + 1;
						when "1011" => freq <= non; dotcnt <= dotcnt + 1;
						when "1100" => freq <= mi; dotcnt <= dotcnt + 1;
						when "1101" => freq <= fa; dotcnt <= dotcnt + 1;
						when "1110" => freq <= so;dotcnt <= "0000"; songcnt <= songcnt + 1;
						when others => freq <= fa; dotcnt <= "0000"; songcnt <= songcnt + 1;
					end case;
				end if;
			else clk <= clk + 1;
			end if;
		--结束
		
		--音频输出
			if reset = '1' then 
				if freq = non 			--没有输入则不响
					then waveout <= '0';			--假设输出低则蜂鸣器不响
				else
					if soundcnt = freq 		--计数器达到周期
						then soundcnt <= "00000000";
						waveout <= not waveout;	--输出取反，输出方波
					else soundcnt <= soundcnt + 1;
					end if;
				end if;
			
			else --复位信号有效时
				waveout <= '0';
				soundcnt <= "00000000";
			end if;
		--结束
		end if;
	end process;
end architecture;