-- adc_sample_to_out.vhd
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adc_sample_to_out is
    port (
        adc_sample  : in std_logic_vector(11 downto 0);
        ones        : out std_logic_vector(3 downto 0);
        tenths      : out std_logic_vector(3 downto 0);
		  hundreds     : out std_logic_vector(3 downto 0)
    );
end entity;


architecture A of adc_sample_to_out is
begin
    ones <= adc_sample(3 downto 0);
    tenths <= adc_sample(7 downto 4);
    hundreds <= adc_sample(11 downto 8);
end architecture A;

