
_intone:

;code of traffic.c,3 :: 		void intone() // to use for manual mode in first
;code of traffic.c,5 :: 		portc.B5 = 1;  // green 1 on
	BSF        PORTC+0, 5
;code of traffic.c,6 :: 		portc.b0 = 1; // red 1 on
	BSF        PORTC+0, 0
;code of traffic.c,7 :: 		}
L_end_intone:
	RETURN
; end of _intone

_intsec:

;code of traffic.c,8 :: 		void intsec() // to use for manual mode in sec
;code of traffic.c,10 :: 		portc.B4 = 1; // yellow 2 on
	BSF        PORTC+0, 4
;code of traffic.c,11 :: 		portc.b5 = 0; // grren 2  off
	BCF        PORTC+0, 5
;code of traffic.c,12 :: 		delay_ms(3000); // delay by 3 sec
	MOVLW      31
	MOVWF      R11+0
	MOVLW      113
	MOVWF      R12+0
	MOVLW      30
	MOVWF      R13+0
L_intsec0:
	DECFSZ     R13+0, 1
	GOTO       L_intsec0
	DECFSZ     R12+0, 1
	GOTO       L_intsec0
	DECFSZ     R11+0, 1
	GOTO       L_intsec0
	NOP
;code of traffic.c,13 :: 		portc.b4 = 0;  // yellow 2 off
	BCF        PORTC+0, 4
;code of traffic.c,14 :: 		portc.B3 = 1;  // red 2  on
	BSF        PORTC+0, 3
;code of traffic.c,15 :: 		portc.b0 = 0; // red 1 off
	BCF        PORTC+0, 0
;code of traffic.c,16 :: 		portc.b2 = 1; // green 1 on
	BSF        PORTC+0, 2
;code of traffic.c,17 :: 		}
L_end_intsec:
	RETURN
; end of _intsec

_actint:

;code of traffic.c,18 :: 		void actint()
;code of traffic.c,20 :: 		porta = 0; // 7 seg. dispaly off
	CLRF       PORTA+0
;code of traffic.c,21 :: 		while(!portb.b1)  intone();
L_actint1:
	BTFSC      PORTB+0, 1
	GOTO       L_actint2
	CALL       _intone+0
	GOTO       L_actint1
L_actint2:
;code of traffic.c,22 :: 		indicator = 1;
	MOVLW      1
	MOVWF      _indicator+0
;code of traffic.c,23 :: 		while(portb.b0)
L_actint3:
	BTFSS      PORTB+0, 0
	GOTO       L_actint4
;code of traffic.c,25 :: 		while(portb.b1 && portb.b0)
L_actint5:
	BTFSS      PORTB+0, 1
	GOTO       L_actint6
	BTFSS      PORTB+0, 0
	GOTO       L_actint6
L__actint34:
;code of traffic.c,26 :: 		if( indicator == 1)
	MOVF       _indicator+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_actint9
;code of traffic.c,28 :: 		intsec();
	CALL       _intsec+0
;code of traffic.c,29 :: 		indicator = 2;
	MOVLW      2
	MOVWF      _indicator+0
;code of traffic.c,30 :: 		}
L_actint9:
	GOTO       L_actint5
L_actint6:
;code of traffic.c,31 :: 		while(!portb.b1 && portb.b0)
L_actint10:
	BTFSC      PORTB+0, 1
	GOTO       L_actint11
	BTFSS      PORTB+0, 0
	GOTO       L_actint11
L__actint33:
;code of traffic.c,32 :: 		if( indicator == 2 )
	MOVF       _indicator+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_actint14
;code of traffic.c,34 :: 		portc.b2 = 0;portc.b1 = 1;
	BCF        PORTC+0, 2
	BSF        PORTC+0, 1
;code of traffic.c,35 :: 		delay_ms(3000);
	MOVLW      31
	MOVWF      R11+0
	MOVLW      113
	MOVWF      R12+0
	MOVLW      30
	MOVWF      R13+0
L_actint15:
	DECFSZ     R13+0, 1
	GOTO       L_actint15
	DECFSZ     R12+0, 1
	GOTO       L_actint15
	DECFSZ     R11+0, 1
	GOTO       L_actint15
	NOP
;code of traffic.c,36 :: 		portc.b1 = 0;
	BCF        PORTC+0, 1
;code of traffic.c,37 :: 		portc.b3 = 0;
	BCF        PORTC+0, 3
;code of traffic.c,38 :: 		intone();
	CALL       _intone+0
;code of traffic.c,39 :: 		indicator = 1;
	MOVLW      1
	MOVWF      _indicator+0
;code of traffic.c,40 :: 		}
L_actint14:
	GOTO       L_actint10
L_actint11:
;code of traffic.c,41 :: 		}
	GOTO       L_actint3
L_actint4:
;code of traffic.c,42 :: 		portc = 0;
	CLRF       PORTC+0
;code of traffic.c,43 :: 		porta = 15 ;
	MOVLW      15
	MOVWF      PORTA+0
;code of traffic.c,44 :: 		}
L_end_actint:
	RETURN
; end of _actint

_checkandint:

;code of traffic.c,45 :: 		void checkandint()
;code of traffic.c,47 :: 		for(i = 0 ; i < 5 ; i++)
	CLRF       _i+0
L_checkandint16:
	MOVLW      5
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_checkandint17
;code of traffic.c,49 :: 		delay_ms(200);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      8
	MOVWF      R12+0
	MOVLW      119
	MOVWF      R13+0
L_checkandint19:
	DECFSZ     R13+0, 1
	GOTO       L_checkandint19
	DECFSZ     R12+0, 1
	GOTO       L_checkandint19
	DECFSZ     R11+0, 1
	GOTO       L_checkandint19
;code of traffic.c,50 :: 		if(portb.b0 == 1)
	BTFSS      PORTB+0, 0
	GOTO       L_checkandint20
;code of traffic.c,52 :: 		actint();
	CALL       _actint+0
;code of traffic.c,53 :: 		return;
	GOTO       L_end_checkandint
;code of traffic.c,54 :: 		}
L_checkandint20:
;code of traffic.c,47 :: 		for(i = 0 ; i < 5 ; i++)
	INCF       _i+0, 1
;code of traffic.c,55 :: 		}
	GOTO       L_checkandint16
L_checkandint17:
;code of traffic.c,56 :: 		}
L_end_checkandint:
	RETURN
; end of _checkandint

_one:

;code of traffic.c,57 :: 		void one()
;code of traffic.c,59 :: 		for(x = 0; x < 23 ; x++)
	CLRF       _x+0
L_one21:
	MOVLW      23
	SUBWF      _x+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_one22
;code of traffic.c,60 :: 		{ portd = terms[x];
	MOVF       _x+0, 0
	ADDLW      _terms+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTD+0
;code of traffic.c,61 :: 		if(x < 19)
	MOVLW      19
	SUBWF      _x+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_one24
;code of traffic.c,63 :: 		portc.B5 = 1;
	BSF        PORTC+0, 5
;code of traffic.c,64 :: 		portc.b0 = 1;
	BSF        PORTC+0, 0
;code of traffic.c,65 :: 		}
L_one24:
;code of traffic.c,66 :: 		if(x >= 19)
	MOVLW      19
	SUBWF      _x+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_one25
;code of traffic.c,68 :: 		portc.B5 = 0;
	BCF        PORTC+0, 5
;code of traffic.c,69 :: 		portc.b4 = 1;
	BSF        PORTC+0, 4
;code of traffic.c,70 :: 		}
L_one25:
;code of traffic.c,71 :: 		checkandint();
	CALL       _checkandint+0
;code of traffic.c,59 :: 		for(x = 0; x < 23 ; x++)
	INCF       _x+0, 1
;code of traffic.c,72 :: 		}
	GOTO       L_one21
L_one22:
;code of traffic.c,73 :: 		}
L_end_one:
	RETURN
; end of _one

_second:

;code of traffic.c,74 :: 		void second ()
;code of traffic.c,76 :: 		for(x = 0 ; x <15 ; x++ )
	CLRF       _x+0
L_second26:
	MOVLW      15
	SUBWF      _x+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_second27
;code of traffic.c,77 :: 		{  portd = terms[x  + 8];
	MOVLW      8
	ADDWF      _x+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	ADDLW      _terms+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTD+0
;code of traffic.c,78 :: 		if(x < 3)
	MOVLW      3
	SUBWF      _x+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_second29
;code of traffic.c,80 :: 		portc.B1 = 1;
	BSF        PORTC+0, 1
;code of traffic.c,81 :: 		portc.b3 = 1;
	BSF        PORTC+0, 3
;code of traffic.c,82 :: 		}
L_second29:
;code of traffic.c,83 :: 		if(x >= 3)
	MOVLW      3
	SUBWF      _x+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_second30
;code of traffic.c,85 :: 		portc.B1 = 0;
	BCF        PORTC+0, 1
;code of traffic.c,86 :: 		portc.b2 = 1;
	BSF        PORTC+0, 2
;code of traffic.c,87 :: 		}
L_second30:
;code of traffic.c,88 :: 		checkandint();
	CALL       _checkandint+0
;code of traffic.c,76 :: 		for(x = 0 ; x <15 ; x++ )
	INCF       _x+0, 1
;code of traffic.c,89 :: 		}
	GOTO       L_second26
L_second27:
;code of traffic.c,90 :: 		}
L_end_second:
	RETURN
; end of _second

_operation:

;code of traffic.c,91 :: 		void operation()
;code of traffic.c,93 :: 		one();
	CALL       _one+0
;code of traffic.c,94 :: 		portc.b0 = 0;
	BCF        PORTC+0, 0
;code of traffic.c,95 :: 		portc.b4 = 0;
	BCF        PORTC+0, 4
;code of traffic.c,96 :: 		portc.b5 = 0;
	BCF        PORTC+0, 5
;code of traffic.c,97 :: 		second();
	CALL       _second+0
;code of traffic.c,98 :: 		portc.b3 = 0;
	BCF        PORTC+0, 3
;code of traffic.c,99 :: 		portc.b2 = 0;
	BCF        PORTC+0, 2
;code of traffic.c,100 :: 		portc.b1 = 0;
	BCF        PORTC+0, 1
;code of traffic.c,101 :: 		}
L_end_operation:
	RETURN
; end of _operation

_main:

;code of traffic.c,102 :: 		void main() {
;code of traffic.c,104 :: 		ADCON0 = 1;
	MOVLW      1
	MOVWF      ADCON0+0
;code of traffic.c,105 :: 		trisc = 0;
	CLRF       TRISC+0
;code of traffic.c,106 :: 		portc = 0;
	CLRF       PORTC+0
;code of traffic.c,107 :: 		trisd = 0;
	CLRF       TRISD+0
;code of traffic.c,108 :: 		portd = 0;
	CLRF       PORTD+0
;code of traffic.c,109 :: 		trisa = 0;
	CLRF       TRISA+0
;code of traffic.c,110 :: 		porta = 15;
	MOVLW      15
	MOVWF      PORTA+0
;code of traffic.c,111 :: 		trisb = 2;
	MOVLW      2
	MOVWF      TRISB+0
;code of traffic.c,112 :: 		while(1)
L_main31:
;code of traffic.c,114 :: 		operation();
	CALL       _operation+0
;code of traffic.c,115 :: 		}
	GOTO       L_main31
;code of traffic.c,116 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
