.data
ord: .asciiz "Ordem da matriz: "
Ent1: .asciiz "Insira o valor de matriz["
Ent2: .asciiz "]["
Ent3: .asciiz "]: "
false: .asciiz "Nao e matriz de permutacao"
true: .asciiz "E matriz de permutacao"

debug1: .asciiz "\n percorreColuna\n"

.text
	
main:	la $a0, ord # carrega o endere�o da string
	li $v0, 4		
	syscall			
	li $v0, 5		# codigo de leitura de inteiro
	syscall			# leitura do valor (retorna em $v0)
	move $a1, $v0		# n�mero de linhas recebe $v0
	move $a2, $v0		# n�mero de colunas recebe $v0
	mul $a0, $v0, 4		# $a0 = tamanho da matriz * 4
	li $v0, 9		# c�digo de aloca��o dinamica
	syscall			# aloca tamanho * 4 bytes (endere�o em $v0)
	la $a0, ($v0)		# $a0 aponta para $v0 (local onde a matriz esta alocada)
	jal leitura		# leitura (matriz, numeroLinhas, numeroColunas) retorna matriz em $v0
	move $a0, $v0		# move o endere�o da matriz para argumento $a0
	jal percorreLinhas	# percorreLinhas(matriz, numeroLinhas, numeroColunas)
	move $a0, $v0		# move o endere�o da matriz para argumento $a0
	jal percorreColunas	# percorreColunas(matriz, numeroLinhas, numeroColunas)
	la $a0, true		# carrega o endere�o da string
	li $v0, 4		# c�digo de impress�o de string
	syscall			# imprime a string
	li $v0, 10		# c�digo para finalizar o programa
	syscall			# finaliza o programa

indice:	mul $v0, $t0, $a2	# i * numeroColunas
	add $v0, $v0, $t1	# (i * numeroColunas) + j
	sll $v0, $v0, 2		# [(i * numeroColunas) + j] * 4 (inteiro)
	add $v0, $v0, $a3	# soma o endere�o base de matriz
	jr $ra			# retorna para o caller

leitura:subi $sp, $sp, 4	# espa�o para 1 item na pilha
	sw $ra, ($sp)		# salva o retorno para a main
	move $a3, $a0		# aux = endere�o base de matriz
	
l:	la $a0, Ent1	# carrega o endere�o da string
	li $v0, 4		# c�digo de impress�o de string
	syscall			# imprime a string
	move $a0, $t0		# valor de i para impressao
	li $v0, 1		# c�digo de impressao de inteiro
	syscall			# imprime i
	la $a0, Ent2	# carrega o endere�o da string
	li $v0, 4		# c�digo de impress�o de string
	syscall			# imprime a string
	move $a0, $t1		# valor de j para impressao
	li $v0, 1		# c�digo de impressao de inteiro
	syscall			# imprime j
	la $a0, Ent3	# carrega o endere�o da string
	li $v0, 4		# c�digo de impress�o de string
	syscall			# imprime a string
	li $v0, 5		# codigo de leitura de inteiro
	syscall			# leitura do valor (retorna em $v0)
	move $t2, $v0		# aux = valor lido
	jal indice		# calcula o endere�o de matriz[i][j]
	sw $t2, ($v0)		# matriz[i][j] = aux
	addi $t1, $t1, 1	# j++
	blt $t1, $a2, l		# if (j < numeroColunas1) goto 1
	li $t1, 0		# j = 0
	addi $t0, $t0, 1	# i++
	blt $t0, $a1, l		# if (i < numeroLinhas) goto 1
	li $t0, 0		# i = 0
	lw $ra, ($sp)		# recupera o retorno para a main
	addi $sp, $sp, 4	# libera o espa�o na pilha
	move $v0, $a3		# endere�o da matriz para retorno
	jr $ra

percorreLinhas:
	subi $sp, $sp, 4	# espa�o para 1 item na pilha
	sw $ra, ($sp)		# salva o retorno para a main
	move $a3, $a0		# aux = endere�o base de matriz
	li $s0, 0		# soma = 0
	li $t7, 0		# variavel intermediaria = 0
	
pL:	jal indice		# calcula o endere�o de matriz[i][j]

	lw $t7, ($v0)		# t7 = valor de matriz[i][j]
	
	add $s0, $s0, $t7	# soma = soma + valor em matriz[i][j]
	
	addi, $t1, $t1, 1	# j++
	
	blt $t1, $a2, pL	# if (j < numeroColunas) goto pL
	
	bne $s0, 1, notTrue	# se soma != 1, falso
	
	li $s0, 0		# soma = 0
	
	li $t1, 0		# j = 0
	
	addi $t0, $t0, 1	# i++
	
	blt $t0, $a1, pL	# if (i < numeroLinhas) goto pL
	
	li $t0, 0		# i = 0
	
	lw $ra, ($sp)		# recupera o endere�o de retorno pra main
	addi $sp, $sp, 4	# libera espa�o na pilha
	move $v0, $a3		# endere�o base da matriz para retorno
	jr $ra 			#retorna para a main
	
notTrue:la $a0, false		# carrega o endere�o da string
	li $v0, 4		# c�digo de impress�o de string
	syscall			# imprime a stringd
	
	#temp
	move $a0, $s0		# valor de i para impressao
	li $v0, 1		# c�digo de impressao de inteiro
	syscall			# imprime i
	#temp
	
	li $v0, 10		# c�digo para finalizar o programa
	syscall			# finaliza o programa
	
percorreColunas:
	subi $sp, $sp, 4	# espa�o para 1 item na pilha
	sw $ra, ($sp)		# salva o retorno para a main
	move $a3, $a0		# aux = endere�o base de matriz
	li $s0, 0		# soma = 0
	li $t0, 0		# $t0 = 0
	li $t1, 0		# $t2 = 0
	li $t7, 0		# variavel intermediaria = 0
	
pC:	jal indice		# calcula o endere�o de matriz[i][j]

	lw $t7, ($v0)		# t7 = valor de matriz[i][j]
	
	add $s0, $s0, $t7	# soma = soma + valor em matriz[i][j]
	
	addi, $t0, $t0, 1	# i++
	
	blt $t0, $a1, pC	# if (i < numeroLinhas) goto pL
	
	bne $s0, 1, notTrue	# se soma != 1, falso
	
	li $s0, 0		# soma = 0
	
	li $t0, 0		# i = 0
	
	addi $t1, $t1, 1	# j++
	
	blt $t1, $a2, pC	# if (j < numeroColunas) goto pL
	
	li $t1, 0		# j = 0
	
	lw $ra, ($sp)		# recupera o endere�o de retorno pra main
	addi $sp, $sp, 4	# libera espa�o na pilha
	move $v0, $a3		# endere�o base da matriz para retorno
	jr $ra 			#retorna para a main