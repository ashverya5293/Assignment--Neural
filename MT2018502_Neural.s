       ;MT2018502_Neural Network

  	AREA    appcode ,CODE,READONLY
	IMPORT printMsg
    EXPORT __main
    ENTRY
__main    FUNCTION
	MOV R2,#1; Counting Variable 'i'	
    MOV R3,#20; Holding the Number of Terms in Series 'n'
        
				
	VLDR.F32 S0,=1 ; Used to store the final sum of the exponent(e^x)  
	VLDR.F32 S1,=1; Temp variable to store intermediate multiplication result

	VLDR.F32 S6,=1; Temp variable to store the result of the factorial

	VLDR.F32 S4,=1; Storing constant 1 in reg s4

	MOV R10, #2	;Select the value according to the logic to be implemented.
	BAL switch_case
		
switch_case		; switch-case equivalent

	CMP R10,#0	;Go to logic AND  
	BEQ AND_logic

	CMP R10,#1	;Go to logic OR 
	BEQ OR_logic

	CMP R10,#2	;Go to logic NOT 
	BEQ NOT_logic

	CMP R10,#3	;Go to logic NAND 
	BEQ NAND_logic

	CMP R10,#4	;Go to logic NOR 
	BEQ NOR_logic

	CMP R10,#5      ;Go to logic XOR 
	BEQ XOR_logic

	CMP R10,#6	;Go to logic XNOR 
	BEQ XNOR_logic
	
AND_logic
	VLDR.F32 S7,=-0.1  ;Initializing values as per the data given in python file
	VLDR.F32 S8,=0.2
	VLDR.F32 S9,=0.2
	VLDR.F32 S10,=-0.2
	B compute
		
OR_logic
	VLDR.F32 S7,=-0.1  ;Initializing values as per the data given in python file
	VLDR.F32 S8,=0.7
	VLDR.F32 S9,=0.7
	VLDR.F32 S10,=-0.1
	B compute
		
NOT_logic
	VLDR.F32 S7,=0.5  ;Initializing values as per the data given in python file
	VLDR.F32 S8,=-0.7
	VLDR.F32 S9,=0
	VLDR.F32 S10,=0.1
	B compute
		
NAND_logic
	VLDR.F32 S7,=0.6  ;Initializing values as per the data given in python file
	VLDR.F32 S8,=-0.8
	VLDR.F32 S9,=-0.8
	VLDR.F32 S10,=0.3
	B compute
		
NOR_logic
	VLDR.F32 S7,=0.5  ;Initializing values as per the data given in python file
	VLDR.F32 S8,=-0.7
	VLDR.F32 S9,=-0.7
	VLDR.F32 S10,=0.1
	B compute
		
XOR_logic		
	VLDR.F32 S7,=-5  ;Initializing values as per the data given in python file
	VLDR.F32 S8,=20
	VLDR.F32 S9,=10
	VLDR.F32 S10,=1
	B compute

XNOR_logic
	VLDR.F32 S7,=-5  ;Initializing values as per the data given in python file
	VLDR.F32 S8,=20
	VLDR.F32 S9,=10
	VLDR.F32 S10,=1
	B compute  

compute	VLDR.F32 S16,=1
	VLDR.F32 S17,=0
	VLDR.F32 S18,=0

	VMUL.F32 S19,S7,S16;
	VMUL.F32 S20,S8,S17;
	VMUL.F32 S21,S9,S18;

	VADD.F32 S22,S19,S20
	VADD.F32 S22,S22,S21
	VADD.F32 S22,S22,S10      ;Final value of x is computed and stored in register S22
	VMOV.F32 S2, S22;
	B exp
				
exp   CMP R2,R3; 	Compare values of 'i' and 'n' 
      BLE loop; 	if i < n goto loop
      B sigmoid_func;		else goto sigmoid function
		
loop    VMUL.F32 S1,S1,S2; temp = temp*x
	VMOV.F32 S3,S1;
        VMOV.F32 S5,R2; 	Moving bitstream from register R2 to floating register S5
        VCVT.F32.U32 S5, S5;	Converting bitstream into floating point number
		
	VMUL.F32 S6,S6,S5;	Computing factorial and store result in S6
        VDIV.F32 S3,S3,S6;	Divide temp by factorial S6 and store it back in temp
        VADD.F32 S0,S0,S3;	Final exponential series result is stored in S0
		
        ADD R2,R2,#1;	Increment the counter variable 'i'
        B exp;	Again goto comparison

sigmoid_func
	VADD.F32 s14,s4,s0 ;	
	VDIV.F32 S15,S0,S14;
	
	VCVT.U32.F32 S15,S15
	VMOV.F32 R0,S15;
	BL printMsg;	 		
	
		
stop    B stop
        ENDFUNC
        END