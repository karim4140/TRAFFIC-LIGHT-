
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;MyProject.c,19 :: 		void interrupt(){
;MyProject.c,20 :: 		if(intf_bit == 1){
	BTFSS      INTF_bit+0, BitPos(INTF_bit+0)
	GOTO       L_interrupt0
;MyProject.c,21 :: 		intf_bit = 0;
	BCF        INTF_bit+0, BitPos(INTF_bit+0)
;MyProject.c,22 :: 		if(counter == 2){counter = 0;}
	MOVF       _counter+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt1
	CLRF       _counter+0
L_interrupt1:
;MyProject.c,23 :: 		counter++;}}
	INCF       _counter+0, 1
L_interrupt0:
L_end_interrupt:
L__interrupt47:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;MyProject.c,24 :: 		void main() {
;MyProject.c,25 :: 		gie_bit = 1;
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;MyProject.c,26 :: 		inte_bit = 1;
	BSF        INTE_bit+0, BitPos(INTE_bit+0)
;MyProject.c,27 :: 		intedg_bit = 1;
	BSF        INTEDG_bit+0, BitPos(INTEDG_bit+0)
;MyProject.c,28 :: 		trisd = 0;trisb.b0 = trisb.b1 = 1;trisc = 0;
	CLRF       TRISD+0
	BSF        TRISB+0, 1
	BTFSC      TRISB+0, 1
	GOTO       L__main49
	BCF        TRISB+0, 0
	GOTO       L__main50
L__main49:
	BSF        TRISB+0, 0
L__main50:
	CLRF       TRISC+0
;MyProject.c,29 :: 		portd = 0b00000000; portc = 0;
	CLRF       PORTD+0
	CLRF       PORTC+0
;MyProject.c,30 :: 		while(1){
L_main2:
;MyProject.c,31 :: 		if(!(counter == 2)){
	MOVF       _counter+0, 0
	XORLW      2
	BTFSC      STATUS+0, 2
	GOTO       L_main4
;MyProject.c,32 :: 		automatic();
	CALL       _automatic+0
;MyProject.c,33 :: 		}else{
	GOTO       L_main5
L_main4:
;MyProject.c,34 :: 		manual();}}
	CALL       _manual+0
L_main5:
	GOTO       L_main2
;MyProject.c,35 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_automatic:

;MyProject.c,36 :: 		void automatic(){
;MyProject.c,37 :: 		portd = 0;
	CLRF       PORTD+0
;MyProject.c,38 :: 		on1  = on2 = 1;
	BSF        PORTD+0, 7
	BTFSC      PORTD+0, 7
	GOTO       L__automatic52
	BCF        PORTD+0, 3
	GOTO       L__automatic53
L__automatic52:
	BSF        PORTD+0, 3
L__automatic53:
;MyProject.c,39 :: 		while(1){
L_automatic6:
;MyProject.c,40 :: 		for(i=0;i<20;i++){
	CLRF       _i+0
	CLRF       _i+1
L_automatic8:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__automatic54
	MOVLW      20
	SUBWF      _i+0, 0
L__automatic54:
	BTFSC      STATUS+0, 0
	GOTO       L_automatic9
;MyProject.c,41 :: 		if(counter == 2) return;
	MOVF       _counter+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_automatic11
	GOTO       L_end_automatic
L_automatic11:
;MyProject.c,42 :: 		portc = arr[i];
	MOVF       _i+0, 0
	MOVWF      R0+0
	MOVF       _i+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _arr+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;MyProject.c,43 :: 		gre1 = red2 = 1;
	BSF        PORTD+0, 6
	BTFSC      PORTD+0, 6
	GOTO       L__automatic55
	BCF        PORTD+0, 0
	GOTO       L__automatic56
L__automatic55:
	BSF        PORTD+0, 0
L__automatic56:
;MyProject.c,44 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_automatic12:
	DECFSZ     R13+0, 1
	GOTO       L_automatic12
	DECFSZ     R12+0, 1
	GOTO       L_automatic12
	DECFSZ     R11+0, 1
	GOTO       L_automatic12
	NOP
	NOP
;MyProject.c,40 :: 		for(i=0;i<20;i++){
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;MyProject.c,45 :: 		}
	GOTO       L_automatic8
L_automatic9:
;MyProject.c,46 :: 		portc = 0;
	CLRF       PORTC+0
;MyProject.c,47 :: 		for(i=1;i<4;i++){
	MOVLW      1
	MOVWF      _i+0
	MOVLW      0
	MOVWF      _i+1
L_automatic13:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__automatic57
	MOVLW      4
	SUBWF      _i+0, 0
L__automatic57:
	BTFSC      STATUS+0, 0
	GOTO       L_automatic14
;MyProject.c,48 :: 		if(counter == 2) return;
	MOVF       _counter+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_automatic16
	GOTO       L_end_automatic
L_automatic16:
;MyProject.c,49 :: 		gre1 = 0;yel1 = 1;
	BCF        PORTD+0, 0
	BSF        PORTD+0, 1
;MyProject.c,50 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_automatic17:
	DECFSZ     R13+0, 1
	GOTO       L_automatic17
	DECFSZ     R12+0, 1
	GOTO       L_automatic17
	DECFSZ     R11+0, 1
	GOTO       L_automatic17
	NOP
	NOP
;MyProject.c,51 :: 		portc = arr[i];
	MOVF       _i+0, 0
	MOVWF      R0+0
	MOVF       _i+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _arr+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;MyProject.c,47 :: 		for(i=1;i<4;i++){
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;MyProject.c,52 :: 		}
	GOTO       L_automatic13
L_automatic14:
;MyProject.c,53 :: 		portc = 0;
	CLRF       PORTC+0
;MyProject.c,54 :: 		for(i=0;i<12;i++){
	CLRF       _i+0
	CLRF       _i+1
L_automatic18:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__automatic58
	MOVLW      12
	SUBWF      _i+0, 0
L__automatic58:
	BTFSC      STATUS+0, 0
	GOTO       L_automatic19
;MyProject.c,55 :: 		if(counter == 2) return;
	MOVF       _counter+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_automatic21
	GOTO       L_end_automatic
L_automatic21:
;MyProject.c,56 :: 		red2 = yel1 = 0;red1 = gre2 = 1;
	BCF        PORTD+0, 1
	BTFSC      PORTD+0, 1
	GOTO       L__automatic59
	BCF        PORTD+0, 6
	GOTO       L__automatic60
L__automatic59:
	BSF        PORTD+0, 6
L__automatic60:
	BSF        PORTD+0, 4
	BTFSC      PORTD+0, 4
	GOTO       L__automatic61
	BCF        PORTD+0, 2
	GOTO       L__automatic62
L__automatic61:
	BSF        PORTD+0, 2
L__automatic62:
;MyProject.c,57 :: 		portc = arr[i];
	MOVF       _i+0, 0
	MOVWF      R0+0
	MOVF       _i+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _arr+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;MyProject.c,58 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_automatic22:
	DECFSZ     R13+0, 1
	GOTO       L_automatic22
	DECFSZ     R12+0, 1
	GOTO       L_automatic22
	DECFSZ     R11+0, 1
	GOTO       L_automatic22
	NOP
	NOP
;MyProject.c,54 :: 		for(i=0;i<12;i++){
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;MyProject.c,59 :: 		}
	GOTO       L_automatic18
L_automatic19:
;MyProject.c,60 :: 		portc = 0;
	CLRF       PORTC+0
;MyProject.c,61 :: 		yel2 = 1;gre2 = 0;
	BSF        PORTD+0, 5
	BCF        PORTD+0, 4
;MyProject.c,62 :: 		for(i=1;i<4;i++){
	MOVLW      1
	MOVWF      _i+0
	MOVLW      0
	MOVWF      _i+1
L_automatic23:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__automatic63
	MOVLW      4
	SUBWF      _i+0, 0
L__automatic63:
	BTFSC      STATUS+0, 0
	GOTO       L_automatic24
;MyProject.c,63 :: 		if(counter == 2) return;
	MOVF       _counter+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_automatic26
	GOTO       L_end_automatic
L_automatic26:
;MyProject.c,64 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_automatic27:
	DECFSZ     R13+0, 1
	GOTO       L_automatic27
	DECFSZ     R12+0, 1
	GOTO       L_automatic27
	DECFSZ     R11+0, 1
	GOTO       L_automatic27
	NOP
	NOP
;MyProject.c,65 :: 		portc = arr[i];
	MOVF       _i+0, 0
	MOVWF      R0+0
	MOVF       _i+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _arr+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;MyProject.c,62 :: 		for(i=1;i<4;i++){
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;MyProject.c,66 :: 		}
	GOTO       L_automatic23
L_automatic24:
;MyProject.c,67 :: 		yel2 = red1 = 0;
	BCF        PORTD+0, 2
	BTFSC      PORTD+0, 2
	GOTO       L__automatic64
	BCF        PORTD+0, 5
	GOTO       L__automatic65
L__automatic64:
	BSF        PORTD+0, 5
L__automatic65:
;MyProject.c,68 :: 		}}
	GOTO       L_automatic6
L_end_automatic:
	RETURN
; end of _automatic

_manual:

;MyProject.c,69 :: 		void manual(){
;MyProject.c,70 :: 		portd = 0;
	CLRF       PORTD+0
;MyProject.c,71 :: 		while(1)
L_manual28:
;MyProject.c,73 :: 		for(i=0;i<3;i++)
	CLRF       _i+0
	CLRF       _i+1
L_manual30:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__manual67
	MOVLW      3
	SUBWF      _i+0, 0
L__manual67:
	BTFSC      STATUS+0, 0
	GOTO       L_manual31
;MyProject.c,74 :: 		{     if(counter == 1) return;
	MOVF       _counter+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_manual33
	GOTO       L_end_manual
L_manual33:
;MyProject.c,75 :: 		on1 = 1;
	BSF        PORTD+0, 3
;MyProject.c,76 :: 		portc = arr[i];
	MOVF       _i+0, 0
	MOVWF      R0+0
	MOVF       _i+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _arr+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;MyProject.c,77 :: 		gre1 = red2 = 0;yel1 = gre2 = 1;
	BCF        PORTD+0, 6
	BTFSC      PORTD+0, 6
	GOTO       L__manual68
	BCF        PORTD+0, 0
	GOTO       L__manual69
L__manual68:
	BSF        PORTD+0, 0
L__manual69:
	BSF        PORTD+0, 4
	BTFSC      PORTD+0, 4
	GOTO       L__manual70
	BCF        PORTD+0, 1
	GOTO       L__manual71
L__manual70:
	BSF        PORTD+0, 1
L__manual71:
;MyProject.c,78 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_manual34:
	DECFSZ     R13+0, 1
	GOTO       L_manual34
	DECFSZ     R12+0, 1
	GOTO       L_manual34
	DECFSZ     R11+0, 1
	GOTO       L_manual34
	NOP
	NOP
;MyProject.c,73 :: 		for(i=0;i<3;i++)
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;MyProject.c,79 :: 		}     on1 = 0;
	GOTO       L_manual30
L_manual31:
	BCF        PORTD+0, 3
;MyProject.c,80 :: 		yel1 = 0;red1 =1;
	BCF        PORTD+0, 1
	BSF        PORTD+0, 2
;MyProject.c,81 :: 		while(manmode == 0){if(counter == 1) return;};
L_manual35:
	BTFSC      PORTB+0, 1
	GOTO       L_manual36
	MOVF       _counter+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_manual37
	GOTO       L_end_manual
L_manual37:
	GOTO       L_manual35
L_manual36:
;MyProject.c,82 :: 		for(i=0;i<3;i++)
	CLRF       _i+0
	CLRF       _i+1
L_manual38:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__manual72
	MOVLW      3
	SUBWF      _i+0, 0
L__manual72:
	BTFSC      STATUS+0, 0
	GOTO       L_manual39
;MyProject.c,83 :: 		{    if(counter == 1) return;
	MOVF       _counter+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_manual41
	GOTO       L_end_manual
L_manual41:
;MyProject.c,84 :: 		on2 = 1;
	BSF        PORTD+0, 7
;MyProject.c,85 :: 		portc = arr[i];
	MOVF       _i+0, 0
	MOVWF      R0+0
	MOVF       _i+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _arr+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;MyProject.c,86 :: 		gre2 = red1 = 0;yel2 = gre1 = 1;
	BCF        PORTD+0, 2
	BTFSC      PORTD+0, 2
	GOTO       L__manual73
	BCF        PORTD+0, 4
	GOTO       L__manual74
L__manual73:
	BSF        PORTD+0, 4
L__manual74:
	BSF        PORTD+0, 0
	BTFSC      PORTD+0, 0
	GOTO       L__manual75
	BCF        PORTD+0, 5
	GOTO       L__manual76
L__manual75:
	BSF        PORTD+0, 5
L__manual76:
;MyProject.c,87 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_manual42:
	DECFSZ     R13+0, 1
	GOTO       L_manual42
	DECFSZ     R12+0, 1
	GOTO       L_manual42
	DECFSZ     R11+0, 1
	GOTO       L_manual42
	NOP
	NOP
;MyProject.c,82 :: 		for(i=0;i<3;i++)
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;MyProject.c,88 :: 		}    on2 = 0;
	GOTO       L_manual38
L_manual39:
	BCF        PORTD+0, 7
;MyProject.c,89 :: 		yel2 = 0;red2 = 1;
	BCF        PORTD+0, 5
	BSF        PORTD+0, 6
;MyProject.c,90 :: 		while(manmode == 0){if(counter == 1) return;};
L_manual43:
	BTFSC      PORTB+0, 1
	GOTO       L_manual44
	MOVF       _counter+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_manual45
	GOTO       L_end_manual
L_manual45:
	GOTO       L_manual43
L_manual44:
;MyProject.c,91 :: 		}
	GOTO       L_manual28
;MyProject.c,92 :: 		}
L_end_manual:
	RETURN
; end of _manual
