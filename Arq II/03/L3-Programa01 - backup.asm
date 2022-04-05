.data
ent1: .asciiz "Insira a string 1: "
ent2: .asciiz "Insira a string 2: "
str1: .space 100
str2: .space 100
str3: .space 200
fim: .ascii "\n"

.text
main:
	la $a0, ent1 #Parâmetro: mensagem
	la $a1, str1 #Parâmetro: endereço da string
	jal leitura #leitura(mensagem,string)
	la $a0, ent2 #Parâmetro: mensagem
	la $a1, str2 #Parametro: Endereço da string
	jal leitura #leitura (mensagem, string)
	la $a0, str1 #Parametro: Endereço da string 1
	la $a1, str2 #Parametro: Endereço da string 2
	la $a2, str3 #Parametro: Endereço da string 3
	la $a3, fim #Parametro: enderoço do fim
	jal intercala #intercala(str1, str2, str3)
	move $a0, $v0 #move o retorno da string resultante
	li $v0, 4 #Código de impressão de string
	syscall #Imprime a string intercalada
	li $v0, 10 #Código para finalizar o programa
	syscall #Finaliza o programa
	
leitura:
	li $v0, 4 #Código de impressão de string
	syscall #Imprime a string
	move $a0, $a1 #endereço da string para leitura
	li $a1, 100 #Número máximo de caracteres
	li $v0, 8 #Código de leitura da string
	syscall #Faz a leitura da string
	jr $ra #Retorna para a main
	
intercala:
	move $t0, $a0 #Salva o endereço base da string 1
	move $t1, $a1 #Salva o endereço base da string 2
	move $t2, $a2 #Salva o endereço base da string 3
	move $t4, $a2 #Salva o endereço base da string 3
	move $t5, $a3 #Salva o endereço base da string fim
	li $t3, 0 #salva i=0
	lb $t6, ($t5) #Tentativa de salvar o \n

loop:
	lb $a0, ($t0) #Carrega o valor de string 1
	lb $a1, ($t1) #Carrega o valor de string 2
	beq $a0, $t6, s2 #Se chegar no fim, vai só na próxima
	sb $a0, ($t2) #Salva o valor da string 1
	addi $t2, $t2, 1 #Anda uma posição com a string 3
	addi $t0, $t0, 1 #Anda uma posição com a string 1
s2:    
	beq $a1, $t6, con #Se chegar no fim, vai só na próxima
	sb $a1, ($t2) #Salva o valor da string 2
	addi $t1, $t1, 1 #Anda uma posição com a string 2
	addi $t2, $t2, 1 #Anda uma posição com a string 3
con:
	addi $t3, $t3, 2 #anda duas posições no contador
	blt $t3, 200, loop #Caso nao chegou ao final fica em loop
	move $v0, $t4 #Salva o endereço base da string 1
	jr $ra #Retorna para a main
	
