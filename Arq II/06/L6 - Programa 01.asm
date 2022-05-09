 .data
buffer: .asciiz " "
Arquivo: .asciiz "dados1.txt"
Erro: .asciiz "Arquivo não encontrado!\n"
Resmaior: .asciiz "\nO maior valor encontrado foi: "
Resmenor: .asciiz "\nO menor valor encontrado foi: "
Respar: .asciiz "\nO numero de pares encontrados foi: "
Resimpar: .asciiz "\nO numero de impares encontrados foi: "
Ressoma: .asciiz "\nO resultado da soma foi: "
Resprod: .asciiz "\nO resultado do produto foi: "
Rescarac: .asciiz "\nO numero de caracteres é de: "
.text
main:
	la $a0, Arquivo # Nome do arquivo
	li $a1, 0 # Somente leitura
	jal abertura # Retorna file descriptor no sucesso
	move $s0, $v0 # Salva o file descriptor em $s0
	move $a0, $s0 # Parâmetro file descriptor
	la $a1, buffer # Buffer de entrada
	li $a2, 1 # 1 caractere por leitura
	jal soma # Retorna
	jal reabrirArquivo	# reabre o arquivo
	jal maior
	jal reabrirArquivo	# reabre o arquivo
	jal menor
	jal reabrirArquivo
	jal par
	jal reabrirArquivo
	jal impar
	jal reabrirArquivo
	jal multiplicacao
	jal reabrirArquivo
	jal caracter
	li $v0, 16 # Código para fechar o arquivo
	move $a0, $s0 # Parâmetro file descriptor
	syscall # Fecha o arquivo
	li $v0, 10 # Código para finalizar o programa
	syscall # Finaliza o programa

soma:		
	li $t0, 0 # $t0 = 0
	li $t1, 0 # $t1 = 0
	li $t2, 0 # $t2 = 0
	li $t3, 0 # $t3 = 0

localsoma:	
	li $v0, 14 # codigo de leitura de arquivo
	syscall	# faz a leitura de 1 caractere
	beqz $v0, EOFsoma # if (EOF) termina a soma
	lb $t0, ($a1) # carrega o caractere lido no buffer
	beq $t0, 32, globalsoma # if (space) goto s
	subi $t0, $t0, 48 # char para decimal
	mul $t1, $t1, 10 # transforma o numero intermediario
	add $t1, $t1, $t0 # soma da unidade lida
	j localsoma #

globalsoma:	
	add $t2, $t2, $t1 # soma o numero lido ao somador global
	li $t1, 0 # zera o numero local
	j localsoma 
EOFsoma:
	add $t3, $t2, $t1 # $t3 recebe o resultado da soma
	la $a0, Ressoma # carrega o endere?o da string
	li $v0, 4 # c?digo para printar string
	syscall	# printa a string
	move $a0, $t3 # parametro $a0 recebe o resultado
	li $v0, 1 # c?digo para printar int
	syscall	# printa o int
	jr $ra # retorna para a main

maior:		
	li $t0, 0 # $t0 = 0
	li $t1, 0 # $t1 = 0
	li $t2, 0 # $t2 = 0
	li $t3, 0 # $t3 = 0

localmaior:	
	li $v0, 14 # codigo de leitura de arquivo
	syscall	# faz a leitura de 1 caractere
	beqz $v0, EOFmaior # if (EOF) termina a soma
	lb $t0, ($a1) # carrega o caractere lido no buffer
	beq $t0, 32, globalmaior # if (space) goto s
	subi $t0, $t0, 48 # char para decimal
	mul $t1, $t1, 10 # transforma o numero intermediario
	add $t1, $t1, $t0 # soma da unidade lida
	j localmaior #

globalmaior:	
	move $t2, $t1 # soma o numero lido ao somador global
	blt $t2, $t3, cont
	move $t3, $t2
cont:	li $t1, 0 # zera o numero local
	j localmaior 
EOFmaior:
	add $t3, $t2, $t1 # $t3 recebe o resultado da soma
	la $a0, Resmaior # carrega o endere?o da string
	li $v0, 4 # c?digo para printar string
	syscall	# printa a string
	move $a0, $t3 # parametro $a0 recebe o resultado
	li $v0, 1 # c?digo para printar int
	syscall	# printa o int
	jr $ra # retorna para a main

menor:		
	li $t0, 0 # $t0 = 0
	li $t1, 0 # $t1 = 0
	li $t2, 0 # $t2 = 0
	li $t3, 1000 # $t3 = 0

localmenor:	
	li $v0, 14 # codigo de leitura de arquivo
	syscall	# faz a leitura de 1 caractere
	beqz $v0, EOFmenor # if (EOF) termina a soma
	lb $t0, ($a1) # carrega o caractere lido no buffer
	beq $t0, 32, globalmenor # if (space) goto s
	subi $t0, $t0, 48 # char para decimal
	mul $t1, $t1, 10 # transforma o numero intermediario
	add $t1, $t1, $t0 # soma da unidade lida
	j localmenor #

globalmenor:	
	move $t2, $t1 #salva o valor
	bgt $t2, $t3, contme
	move $t3, $t2
contme:	li $t1, 0 # zera o numero local
	j localmenor 
EOFmenor:
	la $a0, Resmenor # carrega o endere?o da string
	li $v0, 4 # c?digo para printar string
	syscall	# printa a string
	move $a0, $t3 # parametro $a0 recebe o resultado
	li $v0, 1 # c?digo para printar int
	syscall	# printa o int
	jr $ra # retorna para a main
	
par:		
	li $t0, 0 # $t0 = 0
	li $t1, 0 # $t1 = 0
	li $t2, 0 # $t2 = 0
	li $t3, 0 # $t3 = 0
	li $t4, 0

localpar:	
	li $v0, 14 # codigo de leitura de arquivo
	syscall	# faz a leitura de 1 caractere
	beqz $v0, EOFpar # if (EOF) termina a soma
	lb $t0, ($a1) # carrega o caractere lido no buffer
	beq $t0, 32, globalpar # if (space) goto s
	subi $t0, $t0, 48 # char para decimal
	mul $t1, $t1, 10 # transforma o numero intermediario
	add $t1, $t1, $t0 # soma da unidade lida
	j localpar #

globalpar:	
	move $t2, $t1 # soma o numero lido ao somador global
	div $t2, $t2, 2
	mfhi $t4
	bnez $t4, contpar
	addi $t3, $t3, 1
contpar:	li $t1, 0 # zera o numero local
	j localpar
EOFpar:
	la $a0, Respar # carrega o endere?o da string
	li $v0, 4 # c?digo para printar string
	syscall	# printa a string
	move $a0, $t3 # parametro $a0 recebe o resultado
	li $v0, 1 # c?digo para printar int
	syscall	# printa o int
	jr $ra # retorna para a main

impar:		
	li $t0, 0 # $t0 = 0
	li $t1, 0 # $t1 = 0
	li $t2, 0 # $t2 = 0
	li $t3, 0 # $t3 = 0
	li $t4, 0

localimpar:	
	li $v0, 14 # codigo de leitura de arquivo
	syscall	# faz a leitura de 1 caractere
	beqz $v0, EOFimpar # if (EOF) termina a soma
	lb $t0, ($a1) # carrega o caractere lido no buffer
	beq $t0, 32, globalimpar # if (space) goto s
	subi $t0, $t0, 48 # char para decimal
	mul $t1, $t1, 10 # transforma o numero intermediario
	add $t1, $t1, $t0 # soma da unidade lida
	j localimpar #

globalimpar:	
	move $t2, $t1 # soma o numero lido ao somador global
	div $t2, $t2, 2
	mfhi $t4
	beqz $t4, contimpar
	addi $t3, $t3, 1
contimpar:	li $t1, 0 # zera o numero local
	j localimpar
EOFimpar:
	la $a0, Resimpar # carrega o endere?o da string
	li $v0, 4 # c?digo para printar string
	syscall	# printa a string
	move $a0, $t3 # parametro $a0 recebe o resultado
	li $v0, 1 # c?digo para printar int
	syscall	# printa o int
	jr $ra # retorna para a main
	
multiplicacao:		
	li $t0, 0 # $t0 = 0
	li $t1, 0 # $t1 = 0
	li $t2, 1 # $t2 = 0
	li $t3, 0 # $t3 = 0

localmul:	
	li $v0, 14 # codigo de leitura de arquivo
	syscall	# faz a leitura de 1 caractere
	beqz $v0, EOFmul # if (EOF) termina a soma
	lb $t0, ($a1) # carrega o caractere lido no buffer
	beq $t0, 32, globalmul # if (space) goto s
	subi $t0, $t0, 48 # char para decimal
	mul $t1, $t1, 10 # transforma o numero intermediario
	add $t1, $t1, $t0 # soma da unidade lida
	j localmul #

globalmul:	
	mul $t2, $t2, $t1 # soma o numero lido ao somador global
	li $t1, 0 # zera o numero local
	j localmul
EOFmul:
	add $t3, $t2, $t1 # $t3 recebe o resultado da soma
	la $a0, Resprod # carrega o endere?o da string
	li $v0, 4 # c?digo para printar string
	syscall	# printa a string
	move $a0, $t3 # parametro $a0 recebe o resultado
	li $v0, 1 # c?digo para printar int
	syscall	# printa o int
	jr $ra # retorna para a main

caracter:		
	li $t0, 0 # $t0 = 0
	li $t1, 0 # $t1 = 0
	li $t2, 0 # $t2 = 0
	li $t3, 0 # $t3 = 0

localcarac:	
	li $v0, 14 # codigo de leitura de arquivo
	syscall	# faz a leitura de 1 caractere
	beqz $v0, EOFcarac # if (EOF) termina a soma
	lb $t0, ($a1) # carrega o caractere lido no buffer
	beq $t0, 32, globalcarac # if (space) goto s
	subi $t0, $t0, 48 # char para decimal
	mul $t1, $t1, 10 # transforma o numero intermediario
	add $t1, $t1, $t0 # soma da unidade lida
	j localcarac #

globalcarac:	
	addi $t2, $t2, 2 # incrementa o contador de caracter
	li $t1, 0 # zera o numero local
	j localcarac
EOFcarac:
	add $t3, $t2, 1 # $t3 recebe o resultado da soma
	la $a0, Rescarac # carrega o endere?o da string
	li $v0, 4 # c?digo para printar string
	syscall	# printa a string
	move $a0, $t3 # parametro $a0 recebe o resultado
	li $v0, 1 # c?digo para printar int
	syscall	# printa o int
	jr $ra # retorna para a main
	
	

abertura:
	li $v0, 13 # Código de abertura de arquivo
	syscall # Tenta abrir o arquivo
	bgez $v0, a # if(file_descriptor >= 0) goto a
	la $a0, Erro # else erro: carrega o endereço da string
	li $v0, 4 # Código de impressão de string
	syscall # Imprime o erro
	li $v0, 10 # Código para finalizar o programa
	syscall # Finaliza o programa

a: jr $ra # Retorna para a main

reabrirArquivo:	subi $sp, $sp, 4	# espaco para 1 item na pilha
		sw $ra, ($sp)		# salva o retorno para a main
		jal fecharArquivo	# fecha o arquivo
		la $a0, Arquivo		# nome do arquivo
		li $a1, 0 		# somente leitura
		jal abertura		# retorna file descriptor no sucesso
		move $s0, $v0		# salva file descriptor em $s0
		move $a0, $s0		# parametro $a0 recebe file descriptor
		la $a1, buffer		# buffer de entrada
		li $a2, 1		# caractere por leitura
		lw $ra, ($sp)		# recupera o retorno para a main
		addi $sp, $sp, 4	# libera espaco na pilha
		jr $ra			# retorna para a main

fecharArquivo:	li $v0, 16		# c?digo para fechar o arquivo
		move $a0, $s0		# parametro $a0 recebe file descriptor
		syscall			# fecha o arquivo
		jr $ra			# retorna para o caller
