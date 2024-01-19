library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CLK_POT is
    Port (
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        potentiometer_value : in STD_LOGIC_VECTOR(3 downto 0);
        out_pulse : out STD_LOGIC
    );
end CLK_POT;

architecture Behavioral of CLK_POT is
    constant CLOCK_FREQUENCY : natural := 50_000_000;  -- 50 MHz
    signal count : natural := 0;
    signal state : STD_LOGIC := '0';  -- Output state
    signal pulse_timer : natural := 0;

    -- Clock modulation parameters
    signal clock_period : natural := 0;

    -- Clock generation
    begin
    process(clk, rst)
        variable potentiometer_decimal : natural;
    begin
        if rst = '1' then
            count <= 0;
            state <= '0';
            pulse_timer <= 0;
        elsif rising_edge(clk) then
            if count < clock_period then
                count <= count + 1;
            else
                count <= 0;
                state <= '1';  -- Output pulse active
                pulse_timer <= 0;
            end if;

            if state = '1' then
                potentiometer_decimal := to_integer(unsigned(potentiometer_value));

                -- Modulate the clock period based on the potentiometer value
                clock_period <= (CLOCK_FREQUENCY * 10) / (potentiometer_decimal + 1);  -- 0.2 Hz (5 seconds) to 2 Hz (0.5 seconds) range

                if pulse_timer < (clock_period / 2) then
                    pulse_timer <= pulse_timer + 1;
                    out_pulse <= '1';  -- Output pulse active
                else
                    state <= '0';  -- Turn off output pulse
                    out_pulse <= '0';  -- Output pulse inactive
                end if;
            else
                out_pulse <= '0';  -- Output pulse inactive
            end if;
        end if;
    end process;
    end Behavioral;
