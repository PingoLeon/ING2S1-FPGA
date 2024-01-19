library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity measurement_cal is
		
		generic
		(
			
			ns_cycel			:	unsigned(4 downto 0)		:= to_unsigned(20,5);
			division_cons	:	unsigned(29 downto 0) := to_unsigned(606627105, 30)--2^45/(1000*58)
		);		

		port
		(
			-- In
			i_Clock					:	in 	std_logic;
			i_Reset_n				:	in 	std_logic;
			i_Echo_pulse_time		:	in	std_logic_Vector(23 downto 0);--nr clock cycel on high echo pulse from counter component
			i_DV_n					:	in	std_logic;
	
			-- Output ports
			o_Distance				:	out	std_logic_Vector(13 downto 0);
			o_DV_n					:	out	std_logic
		);

end measurement_cal;



architecture Behavioral of measurement_cal is

-- Build an enumerated type for the statemachine
type state_type is (idle, counting);
-- Register to hold the current state
signal state: state_type;

signal result		:	unsigned(13 downto 0);
constant c_ns_cycle : integer := 20;

begin

	process(i_Clock, i_Reset_n)
		
		--(i_Echo_pulse_time+ns_cycel)-1
		variable time_ns				:	unsigned(28 downto 0);
		--(time_ns+division_cons)-1
		variable	val_in_const_val	:	unsigned(58 downto 0);
	
		
	begin
		
			if i_Reset_n = '0' then
				val_in_const_val :=(others => '0');
				time_ns :=(others => '0');
				result <=(others => '0');
				state <= idle;
				
			elsif(rising_edge(i_Clock)) then
			
				case state is
					
					when idle =>
					
						val_in_const_val :=(others => '0');
						time_ns :=(others => '0');
						result <=(others => '0');
						
						if i_DV_n = '0' then
							state <= counting;
						else
							state <= idle;
						end if;
							
					when counting =>
						
						
						time_ns 					:= unsigned(i_Echo_pulse_time) * ns_cycel;
						val_in_const_val 		:= time_ns * division_cons;
						
						result 					<= val_in_const_val(58 downto 45);
						
						state <= idle;

				end case;
						
			end if;
		
	end process;
	
	o_DV_n <= '0' when state = counting else '1';
	
	o_Distance 		<= std_logic_Vector(result);


end Behavioral;