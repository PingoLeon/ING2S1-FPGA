library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity machine_LIFTCONTROL is
   Port (
      clk : in STD_LOGIC;
      units_signal, tens_signal, hundreds_signal : in STD_LOGIC_VECTOR(3 downto 0);
      objectDetected : out STD_LOGIC
   );
end machine_LIFTCONTROL;

architecture Behavioral of machine_LIFTCONTROL is
   signal totalDistance_cm : integer := 0;
   signal objectDetected_delayed : STD_LOGIC := '0';
   signal obstacle_present : STD_LOGIC := '0';
   signal counter : integer := 0;
   signal object_detected_flag : STD_LOGIC := '0';

begin
   process(clk)
   begin
       if rising_edge(clk) then
           -- Check if an object is detected
           totalDistance_cm <= to_integer(unsigned(hundreds_signal)) * 100 + to_integer(unsigned(tens_signal)) * 10 + to_integer(unsigned(units_signal));

           -- Introduce a 3 ms delay only if an object is detected
           if object_detected_flag = '1' then
               if counter < 150000 then
                   counter <= counter + 1;
               else
                   counter <= 0;
                   obstacle_present <= objectDetected_delayed;
               end if;
           else
               counter <= 0;
               obstacle_present <= '0'; -- No obstacle detected
           end if;

           -- Set the object_detected_flag based on the totalDistance_cm
           if totalDistance_cm < 50 then
               object_detected_flag <= '1'; -- Object detected
           else
               object_detected_flag <= '0'; -- No object detected
           end if;

           -- Output the obstacle_present signal
           objectDetected <= obstacle_present;

           -- Delay the objectDetected signal for 3 ms (assuming 50 MHz clock)
           objectDetected_delayed <= object_detected_flag;
       end if;
   end process;
end Behavioral;
