.data

.balign
message1: .asciz "rsum\nn: "

.balign
message2: .asciz "%d: "

.balign
message3: .asciz "sum:%d\n"

.balign
scan_pattern: .asciz "%d"

.balign
test_log: .asciz "\nTesting\n"

.balign
i: .word 0

.balign
size: .word 0

.balign
start_of_stack: .word 0

.balign
total: .word 0

/*used as a cache*/
.balign
tmp: .word 0

.balign
return_of_test: .word 0

.balign
return: .word 0

.balign
return3: .word 0

.text

get_address_of_a_n:
        ldr r1, address_of_return3
    str lr, [r1]

        /*because array index are 0-based*/
        add r0, r0, #1

        mov r3, #4
        mul r2, r3, r0

    ldr r0, address_of_start_of_stack
    ldr r0, [r0]


    sub r0, r0, r2

    ldr lr, address_of_return3
    ldr lr, [lr]
    bx lr

sum:
	str lr, [sp, #-4]!

	ldr r1, address_of_tmp
	str r0, [r1]
	bl get_address_of_a_n
	ldr r0, [r0]
	str r0, [sp, #-4]!
	ldr r0, address_of_tmp
	ldr r0, [r0]	

	cmp r0, #0
	bgt is_nonzero
	
	bl get_address_of_a_n
	ldr r0, [r0]
	b end

is_nonzero:
	sub r0, r0, #1
	bl sum	


	ldr r1, [sp, #+4]!
	add r0, r0, r1
end:
	add sp, sp, #+4	
	ldr lr, [sp]
	bx lr





.global main

main: 
    ldr r0, address_of_return
    str lr, [r0]

    ldr r0, address_of_message1
	bl printf
	
	ldr r0, address_of_scan_pattern
	ldr r1, address_of_size
	bl scanf

    ldr r0, address_of_start_of_stack
    str sp, [r0]

    b check_array_loop

/*initialize array here*/
array_loop:
	/*printf("%d: ", i + 1);*/
	ldr r0, address_of_message2
	ldr r1, address_of_i
	ldr r1, [r1]
    add r1, r1, #1
	bl printf
	/*scanf("%d", &a[i])*/
	ldr r0, address_of_scan_pattern
	add sp, sp, #-4
	mov r1, sp
	bl scanf
	
	/*i++;*/
	ldr r1, address_of_i
	ldr r2, [r1]
	add r2, r2, #1
	str r2, [r1]

check_array_loop:
	/*if i < size/n then continue*/
	ldr r0, address_of_size
	ldr r0, [r0]

	ldr r1, address_of_i
	ldr r1, [r1]

	cmp r1, r0
	bne array_loop

print_result:

    /*reset i ＝ i － 1*/
    ldr r1, address_of_i
    ldr r0, [r1]
    add r0, r0, #-1
    str r0, [r1]
    
    bl sum
    mov r1, r0	
    ldr r0, address_of_message3
    
    bl printf

end_of_main:
	ldr r0, address_of_return
	ldr lr, [r0]
	bx lr


address_of_tmp: .word tmp
address_of_total: .word total
address_of_message1: .word message1
address_of_message2: .word message2
address_of_message3: .word message3
address_of_scan_pattern: .word scan_pattern
address_of_test_log: .word test_log
address_of_i: .word i
address_of_size: .word size
address_of_return_of_test: .word return_of_test
address_of_return: .word return
address_of_return3: .word return3
address_of_start_of_stack: .word start_of_stack
.global printf
.global scanf

