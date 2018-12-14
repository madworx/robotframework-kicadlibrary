EESchema Schematic File Version 4
EELAYER 26 0
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
L 74xx:74LS688 U*1
U 1 1 5C10CE1F
P 5950 3750
F 0 "U*1" H 6491 3796 50  0000 L CNN
F 1 "74LS688" H 6491 3705 50  0000 L CNN
F 2 "Package_DIP:DIP-20_W7.62mm" H 5950 3750 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS688" H 5950 3750 50  0001 C CNN
	1    5950 3750
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0101
U 1 1 5C10CEF9
P 5950 2450
F 0 "#PWR0101" H 5950 2300 50  0001 C CNN
F 1 "VCC" H 5967 2623 50  0000 C CNN
F 2 "" H 5950 2450 50  0001 C CNN
F 3 "" H 5950 2450 50  0001 C CNN
	1    5950 2450
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0102
U 1 1 5C10CF36
P 5950 5050
F 0 "#PWR0102" H 5950 4800 50  0001 C CNN
F 1 "GND" H 5955 4877 50  0000 C CNN
F 2 "" H 5950 5050 50  0001 C CNN
F 3 "" H 5950 5050 50  0001 C CNN
	1    5950 5050
	1    0    0    -1  
$EndComp
Wire Wire Line
	5950 4950 5950 5000
Connection ~ 5950 5000
Wire Wire Line
	5950 5000 5950 5050
Wire Wire Line
	5450 3750 5350 3750
Wire Wire Line
	5950 2450 5950 2500
Connection ~ 5950 2500
Wire Wire Line
	5950 2500 5950 2550
Wire Wire Line
	5450 4250 5350 4250
Wire Wire Line
	5450 4450 5350 4450
Entry Wire Line
	5250 2750 5350 2850
Entry Wire Line
	5250 2850 5350 2950
Entry Wire Line
	5250 2950 5350 3050
Entry Wire Line
	5250 3050 5350 3150
Entry Wire Line
	5250 3150 5350 3250
Entry Wire Line
	5250 3250 5350 3350
Entry Wire Line
	5250 3350 5350 3450
Entry Wire Line
	5250 3450 5350 3550
Wire Wire Line
	5350 2850 5450 2850
Wire Wire Line
	5350 3050 5450 3050
Wire Wire Line
	5350 3250 5450 3250
Wire Wire Line
	5350 3350 5450 3350
Wire Wire Line
	5350 3450 5450 3450
Text Label 5350 2850 0    50   ~ 0
d0
Text Label 5350 2950 0    50   ~ 0
d1
Text Label 5350 3050 0    50   ~ 0
d2
Text Label 5350 3150 0    50   ~ 0
d3
Text Label 5350 3250 0    50   ~ 0
d4
Text Label 5350 3350 0    50   ~ 0
d5
Text Label 5350 3450 0    50   ~ 0
d6
Text Label 5350 3550 0    50   ~ 0
d7
Wire Wire Line
	5450 2950 5350 2950
Wire Wire Line
	5450 3150 5350 3150
Wire Wire Line
	5450 3550 5350 3550
Wire Wire Line
	5150 2500 5150 3950
Wire Wire Line
	5150 3950 5150 4150
Connection ~ 5150 3950
Wire Wire Line
	5150 4150 5150 4350
Connection ~ 5150 4150
Wire Wire Line
	5150 2500 5950 2500
Wire Wire Line
	5150 3950 5450 3950
Wire Wire Line
	5150 4350 5450 4350
Wire Wire Line
	5150 4150 5450 4150
Connection ~ 5350 4050
Wire Wire Line
	5350 4050 5450 4050
Wire Wire Line
	5350 4050 5350 4250
Connection ~ 5350 4250
Wire Wire Line
	5350 4250 5350 4450
Wire Wire Line
	5350 4450 5350 4650
Connection ~ 5350 4450
Wire Wire Line
	5450 4650 5350 4650
Connection ~ 5350 4650
Wire Wire Line
	5350 4650 5350 5000
Wire Wire Line
	5350 5000 5950 5000
Wire Wire Line
	5350 3750 5350 3850
$Comp
L power:VCC #PWR0103
U 1 1 5C12228F
P 7900 2450
F 0 "#PWR0103" H 7900 2300 50  0001 C CNN
F 1 "VCC" H 7917 2623 50  0000 C CNN
F 2 "" H 7900 2450 50  0001 C CNN
F 3 "" H 7900 2450 50  0001 C CNN
	1    7900 2450
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0104
U 1 1 5C122295
P 7900 5050
F 0 "#PWR0104" H 7900 4800 50  0001 C CNN
F 1 "GND" H 7905 4877 50  0000 C CNN
F 2 "" H 7900 5050 50  0001 C CNN
F 3 "" H 7900 5050 50  0001 C CNN
	1    7900 5050
	1    0    0    -1  
$EndComp
Wire Wire Line
	7900 4950 7900 5000
Connection ~ 7900 5000
Wire Wire Line
	7900 5000 7900 5050
Wire Wire Line
	7400 3750 7300 3750
Wire Wire Line
	7900 2450 7900 2500
Connection ~ 7900 2500
Wire Wire Line
	7900 2500 7900 2550
Wire Wire Line
	7400 4250 7300 4250
Wire Wire Line
	7400 4450 7300 4450
Entry Wire Line
	7200 2750 7300 2850
Entry Wire Line
	7200 2850 7300 2950
Entry Wire Line
	7200 2950 7300 3050
Entry Wire Line
	7200 3050 7300 3150
Entry Wire Line
	7200 3150 7300 3250
Entry Wire Line
	7200 3250 7300 3350
Entry Wire Line
	7200 3350 7300 3450
Entry Wire Line
	7200 3450 7300 3550
Wire Wire Line
	7300 2850 7400 2850
Wire Wire Line
	7300 3050 7400 3050
Wire Wire Line
	7300 3250 7400 3250
Wire Wire Line
	7300 3350 7400 3350
Wire Wire Line
	7300 3450 7400 3450
Text Label 7300 2850 0    50   ~ 0
d0
Text Label 7300 2950 0    50   ~ 0
d1
Text Label 7300 3050 0    50   ~ 0
d2
Text Label 7300 3150 0    50   ~ 0
d3
Text Label 7300 3250 0    50   ~ 0
d4
Text Label 7300 3350 0    50   ~ 0
d5
Text Label 7300 3450 0    50   ~ 0
d6
Text Label 7300 3550 0    50   ~ 0
d7
Wire Wire Line
	7400 2950 7300 2950
Wire Wire Line
	7400 3150 7300 3150
Wire Wire Line
	7400 3550 7300 3550
Wire Wire Line
	7100 2500 7100 3950
Wire Wire Line
	7100 3950 7100 4150
Connection ~ 7100 3950
Wire Wire Line
	7100 4150 7100 4350
Connection ~ 7100 4150
Wire Wire Line
	7100 2500 7900 2500
Wire Wire Line
	7100 3950 7400 3950
Wire Wire Line
	7100 4350 7400 4350
Wire Wire Line
	7100 4150 7400 4150
Connection ~ 7300 4050
Wire Wire Line
	7300 4050 7400 4050
Wire Wire Line
	7300 4050 7300 4250
Connection ~ 7300 4250
Wire Wire Line
	7300 4250 7300 4450
Wire Wire Line
	7300 4450 7300 4650
Connection ~ 7300 4450
Wire Wire Line
	7400 4650 7300 4650
Connection ~ 7300 4650
Wire Wire Line
	7300 4650 7300 5000
Wire Wire Line
	7300 5000 7900 5000
Wire Wire Line
	7300 3750 7300 3850
Wire Wire Line
	7400 3850 7300 3850
Connection ~ 7300 3850
Wire Wire Line
	7300 3850 7300 4050
Wire Wire Line
	5450 3850 5350 3850
Connection ~ 5350 3850
Wire Wire Line
	5350 3850 5350 4050
Entry Wire Line
	3050 3150 3150 3250
Entry Wire Line
	3050 3250 3150 3350
Entry Wire Line
	3050 3350 3150 3450
Entry Wire Line
	3050 3450 3150 3550
Entry Wire Line
	3050 3550 3150 3650
Entry Wire Line
	3050 3650 3150 3750
Text Label 3150 3250 0    50   ~ 0
VCC
Text Label 3150 3350 0    50   ~ 0
d0
Text Label 3150 3450 0    50   ~ 0
d2
Text Label 3150 3550 0    50   ~ 0
d4
Text Label 3150 3650 0    50   ~ 0
d6
$Comp
L Connector_Generic:Conn_02x06_Odd_Even J1
U 1 1 5C126C8B
P 3550 3450
F 0 "J1" H 3600 3867 50  0000 C CNN
F 1 "Conn_02x06_Odd_Even" H 3600 3776 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_2x06_P2.54mm_Vertical" H 3550 3450 50  0001 C CNN
F 3 "~" H 3550 3450 50  0001 C CNN
	1    3550 3450
	1    0    0    -1  
$EndComp
Wire Wire Line
	3150 3250 3350 3250
Wire Wire Line
	3150 3350 3350 3350
Wire Wire Line
	3150 3450 3350 3450
Wire Wire Line
	3150 3550 3350 3550
Wire Wire Line
	3150 3650 3350 3650
Wire Wire Line
	3150 3750 3350 3750
Entry Wire Line
	4150 3150 4050 3250
Entry Wire Line
	4150 3250 4050 3350
Entry Wire Line
	4150 3350 4050 3450
Entry Wire Line
	4150 3450 4050 3550
Entry Wire Line
	4150 3550 4050 3650
Entry Wire Line
	4150 3650 4050 3750
Text Label 4050 3250 2    50   ~ 0
GND
Text Label 4050 3350 2    50   ~ 0
d1
Text Label 4050 3450 2    50   ~ 0
d3
Text Label 4050 3550 2    50   ~ 0
d5
Text Label 4050 3650 2    50   ~ 0
d7
Text Label 4050 3750 2    50   ~ 0
id#
Wire Wire Line
	4050 3250 3850 3250
Wire Wire Line
	4050 3350 3850 3350
Wire Wire Line
	4050 3450 3850 3450
Wire Wire Line
	4050 3550 3850 3550
Wire Wire Line
	4050 3650 3850 3650
Text Label 3150 3750 0    50   ~ 0
id*
Wire Wire Line
	3850 3750 4050 3750
$Comp
L 74xx:74LS688 U#1
U 1 1 5C122289
P 7900 3750
F 0 "U#1" H 8441 3796 50  0000 L CNN
F 1 "74LS688" H 8441 3705 50  0000 L CNN
F 2 "Package_DIP:DIP-20_W7.62mm" H 7900 3750 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS688" H 7900 3750 50  0001 C CNN
	1    7900 3750
	1    0    0    -1  
$EndComp
Wire Wire Line
	8400 2850 8600 2850
Wire Wire Line
	6450 2850 6650 2850
Entry Wire Line
	6650 2850 6750 2950
Entry Wire Line
	8600 2850 8700 2950
Wire Bus Line
	6750 2850 6750 3000
Wire Bus Line
	8700 2850 8700 3000
Wire Bus Line
	3050 3050 3050 3800
Wire Bus Line
	4150 3050 4150 3800
Wire Bus Line
	5250 2700 5250 3600
Wire Bus Line
	7200 2700 7200 3600
Text Label 8450 2850 0    50   ~ 0
id#
Text Label 6500 2850 0    50   ~ 0
id*
$EndSCHEMATC
