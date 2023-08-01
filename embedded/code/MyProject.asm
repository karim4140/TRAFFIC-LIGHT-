
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;MyProject.c,15 :: 		void interrupt()
;MyProject.c,16 :: 		{     if(intf_bit==1)
	BTFSS      INTF_bit+0, BitPos(INTF_bit+0)
	GOTO       L_interrupt0
;MyProject.c,17 :: 		{intf_bit=0;
	BCF        INTF_bit+0, BitPos(INTF_bit+0)
;MyProject.c,18 :: 		if(flag==99)
	MOVF       _flag+0, 0
	XORLW      99
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt1
;MyProject.c,19 :: 		flag=-1;
	MOVLW      255
	MOVWF      _flag+0
L_interrupt1:
;MyProject.c,20 :: 		flag++;
	INCF       _flag+0, 1
;MyProject.c,21 :: 		}}
L_interrupt0:
L_end_interrupt:
L__interrupt41:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;MyProject.c,22 :: 		void main()
;MyProject.c,23 :: 		{       switchA_MDir=1;
	BSF        TRISB+0, 0
;MyProject.c,24 :: 		gie_bit=1;
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;MyProject.c,25 :: 		inte_bit=1;
	BSF        INTE_bit+0, BitPos(INTE_bit+0)
;MyProject.c,26 :: 		intedg_bit=1;
	BSF        INTEDG_bit+0, BitPos(INTEDG_bit+0)
;MyProject.c,27 :: 		trafficDir=0b00000000;
	CLRF       TRISC+0
;MyProject.c,28 :: 		traffic=0b00000000;
	CLRF       PORTC+0
;MyProject.c,29 :: 		ssdDir=0b00000000;
	CLRF       TRISD+0
;MyProject.c,30 :: 		ssd=0b00000000;
	CLRF       PORTD+0
;MyProject.c,31 :: 		powerDir=0;
	BCF        TRISB+0, 2
;MyProject.c,32 :: 		power1Dir=0;
	BCF        TRISB+0, 3
;MyProject.c,33 :: 		while(1)
L_main2:
;MyProject.c,34 :: 		{    if(flag%2==0)
	MOVLW      1
	ANDWF      _flag+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main4
;MyProject.c,35 :: 		manualTraffic();
	CALL       _manualTraffic+0
	GOTO       L_main5
L_main4:
;MyProject.c,37 :: 		autoTraffic();
	CALL       _autoTraffic+0
L_main5:
;MyProject.c,38 :: 		}
	GOTO       L_main2
;MyProject.c,39 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_autoTraffic:

;MyProject.c,40 :: 		void autoTraffic()
;MyProject.c,42 :: 		int i=0;
	MOVLW      ?ICSautoTraffic_i_L0+0
	MOVWF      ___DoICPAddr+0
	MOVLW      hi_addr(?ICSautoTraffic_i_L0+0)
	MOVWF      ___DoICPAddr+1
	MOVLW      autoTraffic_i_L0+0
	MOVWF      FSR
	MOVLW      48
	MOVWF      R0+0
	CALL       ___CC2DW+0
;MyProject.c,44 :: 		power=1;
	BSF        PORTB+0, 2
;MyProject.c,45 :: 		power1=1;
	BSF        PORTB+0, 3
;MyProject.c,46 :: 		while(1)
L_autoTraffic6:
;MyProject.c,49 :: 		for(i=14;i>=0;i--)
	MOVLW      14
	MOVWF      autoTraffic_i_L0+0
	MOVLW      0
	MOVWF      autoTraffic_i_L0+1
L_autoTraffic8:
	MOVLW      128
	XORWF      autoTraffic_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__autoTraffic44
	MOVLW      0
	SUBWF      autoTraffic_i_L0+0, 0
L__autoTraffic44:
	BTFSS      STATUS+0, 0
	GOTO       L_autoTraffic9
;MyProject.c,50 :: 		{    if(flag%2==0) return;
	MOVLW      1
	ANDWF      _flag+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_autoTraffic11
	GOTO       L_end_autoTraffic
L_autoTraffic11:
;MyProject.c,51 :: 		ssd=num[i];
	MOVF       autoTraffic_i_L0+0, 0
	MOVWF      R0+0
	MOVF       autoTraffic_i_L0+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      autoTraffic_num_L0+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTD+0
;MyProject.c,52 :: 		if(i>11)
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      autoTraffic_i_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__autoTraffic45
	MOVF       autoTraffic_i_L0+0, 0
	SUBLW      11
L__autoTraffic45:
	BTFSC      STATUS+0, 0
	GOTO       L_autoTraffic12
;MyProject.c,53 :: 		traffic=0b010001;
	MOVLW      17
	MOVWF      PORTC+0
	GOTO       L_autoTraffic13
L_autoTraffic12:
;MyProject.c,55 :: 		traffic=0b100001;
	MOVLW      33
	MOVWF      PORTC+0
L_autoTraffic13:
;MyProject.c,56 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_autoTraffic14:
	DECFSZ     R13+0, 1
	GOTO       L_autoTraffic14
	DECFSZ     R12+0, 1
	GOTO       L_autoTraffic14
	DECFSZ     R11+0, 1
	GOTO       L_autoTraffic14
	NOP
	NOP
;MyProject.c,49 :: 		for(i=14;i>=0;i--)
	MOVLW      1
	SUBWF      autoTraffic_i_L0+0, 1
	BTFSS      STATUS+0, 0
	DECF       autoTraffic_i_L0+1, 1
;MyProject.c,57 :: 		}
	GOTO       L_autoTraffic8
L_autoTraffic9:
;MyProject.c,58 :: 		for(i=22;i>=0;i--)
	MOVLW      22
	MOVWF      autoTraffic_i_L0+0
	MOVLW      0
	MOVWF      autoTraffic_i_L0+1
L_autoTraffic15:
	MOVLW      128
	XORWF      autoTraffic_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__autoTraffic46
	MOVLW      0
	SUBWF      autoTraffic_i_L0+0, 0
L__autoTraffic46:
	BTFSS      STATUS+0, 0
	GOTO       L_autoTraffic16
;MyProject.c,59 :: 		{     if(flag%2==0) return;
	MOVLW      1
	ANDWF      _flag+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_autoTraffic18
	GOTO       L_end_autoTraffic
L_autoTraffic18:
;MyProject.c,60 :: 		ssd=num[i];
	MOVF       autoTraffic_i_L0+0, 0
	MOVWF      R0+0
	MOVF       autoTraffic_i_L0+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      autoTraffic_num_L0+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTD+0
;MyProject.c,61 :: 		if(i>19)
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      autoTraffic_i_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__autoTraffic47
	MOVF       autoTraffic_i_L0+0, 0
	SUBLW      19
L__autoTraffic47:
	BTFSC      STATUS+0, 0
	GOTO       L_autoTraffic19
;MyProject.c,62 :: 		traffic=0b001010;
	MOVLW      10
	MOVWF      PORTC+0
	GOTO       L_autoTraffic20
L_autoTraffic19:
;MyProject.c,64 :: 		traffic=0b001100;
	MOVLW      12
	MOVWF      PORTC+0
L_autoTraffic20:
;MyProject.c,65 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_autoTraffic21:
	DECFSZ     R13+0, 1
	GOTO       L_autoTraffic21
	DECFSZ     R12+0, 1
	GOTO       L_autoTraffic21
	DECFSZ     R11+0, 1
	GOTO       L_autoTraffic21
	NOP
	NOP
;MyProject.c,58 :: 		for(i=22;i>=0;i--)
	MOVLW      1
	SUBWF      autoTraffic_i_L0+0, 1
	BTFSS      STATUS+0, 0
	DECF       autoTraffic_i_L0+1, 1
;MyProject.c,66 :: 		}
	GOTO       L_autoTraffic15
L_autoTraffic16:
;MyProject.c,67 :: 		}
	GOTO       L_autoTraffic6
;MyProject.c,68 :: 		}
L_end_autoTraffic:
	RETURN
; end of _autoTraffic

_manualTraffic:

;MyProject.c,69 :: 		void manualTraffic()
;MyProject.c,71 :: 		int i=0;
	MOVLW      ?ICSmanualTraffic_i_L0+0
	MOVWF      ___DoICPAddr+0
	MOVLW      hi_addr(?ICSmanualTraffic_i_L0+0)
	MOVWF      ___DoICPAddr+1
	MOVLW      manualTraffic_i_L0+0
	MOVWF      FSR
	MOVLW      48
	MOVWF      R0+0
	CALL       ___CC2DW+0
;MyProject.c,73 :: 		switchManualModeDir=1;
	BSF        TRISB+0, 1
;MyProject.c,74 :: 		power=0;
	BCF        PORTB+0, 2
;MyProject.c,75 :: 		power1=0;
	BCF        PORTB+0, 3
;MyProject.c,76 :: 		while(1)
L_manualTraffic22:
;MyProject.c,77 :: 		{        for(i=2;i>=0;i--)
	MOVLW      2
	MOVWF      manualTraffic_i_L0+0
	MOVLW      0
	MOVWF      manualTraffic_i_L0+1
L_manualTraffic24:
	MOVLW      128
	XORWF      manualTraffic_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__manualTraffic49
	MOVLW      0
	SUBWF      manualTraffic_i_L0+0, 0
L__manualTraffic49:
	BTFSS      STATUS+0, 0
	GOTO       L_manualTraffic25
;MyProject.c,78 :: 		{      if(flag%2==1) return;
	MOVLW      1
	ANDWF      _flag+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_manualTraffic27
	GOTO       L_end_manualTraffic
L_manualTraffic27:
;MyProject.c,79 :: 		power1=1;
	BSF        PORTB+0, 3
;MyProject.c,80 :: 		ssd=num[i];
	MOVF       manualTraffic_i_L0+0, 0
	MOVWF      R0+0
	MOVF       manualTraffic_i_L0+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      manualTraffic_num_L0+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTD+0
;MyProject.c,81 :: 		traffic=0b010001;
	MOVLW      17
	MOVWF      PORTC+0
;MyProject.c,82 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_manualTraffic28:
	DECFSZ     R13+0, 1
	GOTO       L_manualTraffic28
	DECFSZ     R12+0, 1
	GOTO       L_manualTraffic28
	DECFSZ     R11+0, 1
	GOTO       L_manualTraffic28
	NOP
	NOP
;MyProject.c,77 :: 		{        for(i=2;i>=0;i--)
	MOVLW      1
	SUBWF      manualTraffic_i_L0+0, 1
	BTFSS      STATUS+0, 0
	DECF       manualTraffic_i_L0+1, 1
;MyProject.c,83 :: 		}    power1=0;
	GOTO       L_manualTraffic24
L_manualTraffic25:
	BCF        PORTB+0, 3
;MyProject.c,84 :: 		traffic=0b100001;
	MOVLW      33
	MOVWF      PORTC+0
;MyProject.c,85 :: 		while(switchManualMode!=1){if(flag%2==1) return;}
L_manualTraffic29:
	BTFSC      PORTB+0, 1
	GOTO       L_manualTraffic30
	MOVLW      1
	ANDWF      _flag+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_manualTraffic31
	GOTO       L_end_manualTraffic
L_manualTraffic31:
	GOTO       L_manualTraffic29
L_manualTraffic30:
;MyProject.c,86 :: 		for(i=2;i>=0;i--)
	MOVLW      2
	MOVWF      manualTraffic_i_L0+0
	MOVLW      0
	MOVWF      manualTraffic_i_L0+1
L_manualTraffic32:
	MOVLW      128
	XORWF      manualTraffic_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__manualTraffic50
	MOVLW      0
	SUBWF      manualTraffic_i_L0+0, 0
L__manualTraffic50:
	BTFSS      STATUS+0, 0
	GOTO       L_manualTraffic33
;MyProject.c,87 :: 		{    if(flag%2==1) return;
	MOVLW      1
	ANDWF      _flag+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_manualTraffic35
	GOTO       L_end_manualTraffic
L_manualTraffic35:
;MyProject.c,88 :: 		power=1;
	BSF        PORTB+0, 2
;MyProject.c,89 :: 		ssd=num[i];
	MOVF       manualTraffic_i_L0+0, 0
	MOVWF      R0+0
	MOVF       manualTraffic_i_L0+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      manualTraffic_num_L0+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTD+0
;MyProject.c,90 :: 		traffic=0b001010;
	MOVLW      10
	MOVWF      PORTC+0
;MyProject.c,91 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_manualTraffic36:
	DECFSZ     R13+0, 1
	GOTO       L_manualTraffic36
	DECFSZ     R12+0, 1
	GOTO       L_manualTraffic36
	DECFSZ     R11+0, 1
	GOTO       L_manualTraffic36
	NOP
	NOP
;MyProject.c,86 :: 		for(i=2;i>=0;i--)
	MOVLW      1
	SUBWF      manualTraffic_i_L0+0, 1
	BTFSS      STATUS+0, 0
	DECF       manualTraffic_i_L0+1, 1
;MyProject.c,92 :: 		}    power=0;
	GOTO       L_manualTraffic32
L_manualTraffic33:
	BCF        PORTB+0, 2
;MyProject.c,93 :: 		traffic=0b001100;
	MOVLW      12
	MOVWF      PORTC+0
;MyProject.c,94 :: 		while(switchManualMode!=1){if(flag%2==1) return;};
L_manualTraffic37:
	BTFSC      PORTB+0, 1
	GOTO       L_manualTraffic38
	MOVLW      1
	ANDWF      _flag+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_manualTraffic39
	GOTO       L_end_manualTraffic
L_manualTraffic39:
	GOTO       L_manualTraffic37
L_manualTraffic38:
;MyProject.c,95 :: 		}
	GOTO       L_manualTraffic22
;MyProject.c,96 :: 		}
L_end_manualTraffic:
	RETURN
; end of _manualTraffic
