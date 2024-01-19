library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
entity trigger_generator is
			port(			i_Clock : in std_logic;
							i_Reset_n: in std_logic;
							o_Trigger: out std_logic
			);
end trigger_generator;

architecture Behavioral of trigger_generator is
signal counter 	: unsigned (23 downto 0) := "000000000000000000000000";
-- counts up to 60ms

begin
process (i_Clock,i_Reset_n)
			begin
					if i_Reset_n = '0' then
							counter <= (others => '0');
					elsif rising_edge (i_Clock) then
							if (counter >= 3000000) then--3000000= 60ms
										counter <= (others => '0');
							else
										counter <= counter + 1;
							end if;
							
					end if;

end process;
o_Trigger <= '1' when counter >= 1 and counter <= 500 else '0';--10us trigger signal
end Behavioral;