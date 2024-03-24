# ��czenie dw�ch string�w w jeden
.data
prompt1: .asciz "Enter first string: "
prompt2: .asciz "Enter second string: "
prompt3: .asciz "Result: "
buf1: .space 100
buf2: .space 100
result_buf: .space 200
	
.text
.global main
	
main:
    # Wczytywanie pierwszego ci�gu
    li a7, 4
    la a0, prompt1
    ecall
    
    li a7, 8
    la a0, buf1
    li a1, 100
    ecall
    
    # Wczytywanie drugiego ci�gu
    li a7, 4
    la a0, prompt2
    ecall
    
    li a7, 8
    la a0, buf2
    li a1, 100
    ecall
    
    # ��czenie ci�g�w
    la t0, buf1            # Wska�nik na buf1
    la t1, buf2            # Wska�nik na buf2
    la t2, result_buf      # Wska�nik na bufor wynikowy
    
    # Kopiowanie pierwszego ci�gu do bufora wynikowego
    copy_first:
        lb t3, 0(t0)        # Wczytaj znak z buf1
        beqz t3, copy_second # Je�li napotkano '\0', przejd� do kopiowania drugiego ci�gu
        sb t3, 0(t2)        # Zapisz znak z buf1 do bufora wynikowego
        addi t0, t0, 1      # Przesu� wska�nik na buf1
        addi t2, t2, 1      # Przesu� wska�nik na bufor wynikowy
        j copy_first
    
    # Kopiowanie drugiego ci�gu do bufora wynikowego
    copy_second:
        lb t3, 0(t1)        # Wczytaj znak z buf2
        beqz t3, end_copy   # Je�li napotkano '\0', zako�cz kopiowanie
        sb t3, 0(t2)        # Zapisz znak z buf2 do bufora wynikowego
        addi t1, t1, 1      # Przesu� wska�nik na buf2
        addi t2, t2, 1      # Przesu� wska�nik na bufor wynikowy
        j copy_second
    
    end_copy:
    
    # Wy�wietlenie wyniku
    li a7, 4
    la a0, prompt3
    ecall
    
    # Wy�wietlenie zawarto�ci bufora wynikowego bez uwzgl�dniania '\0'
    la t0, result_buf      # Wska�nik na bufor wynikowy
print_result:
    lb a0, 0(t0)          # Wczytaj znak z bufora wynikowego
    beqz a0, end_print    # Je�li napotkano '\0', zako�cz wy�wietlanie
    li a7, 11             # Wywo�anie systemowe do wy�wietlenia znaku
    ecall
    addi t0, t0, 1        # Przesu� wska�nik na bufor wynikowy
    j print_result
    
end_print:

    # Zako�czenie programu
    li a7, 10
    ecall
