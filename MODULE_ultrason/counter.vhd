library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity counter is
		port
		(	i_Clock			:	in std_logic;
			i_Reset_n		:	in std_logic;
			i_Echo			:	in std_logic;
			o_DV_n			:	out std_logic;
			o_Echo_pulse_time	:	out std_logic_vector(23 downto 0)
		);
end counter;

architecture Behavioral of counter is
signal echo_pulse_counter				: unsigned (23 downto 0);
type state_type is (idle, counting, sending_info);
signal state: state_type;
begin
measuring_echo_pulse_time: process (i_Clock,i_Reset_n)
	begin
		if (i_Reset_n = '0') then
			o_Echo_pulse_time <= (others => '0');
			echo_pulse_counter <= (others => '0');
			state <= idle;
			o_DV_n <= '1';--wont send data
		elsif (rising_edge(i_Clock)) then
			case state is
				when idle => --out of range (no echo)
					echo_pulse_counter <= (others => '0');
					o_DV_n <= '1';--wont send data
					if(i_Echo = '1') then
						state <= counting;
					else
						state <= idle; 	-- if there's no echo stay in idle or obsticle below 2cm (58823.52941ns)in distance
					end if;
				when counting =>
					echo_pulse_counter <= echo_pulse_counter + 1;--increases with 20ns every time									
					if(i_Echo = '1') then
						state <= counting;
					else
						state <= sending_info;
					end if;					
				when sending_info =>					
					o_DV_n <= '0';
					o_Echo_pulse_time <= std_logic_vector(echo_pulse_counter);
					if(i_Echo = '1') then
						state <= counting;
					else
						state <= idle;
					end if;				
			end case;
		end if;
	end process measuring_echo_pulse_time;
end Behavioral;