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

-- PROGRAM		"Quartus Prime"
-- VERSION		"Version 20.1.0 Build 711 06/05/2020 SJ Lite Edition"
-- CREATED		"Fri Sep 29 15:13:53 2023"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY mdist IS 
	PORT
	(
		iCLOCK :  IN  STD_LOGIC;
		iREST :  IN  STD_LOGIC;
		iECHO :  IN  STD_LOGIC;
		iiECHO :  OUT  STD_LOGIC;
		iiCLOCK :  OUT  STD_LOGIC;
		iiRESET :  OUT  STD_LOGIC
	);
END mdist;

ARCHITECTURE bdf_type OF mdist IS 

SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	DFF_inst :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	DFF_inst2 :  STD_LOGIC;
SIGNAL	DFF_inst3 :  STD_LOGIC;


BEGIN 
iiCLOCK <= iCLOCK;
iiRESET <= SYNTHESIZED_WIRE_1;
SYNTHESIZED_WIRE_0 <= '1';



PROCESS(iCLOCK,iREST)
BEGIN
IF (iREST = '0') THEN
	DFF_inst <= '0';
ELSIF (RISING_EDGE(iCLOCK)) THEN
	DFF_inst <= SYNTHESIZED_WIRE_0;
END IF;
END PROCESS;


PROCESS(iCLOCK,iREST)
BEGIN
IF (iREST = '0') THEN
	SYNTHESIZED_WIRE_1 <= '0';
ELSIF (RISING_EDGE(iCLOCK)) THEN
	SYNTHESIZED_WIRE_1 <= DFF_inst;
END IF;
END PROCESS;


PROCESS(iCLOCK,SYNTHESIZED_WIRE_1)
BEGIN
IF (SYNTHESIZED_WIRE_1 = '0') THEN
	DFF_inst2 <= '0';
ELSIF (RISING_EDGE(iCLOCK)) THEN
	DFF_inst2 <= iECHO;
END IF;
END PROCESS;


PROCESS(iCLOCK,SYNTHESIZED_WIRE_1)
BEGIN
IF (SYNTHESIZED_WIRE_1 = '0') THEN
	DFF_inst3 <= '0';
ELSIF (RISING_EDGE(iCLOCK)) THEN
	DFF_inst3 <= DFF_inst2;
END IF;
END PROCESS;



PROCESS(iCLOCK,SYNTHESIZED_WIRE_1)
BEGIN
IF (SYNTHESIZED_WIRE_1 = '0') THEN
	iiECHO <= '0';
ELSIF (RISING_EDGE(iCLOCK)) THEN
	iiECHO <= DFF_inst3;
END IF;
END PROCESS;


END bdf_type;