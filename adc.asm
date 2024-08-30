 org 0000h
 EOC EQU P0.4 ; End Of Conversion pin
START_ALE EQU P0.7 
 mov p1,#0ffh
 repeat:mov dptr,#command
 nextcmd:clr a
 movc a,@a+dptr
 cjne a,#'$',next1
 sjmp data1
 next1:acall cmdwrite
 acall delay
 inc dptr
 sjmp nextcmd
 data1:mov dptr,#datalcd
 nextdata:clr a
 movc a,@a+dptr
 cjne a,#'$',next2
 ;adcroutine
 complete: mov a,#0C4h 
acall cmdwrite
acall delay
 MOV P0, #0F0H
 
 ; Start ADC conversion
 CLR START_ALE
 ACALL delay
 SETB START_ALE
 ACALL delay
 CLR START_ALE
 
 ; Wait for End Of Conversion
WAIT_EOC:
 MOV A, P0
 ANL A, #0x10
 JZ WAIT_EOC
 
WAIT_EOC_LOW:
 MOV A, P0
 ANL A, #0x10
 JZ WAIT_EOC_LOW
mov a,p1
mov r1,a
anl a,#0Fh
acall convert
mov a,r1
anl a,#0f0h
swap a
acall convert
sjmp complete
 sjmp $
 next2:acall datawrite
 acall delay
 inc dptr
 sjmp nextdata
 cmdwrite:mov b,a
 anl a,#0f0h
 swap a
 mov p2,a
 clr p2.7
 clr p2.5
 setb p2.6
 nop 
 nop
 nop
 nop
 clr p2.6
 mov a,b
 anl a,#0fh
 mov p2,a
 clr p2.7
 clr p2.5
 setb p2.6
 nop
 nop
 nop
 nop
 clr p2.6
 ret
 datawrite:mov b,a
 anl a,#0f0h
 swap a
 mov p2,a
 setb p2.7
 clr p2.5
 setb p2.6
 nop
 nop
 nop
 nop
 clr p2.6
 mov a,b
 anl a,#0fh
 mov p2,a
 setb p2.7
 clr p2.5
 setb p2.6
 nop
 nop
 nop
 nop
 clr p2.6
 ret
 delay:mov r0,#0f0h
 loop2:mov r1,#0f0h
 loop1:djnz r1,loop1
 djnz r0,loop2
 ret
 convert: cjne a,#0ah,next
next: jc skip
add a,#07h
skip: add a,#30h
acall datawrite
acall delay
ret
 org 200h
 command:db 02h,28h,0eh,01h,06h,80h,'$'
 datalcd:db 'a','d','c','o','p',':','$'
 end