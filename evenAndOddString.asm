# At the beginning of the output string put the characters from the odd positions, next the even. 
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
	la t0, buf 		# Wskaünik znakÛw nieparzystych
	la t1, buf		# Wskaünik znakÛw parzystych
	la t2, buf		# Wskaünik wstawiajπcy znaki
	li t5, '\n'
	
	lb t3, (t0)
	beqz t3, end
	
	addi t1, t1, 1

odd_numbers:
	lb t3, (t0)
	beqz t3, even_numbers
	beq t3, t5, even_numbers
	sb t3, (t2)
	addi t0, t0, 2
	addi t2, t2, 1
	j odd_numbers
	
even_numbers:
	lb t4, (t1)
	beqz t4, end
	beq t4, t5, end
	sb t4, (t2)
	addi t1, t1, 2
	addi t2, t2, 1
	j even_numbers

end:
	li a7, 4
	la a0, buf
	ecall
	
	li a7, 10
	ecall



	
	