
_main3:

;traffic.c,10 :: 		void main3(){
;traffic.c,12 :: 		TRISB = 0;
	CLRF       TRISB+0
;traffic.c,13 :: 		portb = 0;
	CLRF       PORTB+0
;traffic.c,15 :: 		while (1){
L_main30:
;traffic.c,16 :: 		green1 = 1;
	BSF        PORTB+0, 3
;traffic.c,17 :: 		red2 = 1;
	BSF        PORTB+0, 4
;traffic.c,18 :: 		delay_ms(20000);
	MOVLW      203
	MOVWF      R11+0
	MOVLW      236
	MOVWF      R12+0
	MOVLW      132
	MOVWF      R13+0
L_main32:
	DECFSZ     R13+0, 1
	GOTO       L_main32
	DECFSZ     R12+0, 1
	GOTO       L_main32
	DECFSZ     R11+0, 1
	GOTO       L_main32
	NOP
;traffic.c,19 :: 		green1 = 0;
	BCF        PORTB+0, 3
;traffic.c,20 :: 		yellow1 = 1;
	BSF        PORTB+0, 2
;traffic.c,21 :: 		delay_ms(3000);
	MOVLW      31
	MOVWF      R11+0
	MOVLW      113
	MOVWF      R12+0
	MOVLW      30
	MOVWF      R13+0
L_main33:
	DECFSZ     R13+0, 1
	GOTO       L_main33
	DECFSZ     R12+0, 1
	GOTO       L_main33
	DECFSZ     R11+0, 1
	GOTO       L_main33
	NOP
;traffic.c,22 :: 		yellow1 = 0;
	BCF        PORTB+0, 2
;traffic.c,23 :: 		red1 = 1;
	BSF        PORTB+0, 1
;traffic.c,24 :: 		red2 = 0;
	BCF        PORTB+0, 4
;traffic.c,25 :: 		green2 = 1;
	BSF        PORTB+0, 6
;traffic.c,26 :: 		delay_ms(12000);
	MOVLW      122
	MOVWF      R11+0
	MOVLW      193
	MOVWF      R12+0
	MOVLW      129
	MOVWF      R13+0
L_main34:
	DECFSZ     R13+0, 1
	GOTO       L_main34
	DECFSZ     R12+0, 1
	GOTO       L_main34
	DECFSZ     R11+0, 1
	GOTO       L_main34
	NOP
	NOP
;traffic.c,27 :: 		yellow2 = 1;
	BSF        PORTB+0, 5
;traffic.c,28 :: 		green2 = 0;
	BCF        PORTB+0, 6
;traffic.c,29 :: 		delay_ms(3000);
	MOVLW      31
	MOVWF      R11+0
	MOVLW      113
	MOVWF      R12+0
	MOVLW      30
	MOVWF      R13+0
L_main35:
	DECFSZ     R13+0, 1
	GOTO       L_main35
	DECFSZ     R12+0, 1
	GOTO       L_main35
	DECFSZ     R11+0, 1
	GOTO       L_main35
	NOP
;traffic.c,30 :: 		yellow2 = 0;
	BCF        PORTB+0, 5
;traffic.c,31 :: 		red1 = 0;
	BCF        PORTB+0, 1
;traffic.c,32 :: 		}
	GOTO       L_main30
;traffic.c,33 :: 		}
L_end_main3:
	RETURN
; end of _main3
