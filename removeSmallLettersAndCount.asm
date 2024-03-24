# Write function remove which removes from the source string every small letter. remove returns the length of
# the resulting string.
# Source> Computer Architecture Lab
# Result> C A L
# Return value: 5
	.data
prompt1: .asciz "Source> "
prompt2: .asciz "Result> "
prompt3: .asciz "Return value: "
newLine: .ascii "\n"
buf1:	.space 100
buf2:	.space 100	

	.text
	.global main
	
main:
	li a7, 4
	la a0, prompt1
	ecall
	
	li a7, 8
	la a0, buf1
	li a1, 100
	ecall
	
	la t0, buf1
	la t1, buf2
	li t2, 'A'
	li t3, 'Z'
	li t4, ' '
	
	li s0, 0		# Char count
	li s1, 0
	
	lb t5, (t0)
	beqz t5, end

seek_for_uppercase:
	lb t5, (t0)
	beqz t5, end_string
	blt t5, t2, next_char
	bgt t5, t3, next_char
	sb t5, (t1)
	addi t1, t1, 1
	sb t4, (t1)
	addi t1, t1, 1

next_char:
	addi t0, t0, 1
	j seek_for_uppercase

end_string:
	sb zero, (t1)
	
	li s0, 0
	li s1, 0
	la t1, buf2
count_chars_buf2:
	lb s0, (t1)
	beqz s0, print_chars
	addi t1, t1, 1
	addi s1, s1, 1
	j count_chars_buf2

print_chars:
	addi s1, s1, -1

end:
	li a7, 4
	la a0, prompt2
	ecall
	
	li a7, 4
	la a0, buf2
	ecall
	
	li a7, 4
	la a0, newLine
	ecall
	
	li a7, 4
	la a0, prompt3
	ecall
	
	li a7, 1
	mv a0, s1
	ecall
	
	li a7, 10
	ecall
	
