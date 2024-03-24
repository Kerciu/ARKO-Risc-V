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
	li t1, 0		# Licznik znak�w
	li t2, '\n'
	
	lb t3, (t0)
	beqz t3, print_sorted_string

count_length:
    	lb t3, (t0)         # Wczytaj kolejny znak
    	beqz t3, sort        # Je�li koniec ci�gu, przejd� do sortowania
   	beq t3, t2, sort    # Je�li znak nowej linii, przejd� do sortowania
   	addi t1, t1, 1      # Zwi�ksz licznik znak�w
    	addi t0, t0, 1      # Przesu� wska�nik na nast�pny znak
    	j count_length      # Powtarzaj, dop�ki nie sko�czy si� ci�g
    
sort:
    # P�tla sortowania b�belkowego
    	li t4, 1             # Flaga wskazuj�ca, czy nast�pi�a zamiana
outer_loop:
    	li t4, 0             # Zresetuj flag� zamiany
    	la t0, buf           # Ustaw wska�nik na pocz�tek bufora
inner_loop:
    	lb t5, (t0)          # Wczytaj znak
    	lb t6, 1(t0)         # Wczytaj nast�pny znak
    
    # Je�li t6 == '\n' || t6 == 0, to koniec ci�gu, przejd� do ko�ca sortowania
    	beqz t6, end_sort
    	beq t6, t2, end_sort
    
    	blt t6, t5, swap     # Je�li t6 < t5, zamie� je
    	addi t0, t0, 1       # Przesu� wska�nik na nast�pny znak
    	j inner_loop         # Powtarzaj, dop�ki nie sko�czy si� ci�g
    
swap:
    # Zamie� warto�ci t5 i t6
    	sb t6, (t0)          # Zapisz t6 w miejscu t5
    	sb t5, 1(t0)         # Zapisz t5 w miejscu t6
    	li t4, 1             # Ustaw flag� zamiany na 1
inner_loop_end:
    	addi t0, t0, 1       # Przesu� wska�nik na nast�pny znak
    	j inner_loop         # Powtarzaj, dop�ki nie sko�czy si� ci�g
    
end_sort:
    	beqz t4, print_sorted_string  # Je�li nie by�o zamian, przejd� do wypisywania posortowanego ci�gu
    	li t4, 0             # Zresetuj flag� zamiany
    	j outer_loop         # Powtarzaj zewn�trzn� p�tl� sortowania

print_sorted_string:
    # Wy�wietl posortowany ci�g znak�w
    	li a7, 4
    	la a0, buf
    	ecall
    
    # Zako�cz program
    	li a7, 10
    	ecall