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
-- Created on Mon Oct 30 19:21:47 2023

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY module_retour IS
    PORT (
        reset : IN STD_LOGIC := '0';
        clock : IN STD_LOGIC;
        X : IN STD_LOGIC := '0';
        Y : IN STD_LOGIC := '0';
        SWS0 : OUT STD_LOGIC
    );
END module_retour;

ARCHITECTURE BEHAVIOR OF module_retour IS
    TYPE type_fstate IS (state1,state2);
    SIGNAL fstate : type_fstate;
    SIGNAL reg_fstate : type_fstate;
    SIGNAL reg_SWS0 : STD_LOGIC := '0';
BEGIN
    PROCESS (clock,reg_fstate)
    BEGIN
        IF (clock='1' AND clock'event) THEN
            fstate <= reg_fstate;
        END IF;
    END PROCESS;

    PROCESS (fstate,reset,X,Y,reg_SWS0)
    BEGIN
        IF (reset='1') THEN
            reg_fstate <= state1;
            reg_SWS0 <= '0';
            SWS0 <= '0';
        ELSE
            reg_SWS0 <= '0';
            SWS0 <= '0';
            CASE fstate IS
                WHEN state1 =>
                    IF ((X = '1')) THEN
                        reg_fstate <= state2;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= state1;
                    END IF;

                    reg_SWS0 <= '0';
                WHEN state2 =>
                    IF ((X = '1')) THEN
                        reg_fstate <= state2;
                    ELSIF (((Y = '1') AND NOT((X = '1')))) THEN
                        reg_fstate <= state1;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= state2;
                    END IF;

                    reg_SWS0 <= '1';
                WHEN OTHERS => 
                    reg_SWS0 <= 'X';
                    report "Reach undefined state";
            END CASE;
            SWS0 <= reg_SWS0;
        END IF;
    END PROCESS;
END BEHAVIOR;
