# The first and the second character in the string represent the (begin and the end) markers, which define a
# substring. Your task is to replace all characters between the first occurrence of begin marker and first
# occurcence of the end marker with * character. If there is no begin or end marker in the input string (the string
# after the : character), then nothing should be changed. Replace the first three characters of the string with
# spaces.
# Input string > 	oi:wind on the hill
# Conversion results> 	   wind *********ll

	.data
prompt1: .asciz "Input string: "
prompt2: .asciz "Conversion results"
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
	
	la t0, buf		# WskaŸnik na ci¹g znaków
	li t1, 0		# Rejestr na pierwsz¹ literê
	li t2, 0		# Rejestr na drug¹ literê
	li t3, ':'
	li t4, ' '
	li s0, '*'
	li s1, 0 		# Rejestr na d³ugoœæ stringa

	lb t5, (t0)
	beqz t5, end

seek_for_colon:
	lb t5, (t0)
	beq t5, t3, colon_found
	beqz t5, reset_buf_pointer
	addi t0, t0, 1
	addi s1, s1, 1
	j seek_for_colon

# Tu jest b³¹d, przesuñ stringa o trzy miejsca w prawo po czym wpisz spacje w miejsca przed stringiem
reset_buf_pointer:
	la t0, buf
	add t0, t0, s1

insert_spaces:
	lb t5, (t0)
	beqz s1, end
	sb t4, (t0)
	addi s1, s1, -1
	j insert_spaces

colon_found:
	addi t0, t0, -2
	lb t1, (t0)
	sb t4, (t0)
	addi t0, t0, 1
	lb t2, (t0)
	sb t4, (t0)
	addi t0, t0, 1
	sb t4, (t0)
	addi t0, t0, 1		# Ustaw wskaŸnik na pocz¹tek dobrego stringa

transform_string:
	lb t5, (t0)
	beq t5, t1, put_asterisks
	beqz t5, end
	addi t0, t0, 1
	j transform_string

put_asterisks:
	lb t5, (t0)
	sb s0, (t0)
	beq t5, t2, end
	addi t0, t0, 1
	j put_asterisks

end:
	li a7, 4
	la a0, prompt2
	ecall
	
	li a7, 4
	la a0, buf
	ecall
	
	li a7, 10
	ecall
	
	
	