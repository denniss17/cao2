/ microstore
ORG 0
10000001000000100101010010100000000000000 / Read an ARC instruction from main meory
00000000000000000000000010111100000000000 / 256-way jump according to opcode
/ sethi
ORG 1152
10010100000000000000100101011011111111111 / Copy imm22 field to target register -> goto 2047
/ CALL
ORG 1280
10000001000000011111000010100000000000000 / Save %pc in %r31
/ next two lines are replaced, exercise 5.8
/10010101001010100001000100000000000000000 / Shift disp30 field left
/10000101000010100001000100000000000000000 / Shift again
10010100000000100001000100100000000000000 / R[temp0] ,- LSHIFT(R[ir])
/ end replacement
10000001000010100000000100000000000000000 / Jump to subroutine
10011000000000100110000110111000000000000 / Add 1 to %38 (cwp) -> goto 0
ORG 1600
/ ADDCC
00000000000000000000000010110111001000010 / Is second source operand immediate? then goto 1602
00000010000001000000100001111011111111111 / Perform ADDCC on reigsrer/simm13  -> goto 2047
10010100000000100001000110000000000000000 / Get sign extended simm13 field
00000011000010000000100001111011111111111 / Perform ADDCC on register.simm13 sources -> goto 2047
/ ANDCC
00000000000000000000000010110111001000110 / Is second operand immediate? then goto 1606
00000010000001000000100000011011111111111 / Perform ANDCC on register sources -> goto 2047
10010100000000100001000101100000000000000 / Get simm13 field
00000011000010000000100000011011111111111 / Perform ANDCC on register/simm13 sources -> goto 2047
/ ORCC
00000000000000000000000010110111001001010 / Is second operand immediate? then goto 1610
00000010000001000000100000111011111111111 / Perform ORCC on register sources -> goto 2047
10010100000000100001000101100000000000000 / Get simm13 field
00000011000010000000100000111011111111111 / Perform ORCC on register/simm13 sources -> goto 2047
ORG 1624
/ ORNCC
00000000000000000000000010110111001011010 / Is second source operand immediate? then goto 1626
00000010000001000000100001011011111111111 / Perform ORNCC on register sources -> goto 2047
10010100000000100001000101100000000000000 / Get simm13 field
00000011000010000000100001011011111111111 / Perform ORNCC on register/simm13 sources -> goto 2047
ORG 1688
/ SRL
/ corrected line (jump condition should test on R[15]
/00000000000000000000000010100011010011010 / Is second source operand immediate? then goto 1690
00000000000000000000000010110111010011010 / Is second source operand immediate? then goto 1690
/ END changed line
00000010000001000000100010011011111111111 / Perform ORCC on register sources -> goto 2047
10010100000000100001000101100000000000000 / Get simm13 field
00000011000010000000100010011011111111111 / Perform SRL on register/simm13 sources -> goto 2047
ORG	 1760
/ JMPL
00000000000000100100000011100000000000000 / ORN %r0 %r0 %r36 (Write -1 in tmp3)
10011001001000100110000100000000000000000 / add tmp3 to CWP
00000000000000000000000010110111011100100 / Is second source operand immediate? then goto 1764
00000010000001100000000100011000000000000 / Perform ADD on register sources -> goto 0
10010100000000100001000110000000000000000 / Get sign extended simm13 field
00000011000010100000000100011000000000000 / Perform ADD on register/simm13 sources
ORG 1792
/ LD
00000010000001100001000100010111100000010 / Compute source address, if immediate then goto 1794
10000101000010000000110010111011111111111 / Place source address on A bus -> goto 2047
10010100000000100001000110000000000000000 / Get simm13 field for source address
00000011000010100001000100011011100000001 / Compute source address -> goto 1793
ORG 1808
/ ST
00000010000001100001000100010111100010010 / Compute destination address, if immediate then goto 1810
10010100000000100101000111111000000101000 / Move Rd field into position of rs2 by shifting to the right by 25 bits -> goto 40
ORG 40
10010100000000100101000111100000000000000 / shift right R[ir] over 5 positions
10010100000000100101000111100000000000000
10010100000000100101000111100000000000000
10010100000000100101000111100000000000000
10000100000001000000001010111011111111111 / shift right R[ir] over 5 postions, goto 2047
ORG 1810
10010100000000100001000110000000000000000 / Get simm13 field for destination address
00000011000010100001000100011011100010001 / Compute destination address -> goto 1809
ORG 1088
00000000000000000000000010111000000000010 / Decoding tree for branches
ORG 2
/ Branch instructions
10010100000000100001000101000000000000000 / Sign extend the 22 LSB's of %temp0
10000100000000100001000111100000000000000 / by shifting left 10 bits, then right 10
/ Jump to 30 and multiply temp0 with 4 (displacement address)
/10000100000000100001000111100000000000000 / bits. RSHIFT5 does sign extension
10000100000000100001000111111000000011110 / bits. RSHIFT5 does sign extension
/ END changed line
10010100000000100101000111100000000000000 / Move COND field to IR[13] by
10010100000000100101000111100000000000000 / applying RSHIFT5 three times. (The
10010100000000100101000111100000000000000 / sign extension is inconsequential.)
/ microaddress B is wrong is 100100 should be 100101
/10010101001000100101000100010100000001100 / Is it BA? then goto 12
/10010101001000100101000100010100000001101 / Is it not BE? then goto 13
/10010101001000100101000100001000000001100 / Execute BE
10010101001010100101000100010100000001100 / Is it BA? then goto 12
10010101001010100101000100010100000001101 / Is it not BE? then goto 13
10010101001010100101000100001000000001100 / Execute BE
/ END changed lines
00000000000000000000000010111011111111111 / Branch for BE not taken
10000001000010100000000100011000000000000 / Branch is taken
10010101001010100101000100010100000010000 / Is it BCS? the goto 16
00000000000000000000000010110000000001100 / Execute BCS
00000000000000000000000010111011111111111 / -> 2047
00000000000000000000000010110100000010011 / Is it BVS?
00000000000000000000000010100100000001100 / Execute BNEG
00000000000000000000000010111011111111111 / Branch for BNEG not taken
00000000000000000000000010101100000001100 / Execute BVS ->
00000000000000000000000010111011111111111 / Branch for BVS not taken -> 2047
/ added XORCC instruction; exercise 5-14
ORG 1612
10010100000000100001000101110111001001110 / R[temp0]<-SIMM13(R[IR]) IF R[13] THEN GOTO 1614
00000000000001100001000100000000000000000 / R[temp0] <- R[rs2]
00000010000000100010000100011000000010101 / R[temp1] <- R[rs1]  GOTO 21
ORG 21
00000001000010100011000011100000000000000 / R[temp2]<-ORN(R[0],R[temp0])
00000001000100100100000011100000000000000 / R[temp3]<-ORN(R[0],R[temp1])
10001001000110100010000010100000000000000 / R[temp1]<-AND(R[temp1], R[temp2])
10000101001000100011000010100000000000000 / R[temp2]<-AND(R[temp0], R[temp3])
10001001000110000000100000111011111111111 / ORCC(R[temp1],R[temp2]) GOTO 2047
/ END XORCC
ORG 2047
10000000000000100000000111011000000000000 / increment %pc and start over
ORG 30 multiply temp0 with 4 (displacement address)
10000101000010100001000100000000000000000 / temp0 < ADD(temp0,temp0)
10000101000010100001000100011000000000101 / temp0 < ADD(temp0,temp0, -> 5