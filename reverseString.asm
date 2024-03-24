	.data
prompt: .asciz "Enter string in: "
buf: .space 100

	.text
	.global main

main:
	li a7, 4
	la a0 prompt
	ecall
	
	li a7, 8
	la a0, buf
	li a1, 100
	ecall
	
	la t0, buf		# Pierwszy wskaünik na poczπtek bufora
	la t1, buf		# Drugi wskaünik ktÛry bÍdzie wskaünikiem na koniec bufora
	li t2, 0		# Char counter
	
	lb t3, (t0)
	beqz t3, end

count_chars:
	lb t3, (t0)
	beqz t3, increment_buf_pointer
	addi t0, t0, 1
	addi t2, t2, 1
	j count_chars

increment_buf_pointer:
	la t0, buf
	add t1, t1, t2
	addi t1, t1, -1

loop:
	ble t5, t4, end
	lb t4, (t0) 		# Pierwszy znak
	lb t5, (t1)		# Ostatni znak
	sb t5, (t0)
	sb t4, (t1)
	addi t0, t0, 1
	addi t1, t1, -1
	j loop

end:
	li a7, 4
	la a0, buf
	ecall
	
	li a7, 10
	ecall
