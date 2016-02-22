.data

.balign 4
message1: .asciz "factorial\n"

.balign 4
message2: .asciz "number: "

.balign 4
scan_pattern: .asciz "%d"

.balign 4
input: .word 0

.balign 4
message3: .asciz "fact(%d)=%d\n"

.balign 4
result: .word 0

.balign 4
return: .word 0


.text

.global main
main:
	ldr r1, address_of_return
	str lr, [r1]

	ldr r0, address_of_message1
	bl printf

	ldr r0, address_of_message2
	bl printf

	ldr r0, address_of_scan_pattern
	ldr r1, address_of_input
	bl scanf
	
	ldr r1, address_of_input
	ldr r1, [r1]

	mov r2, r1
	mov r3, r1
	b check_loop	
loop:
	sub r1, r1, #1
	mul r2, r1, r2
		

check_loop:
	cmp r1, #1
	bgt loop
	
end:
		
	ldr r0, address_of_message3
        mov r1, r3

	bl printf
	ldr lr, address_of_return
	ldr lr, [lr]
	bx lr
 
address_of_message1: .word message1
address_of_message2: .word message2
address_of_scan_pattern: .word scan_pattern
address_of_input: .word input
address_of_return: .word return
address_of_result: .word result
address_of_message3: .word message3


.global printf
.global scanf



