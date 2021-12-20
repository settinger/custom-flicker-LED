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
Wire Notes Line
	1775 5975 1775 4475
Wire Notes Line
	1775 4475 2425 4475
Wire Notes Line
	2425 4475 2525 4225
Wire Notes Line
	2525 4225 2725 4725
Wire Notes Line
	2725 4725 2925 4225
Wire Notes Line
	2925 4225 3125 4725
Wire Notes Line
	3125 4725 3325 4225
Wire Notes Line
	3325 4225 3525 4725
Wire Notes Line
	3525 4725 3625 4475
Wire Notes Line
	6950 4225 7450 4475
Wire Notes Line
	7450 4475 6950 4725
Wire Notes Line
	6950 4225 6950 4725
Wire Notes Line
	7450 4725 7450 4225
Wire Notes Line
	7450 4225 7475 4225
Wire Notes Line
	7475 4225 7475 4725
Wire Notes Line
	7475 4725 7450 4725
Wire Notes Line
	7250 4175 7250 4225
Wire Notes Line
	7250 4175 7200 4175
Wire Notes Line
	7250 4175 7175 4250
Wire Notes Line
	7275 4300 7350 4225
Wire Notes Line
	7350 4225 7350 4275
Wire Notes Line
	7350 4225 7300 4225
Wire Notes Line
	6075 5775 6075 6175
Wire Notes Line
	6075 6175 5975 6175
Wire Notes Line
	5975 6175 5975 5775
Wire Notes Line
	5975 5775 6075 5775
Wire Notes Line
	5725 5775 5725 6175
Wire Notes Line
	5725 6175 5625 6175
Wire Notes Line
	5625 6175 5625 5775
Wire Notes Line
	5725 5775 5625 5775
$Comp
L Connector:TestPoint_Small J2
U 1 1 622FC221
P 9125 4475
F 0 "J2" V 9075 4500 50  0000 L CNN
F 1 "Conn_01x01" V 9088 4555 50  0001 L CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x01_P2.54mm_Vertical" H 9125 4475 50  0001 C CNN
F 3 "~" H 9125 4475 50  0001 C CNN
	1    9125 4475
	0    1    1    0   
$EndComp
$Comp
L Device:C C1
U 1 1 62315630
P 6775 2125
F 0 "C1" H 6600 2075 50  0000 C CNN
F 1 "1μF" H 6575 2175 50  0000 C CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 6813 1975 50  0001 C CNN
F 3 "~" H 6775 2125 50  0001 C CNN
F 4 "0402" H 6550 2275 50  0000 C CNN "Field4"
	1    6775 2125
	-1   0    0    1   
$EndComp
Wire Wire Line
	9125 1925 9075 1925
Text Label 9125 3525 0    50   ~ 0
LED-
Text Notes 925  2225 0    50   ~ 0
Falstad simulation: https://tinyurl.com/yxa3gy2q
$Comp
L Device:R R2
U 1 1 6230567C
P 8575 2950
F 0 "R2" H 8450 2900 50  0000 C CNN
F 1 "1kΩ" H 8425 2975 50  0000 C CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 8505 2950 50  0001 C CNN
F 3 "~" H 8575 2950 50  0001 C CNN
F 4 "0402" H 8400 3050 50  0000 C CNN "Field4"
	1    8575 2950
	1    0    0    1   
$EndComp
$Comp
L MCU_Microchip_ATtiny:ATtiny20-UU U1
U 1 1 623067A3
P 8175 1925
F 0 "U1" V 7425 1925 50  0000 C CNN
F 1 "ATtiny20-UU" V 7525 1925 50  0000 C CNN
F 2 "Package_CSP:WLCSP-12_1.403x1.555mm_P0.4mm_Stagger" H 8175 1925 50  0001 C CIN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/atmel-8235-8-bit-avr-microcontroller-attiny20_datasheet.pdf" H 8175 1925 50  0001 C CNN
F 4 "WLCSP-12 Package" V 7625 1925 50  0000 C CNN "Field4"
	1    8175 1925
	0    -1   1    0   
$EndComp
$Comp
L custom-flicker-LED:TCR3UG U2
U 1 1 62353CF2
P 6350 1925
F 0 "U2" H 6350 2349 50  0000 C CNN
F 1 "TCR3UG18A" H 6350 2258 50  0000 C CNN
F 2 "custom-flicker-LED:WCSP-4F_0.65x0.65mm_P0.35mm" H 6350 2150 50  0001 C CIN
F 3 "https://toshiba.semicon-storage.com/info/docget.jsp?did=59176&prodName=TCR3UG12A" H 6350 1875 50  0001 C CNN
F 4 "1.8V LDO" H 6350 2167 50  0000 C CNN "Field4"
F 5 "WCSP-4F Package" H 6350 2076 50  0000 C CNN "Field5"
	1    6350 1925
	1    0    0    -1  
$EndComp
Wire Wire Line
	5975 1925 5975 2025
Wire Wire Line
	5975 2025 6050 2025
Connection ~ 5975 1925
Wire Wire Line
	5975 1925 6050 1925
Wire Wire Line
	6450 2450 6450 2300
Wire Wire Line
	6450 2300 6450 2225
Wire Wire Line
	6650 1925 6775 1925
Text Label 6900 1925 0    50   ~ 0
1.8V
$Comp
L Device:C C2
U 1 1 62359212
P 5875 2125
F 0 "C2" H 5700 2075 50  0000 C CNN
F 1 "1μF" H 5675 2175 50  0000 C CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 5913 1975 50  0001 C CNN
F 3 "~" H 5875 2125 50  0001 C CNN
F 4 "0402" H 5650 2275 50  0000 C CNN "Field4"
	1    5875 2125
	1    0    0    1   
$EndComp
Wire Wire Line
	5875 1925 5875 1975
Wire Wire Line
	5875 2275 5875 2300
Connection ~ 5875 1925
Wire Wire Line
	5875 1925 5975 1925
Wire Wire Line
	5875 2300 6450 2300
Wire Wire Line
	6775 1925 6775 1975
Wire Wire Line
	6775 2300 6450 2300
Wire Wire Line
	6775 2275 6775 2300
Connection ~ 6775 1925
Connection ~ 6450 2300
Text Label 8775 2600 3    50   ~ 0
~rst
Text Label 8475 2600 3    50   ~ 0
clk
Text Label 8275 2750 2    50   ~ 0
mosi
Wire Wire Line
	8475 2600 8475 2525
Wire Wire Line
	8775 2600 8775 2525
$Comp
L Connector_Generic:Conn_01x05 J3
U 1 1 623622D1
P 9750 2625
F 0 "J3" H 9830 2667 50  0000 L CNN
F 1 "TPI interface" H 9830 2576 50  0000 L CNN
F 2 "custom-flicker-LED:padz" H 9750 2625 50  0001 C CNN
F 3 "~" H 9750 2625 50  0001 C CNN
	1    9750 2625
	1    0    0    -1  
$EndComp
Text Label 9550 2825 2    50   ~ 0
1.8V
Text Label 9550 2625 2    50   ~ 0
clk
Text Label 9550 2725 2    50   ~ 0
~rst
Text Label 9550 2425 2    50   ~ 0
mosi
Text Label 9550 2525 2    50   ~ 0
LED-
Wire Wire Line
	6775 1925 7275 1925
Wire Wire Line
	5400 1925 5875 1925
$Comp
L Connector:TestPoint_Small J1
U 1 1 622FB3C2
P 5400 4475
F 0 "J1" V 5325 4500 50  0000 L CNN
F 1 "Conn_01x01" V 5363 4555 50  0001 L CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x01_P2.54mm_Vertical" H 5400 4475 50  0001 C CNN
F 3 "~" H 5400 4475 50  0001 C CNN
	1    5400 4475
	0    1    1    0   
$EndComp
Text Label 5400 3525 2    50   ~ 0
LED+
Wire Wire Line
	5400 3525 7075 3525
Wire Wire Line
	8575 3100 8575 3225
Wire Notes Line
	3625 4475 6950 4475
Wire Notes Line
	7475 4475 9725 4475
Wire Notes Line
	9725 4475 9725 5975
Wire Notes Line
	1775 5975 5450 5975
Wire Notes Line
	5900 5600 5800 5600
Wire Notes Line
	5800 5600 5800 6350
Wire Notes Line
	5800 6350 5900 6350
Wire Notes Line
	5900 5600 5900 6350
Wire Notes Line
	5550 6350 5550 5600
Wire Notes Line
	5550 5600 5450 5600
Wire Notes Line
	5450 5600 5450 6350
Wire Notes Line
	5450 6350 5550 6350
Wire Wire Line
	7775 2525 7775 2675
Text Notes 925  2025 0    50   ~ 0
PA2 and GND are tied together for easier routing.\nUse PB1, PB2, or PA7 for fast PWM output.
$Comp
L power:GNDREF #PWR0101
U 1 1 623B2AAF
P 9125 4650
F 0 "#PWR0101" H 9125 4400 50  0001 C CNN
F 1 "GNDREF" H 9130 4477 50  0001 C CNN
F 2 "" H 9125 4650 50  0001 C CNN
F 3 "" H 9125 4650 50  0001 C CNN
	1    9125 4650
	1    0    0    -1  
$EndComp
Wire Wire Line
	9125 4475 9125 4650
$Comp
L power:GNDREF #PWR0102
U 1 1 623B7631
P 6450 2450
F 0 "#PWR0102" H 6450 2200 50  0001 C CNN
F 1 "GNDREF" H 6455 2277 50  0001 C CNN
F 2 "" H 6450 2450 50  0001 C CNN
F 3 "" H 6450 2450 50  0001 C CNN
	1    6450 2450
	1    0    0    -1  
$EndComp
Wire Notes Line
	6075 5975 9725 5975
$Comp
L Device:D_Zener D2
U 1 1 622FCF2E
P 7225 3525
F 0 "D2" H 7225 3742 50  0000 C CNN
F 1 "CZRQR52C2-HF" H 7225 3651 50  0000 C CNN
F 2 "Diode_SMD:D_0402_1005Metric" H 7225 3525 50  0001 C CNN
F 3 "https://www.comchiptech.com/admin/files/product/CZRQR52C2-HF%20THRU%20CZRQR52C39-HF-RevB.pdf" H 7225 3525 50  0001 C CNN
F 4 "2.0V Zener" H 7225 3400 50  0000 C CNN "Field4"
F 5 "0402 Package" H 7225 3300 50  0000 C CNN "Field5"
	1    7225 3525
	1    0    0    -1  
$EndComp
$Comp
L power:GNDREF #PWR0103
U 1 1 61B7DD8C
P 7775 2675
F 0 "#PWR0103" H 7775 2425 50  0001 C CNN
F 1 "GNDREF" H 7780 2502 50  0001 C CNN
F 2 "" H 7775 2675 50  0001 C CNN
F 3 "" H 7775 2675 50  0001 C CNN
	1    7775 2675
	1    0    0    -1  
$EndComp
Wire Wire Line
	8575 2525 8575 2750
Connection ~ 8575 2750
Wire Wire Line
	8575 2750 8575 2800
Wire Wire Line
	8275 2750 8575 2750
$Comp
L Device:Q_NPN_BEC Q1
U 1 1 622FE3FA
P 8575 3425
F 0 "Q1" V 8810 3425 50  0000 C CNN
F 1 "MMBT3904M" V 8901 3425 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-723" H 8775 3525 50  0001 C CNN
F 3 "https://www.onsemi.com/pdf/datasheet/ns2029m3-d.pdf" H 8575 3425 50  0001 C CNN
F 4 "SOT-723" V 8975 3425 50  0000 C CNN "Field4"
	1    8575 3425
	0    -1   1    0   
$EndComp
Text Notes 925  1675 0    100  ~ 0
Premise: Assume a standard battery - resistor - LED configuration.\nPut this circuit in parallel with the LED to mess with its brightness\nby selectively shunting at intervals.\n\nExact Zener diode and LDO values TBD.
Wire Wire Line
	9125 1925 9125 3525
Connection ~ 9125 3525
Wire Wire Line
	5400 1925 5400 3525
Connection ~ 5400 3525
Wire Wire Line
	7375 3525 8375 3525
Wire Wire Line
	8775 3525 9125 3525
Wire Wire Line
	9125 3525 9125 4475
Connection ~ 9125 4475
Wire Wire Line
	5400 3525 5400 4475
$EndSCHEMATC
