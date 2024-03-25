# When [ ] then put asterisks in between

	.data
prompt: .asciz "Enter string in "
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
	
	la t0, buf		# Buffor pointer
	li s0, 0		# Opening bracket pointer
	li s1, 0		# Closing bracket pointer
	
	li t1, '['
	li t2, ']'
	li t3, '*'
	
	lb t4, (t0)
	beqz t4, end

search_for_opening_bracket:
	lb t4, (t0)
	beqz t4, end
	beq t4, t1, opening_found
	addi t0, t0, 1
	j search_for_opening_bracket

opening_found:
	mv s0, t0
	addi s0, s0, 1
	
search_for_closing_bracket:
	lb t4, (t0)
	beqz t4, end
	beq t4, t2, closing_found
	addi t0, t0, 1
	j search_for_closing_bracket

closing_found:
	mv s1, t0
	la t0, buf

put_asterisks:
	lb t4, (s0)
	beqz t4, end
	beq s0, s1, end
	sb t3, (s0)
	addi s0, s0, 1
	j put_asterisks

end:
	li a7, 4
	la a0, buf
	ecall
	
	li a7, 10
	ecall
	