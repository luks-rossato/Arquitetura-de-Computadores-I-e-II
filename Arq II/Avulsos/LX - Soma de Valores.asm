 .data
buffer: .asciiz " "
Arquivo: .asciiz "dados.txt"
Erro: .asciiz "Arquivo não encontrado!\n"
Res: .asciiz "O resultado da soma foi: "
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

local:	
	li $v0, 14 # codigo de leitura de arquivo
	syscall	# faz a leitura de 1 caractere
	beqz $v0, EOF # if (EOF) termina a soma
	lb $t0, ($a1) # carrega o caractere lido no buffer
	beq $t0, 32, global # if (space) goto s
	subi $t0, $t0, 48 # char para decimal
	mul $t1, $t1, 10 # transforma o numero intermediario
	add $t1, $t1, $t0 # soma da unidade lida
	j local #

global:	
	add $t2, $t2, $t1 # soma o numero lido ao somador global
	li $t1, 0 # zera o numero local
	j local 
EOF:
	add $t3, $t2, $t1 # $t3 recebe o resultado da soma
	la $a0, Res # carrega o endere?o da string
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