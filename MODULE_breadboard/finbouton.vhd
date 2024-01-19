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
-- Created on Mon Nov 06 19:01:44 2023

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY finbouton IS
    PORT (
        reset : IN STD_LOGIC := '0';
        clock : IN STD_LOGIC;
        bouton1 : IN STD_LOGIC := '0';
        bouton2 : IN STD_LOGIC := '0';
        bouton3 : IN STD_LOGIC := '0';
        bouton4 : IN STD_LOGIC := '0';
        bouton5 : IN STD_LOGIC := '0';
        bouton6 : IN STD_LOGIC := '0';
        bouton7 : IN STD_LOGIC := '0';
        presidentiel : IN STD_LOGIC := '0';
        ser : OUT STD_LOGIC;
        rclk : OUT STD_LOGIC;
        srclk : OUT STD_LOGIC;
        srclr : OUT STD_LOGIC
    );
END finbouton;

ARCHITECTURE BEHAVIOR OF finbouton IS
    TYPE type_fstate IS (initialisation,attente1,data,affiche,reinitialisation,incrementation,decalage1,attente2,decalage2,attente3,decalage3,attente4,decalage4,attente5,decalage5,attente6,decalage6,attente7,decalage7);
    SIGNAL fstate : type_fstate;
    SIGNAL reg_fstate : type_fstate;
BEGIN
    PROCESS (clock,reg_fstate)
    BEGIN
        IF (clock='1' AND clock'event) THEN
            fstate <= reg_fstate;
        END IF;
    END PROCESS;

    PROCESS (fstate,reset,bouton1,bouton2,bouton3,bouton4,bouton5,bouton6,bouton7,presidentiel)
    BEGIN
        IF (reset='1') THEN
            reg_fstate <= initialisation;
            ser <= '0';
            rclk <= '0';
            srclk <= '0';
            srclr <= '0';
        ELSE
            ser <= '0';
            rclk <= '0';
            srclk <= '0';
            srclr <= '0';
            CASE fstate IS
                WHEN initialisation =>
                    IF (((((((((bouton1 = '1') OR (bouton2 = '1')) OR (bouton3 = '1')) OR (bouton4 = '1')) OR (bouton5 = '1')) OR (bouton6 = '1')) OR (bouton7 = '1')) OR (presidentiel = '1'))) THEN
                        reg_fstate <= data;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= initialisation;
                    END IF;

                    srclr <= '1';

                    rclk <= '0';

                    srclk <= '0';

                    ser <= '0';
                WHEN attente1 =>
                    IF (NOT((bouton1 = '1'))) THEN
                        reg_fstate <= decalage1;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= attente1;
                    END IF;

                    srclr <= '1';

                    rclk <= '0';

                    srclk <= '0';

                    ser <= '0';
                WHEN data =>
                    IF (((((((((bouton1 = '1') OR (bouton2 = '1')) OR (bouton3 = '1')) OR (bouton4 = '1')) OR (bouton5 = '1')) OR (bouton6 = '1')) OR (bouton7 = '1')) OR (presidentiel = '1'))) THEN
                        reg_fstate <= incrementation;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= data;
                    END IF;

                    srclr <= '1';

                    rclk <= '0';

                    srclk <= '0';

                    ser <= '1';
                WHEN affiche =>
                    IF (NOT(((((((((bouton1 = '1') OR (bouton2 = '1')) OR (bouton3 = '1')) OR (bouton4 = '1')) OR (bouton5 = '1')) OR (bouton6 = '1')) OR (bouton7 = '1')) OR (presidentiel = '1')))) THEN
                        reg_fstate <= reinitialisation;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= affiche;
                    END IF;

                    srclr <= '1';

                    rclk <= '1';

                    srclk <= '0';

                    ser <= '0';
                WHEN reinitialisation =>
                    IF (NOT(((((((((bouton1 = '1') OR (bouton2 = '1')) OR (bouton3 = '1')) OR (bouton4 = '1')) OR (bouton5 = '1')) OR (bouton6 = '1')) OR (bouton7 = '1')) OR (presidentiel = '1')))) THEN
                        reg_fstate <= initialisation;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= reinitialisation;
                    END IF;

                    srclr <= '0';

                    rclk <= '0';

                    srclk <= '0';

                    ser <= '0';
                WHEN incrementation =>
                    IF ((bouton1 = '1')) THEN
                        reg_fstate <= affiche;
                    ELSIF (NOT((bouton1 = '1'))) THEN
                        reg_fstate <= attente1;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= incrementation;
                    END IF;

                    srclr <= '1';

                    rclk <= '0';

                    srclk <= '1';

                    ser <= '1';
                WHEN decalage1 =>
                    IF (NOT((bouton2 = '1'))) THEN
                        reg_fstate <= attente2;
                    ELSIF ((bouton2 = '1')) THEN
                        reg_fstate <= affiche;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= decalage1;
                    END IF;

                    srclr <= '1';

                    srclk <= '1';
                WHEN attente2 =>
                    IF (NOT((bouton2 = '1'))) THEN
                        reg_fstate <= decalage2;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= attente2;
                    END IF;

                    srclr <= '1';

                    rclk <= '0';

                    srclk <= '0';

                    ser <= '0';
                WHEN decalage2 =>
                    IF (NOT((bouton3 = '1'))) THEN
                        reg_fstate <= attente3;
                    ELSIF ((bouton3 = '1')) THEN
                        reg_fstate <= affiche;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= decalage2;
                    END IF;

                    srclr <= '1';

                    srclk <= '1';
                WHEN attente3 =>
                    IF (NOT((bouton3 = '1'))) THEN
                        reg_fstate <= decalage3;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= attente3;
                    END IF;

                    srclr <= '1';

                    rclk <= '0';

                    srclk <= '0';

                    ser <= '0';
                WHEN decalage3 =>
                    IF ((bouton4 = '1')) THEN
                        reg_fstate <= affiche;
                    ELSIF (NOT((bouton4 = '1'))) THEN
                        reg_fstate <= attente4;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= decalage3;
                    END IF;

                    srclr <= '1';

                    srclk <= '1';
                WHEN attente4 =>
                    IF (NOT((bouton4 = '1'))) THEN
                        reg_fstate <= decalage4;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= attente4;
                    END IF;

                    srclr <= '1';

                    rclk <= '0';

                    srclk <= '0';

                    ser <= '0';
                WHEN decalage4 =>
                    IF ((bouton5 = '1')) THEN
                        reg_fstate <= affiche;
                    ELSIF (NOT((bouton5 = '1'))) THEN
                        reg_fstate <= attente5;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= decalage4;
                    END IF;

                    srclr <= '1';

                    srclk <= '1';
                WHEN attente5 =>
                    IF (NOT((bouton5 = '1'))) THEN
                        reg_fstate <= decalage5;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= attente5;
                    END IF;

                    srclr <= '1';

                    rclk <= '0';

                    srclk <= '0';

                    ser <= '0';
                WHEN decalage5 =>
                    IF (NOT((bouton6 = '1'))) THEN
                        reg_fstate <= attente6;
                    ELSIF ((bouton6 = '1')) THEN
                        reg_fstate <= affiche;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= decalage5;
                    END IF;

                    srclr <= '1';

                    srclk <= '1';
                WHEN attente6 =>
                    IF (NOT((bouton6 = '1'))) THEN
                        reg_fstate <= decalage6;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= attente6;
                    END IF;

                    srclr <= '1';

                    rclk <= '0';

                    srclk <= '0';

                    ser <= '0';
                WHEN decalage6 =>
                    IF ((bouton7 = '1')) THEN
                        reg_fstate <= affiche;
                    ELSIF (NOT((bouton7 = '1'))) THEN
                        reg_fstate <= attente7;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= decalage6;
                    END IF;

                    srclr <= '1';

                    srclk <= '1';
                WHEN attente7 =>
                    IF (NOT((bouton7 = '1'))) THEN
                        reg_fstate <= decalage7;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= attente7;
                    END IF;

                    srclr <= '1';

                    rclk <= '0';

                    srclk <= '0';

                    ser <= '0';
                WHEN decalage7 =>
                    IF ((presidentiel = '1')) THEN
                        reg_fstate <= affiche;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= decalage7;
                    END IF;

                    srclr <= '1';

                    srclk <= '1';
                WHEN OTHERS => 
                    ser <= 'X';
                    rclk <= 'X';
                    srclk <= 'X';
                    srclr <= 'X';
                    report "Reach undefined state";
            END CASE;
        END IF;
    END PROCESS;
END BEHAVIOR;