transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/SoftEcole/intelFPGA_lite/PROJECTS/TP5/MODULE_A2/A2LED.vhd}

