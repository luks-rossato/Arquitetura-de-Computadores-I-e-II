.data
ent1: .asciiz "Insira a string 1: "
ent2: .asciiz "A string tem comprimento: "
msg3: .asciiz "A palavra informada é palíndroma!"
msg4: .asciiz "A palavra informada não é palíndroma!"
str1: .space 100

.text
main:
	la $a0, ent1 #Parâmetro: mensagem
	la $a1, str1 #Parâmetro: endereço da string
	jal leitura #leitura(mensagem,string)	
	la $a0, str1 #Parametro: Endereço da string 1
	jal strlen #strlen(str1)
	move $a0, $v0 #move o retorno do tamanho da string resultante
	move $t1, $a0 #Faz uma cópia do valor
	li $v0, 1 #Código de impressão de inteiros
	syscall #Imprime o comprimento da string	
	la $a0, str1 #Parametro: Endereço da string 1
	move $a1, $t1 #Parametro: Comprimento da string
	jal palindromo #palindromo(str1, len)
	move $a0, $v0 #move o retorno da string resultante
	beqz  $a0, nao #Pula pra não achou
	j sim
nao:	la $a0, msg4 #Parâmetro: mensagem
	j f #pula o sim
sim:	la $a0, msg3 #Parâmetro: mensagem
f:	li $v0, 4 #Código de impressão de string
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
	
strlen:
	li $t0, 0 # i = 0
	loop:
		lb $t1, 0($a0) # carrega o caractere
		beqz $t1, exit # verifica se é fim da palavra
		addi $a0, $a0, 1 # Aumenta o ponteiro da string
		addi $t0, $t0, 1 # incrementa o contador
		j loop # volta pro loop para o próximo caracter
	exit:
		subi $t0, $t0, 1 #Decrementa o contador em uma unidade
		move $v0, $t0 #Salva o contador
		jr $ra

palindromo:
	move $t0, $a0 #Salva o endereço base da string 1
	
	move $t1, $a1 #Salva o comprimento da string
	move $t2, $a0 #salva o endereço base de str1
	subi $t1, $t1, 1 #subtrai um 
	add $t2, $t2, $t1 #vai pro final da string
	move $t4, $t1 #salva j = strlen(str1)
	over:
		lb $a0, ($t0) #Carrega o valor de string 1
		lb $a1, ($t2) #Carrega o valor de string 2
		
		bne $a0, $a1, naopalin #Se não for igual, nao é palindromo
		addi $t0, $t0, 1 #Anda uma posição com a string 1
		subi $t2, $t2, 1 #Anda uma posição com a string 2
		subi $t4, $t4, 1 #Anda uma posição com a string 2
		blt $t4, 1, achou #se chegou ao fim temos um palindromo
		j over
		
	naopalin:    
		li $v0, 0 #retorna 0 na função
		jr $ra
	achou:
		li $v0, 1 #retorna 1 na função
		jr $ra