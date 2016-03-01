.data

.balign 4
message1: .asciz "isort\nn: "

.balign 4
message2: .asciz "%d: "

.balign 4
message3: .asciz "%d\n"

.balign 4
scan_pattern: .asciz "%d"

.balign 4
size: .word 0 

.balign 4
i: .word 1

.balign 4
j: .word 0

.balign 4
cur: .word 0

.balign 4
temp_int: .word 0

.balign 4
return: .word 0

.balign 4
return2: .word 0

.balign 4
return3: .word 0

.balign 4
test_return: .word 0

.balign 4
test_message: .asciz "\nTESTING\n"

.text

test_log:
	ldr r1, address_of_test_return
        str lr, [r1]
	
	ldr r0, address_of_test_message
	bl printf

        ldr lr, address_of_test_return
        ldr lr, [lr]
        bx lr
address_of_test_message: .word test_message
address_of_test_return: .word test_return

reset_i:
	ldr r1, address_of_return2
	str lr, [r1]
	
	ldr r1, address_of_i
	str r0, [r1]	
	
	ldr lr, address_of_return2
	ldr lr, [lr]
	bx lr
address_of_return2: .word return2


get_address_of_a_n:
	ldr r1, address_of_return3
        str lr, [r1]
	
	ldr r1, address_of_size
	ldr r1, [r1]

	/*because array index are 0-based*/
	add r0, r0, #1
	
	sub r2, r1, r0
	mov r3, #4
	mul r2, r3, r2
	
	add r0, sp, r2	

        ldr lr, address_of_return3
        ldr lr, [lr]
        bx lr
address_of_return3: .word return3


.global main
main:
	ldr r1, address_of_return
	str lr, [r1]

	ldr r0, address_of_message1
	bl printf

	ldr r0, address_of_scan_pattern
	ldr r1, address_of_size
	bl scanf

	b check_array_loop

/*initialize array here*/
array_loop: 
	ldr r0, address_of_message2
	ldr r1, address_of_i
	ldr r1, [r1]
	bl printf

	ldr r0, address_of_scan_pattern
	add sp, sp, #-4
	mov r1, sp
	bl scanf

	ldr r1, address_of_i
	ldr r2, [r1]
	add r2, r2, #1
	str r2, [r1]

check_array_loop:
	ldr r0, address_of_size
	ldr r0, [r0]

	ldr r1, address_of_i
	ldr r1, [r1]

	cmp r1, r0
	ble array_loop

/*reset i to 1 here*/
reset_i_1:
	ldr r0, address_of_i
	mov r1, #1
	str r1, [r0]

/*check for loop1*/
check_loop1:

	/* check if i < n  */
	ldr r0, address_of_size
	ldr r0, [r0]
	ldr r1, address_of_i
	ldr r1, [r1]
	cmp r1, r0
	bge reset_i_0
	
/*loop1 */
sort_loop1:	
	/* cur = a[i]  */
	ldr r0, address_of_i
	ldr r0, [r0]
	bl get_address_of_a_n  /* address of a[i] is now in r0 */
	ldr r0, [r0]
	
	ldr r1, address_of_cur
	str r0, [r1]		

	/*j = i - 1*/
         ldr r0, address_of_i
         ldr r0, [r0]
         sub r0, r0, #1
         ldr r1, address_of_j
         str r0, [r1]
	

/*check for loop2*/
check_loop2:
	/* if j < 0 then break */
 	ldr r0, address_of_j
	ldr r0, [r0]        
        cmp r0, #0
        blt sort_loop1_continue
        /* if a[j] <= cur then  break */
        ldr r0, address_of_j
        ldr r0, [r0]
        bl get_address_of_a_n
        ldr r0, [r0]
        ldr r1, address_of_cur
        ldr r1, [r1]
        cmp r0, r1
        ble sort_loop1_continue

/*loop2 inside loop1*/
sort_loop2:
	/* a[j + 1] = a[j] */
	ldr r0, address_of_j
	ldr r0, [r0]
	bl get_address_of_a_n
	ldr r0, [r0]
	ldr r1, address_of_temp_int
        str r0, [r1]            /*store value of a[j] to a temp int variable*/ 
	ldr r0, address_of_j
        ldr r0, [r0]
        add r0, r0, #1
        bl get_address_of_a_n	/*address of a[j + 1] should be now in r0*/
	ldr r1, address_of_temp_int
	ldr r1, [r1]
	str r1, [r0]

	/* j--  */
	ldr r0, address_of_j
	ldr r1, [r0]
	sub r1, r1, #1
	str r1, [r0]
	
	b check_loop2

/*the rest of loop1*/
sort_loop1_continue:
	/*a[j + 1] = cur*/
	ldr r0, address_of_j
	ldr r0, [r0]
	add r0, r0, #1
	bl get_address_of_a_n
	ldr r1, address_of_cur
	ldr r1, [r1]
	str r1, [r0]
	
	/* i++  */
	ldr r0, address_of_i
	ldr r1, [r0]
	add r1, r1, #1
	str r1, [r0]
	
	b check_loop1	

/*i = 0*/
reset_i_0:
	mov r0, #0
	bl reset_i

check_for_display_result_loop:
	ldr r0, address_of_i
	ldr r0, [r0]
	ldr r1, address_of_size
	ldr r1, [r1]
	cmp r0, r1
	bge end
	
display_result_loop:
	/*printf("%d\n", a[i]); */
	ldr r0, address_of_i
	ldr r0, [r0]
	bl get_address_of_a_n
	ldr r1, [r0]
	ldr r0, address_of_message3
	bl printf
		
	/* i++ */
	ldr r0, address_of_i
	ldr r1, [r0]
	add r1, r1, #1
	str r1, [r0]
 
	b check_for_display_result_loop		
end:
	ldr r0, address_of_return
	ldr lr, [r0]
	bx lr 




address_of_scan_pattern: .word scan_pattern
address_of_message1: .word message1
address_of_message2: .word message2
address_of_message3: .word message3
address_of_size: .word size
address_of_i: .word i
address_of_j: .word j
address_of_cur: .word cur
address_of_return: .word return
address_of_temp_int: .word temp_int
.global printf
.global scanf

