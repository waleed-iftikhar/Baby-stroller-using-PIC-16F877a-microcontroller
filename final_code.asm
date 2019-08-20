
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;final_code.c,40 :: 		void interrupt(void)  // Interrupt function
;final_code.c,42 :: 		if(INTCON.RBIF==1) // To verify that what type of interrupt is being generated
	BTFSS      INTCON+0, 0
	GOTO       L_interrupt0
;final_code.c,44 :: 		PORTB_INT_ISR();   // Go to the Service Routine of PORTB change Interrupt
	CALL       _PORTB_INT_ISR+0
;final_code.c,45 :: 		INTCON.RBIF=0;     // Clear the Interrupt flag to indicate that appropriate
	BCF        INTCON+0, 0
;final_code.c,46 :: 		}                 // action has been taken against the generated Interrupt
L_interrupt0:
;final_code.c,47 :: 		if(PIR1.RCIF==1)
	BTFSS      PIR1+0, 5
	GOTO       L_interrupt1
;final_code.c,49 :: 		Rc=RCREG;
	MOVF       RCREG+0, 0
	MOVWF      _Rc+0
;final_code.c,50 :: 		}
L_interrupt1:
;final_code.c,51 :: 		}
L__interrupt190:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;final_code.c,53 :: 		void main()
;final_code.c,55 :: 		char i=0;
	CLRF       main_i_L0+0
;final_code.c,56 :: 		double V0=0,V1=0,V2=0; // To store the calculated decimal results of sensors
	CLRF       main_V0_L0+0
	CLRF       main_V0_L0+1
	CLRF       main_V0_L0+2
	CLRF       main_V0_L0+3
	CLRF       main_V1_L0+0
	CLRF       main_V1_L0+1
	CLRF       main_V1_L0+2
	CLRF       main_V1_L0+3
	CLRF       main_V2_L0+0
	CLRF       main_V2_L0+1
	CLRF       main_V2_L0+2
	CLRF       main_V2_L0+3
;final_code.c,58 :: 		TRISB.RB0=0;      // Configure the Output Pin
	BCF        TRISB+0, 0
;final_code.c,59 :: 		TRISB.RB1=0;      // Configure the Output Pin
	BCF        TRISB+0, 1
;final_code.c,60 :: 		TRISB.RB2=0;      // Configure the Output Pin
	BCF        TRISB+0, 2
;final_code.c,61 :: 		TRISB.RB3=0;      // Configure the Output Pin
	BCF        TRISB+0, 3
;final_code.c,62 :: 		TRISB.RB4=1;      // Configure the Input Pin
	BSF        TRISB+0, 4
;final_code.c,63 :: 		TRISB.RB5=1;      // Configure the Input Pin
	BSF        TRISB+0, 5
;final_code.c,64 :: 		TRISB.RB6=1;      // Configure the Input Pin
	BSF        TRISB+0, 6
;final_code.c,65 :: 		TRISB.RB7=1;      // Configure the Input Pin
	BSF        TRISB+0, 7
;final_code.c,67 :: 		TRISC.RA0=1;          // Configure the PIN RA0 as Input for Sensor 1
	BSF        TRISC+0, 0
;final_code.c,68 :: 		TRISC.RA1=1;          // Configure the PIN RA1 as Input for Sensor 2
	BSF        TRISC+0, 1
;final_code.c,69 :: 		TRISC.RA2=1;          // Configure the PIN RA2 as Input for Sensor 3
	BSF        TRISC+0, 2
;final_code.c,71 :: 		TRISC.RC0=1;      // Configure the Input Pin
	BSF        TRISC+0, 0
;final_code.c,72 :: 		TRISC.RC1=1;      // Configure the Input Pin
	BSF        TRISC+0, 1
;final_code.c,73 :: 		TRISC.RC2=0;      // Configure the Output Pin
	BCF        TRISC+0, 2
;final_code.c,74 :: 		TRISC.RC3=0;      // Configure the Output Pin
	BCF        TRISC+0, 3
;final_code.c,75 :: 		TRISC.RC4=0;      // Configure the Output Pin
	BCF        TRISC+0, 4
;final_code.c,76 :: 		TRISC.RC6=0;          // Configure the Output Tx pin of Serial PORT
	BCF        TRISC+0, 6
;final_code.c,77 :: 		TRISC.RC7=1;          // Configure the Input Rx pin of Serial PORT
	BSF        TRISC+0, 7
;final_code.c,79 :: 		TRISD.RD0=0;      // Configure the Output Pin
	BCF        TRISD+0, 0
;final_code.c,80 :: 		TRISD.RD1=0;      // Configure the Output Pin
	BCF        TRISD+0, 1
;final_code.c,81 :: 		TRISD.RD2=0;      // Configure the Output Pin
	BCF        TRISD+0, 2
;final_code.c,82 :: 		TRISD.RD3=0;      // Configure the Output Pin
	BCF        TRISD+0, 3
;final_code.c,83 :: 		TRISD.RD4=1;      // Configure the Input Pin
	BSF        TRISD+0, 4
;final_code.c,84 :: 		TRISD.RD5=1;      // Configure the Input Pin
	BSF        TRISD+0, 5
;final_code.c,86 :: 		ADCON1=0xC0;          //Configure the ADC Module Register
	MOVLW      192
	MOVWF      ADCON1+0
;final_code.c,87 :: 		ADCON0=0x81;          //Configure the ADC Module Register
	MOVLW      129
	MOVWF      ADCON0+0
;final_code.c,90 :: 		TXSTA=0x24;           //Configure the Tx Register Serial PORT(USART)
	MOVLW      36
	MOVWF      TXSTA+0
;final_code.c,91 :: 		RCSTA=0x90;           //Configure the Rx Register Serial PORT(USART)
	MOVLW      144
	MOVWF      RCSTA+0
;final_code.c,92 :: 		SPBRG=5;              //Set the Baud Rate
	MOVLW      5
	MOVWF      SPBRG+0
;final_code.c,93 :: 		TXSTA.TXEN=1;
	BSF        TXSTA+0, 5
;final_code.c,94 :: 		RCSTA.SPEN=1;
	BSF        RCSTA+0, 7
;final_code.c,98 :: 		INTCON.RBIF=0;
	BCF        INTCON+0, 0
;final_code.c,99 :: 		INTCON.RBIE=1;
	BSF        INTCON+0, 3
;final_code.c,100 :: 		PIE1.RCIE=1;
	BSF        PIE1+0, 5
;final_code.c,101 :: 		INTCON.PEIE=1;
	BSF        INTCON+0, 6
;final_code.c,102 :: 		INTCON.GIE=1;
	BSF        INTCON+0, 7
;final_code.c,104 :: 		LED=0;
	BCF        PORTC+0, 2
;final_code.c,105 :: 		RED_LED1=0;
	BCF        PORTB+0, 0
;final_code.c,106 :: 		GREEN_LED1=0;
	BCF        PORTB+0, 1
;final_code.c,107 :: 		RED_LED2=0;
	BCF        PORTB+0, 2
;final_code.c,108 :: 		GREEN_LED2=0;
	BCF        PORTB+0, 3
;final_code.c,109 :: 		Driver=PORTB.RB4 | PORTB.RB5; // Check the Initial Status of Driver
	MOVLW      0
	BTFSC      PORTB+0, 4
	MOVLW      1
	MOVWF      _Driver+0
	CLRF       R0+0
	BTFSC      PORTB+0, 5
	INCF       R0+0, 1
	MOVF       R0+0, 0
	IORWF      _Driver+0, 1
;final_code.c,110 :: 		Belt=PORTB.RB6;
	MOVLW      0
	BTFSC      PORTB+0, 6
	MOVLW      1
	MOVWF      _Belt+0
;final_code.c,111 :: 		Delay_ms(10);
	MOVLW      36
	MOVWF      R12+0
	MOVLW      231
	MOVWF      R13+0
L_main2:
	DECFSZ     R13+0, 1
	GOTO       L_main2
	DECFSZ     R12+0, 1
	GOTO       L_main2
;final_code.c,112 :: 		ADCON0.GO=1;          // Start Analoge to Digital Conversion
	BSF        ADCON0+0, 2
;final_code.c,113 :: 		Delay_ms(1000);
	MOVLW      15
	MOVWF      R11+0
	MOVLW      7
	MOVWF      R12+0
	MOVLW      154
	MOVWF      R13+0
L_main3:
	DECFSZ     R13+0, 1
	GOTO       L_main3
	DECFSZ     R12+0, 1
	GOTO       L_main3
	DECFSZ     R11+0, 1
	GOTO       L_main3
	NOP
;final_code.c,115 :: 		while(1)
L_main4:
;final_code.c,117 :: 		LED=~LED;
	MOVLW      4
	XORWF      PORTC+0, 1
;final_code.c,118 :: 		V0=ADC(0);            // Read Data of First Sensor
	CLRF       FARG_ADC+0
	CALL       _ADC+0
	MOVF       R0+0, 0
	MOVWF      main_V0_L0+0
	MOVF       R0+1, 0
	MOVWF      main_V0_L0+1
	MOVF       R0+2, 0
	MOVWF      main_V0_L0+2
	MOVF       R0+3, 0
	MOVWF      main_V0_L0+3
;final_code.c,119 :: 		Delay_ms(20);
	MOVLW      72
	MOVWF      R12+0
	MOVLW      207
	MOVWF      R13+0
L_main6:
	DECFSZ     R13+0, 1
	GOTO       L_main6
	DECFSZ     R12+0, 1
	GOTO       L_main6
;final_code.c,120 :: 		V1=ADC(1);            // Read Data of Second Sensor
	MOVLW      1
	MOVWF      FARG_ADC+0
	CALL       _ADC+0
	MOVF       R0+0, 0
	MOVWF      main_V1_L0+0
	MOVF       R0+1, 0
	MOVWF      main_V1_L0+1
	MOVF       R0+2, 0
	MOVWF      main_V1_L0+2
	MOVF       R0+3, 0
	MOVWF      main_V1_L0+3
;final_code.c,121 :: 		Delay_ms(20);
	MOVLW      72
	MOVWF      R12+0
	MOVLW      207
	MOVWF      R13+0
L_main7:
	DECFSZ     R13+0, 1
	GOTO       L_main7
	DECFSZ     R12+0, 1
	GOTO       L_main7
;final_code.c,122 :: 		V2=ADC(2);            // Read Data of Third Sensor
	MOVLW      2
	MOVWF      FARG_ADC+0
	CALL       _ADC+0
	MOVF       R0+0, 0
	MOVWF      main_V2_L0+0
	MOVF       R0+1, 0
	MOVWF      main_V2_L0+1
	MOVF       R0+2, 0
	MOVWF      main_V2_L0+2
	MOVF       R0+3, 0
	MOVWF      main_V2_L0+3
;final_code.c,123 :: 		Delay_ms(20);
	MOVLW      72
	MOVWF      R12+0
	MOVLW      207
	MOVWF      R13+0
L_main8:
	DECFSZ     R13+0, 1
	GOTO       L_main8
	DECFSZ     R12+0, 1
	GOTO       L_main8
;final_code.c,125 :: 		if(V0>3.5 || V1>3.5 || V2>3.5)
	MOVF       main_V0_L0+0, 0
	MOVWF      R4+0
	MOVF       main_V0_L0+1, 0
	MOVWF      R4+1
	MOVF       main_V0_L0+2, 0
	MOVWF      R4+2
	MOVF       main_V0_L0+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVLW      96
	MOVWF      R0+2
	MOVLW      128
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main176
	MOVF       main_V1_L0+0, 0
	MOVWF      R4+0
	MOVF       main_V1_L0+1, 0
	MOVWF      R4+1
	MOVF       main_V1_L0+2, 0
	MOVWF      R4+2
	MOVF       main_V1_L0+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVLW      96
	MOVWF      R0+2
	MOVLW      128
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main176
	MOVF       main_V2_L0+0, 0
	MOVWF      R4+0
	MOVF       main_V2_L0+1, 0
	MOVWF      R4+1
	MOVF       main_V2_L0+2, 0
	MOVWF      R4+2
	MOVF       main_V2_L0+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVLW      96
	MOVWF      R0+2
	MOVLW      128
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main176
	GOTO       L_main11
L__main176:
;final_code.c,126 :: 		{Baby=1;}
	MOVLW      1
	MOVWF      _Baby+0
	GOTO       L_main12
L_main11:
;final_code.c,128 :: 		{Baby=0;}
	CLRF       _Baby+0
L_main12:
;final_code.c,130 :: 		if(Driver==0 && B==1)
	MOVF       _Driver+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main15
	MOVF       _B+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main15
L__main175:
;final_code.c,132 :: 		Delay_ms(10);
	MOVLW      36
	MOVWF      R12+0
	MOVLW      231
	MOVWF      R13+0
L_main16:
	DECFSZ     R13+0, 1
	GOTO       L_main16
	DECFSZ     R12+0, 1
	GOTO       L_main16
;final_code.c,133 :: 		Apply_Brakes();
	CALL       _Apply_Brakes+0
;final_code.c,134 :: 		}
L_main15:
;final_code.c,135 :: 		if(Driver==1 && B==1)
	MOVF       _Driver+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main19
	MOVF       _B+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main19
L__main174:
;final_code.c,137 :: 		Delay_ms(10);
	MOVLW      36
	MOVWF      R12+0
	MOVLW      231
	MOVWF      R13+0
L_main20:
	DECFSZ     R13+0, 1
	GOTO       L_main20
	DECFSZ     R12+0, 1
	GOTO       L_main20
;final_code.c,138 :: 		Lift_Brakes();
	CALL       _Lift_Brakes+0
;final_code.c,139 :: 		}
L_main19:
;final_code.c,141 :: 		if(Driver==0 && Baby==0 && Belt==0 && Brake==0)
	MOVF       _Driver+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main23
	MOVF       _Baby+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main23
	MOVF       _Belt+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main23
	MOVF       _Brake+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main23
L__main173:
;final_code.c,142 :: 		i=0;
	CLRF       main_i_L0+0
	GOTO       L_main24
L_main23:
;final_code.c,143 :: 		else if(Driver==1 && Baby==0 && Belt==0 && Brake==0)
	MOVF       _Driver+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main27
	MOVF       _Baby+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main27
	MOVF       _Belt+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main27
	MOVF       _Brake+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main27
L__main172:
;final_code.c,144 :: 		i=1;
	MOVLW      1
	MOVWF      main_i_L0+0
	GOTO       L_main28
L_main27:
;final_code.c,145 :: 		else if(Driver==0 && Baby==1 && Belt==0 && Brake==0)
	MOVF       _Driver+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main31
	MOVF       _Baby+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main31
	MOVF       _Belt+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main31
	MOVF       _Brake+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main31
L__main171:
;final_code.c,146 :: 		i=2;
	MOVLW      2
	MOVWF      main_i_L0+0
	GOTO       L_main32
L_main31:
;final_code.c,147 :: 		else if(Driver==1 && Baby==1 && Belt==0 && Brake==0)
	MOVF       _Driver+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main35
	MOVF       _Baby+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main35
	MOVF       _Belt+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main35
	MOVF       _Brake+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main35
L__main170:
;final_code.c,148 :: 		i=3;
	MOVLW      3
	MOVWF      main_i_L0+0
	GOTO       L_main36
L_main35:
;final_code.c,149 :: 		else if(Driver==0 && Baby==0 && Belt==1 && Brake==0)
	MOVF       _Driver+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main39
	MOVF       _Baby+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main39
	MOVF       _Belt+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main39
	MOVF       _Brake+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main39
L__main169:
;final_code.c,150 :: 		i=4;
	MOVLW      4
	MOVWF      main_i_L0+0
	GOTO       L_main40
L_main39:
;final_code.c,151 :: 		else if(Driver==1 && Baby==0 && Belt==1 && Brake==0)
	MOVF       _Driver+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main43
	MOVF       _Baby+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main43
	MOVF       _Belt+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main43
	MOVF       _Brake+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main43
L__main168:
;final_code.c,152 :: 		i=5;
	MOVLW      5
	MOVWF      main_i_L0+0
	GOTO       L_main44
L_main43:
;final_code.c,153 :: 		else if(Driver==0 && Baby==1 && Belt==1 && Brake==0)
	MOVF       _Driver+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main47
	MOVF       _Baby+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main47
	MOVF       _Belt+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main47
	MOVF       _Brake+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main47
L__main167:
;final_code.c,154 :: 		i=6;
	MOVLW      6
	MOVWF      main_i_L0+0
	GOTO       L_main48
L_main47:
;final_code.c,155 :: 		else if(Driver==1 && Baby==1 && Belt==1 && Brake==0)
	MOVF       _Driver+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main51
	MOVF       _Baby+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main51
	MOVF       _Belt+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main51
	MOVF       _Brake+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main51
L__main166:
;final_code.c,156 :: 		i=7;
	MOVLW      7
	MOVWF      main_i_L0+0
	GOTO       L_main52
L_main51:
;final_code.c,157 :: 		else if(Driver==0 && Baby==0 && Belt==0 && Brake==1)
	MOVF       _Driver+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main55
	MOVF       _Baby+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main55
	MOVF       _Belt+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main55
	MOVF       _Brake+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main55
L__main165:
;final_code.c,158 :: 		i=8;
	MOVLW      8
	MOVWF      main_i_L0+0
	GOTO       L_main56
L_main55:
;final_code.c,159 :: 		else if(Driver==1 && Baby==0 && Belt==0 && Brake==1)
	MOVF       _Driver+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main59
	MOVF       _Baby+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main59
	MOVF       _Belt+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main59
	MOVF       _Brake+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main59
L__main164:
;final_code.c,160 :: 		i=9;
	MOVLW      9
	MOVWF      main_i_L0+0
	GOTO       L_main60
L_main59:
;final_code.c,161 :: 		else if(Driver==0 && Baby==1 && Belt==0 && Brake==1)
	MOVF       _Driver+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main63
	MOVF       _Baby+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main63
	MOVF       _Belt+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main63
	MOVF       _Brake+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main63
L__main163:
;final_code.c,162 :: 		i=10;
	MOVLW      10
	MOVWF      main_i_L0+0
	GOTO       L_main64
L_main63:
;final_code.c,163 :: 		else if(Driver==1 && Baby==1 && Belt==0 && Brake==1)
	MOVF       _Driver+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main67
	MOVF       _Baby+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main67
	MOVF       _Belt+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main67
	MOVF       _Brake+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main67
L__main162:
;final_code.c,164 :: 		i=11;
	MOVLW      11
	MOVWF      main_i_L0+0
	GOTO       L_main68
L_main67:
;final_code.c,165 :: 		else if(Driver==0 && Baby==0 && Belt==1 && Brake==1)
	MOVF       _Driver+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main71
	MOVF       _Baby+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main71
	MOVF       _Belt+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main71
	MOVF       _Brake+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main71
L__main161:
;final_code.c,166 :: 		i=12;
	MOVLW      12
	MOVWF      main_i_L0+0
	GOTO       L_main72
L_main71:
;final_code.c,167 :: 		else if(Driver==1 && Baby==0 && Belt==1 && Brake==1)
	MOVF       _Driver+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main75
	MOVF       _Baby+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main75
	MOVF       _Belt+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main75
	MOVF       _Brake+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main75
L__main160:
;final_code.c,168 :: 		i=13;
	MOVLW      13
	MOVWF      main_i_L0+0
	GOTO       L_main76
L_main75:
;final_code.c,169 :: 		else if(Driver==0 && Baby==1 && Belt==1 && Brake==1)
	MOVF       _Driver+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main79
	MOVF       _Baby+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main79
	MOVF       _Belt+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main79
	MOVF       _Brake+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main79
L__main159:
;final_code.c,170 :: 		i=14;
	MOVLW      14
	MOVWF      main_i_L0+0
	GOTO       L_main80
L_main79:
;final_code.c,171 :: 		else if(Driver==1 && Baby==1 && Belt==1 && Brake==1)
	MOVF       _Driver+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main83
	MOVF       _Baby+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main83
	MOVF       _Belt+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main83
	MOVF       _Brake+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main83
L__main158:
;final_code.c,172 :: 		i=15;
	MOVLW      15
	MOVWF      main_i_L0+0
L_main83:
L_main80:
L_main76:
L_main72:
L_main68:
L_main64:
L_main60:
L_main56:
L_main52:
L_main48:
L_main44:
L_main40:
L_main36:
L_main32:
L_main28:
L_main24:
;final_code.c,174 :: 		Delay_ms(200);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      207
	MOVWF      R12+0
	MOVLW      29
	MOVWF      R13+0
L_main84:
	DECFSZ     R13+0, 1
	GOTO       L_main84
	DECFSZ     R12+0, 1
	GOTO       L_main84
	DECFSZ     R11+0, 1
	GOTO       L_main84
;final_code.c,175 :: 		TXREG=Tx[i];       // Transmit the Coded Data
	MOVF       main_i_L0+0, 0
	ADDLW      _Tx+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      TXREG+0
;final_code.c,176 :: 		while(PIR1.TXIF==0);
L_main85:
	BTFSC      PIR1+0, 4
	GOTO       L_main86
	GOTO       L_main85
L_main86:
;final_code.c,177 :: 		Delay_ms(200);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      207
	MOVWF      R12+0
	MOVLW      29
	MOVWF      R13+0
L_main87:
	DECFSZ     R13+0, 1
	GOTO       L_main87
	DECFSZ     R12+0, 1
	GOTO       L_main87
	DECFSZ     R11+0, 1
	GOTO       L_main87
;final_code.c,178 :: 		}
	GOTO       L_main4
;final_code.c,179 :: 		}
	GOTO       $+0
; end of _main

_PORTB_INT_ISR:

;final_code.c,182 :: 		void PORTB_INT_ISR()
;final_code.c,184 :: 		if(PORTB.RB6==0 )
	BTFSC      PORTB+0, 6
	GOTO       L_PORTB_INT_ISR88
;final_code.c,187 :: 		Belt=0;
	CLRF       _Belt+0
;final_code.c,188 :: 		}
	GOTO       L_PORTB_INT_ISR89
L_PORTB_INT_ISR88:
;final_code.c,192 :: 		Belt=1;
	MOVLW      1
	MOVWF      _Belt+0
;final_code.c,193 :: 		}
L_PORTB_INT_ISR89:
;final_code.c,195 :: 		if(PORTB.RB4==0 && PORTB.RB5==0 )
	BTFSC      PORTB+0, 4
	GOTO       L_PORTB_INT_ISR92
	BTFSC      PORTB+0, 5
	GOTO       L_PORTB_INT_ISR92
L__PORTB_INT_ISR177:
;final_code.c,198 :: 		Driver=0;
	CLRF       _Driver+0
;final_code.c,199 :: 		B=1;
	MOVLW      1
	MOVWF      _B+0
;final_code.c,200 :: 		}
	GOTO       L_PORTB_INT_ISR93
L_PORTB_INT_ISR92:
;final_code.c,204 :: 		Driver=1;
	MOVLW      1
	MOVWF      _Driver+0
;final_code.c,205 :: 		B=1;
	MOVLW      1
	MOVWF      _B+0
;final_code.c,206 :: 		}
L_PORTB_INT_ISR93:
;final_code.c,207 :: 		}
	RETURN
; end of _PORTB_INT_ISR

_ADC:

;final_code.c,210 :: 		double ADC(unsigned char N)
;final_code.c,214 :: 		if(N==0)
	MOVF       FARG_ADC_N+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_ADC94
;final_code.c,216 :: 		ADCON0=0x81;  // Adjust the value of ADC register to read
	MOVLW      129
	MOVWF      ADCON0+0
;final_code.c,218 :: 		}
	GOTO       L_ADC95
L_ADC94:
;final_code.c,219 :: 		else if(N==1)
	MOVF       FARG_ADC_N+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_ADC96
;final_code.c,221 :: 		ADCON0=0x89;  // Adjust the value of ADC register to read
	MOVLW      137
	MOVWF      ADCON0+0
;final_code.c,223 :: 		}
	GOTO       L_ADC97
L_ADC96:
;final_code.c,224 :: 		else if(N==2)
	MOVF       FARG_ADC_N+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_ADC98
;final_code.c,226 :: 		ADCON0=0x91; // Adjust the value of ADC register to read
	MOVLW      145
	MOVWF      ADCON0+0
;final_code.c,228 :: 		}
L_ADC98:
L_ADC97:
L_ADC95:
;final_code.c,230 :: 		Delay_ms(25);
	MOVLW      90
	MOVWF      R12+0
	MOVLW      195
	MOVWF      R13+0
L_ADC99:
	DECFSZ     R13+0, 1
	GOTO       L_ADC99
	DECFSZ     R12+0, 1
	GOTO       L_ADC99
;final_code.c,231 :: 		ADCON0.GO=1;         // Start Conversion
	BSF        ADCON0+0, 2
;final_code.c,232 :: 		while(ADCON0.GO==1); // Wait till conversion Completes
L_ADC100:
	BTFSS      ADCON0+0, 2
	GOTO       L_ADC101
	GOTO       L_ADC100
L_ADC101:
;final_code.c,234 :: 		DATAH=ADRESH;        // Read Data
	MOVF       ADRESH+0, 0
	MOVWF      ADC_DATAH_L0+0
;final_code.c,235 :: 		DATAL=ADRESL;
	MOVF       ADRESL+0, 0
	MOVWF      ADC_DATAL_L0+0
;final_code.c,237 :: 		DATA=DATAH;          // Rearrange Data
	MOVF       ADC_DATAH_L0+0, 0
	MOVWF      _DATA+0
	CLRF       _DATA+1
;final_code.c,238 :: 		DATA=DATA<<8;
	MOVF       _DATA+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       R0+0, 0
	MOVWF      _DATA+0
	MOVF       R0+1, 0
	MOVWF      _DATA+1
;final_code.c,239 :: 		DATA = DATA | DATAL;// DATA variable contains combined value of ADC
	MOVF       ADC_DATAL_L0+0, 0
	IORWF      R0+0, 1
	MOVLW      0
	IORWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      _DATA+0
	MOVF       R0+1, 0
	MOVWF      _DATA+1
;final_code.c,241 :: 		V0 = DATA*STEP_SIZE;// Calculate actual value that is being read by the ADC
	CALL       _Word2Double+0
	MOVF       _STEP_SIZE+0, 0
	MOVWF      R4+0
	MOVF       _STEP_SIZE+1, 0
	MOVWF      R4+1
	MOVF       _STEP_SIZE+2, 0
	MOVWF      R4+2
	MOVF       _STEP_SIZE+3, 0
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
;final_code.c,242 :: 		V0 = V0/1000;
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      122
	MOVWF      R4+2
	MOVLW      136
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
;final_code.c,243 :: 		return V0;          // Return the Intput value to main Program
;final_code.c,244 :: 		}
	RETURN
; end of _ADC

_Apply_Brakes:

;final_code.c,247 :: 		void Apply_Brakes(void)
;final_code.c,249 :: 		B=0;
	CLRF       _B+0
;final_code.c,250 :: 		if(Lock1==1 && Lock2==1)
	BTFSS      PORTC+0, 0
	GOTO       L_Apply_Brakes104
	BTFSS      PORTC+0, 1
	GOTO       L_Apply_Brakes104
L__Apply_Brakes183:
;final_code.c,252 :: 		RED_LED1=1;
	BSF        PORTB+0, 0
;final_code.c,253 :: 		GREEN_LED1=0;
	BCF        PORTB+0, 1
;final_code.c,254 :: 		RED_LED2=1;
	BSF        PORTB+0, 2
;final_code.c,255 :: 		GREEN_LED2=0;
	BCF        PORTB+0, 3
;final_code.c,256 :: 		Brake=1;
	MOVLW      1
	MOVWF      _Brake+0
;final_code.c,257 :: 		}
L_Apply_Brakes104:
;final_code.c,259 :: 		if((Lock1==0 || Lock2==0) && Driver==0)
	BTFSS      PORTC+0, 0
	GOTO       L__Apply_Brakes182
	BTFSS      PORTC+0, 1
	GOTO       L__Apply_Brakes182
	GOTO       L_Apply_Brakes109
L__Apply_Brakes182:
	MOVF       _Driver+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_Apply_Brakes109
L__Apply_Brakes181:
;final_code.c,261 :: 		M1_Enable=1;
	BSF        PORTD+0, 2
;final_code.c,262 :: 		Delay_ms(5);
	MOVLW      18
	MOVWF      R12+0
	MOVLW      243
	MOVWF      R13+0
L_Apply_Brakes110:
	DECFSZ     R13+0, 1
	GOTO       L_Apply_Brakes110
	DECFSZ     R12+0, 1
	GOTO       L_Apply_Brakes110
;final_code.c,263 :: 		M2_Enable=1;
	BSF        PORTC+0, 3
;final_code.c,264 :: 		Delay_ms(5);
	MOVLW      18
	MOVWF      R12+0
	MOVLW      243
	MOVWF      R13+0
L_Apply_Brakes111:
	DECFSZ     R13+0, 1
	GOTO       L_Apply_Brakes111
	DECFSZ     R12+0, 1
	GOTO       L_Apply_Brakes111
;final_code.c,266 :: 		M1_1=0;
	BCF        PORTD+0, 1
;final_code.c,267 :: 		M1_2=1;
	BSF        PORTD+0, 0
;final_code.c,269 :: 		M2_1=1;
	BSF        PORTD+0, 3
;final_code.c,270 :: 		M2_2=0;
	BCF        PORTC+0, 4
;final_code.c,272 :: 		while(Lock1==0 && Lock2==0 && Driver==0);
L_Apply_Brakes112:
	BTFSC      PORTC+0, 0
	GOTO       L_Apply_Brakes113
	BTFSC      PORTC+0, 1
	GOTO       L_Apply_Brakes113
	MOVF       _Driver+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_Apply_Brakes113
L__Apply_Brakes180:
	GOTO       L_Apply_Brakes112
L_Apply_Brakes113:
;final_code.c,273 :: 		while(Lock1==1 || Lock2==1 || Driver==1)
L_Apply_Brakes116:
	BTFSC      PORTC+0, 0
	GOTO       L__Apply_Brakes179
	BTFSC      PORTC+0, 1
	GOTO       L__Apply_Brakes179
	MOVF       _Driver+0, 0
	XORLW      1
	BTFSC      STATUS+0, 2
	GOTO       L__Apply_Brakes179
	GOTO       L_Apply_Brakes117
L__Apply_Brakes179:
;final_code.c,275 :: 		if(Driver==1)
	MOVF       _Driver+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_Apply_Brakes120
;final_code.c,277 :: 		M1_1=M1_2;        // Instant Braking of motors
	BTFSC      PORTD+0, 0
	GOTO       L__Apply_Brakes191
	BCF        PORTD+0, 1
	GOTO       L__Apply_Brakes192
L__Apply_Brakes191:
	BSF        PORTD+0, 1
L__Apply_Brakes192:
;final_code.c,278 :: 		M2_1=M2_2;
	BTFSC      PORTC+0, 4
	GOTO       L__Apply_Brakes193
	BCF        PORTD+0, 3
	GOTO       L__Apply_Brakes194
L__Apply_Brakes193:
	BSF        PORTD+0, 3
L__Apply_Brakes194:
;final_code.c,279 :: 		break;
	GOTO       L_Apply_Brakes117
;final_code.c,280 :: 		}
L_Apply_Brakes120:
;final_code.c,282 :: 		if(Lock1==1)
	BTFSS      PORTC+0, 0
	GOTO       L_Apply_Brakes121
;final_code.c,283 :: 		{M1_1=M1_2;       // Instant Braking of motors
	BTFSC      PORTD+0, 0
	GOTO       L__Apply_Brakes195
	BCF        PORTD+0, 1
	GOTO       L__Apply_Brakes196
L__Apply_Brakes195:
	BSF        PORTD+0, 1
L__Apply_Brakes196:
;final_code.c,284 :: 		RED_LED1=1;
	BSF        PORTB+0, 0
;final_code.c,285 :: 		GREEN_LED1=0;
	BCF        PORTB+0, 1
;final_code.c,286 :: 		}
L_Apply_Brakes121:
;final_code.c,289 :: 		if(Lock2==1)
	BTFSS      PORTC+0, 1
	GOTO       L_Apply_Brakes122
;final_code.c,291 :: 		M2_1=M2_2;        // Instant Braking of motors
	BTFSC      PORTC+0, 4
	GOTO       L__Apply_Brakes197
	BCF        PORTD+0, 3
	GOTO       L__Apply_Brakes198
L__Apply_Brakes197:
	BSF        PORTD+0, 3
L__Apply_Brakes198:
;final_code.c,292 :: 		RED_LED2=1;
	BSF        PORTB+0, 2
;final_code.c,293 :: 		GREEN_LED2=0;
	BCF        PORTB+0, 3
;final_code.c,294 :: 		}
L_Apply_Brakes122:
;final_code.c,295 :: 		if(Lock1==1 && Lock2==1)
	BTFSS      PORTC+0, 0
	GOTO       L_Apply_Brakes125
	BTFSS      PORTC+0, 1
	GOTO       L_Apply_Brakes125
L__Apply_Brakes178:
;final_code.c,297 :: 		Brake=1;
	MOVLW      1
	MOVWF      _Brake+0
;final_code.c,298 :: 		break;
	GOTO       L_Apply_Brakes117
;final_code.c,299 :: 		}
L_Apply_Brakes125:
;final_code.c,300 :: 		Delay_ms(20);
	MOVLW      72
	MOVWF      R12+0
	MOVLW      207
	MOVWF      R13+0
L_Apply_Brakes126:
	DECFSZ     R13+0, 1
	GOTO       L_Apply_Brakes126
	DECFSZ     R12+0, 1
	GOTO       L_Apply_Brakes126
;final_code.c,301 :: 		}
	GOTO       L_Apply_Brakes116
L_Apply_Brakes117:
;final_code.c,303 :: 		M1_Enable=0;
	BCF        PORTD+0, 2
;final_code.c,304 :: 		Delay_ms(5);
	MOVLW      18
	MOVWF      R12+0
	MOVLW      243
	MOVWF      R13+0
L_Apply_Brakes127:
	DECFSZ     R13+0, 1
	GOTO       L_Apply_Brakes127
	DECFSZ     R12+0, 1
	GOTO       L_Apply_Brakes127
;final_code.c,305 :: 		M2_Enable=0;
	BCF        PORTC+0, 3
;final_code.c,306 :: 		Delay_ms(5);
	MOVLW      18
	MOVWF      R12+0
	MOVLW      243
	MOVWF      R13+0
L_Apply_Brakes128:
	DECFSZ     R13+0, 1
	GOTO       L_Apply_Brakes128
	DECFSZ     R12+0, 1
	GOTO       L_Apply_Brakes128
;final_code.c,307 :: 		M1_1=0;
	BCF        PORTD+0, 1
;final_code.c,308 :: 		M1_2=0;
	BCF        PORTD+0, 0
;final_code.c,309 :: 		M2_1=0;
	BCF        PORTD+0, 3
;final_code.c,310 :: 		M2_2=0;
	BCF        PORTC+0, 4
;final_code.c,311 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      104
	MOVWF      R12+0
	MOVLW      13
	MOVWF      R13+0
L_Apply_Brakes129:
	DECFSZ     R13+0, 1
	GOTO       L_Apply_Brakes129
	DECFSZ     R12+0, 1
	GOTO       L_Apply_Brakes129
	DECFSZ     R11+0, 1
	GOTO       L_Apply_Brakes129
;final_code.c,312 :: 		}
L_Apply_Brakes109:
;final_code.c,313 :: 		}
	RETURN
; end of _Apply_Brakes

_Lift_Brakes:

;final_code.c,316 :: 		void Lift_Brakes(void)
;final_code.c,318 :: 		B=0;
	CLRF       _B+0
;final_code.c,319 :: 		if(UnLock1==1 && UnLock2==1)
	BTFSS      PORTD+0, 4
	GOTO       L_Lift_Brakes132
	BTFSS      PORTD+0, 5
	GOTO       L_Lift_Brakes132
L__Lift_Brakes189:
;final_code.c,321 :: 		RED_LED1=0;
	BCF        PORTB+0, 0
;final_code.c,322 :: 		GREEN_LED1=1;
	BSF        PORTB+0, 1
;final_code.c,323 :: 		RED_LED2=0;
	BCF        PORTB+0, 2
;final_code.c,324 :: 		GREEN_LED2=1;
	BSF        PORTB+0, 3
;final_code.c,325 :: 		Brake=0;
	CLRF       _Brake+0
;final_code.c,326 :: 		}
L_Lift_Brakes132:
;final_code.c,327 :: 		if((UnLock1==0 || UnLock2==0) && Driver==1)
	BTFSS      PORTD+0, 4
	GOTO       L__Lift_Brakes188
	BTFSS      PORTD+0, 5
	GOTO       L__Lift_Brakes188
	GOTO       L_Lift_Brakes137
L__Lift_Brakes188:
	MOVF       _Driver+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_Lift_Brakes137
L__Lift_Brakes187:
;final_code.c,329 :: 		M1_Enable=1;
	BSF        PORTD+0, 2
;final_code.c,330 :: 		Delay_ms(5);
	MOVLW      18
	MOVWF      R12+0
	MOVLW      243
	MOVWF      R13+0
L_Lift_Brakes138:
	DECFSZ     R13+0, 1
	GOTO       L_Lift_Brakes138
	DECFSZ     R12+0, 1
	GOTO       L_Lift_Brakes138
;final_code.c,331 :: 		M2_Enable=1;
	BSF        PORTC+0, 3
;final_code.c,332 :: 		Delay_ms(5);
	MOVLW      18
	MOVWF      R12+0
	MOVLW      243
	MOVWF      R13+0
L_Lift_Brakes139:
	DECFSZ     R13+0, 1
	GOTO       L_Lift_Brakes139
	DECFSZ     R12+0, 1
	GOTO       L_Lift_Brakes139
;final_code.c,334 :: 		M1_1=1;
	BSF        PORTD+0, 1
;final_code.c,335 :: 		M1_2=0;
	BCF        PORTD+0, 0
;final_code.c,337 :: 		M2_1=0;
	BCF        PORTD+0, 3
;final_code.c,338 :: 		M2_2=1;
	BSF        PORTC+0, 4
;final_code.c,339 :: 		while(UnLock1==0 && UnLock2==0 && Driver==1);
L_Lift_Brakes140:
	BTFSC      PORTD+0, 4
	GOTO       L_Lift_Brakes141
	BTFSC      PORTD+0, 5
	GOTO       L_Lift_Brakes141
	MOVF       _Driver+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_Lift_Brakes141
L__Lift_Brakes186:
	GOTO       L_Lift_Brakes140
L_Lift_Brakes141:
;final_code.c,340 :: 		while(UnLock1==1 || UnLock2==1 || Driver==0)
L_Lift_Brakes144:
	BTFSC      PORTD+0, 4
	GOTO       L__Lift_Brakes185
	BTFSC      PORTD+0, 5
	GOTO       L__Lift_Brakes185
	MOVF       _Driver+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L__Lift_Brakes185
	GOTO       L_Lift_Brakes145
L__Lift_Brakes185:
;final_code.c,342 :: 		if(Driver==0)
	MOVF       _Driver+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_Lift_Brakes148
;final_code.c,344 :: 		M1_1=M1_2;        // Instant Braking of motors
	BTFSC      PORTD+0, 0
	GOTO       L__Lift_Brakes199
	BCF        PORTD+0, 1
	GOTO       L__Lift_Brakes200
L__Lift_Brakes199:
	BSF        PORTD+0, 1
L__Lift_Brakes200:
;final_code.c,345 :: 		M2_1=M2_2;
	BTFSC      PORTC+0, 4
	GOTO       L__Lift_Brakes201
	BCF        PORTD+0, 3
	GOTO       L__Lift_Brakes202
L__Lift_Brakes201:
	BSF        PORTD+0, 3
L__Lift_Brakes202:
;final_code.c,346 :: 		break;
	GOTO       L_Lift_Brakes145
;final_code.c,347 :: 		}
L_Lift_Brakes148:
;final_code.c,349 :: 		if(UnLock1==1)
	BTFSS      PORTD+0, 4
	GOTO       L_Lift_Brakes149
;final_code.c,350 :: 		{  M1_1=M1_2;
	BTFSC      PORTD+0, 0
	GOTO       L__Lift_Brakes203
	BCF        PORTD+0, 1
	GOTO       L__Lift_Brakes204
L__Lift_Brakes203:
	BSF        PORTD+0, 1
L__Lift_Brakes204:
;final_code.c,351 :: 		GREEN_LED1=1;
	BSF        PORTB+0, 1
;final_code.c,352 :: 		RED_LED1=0;
	BCF        PORTB+0, 0
;final_code.c,353 :: 		}
L_Lift_Brakes149:
;final_code.c,355 :: 		if(UnLock2==1)
	BTFSS      PORTD+0, 5
	GOTO       L_Lift_Brakes150
;final_code.c,356 :: 		{  M2_1=M2_2;
	BTFSC      PORTC+0, 4
	GOTO       L__Lift_Brakes205
	BCF        PORTD+0, 3
	GOTO       L__Lift_Brakes206
L__Lift_Brakes205:
	BSF        PORTD+0, 3
L__Lift_Brakes206:
;final_code.c,357 :: 		GREEN_LED2=1;
	BSF        PORTB+0, 3
;final_code.c,358 :: 		RED_LED2=0;
	BCF        PORTB+0, 2
;final_code.c,359 :: 		}
L_Lift_Brakes150:
;final_code.c,362 :: 		if(UnLock1==1 && UnLock2==1)
	BTFSS      PORTD+0, 4
	GOTO       L_Lift_Brakes153
	BTFSS      PORTD+0, 5
	GOTO       L_Lift_Brakes153
L__Lift_Brakes184:
;final_code.c,364 :: 		Brake=0;
	CLRF       _Brake+0
;final_code.c,365 :: 		break;
	GOTO       L_Lift_Brakes145
;final_code.c,366 :: 		}
L_Lift_Brakes153:
;final_code.c,367 :: 		Delay_ms(20);
	MOVLW      72
	MOVWF      R12+0
	MOVLW      207
	MOVWF      R13+0
L_Lift_Brakes154:
	DECFSZ     R13+0, 1
	GOTO       L_Lift_Brakes154
	DECFSZ     R12+0, 1
	GOTO       L_Lift_Brakes154
;final_code.c,368 :: 		}
	GOTO       L_Lift_Brakes144
L_Lift_Brakes145:
;final_code.c,370 :: 		M1_Enable=0;
	BCF        PORTD+0, 2
;final_code.c,371 :: 		Delay_ms(5);
	MOVLW      18
	MOVWF      R12+0
	MOVLW      243
	MOVWF      R13+0
L_Lift_Brakes155:
	DECFSZ     R13+0, 1
	GOTO       L_Lift_Brakes155
	DECFSZ     R12+0, 1
	GOTO       L_Lift_Brakes155
;final_code.c,372 :: 		M2_Enable=0;
	BCF        PORTC+0, 3
;final_code.c,373 :: 		Delay_ms(5);
	MOVLW      18
	MOVWF      R12+0
	MOVLW      243
	MOVWF      R13+0
L_Lift_Brakes156:
	DECFSZ     R13+0, 1
	GOTO       L_Lift_Brakes156
	DECFSZ     R12+0, 1
	GOTO       L_Lift_Brakes156
;final_code.c,374 :: 		M1_1=0;
	BCF        PORTD+0, 1
;final_code.c,375 :: 		M1_2=0;
	BCF        PORTD+0, 0
;final_code.c,376 :: 		M2_1=0;
	BCF        PORTD+0, 3
;final_code.c,377 :: 		M2_2=0;
	BCF        PORTC+0, 4
;final_code.c,378 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      104
	MOVWF      R12+0
	MOVLW      13
	MOVWF      R13+0
L_Lift_Brakes157:
	DECFSZ     R13+0, 1
	GOTO       L_Lift_Brakes157
	DECFSZ     R12+0, 1
	GOTO       L_Lift_Brakes157
	DECFSZ     R11+0, 1
	GOTO       L_Lift_Brakes157
;final_code.c,379 :: 		}
L_Lift_Brakes137:
;final_code.c,380 :: 		}
	RETURN
; end of _Lift_Brakes
