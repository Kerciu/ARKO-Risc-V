# Filter Ints from string
		.data
prompt1: .asciz "Source> "
prompt2: .asciz "Result> "
buf: .space 100

	.text
	.global main

main:
	li a7, 4
	la a0, prompt1
	ecall
	
	li a7, 8
	la a0, buf
	li a1, 100
	ecall
	
	la t0, buf
	li t1, '0'
	li t2, '9'
	
	lb t3, (t0)
	beqz t3, end

loop:
	lb t3, (t0)
	beqz t3, end
	blt t3, t1, next
	bgt t3, t2, next

delete:
	lb t3, (t0)
	addi t0, t0, 1
	lb t3, (t0)
	addi t0, t0, -1
	sb t3, (t0)
	addi t0, t0, 1
	bnez t3, delete
	
	la t0, buf
	lb t4, (t0)
	addi t0, t0, -1

next:
	addi t0, t0, 1
	j loop

end:
	li a7, 4
	la a0, prompt2
	ecall
	
	li a7, 4
	la a0, buf
	ecall
	
	li a7, 10
	ecall
	
	