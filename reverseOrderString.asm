# REVERSE THE ORDER IN STRING
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
	li t3, '\n'
	
	lb t4, (t0)
	beqz t4, end

count_string:
	lb t4, (t1)
	beq t4, t3, delete_whitespace
	addi t1, t1, 1
	j count_string

delete_whitespace:
	addi t1, t1, -1

loop:
	lb t4, (t0)
	lb t2, (t1)
	ble t1, t0, end
	sb t4, (t1)
	sb t2, (t0)
	addi t0, t0, 1
	addi t1, t1, -1
	j loop

end:
	li a7, 4
	la a0, buf
	ecall
	
	li a7, 10
	ecall