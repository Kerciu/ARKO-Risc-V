	.data
prompt: .asciz "Enter your string: "
prompt2: .asciz "String lenghth: "
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
	
	la t0, buf 		# Wska�nik na pocz�tek bufora
	lb t1, (t0)		# Wczytaj znak
	li t2, 0		# Licznik znak�w
	
	beqz t1, end		# Zako�cz je�li pusty string

loop:
	lb t1, 0(t0)		# Wczytaj znak
	beqz t1, end		# Jak napotkasz '\0' zako�cz
	addi t0, t0, 1
	addi t2, t2, 1
	j loop

end:
	addi t2, t2, -1		# Usu� znak ko�cowy
	
	li a7, 4
	la a0, prompt2
	ecall
	
	li a7, 1
	mv a0, t2
	ecall
	
	li a7, 10
	ecall
	
	
	