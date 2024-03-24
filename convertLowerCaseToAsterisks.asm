	.data
prompt: .asciz "Enter string: "
buf: .space 100
	.text
	.global main
main:
	li a7, 4
	la a0, prompt
	ecall
	
	li a7 ,8
	la a0, buf
	li a1, 100
	ecall
	
	li t0, 'a'
	li t1, 'z'
	li t2, '*'
	
	la t3, buf 		# wskaünik na stringa
	
	lb t4, (t3)
	beqz t4, end

 loop:
	lb t4, (t3)
	beqz t4, end
 	blt t4, t0, next
 	bgt t4, t1, next
 	sb t2, (t3)
 	addi t3, t3, 1
 	j loop
 	
next:
	addi t3, t3, 1
	j loop

end:
	li a7, 4
	la a0, buf
	ecall
	
	li a7, 10
	ecall
	
 	