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
L Interface:DS90LV011A U1
U 1 1 5F5ACB9F
P 3150 1550
F 0 "U1" H 3150 2131 50  0000 C CNN
F 1 "DS90LV011A" H 3150 2040 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23-5" H 3150 1100 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/ds90lv011a.pdf" H 3150 1650 50  0001 C CNN
	1    3150 1550
	1    0    0    -1  
$EndComp
NoConn ~ 2650 1550
NoConn ~ 3150 1950
NoConn ~ 3650 1650
NoConn ~ 8050 1600
NoConn ~ 8050 1800
NoConn ~ 7550 2100
NoConn ~ 7050 1700
NoConn ~ 6450 1700
NoConn ~ 5450 1800
NoConn ~ 5450 1600
NoConn ~ 5950 1300
NoConn ~ 4500 1200
NoConn ~ 4600 2200
NoConn ~ 4400 2200
NoConn ~ 4100 1700
$Comp
L Interface:DS90LV011A U4
U 1 1 5F5AD448
P 7550 1700
F 0 "U4" H 7550 2281 50  0000 C CNN
F 1 "DS90LV011A" H 7550 2190 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-23-5" H 7550 1250 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/ds90lv011a.pdf" H 7550 1800 50  0001 C CNN
	1    7550 1700
	1    0    0    -1  
$EndComp
$Comp
L Interface:DS90LV011A U3
U 1 1 5F5AD2A0
P 5950 1700
F 0 "U3" H 5406 1654 50  0000 R CNN
F 1 "DS90LV011A" H 5406 1745 50  0000 R CNN
F 2 "Package_TO_SOT_SMD:SOT-23-5" H 5950 1250 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/ds90lv011a.pdf" H 5950 1800 50  0001 C CNN
	1    5950 1700
	-1   0    0    1   
$EndComp
$Comp
L Interface:DS90LV011A U2
U 1 1 5F5AD077
P 4500 1700
F 0 "U2" V 4454 2144 50  0000 L CNN
F 1 "DS90LV011A" V 4545 2144 50  0000 L CNN
F 2 "Package_TO_SOT_SMD:SOT-23-5" H 4500 1250 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/ds90lv011a.pdf" H 4500 1800 50  0001 C CNN
	1    4500 1700
	0    1    1    0   
$EndComp
Text Notes 650  700  0    50   ~ 0
PinHeaders
Wire Notes Line
	550  1800 550  550 
Wire Notes Line
	2250 1800 550  1800
Wire Notes Line
	2250 550  2250 1800
Wire Notes Line
	550  550  2250 550 
NoConn ~ 1000 1250
NoConn ~ 750  1750
NoConn ~ 1800 1150
NoConn ~ 1350 800 
$Comp
L Connector_Generic:Conn_01x02 J2
U 1 1 5F5A56B8
P 650 1550
F 0 "J2" V 614 1362 50  0000 R CNN
F 1 "Conn_01x02" V 523 1362 50  0000 R CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x02_P2.54mm_Vertical" H 650 1550 50  0001 C CNN
F 3 "~" H 650 1550 50  0001 C CNN
	1    650  1550
	0    -1   -1   0   
$EndComp
$Comp
L Connector_Generic:Conn_01x02 J4
U 1 1 5F5A54A0
P 1600 1250
F 0 "J4" H 1518 925 50  0000 C CNN
F 1 "Conn_01x02" H 1518 1016 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x02_P2.54mm_Vertical" H 1600 1250 50  0001 C CNN
F 3 "~" H 1600 1250 50  0001 C CNN
	1    1600 1250
	-1   0    0    1   
$EndComp
$Comp
L Connector_Generic:Conn_01x02 J3
U 1 1 5F5A51C5
P 1450 1000
F 0 "J3" V 1322 1080 50  0000 L CNN
F 1 "Conn_01x02" V 1413 1080 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x02_P2.54mm_Vertical" H 1450 1000 50  0001 C CNN
F 3 "~" H 1450 1000 50  0001 C CNN
	1    1450 1000
	0    1    1    0   
$EndComp
$Comp
L Connector_Generic:Conn_01x02 J1
U 1 1 5F5A512E
P 1200 1150
F 0 "J1" H 1280 1142 50  0000 L CNN
F 1 "Conn_01x02" H 1280 1051 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x02_P2.54mm_Vertical" H 1200 1150 50  0001 C CNN
F 3 "~" H 1200 1150 50  0001 C CNN
	1    1200 1150
	1    0    0    -1  
$EndComp
NoConn ~ 3650 1450
$Comp
L MCU_Espressif:ESP8266EX U5
U 1 1 5F5B1D67
P 4000 4150
F 0 "U5" H 4000 2961 50  0000 C CNN
F 1 "ESP8266EX" H 4000 2870 50  0000 C CNN
F 2 "Package_DFN_QFN:QFN-32-1EP_5x5mm_P0.5mm_EP3.45x3.45mm" H 4000 2850 50  0001 C CNN
F 3 "http://espressif.com/sites/default/files/documentation/0a-esp8266ex_datasheet_en.pdf" H 4100 2850 50  0001 C CNN
	1    4000 4150
	1    0    0    -1  
$EndComp
NoConn ~ 3600 3150
NoConn ~ 3700 3150
NoConn ~ 3800 3150
NoConn ~ 3900 3150
NoConn ~ 4000 3150
NoConn ~ 4100 3150
NoConn ~ 4200 3150
NoConn ~ 4900 3450
NoConn ~ 4900 3550
NoConn ~ 4900 3650
NoConn ~ 4900 3750
NoConn ~ 4900 3850
NoConn ~ 4900 3950
NoConn ~ 4900 4050
NoConn ~ 4900 4150
NoConn ~ 4900 4250
NoConn ~ 4900 4350
NoConn ~ 4900 4450
NoConn ~ 4900 4550
NoConn ~ 4900 4650
NoConn ~ 4900 4750
NoConn ~ 4900 4850
NoConn ~ 4900 4950
NoConn ~ 4000 5250
NoConn ~ 3100 4950
NoConn ~ 3100 4450
NoConn ~ 3100 4150
NoConn ~ 3100 4050
NoConn ~ 3100 3950
NoConn ~ 3100 3850
NoConn ~ 3100 3750
NoConn ~ 3100 3650
$Comp
L MCU_Espressif:ESP8266EX U7
U 1 1 5F5B64F8
P 6250 4150
F 0 "U7" H 6250 2961 50  0000 C CNN
F 1 "ESP8266EX" H 6250 2870 50  0000 C CNN
F 2 "Package_DFN_QFN:QFN-32-1EP_5x5mm_P0.5mm_EP3.45x3.45mm" H 6250 2850 50  0001 C CNN
F 3 "http://espressif.com/sites/default/files/documentation/0a-esp8266ex_datasheet_en.pdf" H 6350 2850 50  0001 C CNN
	1    6250 4150
	0    -1   -1   0   
$EndComp
NoConn ~ 5250 4550
NoConn ~ 5250 4450
NoConn ~ 5250 4350
NoConn ~ 5250 4250
NoConn ~ 5250 4150
NoConn ~ 5250 4050
NoConn ~ 5250 3950
NoConn ~ 5550 3250
NoConn ~ 5650 3250
NoConn ~ 5750 3250
NoConn ~ 5850 3250
NoConn ~ 5950 3250
NoConn ~ 6050 3250
NoConn ~ 6150 3250
NoConn ~ 6250 3250
NoConn ~ 6350 3250
NoConn ~ 6450 3250
NoConn ~ 6550 3250
NoConn ~ 6650 3250
NoConn ~ 6750 3250
NoConn ~ 6850 3250
NoConn ~ 6950 3250
NoConn ~ 7050 3250
NoConn ~ 7350 4150
NoConn ~ 7050 5050
NoConn ~ 6550 5050
NoConn ~ 6250 5050
NoConn ~ 6150 5050
NoConn ~ 6050 5050
NoConn ~ 5950 5050
NoConn ~ 5850 5050
NoConn ~ 5750 5050
$Comp
L MCU_Espressif:ESP8266EX U8
U 1 1 5F5B8F40
P 8650 4250
F 0 "U8" H 8650 3061 50  0000 C CNN
F 1 "ESP8266EX" H 8650 2970 50  0000 C CNN
F 2 "Package_DFN_QFN:QFN-32-1EP_5x5mm_P0.5mm_EP3.45x3.45mm" H 8650 2950 50  0001 C CNN
F 3 "http://espressif.com/sites/default/files/documentation/0a-esp8266ex_datasheet_en.pdf" H 8750 2950 50  0001 C CNN
	1    8650 4250
	-1   0    0    1   
$EndComp
NoConn ~ 9050 5250
NoConn ~ 8950 5250
NoConn ~ 8850 5250
NoConn ~ 8750 5250
NoConn ~ 8650 5250
NoConn ~ 8550 5250
NoConn ~ 8450 5250
NoConn ~ 7750 4950
NoConn ~ 7750 4850
NoConn ~ 7750 4750
NoConn ~ 7750 4650
NoConn ~ 7750 4550
NoConn ~ 7750 4450
NoConn ~ 7750 4350
NoConn ~ 7750 4250
NoConn ~ 7750 4150
NoConn ~ 7750 4050
NoConn ~ 7750 3950
NoConn ~ 7750 3850
NoConn ~ 7750 3750
NoConn ~ 7750 3650
NoConn ~ 7750 3550
NoConn ~ 7750 3450
NoConn ~ 8650 3150
NoConn ~ 9550 3450
NoConn ~ 9550 3950
NoConn ~ 9550 4250
NoConn ~ 9550 4350
NoConn ~ 9550 4450
NoConn ~ 9550 4550
NoConn ~ 9550 4650
NoConn ~ 9550 4750
NoConn ~ 3000 3900
NoConn ~ 3000 4000
NoConn ~ 3000 4100
NoConn ~ 3000 4200
NoConn ~ 3000 4300
NoConn ~ 3000 4400
NoConn ~ 3000 4500
NoConn ~ 2700 5200
NoConn ~ 2600 5200
NoConn ~ 2500 5200
NoConn ~ 2400 5200
NoConn ~ 2300 5200
NoConn ~ 2200 5200
NoConn ~ 2100 5200
NoConn ~ 2000 5200
NoConn ~ 1900 5200
NoConn ~ 1800 5200
NoConn ~ 1700 5200
NoConn ~ 1600 5200
NoConn ~ 1500 5200
NoConn ~ 1400 5200
NoConn ~ 1300 5200
NoConn ~ 1200 5200
NoConn ~ 900  4300
NoConn ~ 1200 3400
NoConn ~ 1700 3400
NoConn ~ 2000 3400
NoConn ~ 2100 3400
NoConn ~ 2200 3400
NoConn ~ 2300 3400
NoConn ~ 2400 3400
NoConn ~ 2500 3400
$Comp
L MCU_Espressif:ESP8266EX U6
U 1 1 5F5BA7DE
P 2000 4300
F 0 "U6" H 2000 3111 50  0000 C CNN
F 1 "ESP8266EX" H 2000 3020 50  0000 C CNN
F 2 "Package_DFN_QFN:QFN-32-1EP_5x5mm_P0.5mm_EP3.45x3.45mm" H 2000 3000 50  0001 C CNN
F 3 "http://espressif.com/sites/default/files/documentation/0a-esp8266ex_datasheet_en.pdf" H 2100 3000 50  0001 C CNN
	1    2000 4300
	0    1    1    0   
$EndComp
$EndSCHEMATC
