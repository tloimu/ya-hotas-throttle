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
P 3900 3700
F 0 "swExtraBack1" H 3900 3993 50  0000 C CNN
F 1 "SW_MEC_5E" H 3900 3994 50  0001 C CNN
F 2 "ya-hotas-throttle-ee:Switch_Tact" H 3900 4000 50  0001 C CNN
F 3 "http://www.apem.com/int/index.php?controller=attachment&id_attachment=1371" H 3900 4000 50  0001 C CNN
	1    3900 3700
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_MEC_5E swBack1
U 1 1 60B7E752
P 5500 3100
F 0 "swBack1" H 5500 3393 50  0000 C CNN
F 1 "SW_MEC_5E" H 5500 3394 50  0001 C CNN
F 2 "ya-hotas-throttle-ee:Switch_Tact" H 5500 3400 50  0001 C CNN
F 3 "http://www.apem.com/int/index.php?controller=attachment&id_attachment=1371" H 5500 3400 50  0001 C CNN
	1    5500 3100
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_MEC_5E dwDown1
U 1 1 60B8700C
P 5450 3700
F 0 "dwDown1" H 5450 3993 50  0000 C CNN
F 1 "SW_MEC_5E" H 5450 3994 50  0001 C CNN
F 2 "ya-hotas-throttle-ee:Switch_Tact" H 5450 4000 50  0001 C CNN
F 3 "http://www.apem.com/int/index.php?controller=attachment&id_attachment=1371" H 5450 4000 50  0001 C CNN
	1    5450 3700
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_MEC_5E swExtraForward1
U 1 1 60B882A4
P 3900 3100
F 0 "swExtraForward1" H 3900 3393 50  0000 C CNN
F 1 "SW_MEC_5E" H 3900 3394 50  0001 C CNN
F 2 "ya-hotas-throttle-ee:Switch_Tact" H 3900 3400 50  0001 C CNN
F 3 "http://www.apem.com/int/index.php?controller=attachment&id_attachment=1371" H 3900 3400 50  0001 C CNN
	1    3900 3100
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_MEC_5E swForward1
U 1 1 60B895EB
P 5500 5900
F 0 "swForward1" H 5500 6193 50  0000 C CNN
F 1 "SW_MEC_5E" H 5500 6194 50  0001 C CNN
F 2 "ya-hotas-throttle-ee:Switch_Tact" H 5500 6200 50  0001 C CNN
F 3 "http://www.apem.com/int/index.php?controller=attachment&id_attachment=1371" H 5500 6200 50  0001 C CNN
	1    5500 5900
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_MEC_5E swUp1
U 1 1 60B6C2E9
P 3100 3100
F 0 "swUp1" H 3100 3393 50  0000 C CNN
F 1 "SW_MEC_5E" H 3100 3394 50  0001 C CNN
F 2 "ya-hotas-throttle-ee:Switch_Tact" H 3100 3400 50  0001 C CNN
F 3 "http://www.apem.com/int/index.php?controller=attachment&id_attachment=1371" H 3100 3400 50  0001 C CNN
	1    3100 3100
	1    0    0    -1  
$EndComp
Text GLabel 6400 3300 2    50   Input ~ 0
col1
Text GLabel 6400 3900 2    50   Input ~ 0
col2
Text GLabel 6400 4200 2    50   Input ~ 0
col3
Text GLabel 3400 2500 1    50   Input ~ 0
row1
Text GLabel 4200 2500 1    50   Input ~ 0
row2
Text GLabel 5000 2500 1    50   Input ~ 0
row3
Text GLabel 5800 2500 1    50   Input ~ 0
row4
$Comp
L Diode:1N4148W D1
U 1 1 60BD82F0
P 2700 3150
F 0 "D1" V 2700 3070 50  0000 R CNN
F 1 "1N4148W" V 2655 3070 50  0001 R CNN
F 2 "Diode_SMD:D_SOD-123" H 2700 2975 50  0001 C CNN
F 3 "https://www.vishay.com/docs/85748/1n4148w.pdf" H 2700 3150 50  0001 C CNN
	1    2700 3150
	0    -1   -1   0   
$EndComp
Wire Wire Line
	2700 3000 2900 3000
Wire Wire Line
	3500 3000 3700 3000
Wire Wire Line
	3550 3600 3700 3600
Wire Wire Line
	4200 3600 4100 3600
Wire Wire Line
	4200 3000 4100 3000
Wire Wire Line
	3400 2500 3400 3000
Wire Wire Line
	3400 3000 3300 3000
$Comp
L Switch:SW_DPDT_x2 swMode1
U 1 1 60BF419C
P 6650 4700
F 0 "swMode1" H 6650 4500 50  0000 C CNN
F 1 "SW_DPDT_x2" H 6650 4894 50  0001 C CNN
F 2 "ya-hotas-throttle-ee:Switch_slide_2" H 6650 4700 50  0001 C CNN
F 3 "~" H 6650 4700 50  0001 C CNN
	1    6650 4700
	-1   0    0    1   
$EndComp
Text GLabel 6350 5500 2    50   Input ~ 0
col4
Wire Wire Line
	2700 3900 3550 3900
$Comp
L Diode:1N4148W D2
U 1 1 60C459F8
P 3500 3150
F 0 "D2" V 3500 3070 50  0000 R CNN
F 1 "1N4148W" V 3455 3070 50  0001 R CNN
F 2 "Diode_THT:D_DO-35_SOD27_P7.62mm_Horizontal" H 3500 2975 50  0001 C CNN
F 3 "https://www.vishay.com/docs/85748/1n4148w.pdf" H 3500 3150 50  0001 C CNN
	1    3500 3150
	0    -1   -1   0   
$EndComp
$Comp
L Diode:1N4148W D5
U 1 1 60C63D98
P 3550 3750
F 0 "D5" V 3550 3670 50  0000 R CNN
F 1 "1N4148W" V 3505 3670 50  0001 R CNN
F 2 "Diode_THT:D_DO-35_SOD27_P7.62mm_Horizontal" H 3550 3575 50  0001 C CNN
F 3 "https://www.vishay.com/docs/85748/1n4148w.pdf" H 3550 3750 50  0001 C CNN
	1    3550 3750
	0    -1   -1   0   
$EndComp
Connection ~ 3550 3900
$Comp
L Diode:1N4148W D6
U 1 1 60CCDE9A
P 5150 5950
F 0 "D6" V 5150 5870 50  0000 R CNN
F 1 "1N4148W" V 5105 5870 50  0001 R CNN
F 2 "Diode_SMD:D_SOD-123" H 5150 5775 50  0001 C CNN
F 3 "https://www.vishay.com/docs/85748/1n4148w.pdf" H 5150 5950 50  0001 C CNN
	1    5150 5950
	0    -1   -1   0   
$EndComp
Wire Wire Line
	5150 5800 5300 5800
$Comp
L Diode:1N4148W D7
U 1 1 60CD44AC
P 5150 3150
F 0 "D7" V 5150 3070 50  0000 R CNN
F 1 "1N4148W" V 5105 3070 50  0001 R CNN
F 2 "Diode_SMD:D_SOD-123" H 5150 2975 50  0001 C CNN
F 3 "https://www.vishay.com/docs/85748/1n4148w.pdf" H 5150 3150 50  0001 C CNN
	1    5150 3150
	0    -1   -1   0   
$EndComp
Connection ~ 5150 3300
Wire Wire Line
	5150 3300 6400 3300
Wire Wire Line
	5300 3000 5150 3000
$Comp
L Diode:1N4148W D3
U 1 1 60CDDD9C
P 6200 4850
F 0 "D3" V 6200 4770 50  0000 R CNN
F 1 "1N4148W" V 6155 4770 50  0001 R CNN
F 2 "Diode_THT:D_DO-35_SOD27_P7.62mm_Horizontal" H 6200 4675 50  0001 C CNN
F 3 "https://www.vishay.com/docs/85748/1n4148w.pdf" H 6200 4850 50  0001 C CNN
	1    6200 4850
	0    -1   -1   0   
$EndComp
Text GLabel 6350 6100 2    50   Input ~ 0
col5
Wire Wire Line
	6450 4600 6200 4600
Wire Wire Line
	6200 4600 6200 4700
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
P 5100 3750
F 0 "D4" V 5100 3670 50  0000 R CNN
F 1 "1N4148W" V 5055 3670 50  0001 R CNN
F 2 "Diode_SMD:D_SOD-123" H 5100 3575 50  0001 C CNN
F 3 "https://www.vishay.com/docs/85748/1n4148w.pdf" H 5100 3750 50  0001 C CNN
	1    5100 3750
	0    -1   -1   0   
$EndComp
Connection ~ 5100 3900
Wire Wire Line
	5100 3900 6400 3900
Wire Wire Line
	5250 3600 5100 3600
Wire Wire Line
	5650 3600 5800 3600
Connection ~ 5800 3600
Wire Wire Line
	4200 2500 4200 3000
Connection ~ 4200 3600
Connection ~ 3400 3000
Wire Wire Line
	5700 5800 5800 5800
Wire Wire Line
	5800 3000 5800 3600
Wire Wire Line
	5800 3000 5800 2500
Connection ~ 5800 3000
Wire Wire Line
	5700 3000 5800 3000
Connection ~ 5150 6100
Wire Wire Line
	2700 3300 3500 3300
Wire Wire Line
	5150 6100 6350 6100
$Comp
L kicad-tloimu-lib:Hat8+press S1
U 1 1 60BFA4BD
P 3950 5500
F 0 "S1" H 3950 5450 50  0000 C CNN
F 1 "Hat8+press" H 3950 5350 50  0000 C CNN
F 2 "ya-hotas-throttle-ee:AlpsRKJXL100401V" H 3950 5500 50  0001 C CNN
F 3 "" H 3950 5500 50  0001 C CNN
	1    3950 5500
	-1   0    0    1   
$EndComp
Wire Wire Line
	5800 5200 5700 5200
Wire Wire Line
	5300 5200 5150 5200
$Comp
L Switch:SW_MEC_5E swTrigger1
U 1 1 60CD9F9C
P 5500 5300
F 0 "swTrigger1" H 5500 5593 50  0000 C CNN
F 1 "SW_MEC_5E" H 5500 5594 50  0001 C CNN
F 2 "ya-hotas-throttle-ee:Switch_Tact" H 5500 5600 50  0001 C CNN
F 3 "http://www.apem.com/int/index.php?controller=attachment&id_attachment=1371" H 5500 5600 50  0001 C CNN
	1    5500 5300
	1    0    0    -1  
$EndComp
$Comp
L Diode:1N4148W Dtrigger1
U 1 1 60C636AC
P 5150 5350
F 0 "Dtrigger1" V 5150 5270 50  0000 R CNN
F 1 "1N4148W" V 5105 5270 50  0001 R CNN
F 2 "Diode_SMD:D_SOD-123" H 5150 5175 50  0001 C CNN
F 3 "https://www.vishay.com/docs/85748/1n4148w.pdf" H 5150 5350 50  0001 C CNN
	1    5150 5350
	0    -1   -1   0   
$EndComp
Connection ~ 3500 3300
Connection ~ 4200 3000
Wire Wire Line
	4200 3000 4200 3600
Wire Wire Line
	2700 6100 3550 6100
Wire Wire Line
	3550 3900 4350 3900
Wire Wire Line
	5800 3600 5800 5200
Wire Wire Line
	2700 4200 4350 4200
Wire Wire Line
	6350 5500 5150 5500
$Comp
L Diode:1N4148W DhatB1
U 1 1 60E2A9C4
P 4350 5350
F 0 "DhatB1" V 4350 5270 50  0000 R CNN
F 1 "1N4148W" V 4305 5270 50  0001 R CNN
F 2 "Diode_THT:D_DO-35_SOD27_P7.62mm_Horizontal" H 4350 5175 50  0001 C CNN
F 3 "https://www.vishay.com/docs/85748/1n4148w.pdf" H 4350 5350 50  0001 C CNN
	1    4350 5350
	0    -1   -1   0   
$EndComp
$Comp
L Diode:1N4148W DhatC1
U 1 1 60E2B327
P 4350 3750
F 0 "DhatC1" V 4350 3670 50  0000 R CNN
F 1 "1N4148W" V 4305 3670 50  0001 R CNN
F 2 "Diode_THT:D_DO-35_SOD27_P7.62mm_Horizontal" H 4350 3575 50  0001 C CNN
F 3 "https://www.vishay.com/docs/85748/1n4148w.pdf" H 4350 3750 50  0001 C CNN
	1    4350 3750
	0    -1   -1   0   
$EndComp
Connection ~ 4350 3900
Wire Wire Line
	4350 3900 5100 3900
$Comp
L Diode:1N4148W DhatD1
U 1 1 60E2BA17
P 4350 4350
F 0 "DhatD1" V 4350 4270 50  0000 R CNN
F 1 "1N4148W" V 4305 4270 50  0001 R CNN
F 2 "Diode_THT:D_DO-35_SOD27_P7.62mm_Horizontal" H 4350 4175 50  0001 C CNN
F 3 "https://www.vishay.com/docs/85748/1n4148w.pdf" H 4350 4350 50  0001 C CNN
	1    4350 4350
	0    1    1    0   
$EndComp
$Comp
L Diode:1N4148W DhatE1
U 1 1 60E354F4
P 2700 3750
F 0 "DhatE1" V 2700 3670 50  0000 R CNN
F 1 "1N4148W" V 2655 3670 50  0001 R CNN
F 2 "Diode_THT:D_DO-35_SOD27_P7.62mm_Horizontal" H 2700 3575 50  0001 C CNN
F 3 "https://www.vishay.com/docs/85748/1n4148w.pdf" H 2700 3750 50  0001 C CNN
	1    2700 3750
	0    -1   -1   0   
$EndComp
$Comp
L Diode:1N4148W DhatF1
U 1 1 60E36082
P 2700 4350
F 0 "DhatF1" V 2700 4270 50  0000 R CNN
F 1 "1N4148W" V 2655 4270 50  0001 R CNN
F 2 "Diode_THT:D_DO-35_SOD27_P7.62mm_Horizontal" H 2700 4175 50  0001 C CNN
F 3 "https://www.vishay.com/docs/85748/1n4148w.pdf" H 2700 4350 50  0001 C CNN
	1    2700 4350
	0    1    1    0   
$EndComp
$Comp
L Diode:1N4148W DHatButton1
U 1 1 60D110AF
P 3550 5950
F 0 "DHatButton1" V 3550 5870 50  0000 R CNN
F 1 "1N4148W" V 3505 5870 50  0001 R CNN
F 2 "Diode_THT:D_DO-35_SOD27_P7.62mm_Horizontal" H 3550 5775 50  0001 C CNN
F 3 "https://www.vishay.com/docs/85748/1n4148w.pdf" H 3550 5950 50  0001 C CNN
	1    3550 5950
	0    -1   -1   0   
$EndComp
Connection ~ 3550 6100
Connection ~ 4350 4200
Wire Wire Line
	4350 4200 6400 4200
$Comp
L Diode:1N4148W DhatA1
U 1 1 60E3DEFD
P 4350 3150
F 0 "DhatA1" V 4350 3070 50  0000 R CNN
F 1 "1N4148W" V 4305 3070 50  0001 R CNN
F 2 "Diode_THT:D_DO-35_SOD27_P7.62mm_Horizontal" H 4350 2975 50  0001 C CNN
F 3 "https://www.vishay.com/docs/85748/1n4148w.pdf" H 4350 3150 50  0001 C CNN
	1    4350 3150
	0    -1   -1   0   
$EndComp
$Comp
L Diode:1N4148W DhatG1
U 1 1 60E3E955
P 2700 5350
F 0 "DhatG1" V 2700 5270 50  0000 R CNN
F 1 "1N4148W" V 2655 5270 50  0001 R CNN
F 2 "Diode_THT:D_DO-35_SOD27_P7.62mm_Horizontal" H 2700 5175 50  0001 C CNN
F 3 "https://www.vishay.com/docs/85748/1n4148w.pdf" H 2700 5350 50  0001 C CNN
	1    2700 5350
	0    -1   -1   0   
$EndComp
$Comp
L Diode:1N4148W DhatH1
U 1 1 60E3F22E
P 2700 5950
F 0 "DhatH1" V 2700 5870 50  0000 R CNN
F 1 "1N4148W" V 2655 5870 50  0001 R CNN
F 2 "Diode_THT:D_DO-35_SOD27_P7.62mm_Horizontal" H 2700 5775 50  0001 C CNN
F 3 "https://www.vishay.com/docs/85748/1n4148w.pdf" H 2700 5950 50  0001 C CNN
	1    2700 5950
	0    -1   -1   0   
$EndComp
Wire Wire Line
	4200 3600 4200 4450
Wire Wire Line
	3400 3000 3400 4850
Wire Wire Line
	5000 2500 5000 4850
Wire Wire Line
	3550 4850 3400 4850
Connection ~ 3400 4850
Wire Wire Line
	3400 4850 3400 5800
Wire Wire Line
	4350 4850 5000 4850
Connection ~ 5000 4850
Wire Wire Line
	5000 4850 5000 5800
Wire Wire Line
	4250 4650 4350 4650
Wire Wire Line
	4350 4650 4350 4500
Wire Wire Line
	4300 4750 4500 4750
Wire Wire Line
	4500 4750 4500 3600
Wire Wire Line
	4500 3600 4350 3600
Wire Wire Line
	3650 4650 3000 4650
Wire Wire Line
	3000 4650 3000 3600
Wire Wire Line
	3000 3600 2700 3600
Wire Wire Line
	3600 4750 2700 4750
Wire Wire Line
	2700 4750 2700 4500
Wire Wire Line
	3600 4950 2700 4950
Wire Wire Line
	2700 4950 2700 5200
Wire Wire Line
	3650 5050 3000 5050
Wire Wire Line
	3000 5050 3000 5800
Wire Wire Line
	3000 5800 2700 5800
Wire Wire Line
	3900 5250 3550 5250
Wire Wire Line
	3550 5250 3550 5800
Wire Wire Line
	3900 4450 4200 4450
Connection ~ 4200 4450
Wire Wire Line
	4200 4450 4200 5800
Wire Wire Line
	2700 5500 4350 5500
Wire Wire Line
	3500 3300 4350 3300
Connection ~ 4350 3300
Wire Wire Line
	4350 3300 5150 3300
Wire Wire Line
	4700 5050 4700 3000
Wire Wire Line
	4350 3000 4700 3000
Wire Wire Line
	4250 5050 4700 5050
Connection ~ 5150 5500
Connection ~ 5800 5200
Wire Wire Line
	5800 5200 5800 5800
Wire Wire Line
	3550 6100 5150 6100
Connection ~ 4350 5500
Wire Wire Line
	4350 5500 5150 5500
Wire Wire Line
	4300 4950 4350 4950
Wire Wire Line
	4350 4950 4350 5200
$EndSCHEMATC
