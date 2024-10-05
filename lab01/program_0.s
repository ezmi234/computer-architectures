; Architetture dei Sistemi di Elaborazione - 02LSEOV 02LSEOQ	 ;
; author: 		Ezmiron Deniku - Politecnico di Torino 
; lab1
; flag1 -> 1 if empty, 0 if not
; flag2 -> 1 if not empty and ascent order
; flag3 -> 1 if not empty and discent order
        
    .data
v1:     .byte 2, 6, -3, 11, 9, 18, -13, 16, 5, 1
v2:     .byte 4, 2, 13, 3, 9, 9, 7, 16, 4, 7
v3:     .space 10    
flag1:  .byte 0
flag2:  .byte 1
flag3:  .byte 1

		.text
main: 
    xor r1,r1,r1
    xor r5,r5,r5                        ; index of v3
    daddui r3,r0,10
    daddui r10,r0,1

outer_loop:
    lb r15,v1(r1)
    xor r2,r2,r2

inner_loop:
    lb r16,v2(r2)

    bne r15,r16, false
    xor r6,r6,r6                        ; check if already in array
check_element:
    beq r6,r5, add_element
    lb r17,v3(r6)
    beq r17,r16, false
    daddui r6,r6,1
    j check_element
add_element:
    beq r5,r0, first_item
    daddui r4,r5,-1
    lb r17,v3(r4)

    slt r20,r17,r16
    beq r20,r0, check1 
    sb r0,flag3(r0)
check1:
    slt r20,r16,r17
    beq r20,r0, first_item
    sb r0,flag2(r0)
first_item:
    sb r16,v3(r5) 
    daddui r5,r5,1
false:
    daddui r2,r2,1
    bne r2,r3, inner_loop
    
    daddui r1,r1,1
    bne r1,r3, outer_loop

    beqz r5, pre_fine
    sb r10,flag1(r0)
    j fine
pre_fine:
    sb r0,flag2(r0)
    sb r0,flag3(r0)

fine:

  	halt
