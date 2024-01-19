library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CLK5 is
    Port (
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        out_pulse : out STD_LOGIC
    );
end CLK5;

architecture Behavioral of CLK5 is
    constant CLOCK_FREQUENCY : natural := 50_000_000;  -- 50 MHz
    constant EDGE_COUNT : natural := CLOCK_FREQUENCY * 5;  -- Count for 5 seconds
    signal count : natural := 0;
    signal state : STD_LOGIC := '0';  -- Output state
    signal pulse_timer : natural := 0;
begin
    process(clk, rst)
    begin
        if rst = '1' then
            count <= 0;
            state <= '0';
            pulse_timer <= 0;
        elsif rising_edge(clk) then
            if count < EDGE_COUNT then
                count <= count + 1;
            else
                count <= 0;
                state <= '1';  -- Output pulse active
                pulse_timer <= 0;
            end if;

            if state = '1' then
                if pulse_timer < CLOCK_FREQUENCY * 1 then  -- 1 seconds
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
