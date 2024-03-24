# SWAP TWO CONSECUTIVE CHARS IN STRING
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
	la t0, buf
	la t1, buf
	li t4, '\n'
	
	addi t1, t1, 1
	
	lb t2, (t0)
	lb t3, (t1)
	
	beqz t3, end
	
swap:
	lb t2, (t0)
	lb t3, (t1)
	beq t2, t4, end
	beq t3, t4, end
	beqz t3, end
	sb t3, (t0)
	sb t2, (t1)
	addi t0, t0, 2
	addi t1, t1, 2
	j swap

end:
	li a7, 4
	la a0, buf
	ecall
	
	li a7, 10
	ecall
	