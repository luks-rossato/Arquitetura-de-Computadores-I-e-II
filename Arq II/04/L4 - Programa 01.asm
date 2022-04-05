.data
Mat1: .space 48 # 4x3 + 4 (inteiro)
Entl: .asciiz " Insira o valor de Mat1["
Ent2: .asciiz "]["
Ent3: .asciiz "]: "
Mat2: .space 12 # 3x3 + 4 (inteiro)
Ent4: .asciiz " Insira o valor de Mat1["
Ent5: .asciiz "]["
Ent6: .asciiz "]: "
Res: .asciiz "A Matriz resultante �:\n"
.text

main: 
	la $a0, Mat1 # Endere�o base de Mat
        li $a1, 3 # N�mero de linhas
        li $a2, 4 # Nimero de colunas
        jal leitura # leitura (mat, nlin, ncol)
        la $a0, Mat2 # Endere�o base de Mat
        li $a1, 3 # N�mero de linhas
        li $a2, 1 # Nimero de colunas
        jal leitura # leitura (mat, nlin, ncol)
        la $a0, Mat1 # Endere�o base de Mat
        la $a1, Mat2 # Endere�o base de Mat
        jal multiplica
        li $v0, 10 # C�digo para finalizar o programa
        syscall # Finaliza o programa
        
indice:
	mul $v0, $t0, $a2 # i + ncol
	add $v0, $v0, $t1 # (i * ncol) + j
	sll $v0, $v0, 2 # [(i * ncol) + j] * 4 (inteiro)
	add $v0, $v0, $a3 # Soma o endere�o base de mat
	jr $ra # Retorna para o caller
   
leitura:
	subi $sp, $sp, 4 # Espa�o para 1 item na pilha
	sw $ra, ($sp) # Salva o retorno para a main
	move $a3, $a0 # aux = endere�o base de mat
l:      la $a0, Entl # Carrega o endere�o da string
	li $v0, 4 # C�digo de impress�o de string
	syscall # Imprime a string
	move $a0, $t0 # Valor de i para impress�o
	li $v0, 1 # C�digo de impress�o de inteiro
	syscall # Imprine i
 	la $a0, Ent2 # Carrega o endere�o da string
  	li $v0, 4 # C�digo de impress�o de string
  	syscall # Imprime a string
  	move $a0, $t1 # Valor de j para impress�o
  	li $v0, 1 # C�digo de impress�o de inteiro
  	syscall # Imprine j
  	la $a0, Ent3 # Carrega o endere�o da string
  	li $v0, 4 # C�digo de impress�o de string
	syscall # Imprine a string
	li $v0, 5 # C�digo de leitura de inteiro
	syscall # Leitura do valor (retorna em qvo)
	move $t2, $v0 # aux = valor 1lido
	jal indice # Calcula o endere�o de mat [i] [jl
	sw $t2, ($v0) # mat [i] [j] = aux
	addi $t1, $t1, 1 # j++
	blt $t1, $a2, l # if(j < ncol) goto 1
	li $t1, 0 #j = 0
	addi $t0, $t0, 1 # i++
       	blt $t0, $a1, l # if(i < nlin) goto 1
	li $t0, 0 #i = 0
	lw $ra, ($sp) # Recupera o retorno para a main
	addi $sp, $sp, 4 # Libera o espa�o na pilha
	move $v0, $a3 # Endere�o base da matriz para retorno
	jr $ra # Retorna para a main
	
escrita:
   	subi $sp, $sp, 4 # Espa�o para 1 item na pilha
   	sw $ra, ($sp) # Salva o retorno para a main
   	move $a3, $a0 # aux = endere�o base de mat
e: 
	jal indice # Calcula o endere�o de mat [i] [j]
  	lw $a0, ($v0) # Valor em mat [i][j]
  	li $v0, 1 # C�digo de impress�o de inteiro
   	syscall # Imprine mat [i] [j]
  	la $a0, 32 # C�digo ASCII para espa�o
   	li $v0, 11 # C�digo de impress�o de caractere
  	syscall # Imprime o espa�o
   	addi $t1, $t1, 1 # j++
   	blt $t1, $a2, e # if(j < ncol) goto e
   	la $a0, 10 # C�digo ASCII para newline ('\n')
   	syscall # Pula a linha
  	li $t1, 0 # j = 0
   	addi $t0, $t0, 1 # i++
   	blt $t0, $a1, e # if(i < nlin) goto e
  	li $t0, 0 #i - 0
   	lw $ra, ($sp) # Recupera o retorno para a main
   	addi $sp, $sp, 4 # Liberao espa�o na pilha
   	move $v0, $a3 # Endere�o base da matriz para retorn0
   	jr $ra # Retorna para a main

multiplica:
	li $t5, 0 #Zera a vari�vel
	li $t7, 0 #Zera a vari�vel
	li $s0, 0 #Zera a vari�vel
	move $t1, $a0 #Salva o endere�o de mat1
	move $t2, $a1  #Salva o endere�o de mat2
	la $a0, Res #Imprime o texto
	li $v0, 4
	syscall
	
	
m:	lw $t3, ($t1)
	lw $t4, ($t2)
	mul $t6, $t3, $t4
	add $t5, $t5, $t6
	addi $t7, $t7, 1
	addi $t1, $t1, 4
	add $t2, $t2, 4
	blt $t7, 3, m
	move $t2, $a1
	addi $s0, $s0, 1
	li $t7, 0
	
	la $a0, 10
	li $v0, 11
	syscall
	move $a0, $t5
	li $v0, 1
	syscall
	
	li $t5, 0
	blt $s0, 3, m
	jr $ra