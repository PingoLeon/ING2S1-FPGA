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
-- Created on Thu Nov 02 14:31:32 2023

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY FS2MDP IS
    PORT (
        reset : IN STD_LOGIC := '0';
        clock : IN STD_LOGIC;
        SWS1 : IN STD_LOGIC := '0';
        SWS2 : IN STD_LOGIC := '0';
        SWS3 : IN STD_LOGIC := '0';
        SWS4 : IN STD_LOGIC := '0';
        SWS5 : IN STD_LOGIC := '0';
        SWS6 : IN STD_LOGIC := '0';
        SWS0 : IN STD_LOGIC := '0';
        MDP : IN STD_LOGIC := '0';
        RD : IN STD_LOGIC := '0';
        STOP : IN STD_LOGIC := '0';
        CarteLed0 : OUT STD_LOGIC;
        CarteLed1 : OUT STD_LOGIC;
        CarteLed2 : OUT STD_LOGIC;
        CarteLed3 : OUT STD_LOGIC;
        CarteLed4 : OUT STD_LOGIC;
        CarteLed5 : OUT STD_LOGIC;
        CarteLed6 : OUT STD_LOGIC;
        CarteLed7 : OUT STD_LOGIC
    );
END FS2MDP;

ARCHITECTURE BEHAVIOR OF FS2MDP IS
    TYPE type_fstate IS (RDC,Etage1,Etage5,Etage6,Etage2,Etage3,Etage4,Prez);
    SIGNAL fstate : type_fstate;
    SIGNAL reg_fstate : type_fstate;
BEGIN
    PROCESS (clock,reg_fstate)
    BEGIN
        IF (clock='1' AND clock'event) THEN
            fstate <= reg_fstate;
        END IF;
    END PROCESS;

    PROCESS (fstate,reset,SWS1,SWS2,SWS3,SWS4,SWS5,SWS6,SWS0,MDP,RD,STOP)
    BEGIN
        IF (reset='1') THEN
            reg_fstate <= RDC;
            CarteLed0 <= '0';
            CarteLed1 <= '0';
            CarteLed2 <= '0';
            CarteLed3 <= '0';
            CarteLed4 <= '0';
            CarteLed5 <= '0';
            CarteLed6 <= '0';
            CarteLed7 <= '0';
        ELSE
            CarteLed0 <= '0';
            CarteLed1 <= '0';
            CarteLed2 <= '0';
            CarteLed3 <= '0';
            CarteLed4 <= '0';
            CarteLed5 <= '0';
            CarteLed6 <= '0';
            CarteLed7 <= '0';
            CASE fstate IS
                WHEN RDC =>
                    IF (((NOT((SWS0 = '1')) AND (((((((SWS1 = '1') OR (SWS2 = '1')) OR (SWS3 = '1')) OR (SWS4 = '1')) OR (SWS5 = '1')) OR (SWS6 = '1')) OR (MDP = '1'))) AND NOT((STOP = '1')))) THEN
                        reg_fstate <= Etage1;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= RDC;
                    END IF;

                    CarteLed1 <= '0';

                    CarteLed3 <= '0';

                    CarteLed6 <= '0';

                    CarteLed2 <= '0';

                    CarteLed7 <= '0';

                    CarteLed4 <= '0';

                    CarteLed0 <= '1';

                    CarteLed5 <= '0';
                WHEN Etage1 =>
                    IF (((NOT(((SWS0 = '1') OR (SWS1 = '1'))) AND ((((((SWS2 = '1') OR (SWS3 = '1')) OR (SWS4 = '1')) OR (SWS5 = '1')) OR (SWS6 = '1')) OR (MDP = '1'))) AND NOT((STOP = '1')))) THEN
                        reg_fstate <= Etage2;
                    ELSIF (((((RD = '1') OR (SWS0 = '1')) AND NOT((((((((SWS1 = '1') OR (SWS2 = '1')) OR (SWS3 = '1')) OR (SWS4 = '1')) OR (SWS5 = '1')) OR (SWS6 = '1')) OR (MDP = '1')))) AND NOT((STOP = '1')))) THEN
                        reg_fstate <= RDC;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= Etage1;
                    END IF;

                    CarteLed1 <= '1';

                    CarteLed3 <= '0';

                    CarteLed6 <= '0';

                    CarteLed2 <= '0';

                    CarteLed7 <= '0';

                    CarteLed4 <= '0';

                    CarteLed0 <= '0';

                    CarteLed5 <= '0';
                WHEN Etage5 =>
                    IF (((((((((RD = '1') OR (SWS0 = '1')) OR (SWS1 = '1')) OR (SWS2 = '1')) OR (SWS3 = '1')) OR (SWS4 = '1')) AND NOT((((SWS5 = '1') OR (SWS6 = '1')) OR (MDP = '1')))) AND NOT((STOP = '1')))) THEN
                        reg_fstate <= Etage4;
                    ELSIF (((NOT(((((((SWS0 = '1') OR (SWS1 = '1')) OR (SWS2 = '1')) OR (SWS3 = '1')) OR (SWS4 = '1')) OR (SWS5 = '1'))) AND ((SWS6 = '1') OR (MDP = '1'))) AND NOT((STOP = '1')))) THEN
                        reg_fstate <= Etage6;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= Etage5;
                    END IF;

                    CarteLed1 <= '0';

                    CarteLed3 <= '0';

                    CarteLed6 <= '0';

                    CarteLed2 <= '0';

                    CarteLed7 <= '0';

                    CarteLed4 <= '0';

                    CarteLed0 <= '0';

                    CarteLed5 <= '1';
                WHEN Etage6 =>
                    IF (((NOT((((((((SWS0 = '1') OR (SWS1 = '1')) OR (SWS2 = '1')) OR (SWS3 = '1')) OR (SWS4 = '1')) OR (SWS5 = '1')) OR (SWS6 = '1'))) AND (MDP = '1')) AND NOT((STOP = '1')))) THEN
                        reg_fstate <= Prez;
                    ELSIF ((((((((((RD = '1') OR (SWS0 = '1')) OR (SWS1 = '1')) OR (SWS2 = '1')) OR (SWS3 = '1')) OR (SWS4 = '1')) OR (SWS5 = '1')) AND NOT(((SWS6 = '1') OR (MDP = '1')))) AND NOT((STOP = '1')))) THEN
                        reg_fstate <= Etage5;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= Etage6;
                    END IF;

                    CarteLed1 <= '0';

                    CarteLed3 <= '0';

                    CarteLed6 <= '1';

                    CarteLed2 <= '0';

                    CarteLed7 <= '0';

                    CarteLed4 <= '0';

                    CarteLed0 <= '0';

                    CarteLed5 <= '0';
                WHEN Etage2 =>
                    IF (((NOT((((SWS0 = '1') OR (SWS1 = '1')) OR (SWS2 = '1'))) AND (((((SWS3 = '1') OR (SWS4 = '1')) OR (SWS5 = '1')) OR (SWS6 = '1')) OR (MDP = '1'))) AND NOT((STOP = '1')))) THEN
                        reg_fstate <= Etage3;
                    ELSIF ((((((RD = '1') OR (SWS0 = '1')) OR (SWS1 = '1')) AND NOT(((((((SWS2 = '1') OR (SWS3 = '1')) OR (SWS4 = '1')) OR (SWS5 = '1')) OR (SWS6 = '1')) OR (MDP = '1')))) AND NOT((STOP = '1')))) THEN
                        reg_fstate <= Etage1;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= Etage2;
                    END IF;

                    CarteLed1 <= '0';

                    CarteLed3 <= '0';

                    CarteLed6 <= '0';

                    CarteLed2 <= '1';

                    CarteLed7 <= '0';

                    CarteLed4 <= '0';

                    CarteLed0 <= '0';

                    CarteLed5 <= '0';
                WHEN Etage3 =>
                    IF (((((((RD = '1') OR (SWS0 = '1')) OR (SWS1 = '1')) OR (SWS2 = '1')) AND NOT((((((SWS3 = '1') OR (SWS4 = '1')) OR (SWS5 = '1')) OR (SWS6 = '1')) OR (MDP = '1')))) AND NOT((STOP = '1')))) THEN
                        reg_fstate <= Etage2;
                    ELSIF (((NOT(((((SWS0 = '1') OR (SWS1 = '1')) OR (SWS2 = '1')) OR (SWS3 = '1'))) AND ((((SWS4 = '1') OR (SWS5 = '1')) OR (SWS6 = '1')) OR (MDP = '1'))) AND NOT((STOP = '1')))) THEN
                        reg_fstate <= Etage4;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= Etage3;
                    END IF;

                    CarteLed1 <= '0';

                    CarteLed3 <= '1';

                    CarteLed6 <= '0';

                    CarteLed2 <= '0';

                    CarteLed7 <= '0';

                    CarteLed4 <= '0';

                    CarteLed0 <= '0';

                    CarteLed5 <= '0';
                WHEN Etage4 =>
                    IF ((((((((RD = '1') OR (SWS0 = '1')) OR (SWS1 = '1')) OR (SWS2 = '1')) OR (SWS3 = '1')) AND NOT(((((SWS4 = '1') OR (SWS5 = '1')) OR (SWS6 = '1')) OR (MDP = '1')))) AND NOT((STOP = '1')))) THEN
                        reg_fstate <= Etage3;
                    ELSIF (((NOT((((((SWS0 = '1') OR (SWS1 = '1')) OR (SWS2 = '1')) OR (SWS3 = '1')) OR (SWS4 = '1'))) AND (((SWS5 = '1') OR (SWS6 = '1')) OR (MDP = '1'))) AND NOT((STOP = '1')))) THEN
                        reg_fstate <= Etage5;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= Etage4;
                    END IF;

                    CarteLed1 <= '0';

                    CarteLed3 <= '0';

                    CarteLed6 <= '0';

                    CarteLed2 <= '0';

                    CarteLed7 <= '0';

                    CarteLed4 <= '1';

                    CarteLed0 <= '0';

                    CarteLed5 <= '0';
                WHEN Prez =>
                    IF (((((((((((RD = '1') OR (SWS0 = '1')) OR (SWS1 = '1')) OR (SWS2 = '1')) OR (SWS3 = '1')) OR (SWS4 = '1')) OR (SWS5 = '1')) OR (SWS6 = '1')) AND NOT((MDP = '1'))) AND NOT((STOP = '1')))) THEN
                        reg_fstate <= Etage6;
                    -- Inserting 'else' block to prevent latch inference
                    ELSE
                        reg_fstate <= Prez;
                    END IF;

                    CarteLed1 <= '0';

                    CarteLed3 <= '0';

                    CarteLed6 <= '0';

                    CarteLed2 <= '0';

                    CarteLed7 <= '1';

                    CarteLed4 <= '0';

                    CarteLed0 <= '0';

                    CarteLed5 <= '0';
                WHEN OTHERS => 
                    CarteLed0 <= 'X';
                    CarteLed1 <= 'X';
                    CarteLed2 <= 'X';
                    CarteLed3 <= 'X';
                    CarteLed4 <= 'X';
                    CarteLed5 <= 'X';
                    CarteLed6 <= 'X';
                    CarteLed7 <= 'X';
                    report "Reach undefined state";
            END CASE;
        END IF;
    END PROCESS;
END BEHAVIOR;
