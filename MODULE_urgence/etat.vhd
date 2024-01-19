-- Copyright (C) 2020  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- Generated by Quartus Prime Version 20.1.0 Build 711 06/05/2020 SJ Lite Edition
-- Created on Fri Nov 03 18:15:08 2023

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY etat IS
    PORT (
        reset : IN STD_LOGIC := '0';
        clock : IN STD_LOGIC;
        compteur : IN STD_LOGIC := '0';
        clk : IN STD_LOGIC := '0';
        buzzer : OUT STD_LOGIC;
        machine : OUT STD_LOGIC
    );
END etat;

ARCHITECTURE BEHAVIOR OF etat IS
    TYPE type_fstate IS (state2,state1,state5);
    SIGNAL fstate : type_fstate;
    SIGNAL reg_fstate : type_fstate;
BEGIN
    PROCESS (clock,reg_fstate)
    BEGIN
        IF (clock='1' AND clock'event) THEN
            fstate <= reg_fstate;
        END IF;
    END PROCESS;

    PROCESS (fstate,reset,compteur,clk)
    BEGIN
        IF (reset='1') THEN
            reg_fstate <= state1;
            buzzer <= '0';
            machine <= '0';
        ELSE
            buzzer <= '0';
            machine <= '0';
            CASE fstate IS
                WHEN state2 =>
                    IF (NOT((compteur = '1'))) THEN
                        reg_fstate <= state5;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= state2;
                    END IF;

                    buzzer <= '1';

                    machine <= '1';
                WHEN state1 =>
                    IF (((compteur = '1') AND (clk = '1'))) THEN
                        reg_fstate <= state2;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= state1;
                    END IF;

                    buzzer <= '0';

                    machine <= '0';
                WHEN state5 =>
                    IF ((compteur = '1')) THEN
                        reg_fstate <= state1;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= state5;
                    END IF;

                    buzzer <= '0';

                    machine <= '1';
                WHEN OTHERS => 
                    buzzer <= 'X';
                    machine <= 'X';
                    report "Reach undefined state";
            END CASE;
        END IF;
    END PROCESS;
END BEHAVIOR;