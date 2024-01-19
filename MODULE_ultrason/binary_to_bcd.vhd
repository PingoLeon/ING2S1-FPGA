library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;


entity binary_to_bcd is
    Port (	
			--in
			i_Clock		:	in std_logic;
			i_Reset_n		:	in std_logic;
			i_Binary		: 	in std_logic_vector (13 downto 0);
			i_DV_n			:	in std_logic;
			--out
            o_Ones 			:	out std_logic_vector (3 downto 0);
            o_Tens 			:	out std_logic_vector (3 downto 0);
            o_Hundreds		:	out std_logic_vector (3 downto 0);
			o_DV_n			:	out std_logic
          );
end binary_to_bcd;

architecture Behavioral of binary_to_bcd is



type state_type is (idle, copying_info, counting);



signal state: state_type;

signal bcd_signal	:	unsigned (11 downto 0);

 

begin

	double_dabble: process(i_Clock,i_Reset_n)



		variable temp	: std_logic_vector (13 downto 0);
		variable bcd	: unsigned (11 downto 0);

	  
	  
		begin
	  
			if i_Reset_n = '0' then
					temp 		:=	(others => '0');
					bcd 		:=	(others => '0');
					bcd_signal 	<=	(others => '0');
					state 		<= idle;
		  
			elsif rising_edge(i_Clock) then
			
				case state is
				
					when idle =>
						temp 		:=	(others => '0');
						bcd 		:=	(others => '0');
						bcd_signal 	<=	(others => '0');
				 
				 -- read input into temp variable
						if i_DV_n = '0' then
							state <= copying_info;
						else
							state <= idle;
						end if;
					
					when copying_info =>
							temp :=i_Binary;
							state <= counting;
							
				 	when counting =>
						

						for i in 0 to 13 loop
						 
							if bcd(3 downto 0) > 4 then 
							  bcd(3 downto 0) := bcd(3 downto 0) + 3;
							end if;
							
							if bcd(7 downto 4) > 4 then 
							  bcd(7 downto 4) := bcd(7 downto 4) + 3;
							end if;
						 
							if bcd(11 downto 8) > 4 then
							  bcd(11 downto 8) := bcd(11 downto 8) + 3;
							end if;
						 
	
							bcd := bcd(10 downto 0) & temp(13); 
						 
							temp := temp(12 downto 0) & '0';
						 
						end loop;
						 
						 bcd_signal <= bcd;
						 state <= idle;
						 
				end case;
					 
					 
			end if;
	  
		end process double_dabble;
		
	o_DV_n <= '0' when state = counting else '1';
	-- set outputs
	o_Ones			<= std_logic_vector(bcd_signal(3 downto 0));
	o_Tens			<= std_logic_vector(bcd_signal(7 downto 4));
	o_Hundreds		<= std_logic_vector(bcd_signal(11 downto 8));

end Behavioral;