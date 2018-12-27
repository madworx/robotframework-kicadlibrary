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
L Timer:LM555 U1
U 1 1 5C193005
P 4200 2650
F 0 "U1" H 4350 3150 50  0000 C CNN
F 1 "LM555" H 4350 3050 50  0000 C CNN
F 2 "Package_DIP:DIP-8_W7.62mm" H 4200 2650 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/lm555.pdf" H 4200 2650 50  0001 C CNN
	1    4200 2650
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0101
U 1 1 5C193F89
P 4200 2050
F 0 "#PWR0101" H 4200 1900 50  0001 C CNN
F 1 "VCC" H 4217 2223 50  0000 C CNN
F 2 "" H 4200 2050 50  0001 C CNN
F 3 "" H 4200 2050 50  0001 C CNN
	1    4200 2050
	1    0    0    -1  
$EndComp
Wire Wire Line
	4200 3050 4200 3200
$Comp
L power:GND #PWR0102
U 1 1 5C19404C
P 4200 3200
F 0 "#PWR0102" H 4200 2950 50  0001 C CNN
F 1 "GND" H 4205 3027 50  0000 C CNN
F 2 "" H 4200 3200 50  0001 C CNN
F 3 "" H 4200 3200 50  0001 C CNN
	1    4200 3200
	1    0    0    -1  
$EndComp
Wire Wire Line
	3700 2850 3600 2850
Wire Wire Line
	3700 2650 3600 2650
Wire Wire Line
	3700 2450 3600 2450
Wire Wire Line
	4800 2450 4700 2450
Wire Wire Line
	4800 2650 4700 2650
Wire Wire Line
	4800 2850 4700 2850
Entry Wire Line
	4800 2450 4900 2550
Entry Wire Line
	4800 2650 4900 2750
Entry Wire Line
	4800 2850 4900 2950
Entry Wire Line
	3500 2950 3600 2850
Entry Wire Line
	3500 2750 3600 2650
Entry Wire Line
	3500 2550 3600 2450
Text Label 4700 2450 0    50   ~ 0
Q
Text Label 4700 2650 0    50   ~ 0
DIS
Text Label 4700 2850 0    50   ~ 0
THR
Text Label 3600 2850 0    50   ~ 0
~R
Text Label 3600 2650 0    50   ~ 0
CV
Text Label 3600 2450 0    50   ~ 0
TR
$Comp
L Timer:LM555 U2
U 1 1 5C1948AB
P 5800 2650
F 0 "U2" H 5950 3150 50  0000 C CNN
F 1 "LM555" H 5950 3050 50  0000 C CNN
F 2 "Package_DIP:DIP-8_W7.62mm" H 5800 2650 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/lm555.pdf" H 5800 2650 50  0001 C CNN
	1    5800 2650
	1    0    0    -1  
$EndComp
$Comp
L power:VCC #PWR0103
U 1 1 5C1948B3
P 5800 2050
F 0 "#PWR0103" H 5800 1900 50  0001 C CNN
F 1 "VCC" H 5817 2223 50  0000 C CNN
F 2 "" H 5800 2050 50  0001 C CNN
F 3 "" H 5800 2050 50  0001 C CNN
	1    5800 2050
	1    0    0    -1  
$EndComp
Wire Wire Line
	5800 3050 5800 3200
$Comp
L power:GND #PWR0104
U 1 1 5C1948BA
P 5800 3200
F 0 "#PWR0104" H 5800 2950 50  0001 C CNN
F 1 "GND" H 5805 3027 50  0000 C CNN
F 2 "" H 5800 3200 50  0001 C CNN
F 3 "" H 5800 3200 50  0001 C CNN
	1    5800 3200
	1    0    0    -1  
$EndComp
Wire Wire Line
	5300 2850 5200 2850
Wire Wire Line
	5300 2650 5200 2650
Wire Wire Line
	5300 2450 5200 2450
Wire Wire Line
	6400 2450 6300 2450
Wire Wire Line
	6400 2650 6300 2650
Wire Wire Line
	6400 2850 6300 2850
Entry Wire Line
	6400 2450 6500 2550
Entry Wire Line
	6400 2650 6500 2750
Entry Wire Line
	6400 2850 6500 2950
Entry Wire Line
	5100 2950 5200 2850
Entry Wire Line
	5100 2750 5200 2650
Entry Wire Line
	5100 2550 5200 2450
Text Label 6300 2450 0    50   ~ 0
Q
Text Label 6300 2650 0    50   ~ 0
DIS
Text Label 6300 2850 0    50   ~ 0
THR
Text Label 5200 2850 0    50   ~ 0
~R
Text Label 5200 2650 0    50   ~ 0
CV
Text Label 5200 2450 0    50   ~ 0
TR
Wire Wire Line
	4200 2050 4200 2250
Wire Wire Line
	5800 2050 5800 2250
$Comp
L Interface:8255 U3
U 1 1 5C1A0A4A
P 8500 3700
F 0 "U3" H 8500 5478 50  0000 C CNN
F 1 "8255" H 8500 5387 50  0000 C CNN
F 2 "Package_DIP:DIP-40_W15.24mm" H 8500 4000 50  0001 C CNN
F 3 "http://aturing.umcs.maine.edu/~meadow/courses/cos335/Intel8255A.pdf" H 8500 4000 50  0001 C CNN
	1    8500 3700
	1    0    0    -1  
$EndComp
$Comp
L Device:R R1
U 1 1 5C24FA6F
P 2800 4350
F 0 "R1" H 2870 4396 50  0000 L CNN
F 1 "10k" H 2870 4305 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0922_L20.0mm_D9.0mm_P7.62mm_Vertical" V 2730 4350 50  0001 C CNN
F 3 "~" H 2800 4350 50  0001 C CNN
	1    2800 4350
	1    0    0    -1  
$EndComp
$Comp
L Device:R R2
U 1 1 5C24FAD5
P 3100 4350
F 0 "R2" H 3170 4396 50  0000 L CNN
F 1 "330" H 3170 4305 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0922_L20.0mm_D9.0mm_P7.62mm_Vertical" V 3030 4350 50  0001 C CNN
F 3 "~" H 3100 4350 50  0001 C CNN
	1    3100 4350
	1    0    0    -1  
$EndComp
$Comp
L Device:R R3
U 1 1 5C24FB07
P 3400 4350
F 0 "R3" H 3470 4396 50  0000 L CNN
F 1 "2 M" H 3470 4305 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0922_L20.0mm_D9.0mm_P7.62mm_Vertical" V 3330 4350 50  0001 C CNN
F 3 "~" H 3400 4350 50  0001 C CNN
	1    3400 4350
	1    0    0    -1  
$EndComp
$Comp
L Device:R R4
U 1 1 5C24FB98
P 3700 4350
F 0 "R4" H 3770 4396 50  0000 L CNN
F 1 "0.1uF" H 3770 4305 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0922_L20.0mm_D9.0mm_P7.62mm_Vertical" V 3630 4350 50  0001 C CNN
F 3 "~" H 3700 4350 50  0001 C CNN
	1    3700 4350
	1    0    0    -1  
$EndComp
Wire Bus Line
	3500 2350 3500 3050
Wire Bus Line
	4900 2350 4900 3050
Wire Bus Line
	5100 2350 5100 3050
Wire Bus Line
	6500 2350 6500 3050
$EndSCHEMATC
