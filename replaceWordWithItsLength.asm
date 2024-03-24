# Replace each character belonging to a word by the length of the word (mod 10).
	.data
prompt: .asciz "Enter string in :"
buf1: .space 100
buf2: .space 100

	.text
	.global main

main:
	li a7, 4
	la a0, prompt
	ecall
	
	li a7, 8
	la a0, buf1
	li a1, 100
	ecall
	
	la t0, buf1 		# Pointer bufora pierwszego
	la t1, buf2		# Pointer bufora drugiego
	li t2, 32
	li t3, 10
	li s0, 0		# Char counter
	li s6, 10

size_of:
	lb t4, (t0)
	addi t0, t0, 1
	beq t4, t2, write
	beq t4, t3, write
	addi s0, s0, 1
	j size_of
	
write:
	sb s0, (t1)
	addi t1, t1, 1
	li s0, 0
	beq t4, t3, part2
	j size

part2:
	la t0, buf1
	la t1, buf2

loop:
	lbu t4, (t0)
	lbu t5, (t1)
	rem t5, t5, t6
	beq t4, t2, nowrt
	beq t4, t3, nowrt
	addi t5, t5, 48
	sb t5, (t0)
	addi t0, t0, 1
	j loop

nowrt:
	beq t4, t3, end
	addi t0, t0, 1
	addi t1, t1, 1
	j loop

end:
	li a7, 4
	la a0, buf1
	ecall
	
	li a7, 10
	ecall
	
