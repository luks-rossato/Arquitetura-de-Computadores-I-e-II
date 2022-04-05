.data
ent1: .asciiz "Insira a string 1: "
ent2: .asciiz "Insira a string 2: "
str1: .space 100
str2: .space 100
str3: .space 200

.text
main:
	la $a0, ent1 #Par�metro: mensagem
	la $a1, str1 #Par�metro: endere�o da string
	jal leitura #leitura(mensagem,string)
	la $a0, ent2 #Par�metro: mensagem
	la $a1, str2 #Parametro: Endere�o da string
	jal leitura #leitura (mensagem, string)
	la $a0, str1 #Parametro: Endere�o da string 1
	la $a1, str2 #Parametro: Endere�o da string 2
	la $a2, str3 #Parametro: Endere�o da string 3
	jal intercala #intercala(str1, str2, str3)
	move $a0, $v0 #move o retorno da string resultante
	li $v0, 4 #C�digo de impress�o de string
	syscall #Imprime a string intercalada
	li $v0, 10 #C�digo para finalizar o programa
	syscall #Finaliza o programa
	
leitura:
	li $v0, 4 #C�digo de impress�o de string
	syscall #Imprime a string
	move $a0, $a1 #endere�o da string para leitura
	li $a1, 100 #N�mero m�ximo de caracteres
	li $v0, 8 #C�digo de leitura da string
	syscall #Faz a leitura da string
	jr $ra #Retorna para a main
	
intercala:
	move $t0, $a0 #Salva o endere�o base da string 1
	move $t1, $a1 #Salva o endere�o base da string 2
	move $t2, $a2 #Salva o endere�o base da string 3
	move $t4, $a2 #Salva o endere�o base da string 3
	li $t3, 0 #salva i=0

loop:
	lb $a0, ($t0) #Carrega o valor de string 1
	lb $a1, ($t1) #Carrega o valor de string 2
	sb $a0, ($t2) #Salva o valor da string 1
	addi $t2, $t2, 1 #Anda uma posi��o com a string 3
	sb $a1, ($t2) #Salva o valor da string 2
	addi $t2, $t2, 1 #Anda uma posi��o com a string 3
	addi $t0, $t0, 1 #Anda uma posi��o com a string 1
	addi $t1, $t1, 1 #Anda uma posi��o com a string 2
	addi $t3, $t3, 2 #anda duas posi��es no contador
	ble $t3, 200, loop #Caso nao chegou ao final fica em loop
	move $v0, $t4 #Salva o endere�o base da string 1
	jr $ra #Retorna para a main