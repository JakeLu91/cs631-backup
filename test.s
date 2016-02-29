.data
.balign 4
message: .asciz "%d\n"

.balign 4
t: .word 0

.balign 4
return: .word 0

.balign 4
return2: .word 0

.text
test:
	ldr r1, address_of_return2
	str lr, [r1]
	


	ldr lr, address_of_return2
	ldr lr, [lr]
	bx lr
address_of_return2: .word return2

.global main
main:
	ldr r1, address_of_return
	str lr, [r1]
	
	ldr r0, address_of_message
	ldr r1, address_of_t
	ldr r1, [r1]
	bl printf

	ldr r0, address_of_return
	ldr lr, [r0]
	bx lr

address_of_t: .word t
address_of_message: .word message
address_of_return: .word return
.global printf
