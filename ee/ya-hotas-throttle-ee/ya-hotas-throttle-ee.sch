EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L power:+3.3V #PWR0101
U 1 1 60B6AE35
P 9300 1050
F 0 "#PWR0101" H 9300 900 50  0001 C CNN
F 1 "+3.3V" H 9315 1223 50  0000 C CNN
F 2 "" H 9300 1050 50  0001 C CNN
F 3 "" H 9300 1050 50  0001 C CNN
	1    9300 1050
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_MEC_5E swExtraBack1
U 1 1 60B711D1
P 4900 3700
F 0 "swExtraBack1" H 4900 3993 50  0000 C CNN
F 1 "SW_MEC_5E" H 4900 3994 50  0001 C CNN
F 2 "ya-hotas-throttle-ee:Switch_Tact" H 4900 4000 50  0001 C CNN
F 3 "http://www.apem.com/int/index.php?controller=attachment&id_attachment=1371" H 4900 4000 50  0001 C CNN
	1    4900 3700
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_MEC_5E dwDown1
U 1 1 60B8700C
P 3850 4300
F 0 "dwDown1" H 3850 4593 50  0000 C CNN
F 1 "SW_MEC_5E" H 3850 4594 50  0001 C CNN
F 2 "ya-hotas-throttle-ee:Switch_Tact" H 3850 4600 50  0001 C CNN
F 3 "http://www.apem.com/int/index.php?controller=attachment&id_attachment=1371" H 3850 4600 50  0001 C CNN
	1    3850 4300
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_MEC_5E swExtraForward1
U 1 1 60B882A4
P 4900 4900
F 0 "swExtraForward1" H 4900 5193 50  0000 C CNN
F 1 "SW_MEC_5E" H 4900 5194 50  0001 C CNN
F 2 "ya-hotas-throttle-ee:Switch_Tact" H 4900 5200 50  0001 C CNN
F 3 "http://www.apem.com/int/index.php?controller=attachment&id_attachment=1371" H 4900 5200 50  0001 C CNN
	1    4900 4900
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_MEC_5E swForward1
U 1 1 60B895EB
P 3900 5500
F 0 "swForward1" H 3900 5793 50  0000 C CNN
F 1 "SW_MEC_5E" H 3900 5794 50  0001 C CNN
F 2 "ya-hotas-throttle-ee:Switch_Tact" H 3900 5800 50  0001 C CNN
F 3 "http://www.apem.com/int/index.php?controller=attachment&id_attachment=1371" H 3900 5800 50  0001 C CNN
	1    3900 5500
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_MEC_5E swUp1
U 1 1 60B6C2E9
P 3900 6100
F 0 "swUp1" H 3900 6393 50  0000 C CNN
F 1 "SW_MEC_5E" H 3900 6394 50  0001 C CNN
F 2 "ya-hotas-throttle-ee:Switch_Tact" H 3900 6400 50  0001 C CNN
F 3 "http://www.apem.com/int/index.php?controller=attachment&id_attachment=1371" H 3900 6400 50  0001 C CNN
	1    3900 6100
	1    0    0    -1  
$EndComp
Text GLabel 850  2500 1    50   Input ~ 0
row1
Text GLabel 4200 2500 1    50   Input ~ 0
row2
$Comp
L Diode:1N4148W D1
U 1 1 60BD82F0
P 3550 6150
F 0 "D1" V 3550 6070 50  0000 R CNN
F 1 "1N4148W" V 3505 6070 50  0001 R CNN
F 2 "Diode_SMD:D_SOD-123" H 3550 5975 50  0001 C CNN
F 3 "https://www.vishay.com/docs/85748/1n4148w.pdf" H 3550 6150 50  0001 C CNN
	1    3550 6150
	0    -1   -1   0   
$EndComp
Wire Wire Line
	4500 4800 4700 4800
Wire Wire Line
	4550 3600 4700 3600
Wire Wire Line
	5200 4800 5100 4800
$Comp
L Switch:SW_DPDT_x2 swMode1
U 1 1 60BF419C
P 5000 5400
F 0 "swMode1" H 5000 5200 50  0000 C CNN
F 1 "SW_DPDT_x2" H 5000 5594 50  0001 C CNN
F 2 "ya-hotas-throttle-ee:Switch_slide_2" H 5000 5400 50  0001 C CNN
F 3 "~" H 5000 5400 50  0001 C CNN
	1    5000 5400
	-1   0    0    1   
$EndComp
$Comp
L Diode:1N4148W D2
U 1 1 60C459F8
P 4500 4950
F 0 "D2" V 4500 4870 50  0000 R CNN
F 1 "1N4148W" V 4455 4870 50  0001 R CNN
F 2 "Diode_THT:D_DO-35_SOD27_P7.62mm_Horizontal" H 4500 4775 50  0001 C CNN
F 3 "https://www.vishay.com/docs/85748/1n4148w.pdf" H 4500 4950 50  0001 C CNN
	1    4500 4950
	0    -1   -1   0   
$EndComp
$Comp
L Diode:1N4148W D5
U 1 1 60C63D98
P 4550 3750
F 0 "D5" V 4550 3670 50  0000 R CNN
F 1 "1N4148W" V 4505 3670 50  0001 R CNN
F 2 "Diode_THT:D_DO-35_SOD27_P7.62mm_Horizontal" H 4550 3575 50  0001 C CNN
F 3 "https://www.vishay.com/docs/85748/1n4148w.pdf" H 4550 3750 50  0001 C CNN
	1    4550 3750
	0    -1   -1   0   
$EndComp
$Comp
L Diode:1N4148W D6
U 1 1 60CCDE9A
P 3550 5550
F 0 "D6" V 3550 5470 50  0000 R CNN
F 1 "1N4148W" V 3505 5470 50  0001 R CNN
F 2 "Diode_SMD:D_SOD-123" H 3550 5375 50  0001 C CNN
F 3 "https://www.vishay.com/docs/85748/1n4148w.pdf" H 3550 5550 50  0001 C CNN
	1    3550 5550
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3550 5400 3700 5400
$Comp
L Diode:1N4148W D3
U 1 1 60CDDD9C
P 4550 5550
F 0 "D3" V 4550 5470 50  0000 R CNN
F 1 "1N4148W" V 4505 5470 50  0001 R CNN
F 2 "Diode_THT:D_DO-35_SOD27_P7.62mm_Horizontal" H 4550 5375 50  0001 C CNN
F 3 "https://www.vishay.com/docs/85748/1n4148w.pdf" H 4550 5550 50  0001 C CNN
	1    4550 5550
	0    -1   -1   0   
$EndComp
Wire Wire Line
	4800 5300 4550 5300
Wire Wire Line
	4550 5300 4550 5400
Text GLabel 8600 1800 2    50   Input ~ 0
col1
Text GLabel 8600 1900 2    50   Input ~ 0
col2
Text GLabel 8600 2000 2    50   Input ~ 0
col3
Text GLabel 8600 2100 2    50   Input ~ 0
col4
Text GLabel 8600 2200 2    50   Input ~ 0
row1
Text GLabel 8600 2300 2    50   Input ~ 0
row2
Text GLabel 8600 2400 2    50   Input ~ 0
row3
Text GLabel 8600 2500 2    50   Input ~ 0
row4
Text GLabel 8600 2600 2    50   Input ~ 0
row5
Wire Wire Line
	8600 2600 8350 2600
Wire Wire Line
	8350 2500 8600 2500
Wire Wire Line
	8600 2400 8350 2400
Wire Wire Line
	8600 2300 8350 2300
Wire Wire Line
	8600 2200 8350 2200
Wire Wire Line
	8600 2100 8350 2100
Wire Wire Line
	8600 2000 8350 2000
Wire Wire Line
	8600 1900 8350 1900
Wire Wire Line
	8600 1800 8350 1800
Wire Wire Line
	5500 1300 5500 1400
Connection ~ 5950 1300
Wire Wire Line
	5950 1300 5500 1300
$Comp
L power:GND #PWR0102
U 1 1 60BB8CC0
P 9300 1450
F 0 "#PWR0102" H 9300 1200 50  0001 C CNN
F 1 "GND" H 9305 1277 50  0000 C CNN
F 2 "" H 9300 1450 50  0001 C CNN
F 3 "" H 9300 1450 50  0001 C CNN
	1    9300 1450
	1    0    0    -1  
$EndComp
Wire Wire Line
	6700 1300 5950 1300
Text GLabel 8600 1500 2    50   Input ~ 0
GND
Text GLabel 8600 1400 2    50   Input ~ 0
3.3V
Text GLabel 8600 1600 2    50   Input ~ 0
Rx
Text GLabel 8600 1700 2    50   Input ~ 0
Ry
Wire Wire Line
	8600 1600 8350 1600
Wire Wire Line
	8600 1700 8350 1700
Wire Wire Line
	8600 1400 8350 1400
Wire Wire Line
	8600 1500 8350 1500
Text GLabel 5700 1500 2    50   Input ~ 0
Rx
$Comp
L Device:R_POT_Small RVx1
U 1 1 60BC6841
P 5500 1500
F 0 "RVx1" H 5441 1500 50  0000 R CNN
F 1 "R_POT_Small" H 5441 1455 50  0001 R CNN
F 2 "Potentiometer_THT:Potentiometer_TT_P0915N" H 5500 1500 50  0001 C CNN
F 3 "~" H 5500 1500 50  0001 C CNN
	1    5500 1500
	1    0    0    -1  
$EndComp
Wire Wire Line
	5500 1850 5950 1850
$Comp
L Device:R_POT_Small RVy1
U 1 1 60BC880B
P 5950 1700
F 0 "RVy1" H 5891 1700 50  0000 R CNN
F 1 "R_POT_Small" H 5891 1655 50  0001 R CNN
F 2 "Potentiometer_THT:Potentiometer_TT_P0915N" H 5950 1700 50  0001 C CNN
F 3 "~" H 5950 1700 50  0001 C CNN
	1    5950 1700
	1    0    0    -1  
$EndComp
Wire Wire Line
	5500 1600 5500 1850
Wire Wire Line
	5700 1500 5600 1500
Wire Wire Line
	5950 1300 5950 1600
Wire Wire Line
	5950 1800 5950 1850
Connection ~ 5950 1850
Wire Wire Line
	5950 1850 6700 1850
Text GLabel 6200 1700 2    50   Input ~ 0
Ry
Wire Wire Line
	6200 1700 6050 1700
Text GLabel 6700 1850 2    50   Input ~ 0
GND
Text GLabel 6700 1300 2    50   Input ~ 0
3.3V
$Comp
L Diode:1N4148W D4
U 1 1 60BF7F0F
P 3500 4350
F 0 "D4" V 3500 4270 50  0000 R CNN
F 1 "1N4148W" V 3455 4270 50  0001 R CNN
F 2 "Diode_SMD:D_SOD-123" H 3500 4175 50  0001 C CNN
F 3 "https://www.vishay.com/docs/85748/1n4148w.pdf" H 3500 4350 50  0001 C CNN
	1    3500 4350
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3650 4200 3500 4200
Wire Wire Line
	4050 4200 4200 4200
Wire Wire Line
	4200 2500 4200 2650
Wire Wire Line
	4100 5400 4200 5400
Wire Wire Line
	4100 3000 4200 3000
Wire Wire Line
	4200 6600 4100 6600
Wire Wire Line
	3700 6600 3550 6600
$Comp
L Switch:SW_MEC_5E swTrigger1
U 1 1 60CD9F9C
P 3900 6700
F 0 "swTrigger1" H 3900 6993 50  0000 C CNN
F 1 "SW_MEC_5E" H 3900 6994 50  0001 C CNN
F 2 "ya-hotas-throttle-ee:Switch_Tact" H 3900 7000 50  0001 C CNN
F 3 "http://www.apem.com/int/index.php?controller=attachment&id_attachment=1371" H 3900 7000 50  0001 C CNN
	1    3900 6700
	1    0    0    -1  
$EndComp
$Comp
L Diode:1N4148W Dtrigger1
U 1 1 60C636AC
P 3550 6750
F 0 "Dtrigger1" V 3550 6670 50  0000 R CNN
F 1 "1N4148W" V 3505 6670 50  0001 R CNN
F 2 "Diode_SMD:D_SOD-123" H 3550 6575 50  0001 C CNN
F 3 "https://www.vishay.com/docs/85748/1n4148w.pdf" H 3550 6750 50  0001 C CNN
	1    3550 6750
	0    -1   -1   0   
$EndComp
$Comp
L Diode:1N4148W DhatB1
U 1 1 60E2A9C4
P 2700 4350
F 0 "DhatB1" V 2700 4270 50  0000 R CNN
F 1 "1N4148W" V 2655 4270 50  0001 R CNN
F 2 "Diode_THT:D_DO-35_SOD27_P7.62mm_Horizontal" H 2700 4175 50  0001 C CNN
F 3 "https://www.vishay.com/docs/85748/1n4148w.pdf" H 2700 4350 50  0001 C CNN
	1    2700 4350
	0    -1   -1   0   
$EndComp
$Comp
L Diode:1N4148W DhatC1
U 1 1 60E2B327
P 2700 3750
F 0 "DhatC1" V 2700 3670 50  0000 R CNN
F 1 "1N4148W" V 2655 3670 50  0001 R CNN
F 2 "Diode_THT:D_DO-35_SOD27_P7.62mm_Horizontal" H 2700 3575 50  0001 C CNN
F 3 "https://www.vishay.com/docs/85748/1n4148w.pdf" H 2700 3750 50  0001 C CNN
	1    2700 3750
	0    -1   -1   0   
$EndComp
$Comp
L Diode:1N4148W DhatD1
U 1 1 60E2BA17
P 2700 3150
F 0 "DhatD1" V 2700 3070 50  0000 R CNN
F 1 "1N4148W" V 2655 3070 50  0001 R CNN
F 2 "Diode_THT:D_DO-35_SOD27_P7.62mm_Horizontal" H 2700 2975 50  0001 C CNN
F 3 "https://www.vishay.com/docs/85748/1n4148w.pdf" H 2700 3150 50  0001 C CNN
	1    2700 3150
	0    -1   -1   0   
$EndComp
$Comp
L Diode:1N4148W DhatE1
U 1 1 60E354F4
P 2700 7300
F 0 "DhatE1" V 2700 7220 50  0000 R CNN
F 1 "1N4148W" V 2655 7220 50  0001 R CNN
F 2 "Diode_THT:D_DO-35_SOD27_P7.62mm_Horizontal" H 2700 7125 50  0001 C CNN
F 3 "https://www.vishay.com/docs/85748/1n4148w.pdf" H 2700 7300 50  0001 C CNN
	1    2700 7300
	0    -1   -1   0   
$EndComp
$Comp
L Diode:1N4148W DhatF1
U 1 1 60E36082
P 2700 6750
F 0 "DhatF1" V 2700 6670 50  0000 R CNN
F 1 "1N4148W" V 2655 6670 50  0001 R CNN
F 2 "Diode_THT:D_DO-35_SOD27_P7.62mm_Horizontal" H 2700 6575 50  0001 C CNN
F 3 "https://www.vishay.com/docs/85748/1n4148w.pdf" H 2700 6750 50  0001 C CNN
	1    2700 6750
	0    -1   -1   0   
$EndComp
$Comp
L Diode:1N4148W DHatButton1
U 1 1 60D110AF
P 3550 7300
F 0 "DHatButton1" V 3550 7220 50  0000 R CNN
F 1 "1N4148W" V 3505 7220 50  0001 R CNN
F 2 "Diode_THT:D_DO-35_SOD27_P7.62mm_Horizontal" H 3550 7125 50  0001 C CNN
F 3 "https://www.vishay.com/docs/85748/1n4148w.pdf" H 3550 7300 50  0001 C CNN
	1    3550 7300
	0    -1   -1   0   
$EndComp
$Comp
L Diode:1N4148W DhatA1
U 1 1 60E3DEFD
P 2700 4950
F 0 "DhatA1" V 2700 4870 50  0000 R CNN
F 1 "1N4148W" V 2655 4870 50  0001 R CNN
F 2 "Diode_THT:D_DO-35_SOD27_P7.62mm_Horizontal" H 2700 4775 50  0001 C CNN
F 3 "https://www.vishay.com/docs/85748/1n4148w.pdf" H 2700 4950 50  0001 C CNN
	1    2700 4950
	0    -1   -1   0   
$EndComp
$Comp
L Diode:1N4148W DhatG1
U 1 1 60E3E955
P 2700 6150
F 0 "DhatG1" V 2700 6070 50  0000 R CNN
F 1 "1N4148W" V 2655 6070 50  0001 R CNN
F 2 "Diode_THT:D_DO-35_SOD27_P7.62mm_Horizontal" H 2700 5975 50  0001 C CNN
F 3 "https://www.vishay.com/docs/85748/1n4148w.pdf" H 2700 6150 50  0001 C CNN
	1    2700 6150
	0    -1   -1   0   
$EndComp
$Comp
L Diode:1N4148W DhatH1
U 1 1 60E3F22E
P 2700 5550
F 0 "DhatH1" V 2700 5470 50  0000 R CNN
F 1 "1N4148W" V 2655 5470 50  0001 R CNN
F 2 "Diode_THT:D_DO-35_SOD27_P7.62mm_Horizontal" H 2700 5375 50  0001 C CNN
F 3 "https://www.vishay.com/docs/85748/1n4148w.pdf" H 2700 5550 50  0001 C CNN
	1    2700 5550
	0    -1   -1   0   
$EndComp
Wire Wire Line
	5200 3600 5100 3600
Wire Wire Line
	3700 3000 3550 3000
$Comp
L Diode:1N4148W D7
U 1 1 60CD44AC
P 3550 3150
F 0 "D7" V 3550 3070 50  0000 R CNN
F 1 "1N4148W" V 3505 3070 50  0001 R CNN
F 2 "Diode_SMD:D_SOD-123" H 3550 2975 50  0001 C CNN
F 3 "https://www.vishay.com/docs/85748/1n4148w.pdf" H 3550 3150 50  0001 C CNN
	1    3550 3150
	0    -1   -1   0   
$EndComp
$Comp
L Switch:SW_MEC_5E swBack1
U 1 1 60B7E752
P 3900 3100
F 0 "swBack1" H 3900 3393 50  0000 C CNN
F 1 "SW_MEC_5E" H 3900 3394 50  0001 C CNN
F 2 "ya-hotas-throttle-ee:Switch_Tact" H 3900 3400 50  0001 C CNN
F 3 "http://www.apem.com/int/index.php?controller=attachment&id_attachment=1371" H 3900 3400 50  0001 C CNN
	1    3900 3100
	1    0    0    -1  
$EndComp
Connection ~ 4200 5400
Wire Wire Line
	6400 5700 4550 5700
Connection ~ 3550 5700
Wire Wire Line
	3550 5700 2700 5700
Wire Wire Line
	6400 6300 3550 6300
Wire Wire Line
	6400 6900 3550 6900
Connection ~ 3550 6900
Wire Wire Line
	3550 6900 2700 6900
Wire Wire Line
	6400 7450 3550 7450
Connection ~ 3550 7450
Wire Wire Line
	3550 7450 2700 7450
Connection ~ 3550 6300
Wire Wire Line
	3550 6300 2700 6300
Wire Wire Line
	3700 6000 3550 6000
Wire Wire Line
	4200 6000 4100 6000
Wire Wire Line
	4200 5400 4200 6000
Wire Wire Line
	4200 6000 4200 6600
Connection ~ 4200 6000
Wire Wire Line
	3550 7050 3550 7150
Connection ~ 4200 2650
Wire Wire Line
	2700 4650 2700 4800
$Comp
L kicad-tloimu-lib:Hat8+press S1
U 1 1 60BFA4BD
P 2350 4950
F 0 "S1" H 2350 4900 50  0000 C CNN
F 1 "Hat8+press" H 2350 4800 50  0000 C CNN
F 2 "ya-hotas-throttle-ee:AlpsRKJXL100401V" H 2350 4950 50  0001 C CNN
F 3 "" H 2350 4950 50  0001 C CNN
	1    2350 4950
	0    1    1    0   
$EndComp
Wire Wire Line
	850  2500 850  4550
Wire Wire Line
	1900 4650 2700 4650
Wire Wire Line
	1700 4550 850  4550
Connection ~ 850  4550
Wire Wire Line
	1700 5350 850  5350
Wire Wire Line
	850  4550 850  5350
Wire Wire Line
	1800 4600 1800 4200
Wire Wire Line
	1800 4200 2700 4200
Wire Wire Line
	1600 4600 1600 3600
Wire Wire Line
	1600 3600 2700 3600
Wire Wire Line
	1500 4650 1500 3000
Wire Wire Line
	1500 3000 2700 3000
Wire Wire Line
	2100 5000 2100 2650
Wire Wire Line
	2100 2650 4200 2650
Wire Wire Line
	1900 5250 1900 5400
Wire Wire Line
	1900 5400 2700 5400
Wire Wire Line
	1800 5300 1800 6000
Wire Wire Line
	1800 6000 2700 6000
Wire Wire Line
	1600 5300 1600 6600
Wire Wire Line
	1600 6600 2700 6600
Wire Wire Line
	1500 5250 1500 7150
Wire Wire Line
	1500 7150 2700 7150
Wire Wire Line
	1300 5000 1300 7050
Wire Wire Line
	1300 7050 3550 7050
Text GLabel 6400 7450 2    50   Input ~ 0
col8
Text GLabel 6400 6900 2    50   Input ~ 0
col7
Text GLabel 6400 6300 2    50   Input ~ 0
col6
Text GLabel 6400 5700 2    50   Input ~ 0
col5
Text GLabel 6400 5100 2    50   Input ~ 0
col4
Text GLabel 6400 4500 2    50   Input ~ 0
col3
Text GLabel 6400 3900 2    50   Input ~ 0
col2
Text GLabel 6400 3300 2    50   Input ~ 0
col1
Wire Wire Line
	2700 4500 3500 4500
Connection ~ 3500 4500
Wire Wire Line
	3500 4500 6400 4500
Connection ~ 4200 4200
Text GLabel 5200 2500 1    50   Input ~ 0
row3
Text Notes 6000 2550 0    50   ~ 0
Move ExtraBack and ExtraForward to ROW 3 (pin 0)\nand remove the pin0-jumper.\nAdd Mode-button to Row2-Col4?
Connection ~ 4550 5700
Wire Wire Line
	4550 5700 3550 5700
Connection ~ 5200 5400
Wire Wire Line
	5200 5400 5200 7100
Wire Wire Line
	2700 3300 3550 3300
Connection ~ 4550 3900
Wire Wire Line
	4550 3900 6400 3900
Connection ~ 5200 3600
Wire Wire Line
	5200 3600 5200 4800
Wire Wire Line
	2700 3900 4550 3900
Wire Wire Line
	4200 2650 4200 3000
Connection ~ 3550 3300
Connection ~ 4200 3000
Wire Wire Line
	4200 3000 4200 4200
Wire Wire Line
	5200 2500 5200 3600
Wire Wire Line
	3550 3300 6400 3300
Connection ~ 4500 5100
Wire Wire Line
	4500 5100 6400 5100
Connection ~ 5200 4800
Wire Wire Line
	5200 4800 5200 5400
Wire Wire Line
	4200 4200 4200 5400
Wire Wire Line
	2700 5100 4500 5100
$EndSCHEMATC
