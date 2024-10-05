
    .data
v1:      .space 10


    .text
main:
    daddui r1,r0,5
    sb r1,v1(r0)
    andi r2,r1,0xFFFFFFFF
    sb r1,v1(r0)
    


    halt
