# £¹czenie dwóch stringów w jeden
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
    # Wczytywanie pierwszego ci¹gu
    li a7, 4
    la a0, prompt1
    ecall
    
    li a7, 8
    la a0, buf1
    li a1, 100
    ecall
    
    # Wczytywanie drugiego ci¹gu
    li a7, 4
    la a0, prompt2
    ecall
    
    li a7, 8
    la a0, buf2
    li a1, 100
    ecall
    
    # £¹czenie ci¹gów
    la t0, buf1            # WskaŸnik na buf1
    la t1, buf2            # WskaŸnik na buf2
    la t2, result_buf      # WskaŸnik na bufor wynikowy
    
    # Kopiowanie pierwszego ci¹gu do bufora wynikowego
    copy_first:
        lb t3, 0(t0)        # Wczytaj znak z buf1
        beqz t3, copy_second # Jeœli napotkano '\0', przejdŸ do kopiowania drugiego ci¹gu
        sb t3, 0(t2)        # Zapisz znak z buf1 do bufora wynikowego
        addi t0, t0, 1      # Przesuñ wskaŸnik na buf1
        addi t2, t2, 1      # Przesuñ wskaŸnik na bufor wynikowy
        j copy_first
    
    # Kopiowanie drugiego ci¹gu do bufora wynikowego
    copy_second:
        lb t3, 0(t1)        # Wczytaj znak z buf2
        beqz t3, end_copy   # Jeœli napotkano '\0', zakoñcz kopiowanie
        sb t3, 0(t2)        # Zapisz znak z buf2 do bufora wynikowego
        addi t1, t1, 1      # Przesuñ wskaŸnik na buf2
        addi t2, t2, 1      # Przesuñ wskaŸnik na bufor wynikowy
        j copy_second
    
    end_copy:
    
    # Wyœwietlenie wyniku
    li a7, 4
    la a0, prompt3
    ecall
    
    # Wyœwietlenie zawartoœci bufora wynikowego bez uwzglêdniania '\0'
    la t0, result_buf      # WskaŸnik na bufor wynikowy
print_result:
    lb a0, 0(t0)          # Wczytaj znak z bufora wynikowego
    beqz a0, end_print    # Jeœli napotkano '\0', zakoñcz wyœwietlanie
    li a7, 11             # Wywo³anie systemowe do wyœwietlenia znaku
    ecall
    addi t0, t0, 1        # Przesuñ wskaŸnik na bufor wynikowy
    j print_result
    
end_print:

    # Zakoñczenie programu
    li a7, 10
    ecall
