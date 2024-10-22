; Architetture dei Sistemi di Elaborazione - 02LSEOV 02LSEOQ	 ;
; author: 		Ezmiron Deniku - Politecnico di Torino 
; lab3
;
    .data
v1: .double 0.99783045, 0.00017023, 0.16671799, 0.0709082, 0.61242463, 0.42469133, 0.17273317, 0.73215372
    .double  0.62463407, 0.33296767, 0.70504857, 0.57059103, 0.74400094, 0.99591749, 0.60278553, 0.17190698
    .double 0.23427507, 0.54117202, 0.1869301, 0.08358128, 0.13213843, 0.89589847, 0.36772047, 0.91563748
    .double 0.8501072, 0.19525894, 0.19471852, 0.91940434, 0.02093211, 0.58199388, 0.42387424, 0.65274575

v2: .double 0.93657084, 0.07329205, 0.88915362, 0.16017189, 0.92359751, 0.81946783, 0.88028619, 0.34575858
    .double 0.6448122 , 0.39555511, 0.95773851, 0.81071946, 0.07811275, 0.18278347, 0.08607937, 0.08333185
    .double 0.94995279, 0.04145172, 0.48132502, 0.06408964, 0.67500968, 0.93156939, 0.07293358, 0.61116231
    .double 0.06100373, 0.86044989, 0.86806543, 0.3689608 , 0.62703852, 0.93207843, 0.23120963, 0.36967262

v3: .double 0.22298433, 0.71482593, 0.38926414, 0.40607433, 0.31468457, 0.01004551, 0.67125849, 0.80362581
    .double 0.09653675, 0.56257223, 0.04907831, 0.93897501, 0.00846443, 0.62413321, 0.22727698, 0.7578525 
    .double 0.04966427, 0.14349547, 0.02001605, 0.91046863, 0.92730684, 0.49839908, 0.37016745, 0.13606532
    .double 0.77308048, 0.62438734, 0.57767142, 0.14256951, 0.40664215, 0.85480691, 0.37757982, 0.17110586

v4: .space  256
v5: .space  256
v6: .space  256

m:  .word   1
a:  .space  8
b:  .space  8


    .text
main:
    daddui  r1,r0,256       ; address of the last element
    daddui  r2,r0,32        ; decrement to move to the previous element (each value is 8 bytes)
    daddui  r3,r0,3
    ld      r11,m(r0)       ; load m in r11
    l.d     f10,b(r0)       ; load b in f10
    l.d     f8,a(r0)        ; load a in f8

loop:
    daddi   r1,r1,-8
    daddi   r2,r2,-1
    ddiv    r4,r2,r3        ; check if the index is divisible by 3
    dmul    r4,r4,r3        ; recalculate the index with the division result
    l.d     f1,v1(r1)
    bne     r4,r2,else      ; if it is not divisible by 3, jump to 'else'

    dsllv   r11,r11,r2      ; shift m left by i
    mtc1    r11,f7
    cvt.d.l f7,f7
    div.d   f8,f1,f7        ; a = v1[i] / ((double)m << i)
    j       then
else:
    dmul    r11,r11,r2
    mtc1    r11,f7
    cvt.d.l f7,f7
    mul.d   f8,f1,f7        ; a = v1[i] * ((double)m * i)
then:
    cvt.l.d f9,f8
    mfc1    r11,f9          ; m = (int) a

    l.d     f2,v2(r1)
    l.d     f3,v3(r1)
    mul.d   f4,f8,f1
    sub.d   f4,f4,f2        ; v4[i] = a * v1[i] - v2[i]
    div.d   f5,f4,f3
    sub.d   f5,f5,f10       ; v5[i] = v4[i] / v3[i] - b
    sub.d   f6,f4,f1
    mul.d   f6,f6,f5        ; v6[i] = (v4[i] - v1[i]) * v5[i]
    s.d     f4,v4(r1)
    s.d     f5,v5(r1)
    s.d     f6,v6(r1)
    bnez    r2,loop
    halt
