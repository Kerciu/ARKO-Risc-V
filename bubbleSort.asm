# Bubble Sort
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
	
	la t0, buf
	li t1, 0		# Licznik znaków
	li t2, '\n'
	
	lb t3, (t0)
	beqz t3, print_sorted_string

count_length:
    	lb t3, (t0)         # Wczytaj kolejny znak
    	beqz t3, sort        # Jeœli koniec ci¹gu, przejdŸ do sortowania
   	beq t3, t2, sort    # Jeœli znak nowej linii, przejdŸ do sortowania
   	addi t1, t1, 1      # Zwiêksz licznik znaków
    	addi t0, t0, 1      # Przesuñ wskaŸnik na nastêpny znak
    	j count_length      # Powtarzaj, dopóki nie skoñczy siê ci¹g
    
sort:
    # Pêtla sortowania b¹belkowego
    	li t4, 1             # Flaga wskazuj¹ca, czy nast¹pi³a zamiana
outer_loop:
    	li t4, 0             # Zresetuj flagê zamiany
    	la t0, buf           # Ustaw wskaŸnik na pocz¹tek bufora
inner_loop:
    	lb t5, (t0)          # Wczytaj znak
    	lb t6, 1(t0)         # Wczytaj nastêpny znak
    
    # Jeœli t6 == '\n' || t6 == 0, to koniec ci¹gu, przejdŸ do koñca sortowania
    	beqz t6, end_sort
    	beq t6, t2, end_sort
    
    	blt t6, t5, swap     # Jeœli t6 < t5, zamieñ je
    	addi t0, t0, 1       # Przesuñ wskaŸnik na nastêpny znak
    	j inner_loop         # Powtarzaj, dopóki nie skoñczy siê ci¹g
    
swap:
    # Zamieñ wartoœci t5 i t6
    	sb t6, (t0)          # Zapisz t6 w miejscu t5
    	sb t5, 1(t0)         # Zapisz t5 w miejscu t6
    	li t4, 1             # Ustaw flagê zamiany na 1
inner_loop_end:
    	addi t0, t0, 1       # Przesuñ wskaŸnik na nastêpny znak
    	j inner_loop         # Powtarzaj, dopóki nie skoñczy siê ci¹g
    
end_sort:
    	beqz t4, print_sorted_string  # Jeœli nie by³o zamian, przejdŸ do wypisywania posortowanego ci¹gu
    	li t4, 0             # Zresetuj flagê zamiany
    	j outer_loop         # Powtarzaj zewnêtrzn¹ pêtlê sortowania

print_sorted_string:
    # Wyœwietl posortowany ci¹g znaków
    	li a7, 4
    	la a0, buf
    	ecall
    
    # Zakoñcz program
    	li a7, 10
    	ecall