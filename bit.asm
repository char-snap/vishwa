org 000h
mov r2,#0ffh
clr a
mov a,#0ffh
mov b,a
mul ab
mov r4,b
mov r5,a
mov b,#0ffh
mov a,r5 
mul ab
mov r6,b
mov r7,a
mov b, #0ffh
mov a, r4
mul ab
mov r4, b
mov r5,a
mov a,r6
mov b,r5
add a,b
jnc next
inc r4
next: mov 40h, r4
mov 41h,a
mov 42h,r7
end
