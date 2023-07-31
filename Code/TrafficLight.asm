
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;TrafficLight.c,20 :: 		void interrupt()
;TrafficLight.c,22 :: 		if(intf_bit==1)
	BTFSS      INTF_bit+0, BitPos(INTF_bit+0)
	GOTO       L_interrupt0
;TrafficLight.c,23 :: 		{intf_bit=0;
	BCF        INTF_bit+0, BitPos(INTF_bit+0)
;TrafficLight.c,24 :: 		if(flag==99)
	MOVLW      0
	XORWF      _flag+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt43
	MOVLW      99
	XORWF      _flag+0, 0
L__interrupt43:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt1
;TrafficLight.c,25 :: 		flag=-1;
	MOVLW      255
	MOVWF      _flag+0
	MOVLW      255
	MOVWF      _flag+1
L_interrupt1:
;TrafficLight.c,26 :: 		flag++;
	INCF       _flag+0, 1
	BTFSC      STATUS+0, 2
	INCF       _flag+1, 1
;TrafficLight.c,27 :: 		}}
L_interrupt0:
L_end_interrupt:
L__interrupt42:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_manualTraffic:

;TrafficLight.c,29 :: 		void manualTraffic(){
;TrafficLight.c,31 :: 		int i = 0;
	CLRF       manualTraffic_i_L0+0
	CLRF       manualTraffic_i_L0+1
;TrafficLight.c,32 :: 		while(1){
L_manualTraffic2:
;TrafficLight.c,34 :: 		if (flag % 2 ==0)
	MOVLW      2
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _flag+0, 0
	MOVWF      R0+0
	MOVF       _flag+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      0
	XORWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__manualTraffic45
	MOVLW      0
	XORWF      R0+0, 0
L__manualTraffic45:
	BTFSS      STATUS+0, 2
	GOTO       L_manualTraffic4
;TrafficLight.c,36 :: 		return;
	GOTO       L_end_manualTraffic
;TrafficLight.c,37 :: 		}
L_manualTraffic4:
;TrafficLight.c,38 :: 		DIS2 = 1;
	BSF        PORTD+0, 7
;TrafficLight.c,39 :: 		all_off();
	CALL       _all_off+0
;TrafficLight.c,40 :: 		yellow1 = 1;
	BSF        PORTB+0, 3
;TrafficLight.c,41 :: 		for (i = 1; i <= 3; i++)
	MOVLW      1
	MOVWF      manualTraffic_i_L0+0
	MOVLW      0
	MOVWF      manualTraffic_i_L0+1
L_manualTraffic5:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      manualTraffic_i_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__manualTraffic46
	MOVF       manualTraffic_i_L0+0, 0
	SUBLW      3
L__manualTraffic46:
	BTFSS      STATUS+0, 0
	GOTO       L_manualTraffic6
;TrafficLight.c,43 :: 		PORTC = i;
	MOVF       manualTraffic_i_L0+0, 0
	MOVWF      PORTC+0
;TrafficLight.c,44 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_manualTraffic8:
	DECFSZ     R13+0, 1
	GOTO       L_manualTraffic8
	DECFSZ     R12+0, 1
	GOTO       L_manualTraffic8
	DECFSZ     R11+0, 1
	GOTO       L_manualTraffic8
	NOP
	NOP
;TrafficLight.c,41 :: 		for (i = 1; i <= 3; i++)
	INCF       manualTraffic_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       manualTraffic_i_L0+1, 1
;TrafficLight.c,45 :: 		}
	GOTO       L_manualTraffic5
L_manualTraffic6:
;TrafficLight.c,46 :: 		DIS2 = 0;
	BCF        PORTD+0, 7
;TrafficLight.c,47 :: 		yellow1 = 0;
	BCF        PORTB+0, 3
;TrafficLight.c,48 :: 		green1 = 1;
	BSF        PORTB+0, 4
;TrafficLight.c,49 :: 		red2 = 1;
	BSF        PORTB+0, 5
;TrafficLight.c,50 :: 		for(; ma == 0;){
L_manualTraffic9:
	BTFSC      PORTB+0, 1
	GOTO       L_manualTraffic10
;TrafficLight.c,51 :: 		if (flag % 2 ==0)
	MOVLW      2
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _flag+0, 0
	MOVWF      R0+0
	MOVF       _flag+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      0
	XORWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__manualTraffic47
	MOVLW      0
	XORWF      R0+0, 0
L__manualTraffic47:
	BTFSS      STATUS+0, 2
	GOTO       L_manualTraffic12
;TrafficLight.c,53 :: 		return;
	GOTO       L_end_manualTraffic
;TrafficLight.c,54 :: 		}
L_manualTraffic12:
;TrafficLight.c,55 :: 		}
	GOTO       L_manualTraffic9
L_manualTraffic10:
;TrafficLight.c,56 :: 		all_off();
	CALL       _all_off+0
;TrafficLight.c,57 :: 		yellow2 = 1;
	BSF        PORTB+0, 6
;TrafficLight.c,58 :: 		DIS2 = 1;
	BSF        PORTD+0, 7
;TrafficLight.c,59 :: 		for (i = 1; i <= 3; i++)
	MOVLW      1
	MOVWF      manualTraffic_i_L0+0
	MOVLW      0
	MOVWF      manualTraffic_i_L0+1
L_manualTraffic13:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      manualTraffic_i_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__manualTraffic48
	MOVF       manualTraffic_i_L0+0, 0
	SUBLW      3
L__manualTraffic48:
	BTFSS      STATUS+0, 0
	GOTO       L_manualTraffic14
;TrafficLight.c,61 :: 		PORTC = i;
	MOVF       manualTraffic_i_L0+0, 0
	MOVWF      PORTC+0
;TrafficLight.c,62 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_manualTraffic16:
	DECFSZ     R13+0, 1
	GOTO       L_manualTraffic16
	DECFSZ     R12+0, 1
	GOTO       L_manualTraffic16
	DECFSZ     R11+0, 1
	GOTO       L_manualTraffic16
	NOP
	NOP
;TrafficLight.c,59 :: 		for (i = 1; i <= 3; i++)
	INCF       manualTraffic_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       manualTraffic_i_L0+1, 1
;TrafficLight.c,63 :: 		}
	GOTO       L_manualTraffic13
L_manualTraffic14:
;TrafficLight.c,64 :: 		DIS2 = 0;
	BCF        PORTD+0, 7
;TrafficLight.c,65 :: 		yellow2 = 0;
	BCF        PORTB+0, 6
;TrafficLight.c,66 :: 		green2 = 1;
	BSF        PORTB+0, 7
;TrafficLight.c,67 :: 		red1 = 1;
	BSF        PORTB+0, 2
;TrafficLight.c,68 :: 		for(; ma == 1;){
L_manualTraffic17:
	BTFSS      PORTB+0, 1
	GOTO       L_manualTraffic18
;TrafficLight.c,69 :: 		if (flag % 2 ==0)
	MOVLW      2
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _flag+0, 0
	MOVWF      R0+0
	MOVF       _flag+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      0
	XORWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__manualTraffic49
	MOVLW      0
	XORWF      R0+0, 0
L__manualTraffic49:
	BTFSS      STATUS+0, 2
	GOTO       L_manualTraffic20
;TrafficLight.c,71 :: 		return;
	GOTO       L_end_manualTraffic
;TrafficLight.c,72 :: 		}
L_manualTraffic20:
;TrafficLight.c,73 :: 		}
	GOTO       L_manualTraffic17
L_manualTraffic18:
;TrafficLight.c,74 :: 		}
	GOTO       L_manualTraffic2
;TrafficLight.c,75 :: 		}
L_end_manualTraffic:
	RETURN
; end of _manualTraffic

_main:

;TrafficLight.c,77 :: 		void main()
;TrafficLight.c,79 :: 		gie_bit = 1;
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;TrafficLight.c,80 :: 		inte_bit = 1;
	BSF        INTE_bit+0, BitPos(INTE_bit+0)
;TrafficLight.c,81 :: 		intedg_bit = 1;
	BSF        INTEDG_bit+0, BitPos(INTEDG_bit+0)
;TrafficLight.c,83 :: 		TRISB = 0B00000011;
	MOVLW      3
	MOVWF      TRISB+0
;TrafficLight.c,84 :: 		TRISC = 0;
	CLRF       TRISC+0
;TrafficLight.c,85 :: 		TRISD = 0;
	CLRF       TRISD+0
;TrafficLight.c,86 :: 		DIS1 = 0;
	BCF        PORTD+0, 6
;TrafficLight.c,87 :: 		DIS2 = 0;
	BCF        PORTD+0, 7
;TrafficLight.c,88 :: 		PORTB = 0;
	CLRF       PORTB+0
;TrafficLight.c,89 :: 		PORTC = 0;
	CLRF       PORTC+0
;TrafficLight.c,90 :: 		PORTD = 0;
	CLRF       PORTD+0
;TrafficLight.c,92 :: 		while (1)
L_main21:
;TrafficLight.c,94 :: 		if (flag % 2 == 0){
	MOVLW      2
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _flag+0, 0
	MOVWF      R0+0
	MOVF       _flag+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      0
	XORWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main51
	MOVLW      0
	XORWF      R0+0, 0
L__main51:
	BTFSS      STATUS+0, 2
	GOTO       L_main23
;TrafficLight.c,95 :: 		automaticTraffic();
	CALL       _automaticTraffic+0
;TrafficLight.c,96 :: 		}else{
	GOTO       L_main24
L_main23:
;TrafficLight.c,97 :: 		manualTraffic();
	CALL       _manualTraffic+0
;TrafficLight.c,98 :: 		}
L_main24:
;TrafficLight.c,99 :: 		}
	GOTO       L_main21
;TrafficLight.c,100 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_timer:

;TrafficLight.c,102 :: 		void timer(int time1, int time2){
;TrafficLight.c,105 :: 		if (flag % 2 == 1)
	MOVLW      2
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _flag+0, 0
	MOVWF      R0+0
	MOVF       _flag+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      0
	XORWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__timer53
	MOVLW      1
	XORWF      R0+0, 0
L__timer53:
	BTFSS      STATUS+0, 2
	GOTO       L_timer25
;TrafficLight.c,107 :: 		return;
	GOTO       L_end_timer
;TrafficLight.c,108 :: 		}
L_timer25:
;TrafficLight.c,110 :: 		if (red1){
	BTFSS      PORTB+0, 2
	GOTO       L_timer26
;TrafficLight.c,111 :: 		i = time2;
	MOVF       FARG_timer_time2+0, 0
	MOVWF      timer_i_L0+0
	MOVF       FARG_timer_time2+1, 0
	MOVWF      timer_i_L0+1
;TrafficLight.c,112 :: 		j = time1;
	MOVF       FARG_timer_time1+0, 0
	MOVWF      timer_j_L0+0
	MOVF       FARG_timer_time1+1, 0
	MOVWF      timer_j_L0+1
;TrafficLight.c,113 :: 		k = j;
	MOVF       FARG_timer_time1+0, 0
	MOVWF      timer_k_L0+0
	MOVF       FARG_timer_time1+1, 0
	MOVWF      timer_k_L0+1
;TrafficLight.c,114 :: 		}
	GOTO       L_timer27
L_timer26:
;TrafficLight.c,116 :: 		i = time1;
	MOVF       FARG_timer_time1+0, 0
	MOVWF      timer_i_L0+0
	MOVF       FARG_timer_time1+1, 0
	MOVWF      timer_i_L0+1
;TrafficLight.c,117 :: 		j = time2;
	MOVF       FARG_timer_time2+0, 0
	MOVWF      timer_j_L0+0
	MOVF       FARG_timer_time2+1, 0
	MOVWF      timer_j_L0+1
;TrafficLight.c,118 :: 		k = i;
	MOVF       FARG_timer_time1+0, 0
	MOVWF      timer_k_L0+0
	MOVF       FARG_timer_time1+1, 0
	MOVWF      timer_k_L0+1
;TrafficLight.c,119 :: 		}
L_timer27:
;TrafficLight.c,121 :: 		for (; k >= 0; i--, j--, k--){
L_timer28:
	MOVLW      128
	XORWF      timer_k_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__timer54
	MOVLW      0
	SUBWF      timer_k_L0+0, 0
L__timer54:
	BTFSS      STATUS+0, 0
	GOTO       L_timer29
;TrafficLight.c,123 :: 		if (flag % 2 == 1)
	MOVLW      2
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _flag+0, 0
	MOVWF      R0+0
	MOVF       _flag+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      0
	XORWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__timer55
	MOVLW      1
	XORWF      R0+0, 0
L__timer55:
	BTFSS      STATUS+0, 2
	GOTO       L_timer31
;TrafficLight.c,125 :: 		return;
	GOTO       L_end_timer
;TrafficLight.c,126 :: 		}
L_timer31:
;TrafficLight.c,128 :: 		display(i/10, i%10, j/10, j%10);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       timer_i_L0+0, 0
	MOVWF      R0+0
	MOVF       timer_i_L0+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      FARG_display_tens+0
	MOVF       R0+1, 0
	MOVWF      FARG_display_tens+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       timer_i_L0+0, 0
	MOVWF      R0+0
	MOVF       timer_i_L0+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      FARG_display_units+0
	MOVF       R0+1, 0
	MOVWF      FARG_display_units+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       timer_j_L0+0, 0
	MOVWF      R0+0
	MOVF       timer_j_L0+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      FARG_display_tens2+0
	MOVF       R0+1, 0
	MOVWF      FARG_display_tens2+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       timer_j_L0+0, 0
	MOVWF      R0+0
	MOVF       timer_j_L0+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      FARG_display_units2+0
	MOVF       R0+1, 0
	MOVWF      FARG_display_units2+1
	CALL       _display+0
;TrafficLight.c,121 :: 		for (; k >= 0; i--, j--, k--){
	MOVLW      1
	SUBWF      timer_i_L0+0, 1
	BTFSS      STATUS+0, 0
	DECF       timer_i_L0+1, 1
	MOVLW      1
	SUBWF      timer_j_L0+0, 1
	BTFSS      STATUS+0, 0
	DECF       timer_j_L0+1, 1
	MOVLW      1
	SUBWF      timer_k_L0+0, 1
	BTFSS      STATUS+0, 0
	DECF       timer_k_L0+1, 1
;TrafficLight.c,129 :: 		}
	GOTO       L_timer28
L_timer29:
;TrafficLight.c,130 :: 		}
L_end_timer:
	RETURN
; end of _timer

_display:

;TrafficLight.c,132 :: 		void display(int tens, int units, int tens2, int units2){
;TrafficLight.c,134 :: 		for (i = 0; i < 10; i++){
	CLRF       display_i_L0+0
	CLRF       display_i_L0+1
L_display32:
	MOVLW      128
	XORWF      display_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__display57
	MOVLW      10
	SUBWF      display_i_L0+0, 0
L__display57:
	BTFSC      STATUS+0, 0
	GOTO       L_display33
;TrafficLight.c,136 :: 		if (flag % 2 == 1)
	MOVLW      2
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _flag+0, 0
	MOVWF      R0+0
	MOVF       _flag+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      0
	XORWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__display58
	MOVLW      1
	XORWF      R0+0, 0
L__display58:
	BTFSS      STATUS+0, 2
	GOTO       L_display35
;TrafficLight.c,138 :: 		return;
	GOTO       L_end_display
;TrafficLight.c,139 :: 		}
L_display35:
;TrafficLight.c,141 :: 		DIS1 = 1;
	BSF        PORTD+0, 6
;TrafficLight.c,142 :: 		PORTC = tens + (tens2 << 4);
	MOVLW      4
	MOVWF      R1+0
	MOVF       FARG_display_tens2+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
L__display59:
	BTFSC      STATUS+0, 2
	GOTO       L__display60
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__display59
L__display60:
	MOVF       R0+0, 0
	ADDWF      FARG_display_tens+0, 0
	MOVWF      PORTC+0
;TrafficLight.c,143 :: 		delay_ms(50);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_display36:
	DECFSZ     R13+0, 1
	GOTO       L_display36
	DECFSZ     R12+0, 1
	GOTO       L_display36
	NOP
	NOP
;TrafficLight.c,144 :: 		DIS1 = 0;
	BCF        PORTD+0, 6
;TrafficLight.c,146 :: 		DIS2 = 1;
	BSF        PORTD+0, 7
;TrafficLight.c,147 :: 		PORTC = units + (units2 << 4);
	MOVLW      4
	MOVWF      R1+0
	MOVF       FARG_display_units2+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
L__display61:
	BTFSC      STATUS+0, 2
	GOTO       L__display62
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__display61
L__display62:
	MOVF       R0+0, 0
	ADDWF      FARG_display_units+0, 0
	MOVWF      PORTC+0
;TrafficLight.c,148 :: 		delay_ms(50);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_display37:
	DECFSZ     R13+0, 1
	GOTO       L_display37
	DECFSZ     R12+0, 1
	GOTO       L_display37
	NOP
	NOP
;TrafficLight.c,149 :: 		DIS2 = 0;
	BCF        PORTD+0, 7
;TrafficLight.c,134 :: 		for (i = 0; i < 10; i++){
	INCF       display_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       display_i_L0+1, 1
;TrafficLight.c,150 :: 		}
	GOTO       L_display32
L_display33:
;TrafficLight.c,151 :: 		}
L_end_display:
	RETURN
; end of _display

_automaticTraffic:

;TrafficLight.c,154 :: 		void automaticTraffic(){
;TrafficLight.c,155 :: 		while (1){
L_automaticTraffic38:
;TrafficLight.c,156 :: 		if (flag % 2 == 1)
	MOVLW      2
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _flag+0, 0
	MOVWF      R0+0
	MOVF       _flag+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      0
	XORWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__automaticTraffic64
	MOVLW      1
	XORWF      R0+0, 0
L__automaticTraffic64:
	BTFSS      STATUS+0, 2
	GOTO       L_automaticTraffic40
;TrafficLight.c,158 :: 		return;
	GOTO       L_end_automaticTraffic
;TrafficLight.c,159 :: 		}
L_automaticTraffic40:
;TrafficLight.c,161 :: 		green1 = 1;
	BSF        PORTB+0, 4
;TrafficLight.c,162 :: 		red2 = 1;
	BSF        PORTB+0, 5
;TrafficLight.c,163 :: 		timer(19, 23);
	MOVLW      19
	MOVWF      FARG_timer_time1+0
	MOVLW      0
	MOVWF      FARG_timer_time1+1
	MOVLW      23
	MOVWF      FARG_timer_time2+0
	MOVLW      0
	MOVWF      FARG_timer_time2+1
	CALL       _timer+0
;TrafficLight.c,164 :: 		green1 = 0;
	BCF        PORTB+0, 4
;TrafficLight.c,165 :: 		yellow1 = 1;
	BSF        PORTB+0, 3
;TrafficLight.c,166 :: 		timer(3, 3);
	MOVLW      3
	MOVWF      FARG_timer_time1+0
	MOVLW      0
	MOVWF      FARG_timer_time1+1
	MOVLW      3
	MOVWF      FARG_timer_time2+0
	MOVLW      0
	MOVWF      FARG_timer_time2+1
	CALL       _timer+0
;TrafficLight.c,167 :: 		yellow1 = 0;
	BCF        PORTB+0, 3
;TrafficLight.c,168 :: 		red1 = 1;
	BSF        PORTB+0, 2
;TrafficLight.c,169 :: 		red2 = 0;
	BCF        PORTB+0, 5
;TrafficLight.c,170 :: 		green2 = 1;
	BSF        PORTB+0, 7
;TrafficLight.c,171 :: 		timer(11, 15);
	MOVLW      11
	MOVWF      FARG_timer_time1+0
	MOVLW      0
	MOVWF      FARG_timer_time1+1
	MOVLW      15
	MOVWF      FARG_timer_time2+0
	MOVLW      0
	MOVWF      FARG_timer_time2+1
	CALL       _timer+0
;TrafficLight.c,172 :: 		yellow2 = 1;
	BSF        PORTB+0, 6
;TrafficLight.c,173 :: 		green2 = 0;
	BCF        PORTB+0, 7
;TrafficLight.c,174 :: 		timer(3, 3);
	MOVLW      3
	MOVWF      FARG_timer_time1+0
	MOVLW      0
	MOVWF      FARG_timer_time1+1
	MOVLW      3
	MOVWF      FARG_timer_time2+0
	MOVLW      0
	MOVWF      FARG_timer_time2+1
	CALL       _timer+0
;TrafficLight.c,175 :: 		yellow2 = 0;
	BCF        PORTB+0, 6
;TrafficLight.c,176 :: 		red1 = 0;
	BCF        PORTB+0, 2
;TrafficLight.c,177 :: 		}
	GOTO       L_automaticTraffic38
;TrafficLight.c,178 :: 		}
L_end_automaticTraffic:
	RETURN
; end of _automaticTraffic

_all_off:

;TrafficLight.c,180 :: 		void all_off(){
;TrafficLight.c,181 :: 		red1 = 0;
	BCF        PORTB+0, 2
;TrafficLight.c,182 :: 		red2 = 0;
	BCF        PORTB+0, 5
;TrafficLight.c,183 :: 		yellow1 = 0;
	BCF        PORTB+0, 3
;TrafficLight.c,184 :: 		yellow2 = 0;
	BCF        PORTB+0, 6
;TrafficLight.c,185 :: 		green1 = 0;
	BCF        PORTB+0, 4
;TrafficLight.c,186 :: 		green2 = 0;
	BCF        PORTB+0, 7
;TrafficLight.c,187 :: 		}
L_end_all_off:
	RETURN
; end of _all_off
