# CONVERT ALL NON LETTER SYMBOLS INTO ASTERISKS

	.data
prompt: .asciz "Enter string in: "
buf: .space 100

	.text
	.global main

main:
	li a7, 4
	la a0, prompt
	ecall
	
	li a7, 8
	la a0, buf
	li a1, 100
	ecall
	
	# Rejestry
	li t0, 'A'
	li t1, 'Z'
	li t2, 'a'
	li t3, 'z'
	li t6, '*'
	
	# Wskaünik na stringa
	la t4, buf
	
	lb t5, (t4)
	beqz t5, end

loop:
	lb t5, (t4)
	li s1, '\n' 
	beq t5, s1, end
	blt t5, t0, asterisk
	bgt t5, t3, asterisk
	ble t5, t1, skip
	bge t5, t2, skip

asterisk:
	sb t6, (t4)
	
skip:
	addi t4, t4, 1
	j loop

end:
	li a7, 4
	la a0, buf
	ecall
	
	li a7, 10
	ecall