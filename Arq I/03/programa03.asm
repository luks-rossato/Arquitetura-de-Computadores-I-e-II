.data 
msg1: .asciiz "\nEntre com um valor 'A' que seja inteiro e (N>1):"
msg2: .asciiz "\nEntre com um valor 'B' que seja inteiro e (N>1):"
msg3: .asciiz "\nO valor digitado N tem que ser maior que 1."
msg4: .asciiz "\nOs m�ltiplos de "
msg5: .asciiz " que est�o no intervalo at� o "
msg6: .asciiz " s�o os seguintes: "
msg7: .asciiz ", "
.text
.globl main
main:
	add $t0,$zero,$zero #Limpamos o conte�do de $t0 para garantir que seja zero
	add $t1,$zero,$zero #Limpamos o conte�do de $t1 para garantir que seja zero
	add $t2,$zero,$zero #Limpamos o conte�do de $t2 para garantir que seja zero
	add $t3,$zero,$zero #Limpamos o conte�do de $t2 para garantir que seja zero
	valorA:
		li $v0,4 #Codigo Syscall para escrever string
		la $a0,msg1 #PAr�metro string a ser escrita
		syscall
		li $v0,5 #Codigo Syscall para ler inteiros
		syscall
		add $t0,$v0,$zero #Armazena em $t0 o numero de inteiros
		blt $t0, 1, invalidoA #Vai para invalido caso valor seja menor que 1
		j valorB #vai para receber valor B
	invalidoA:
		li $v0,4 #C�digo Syscall escrever string
		la $a0,msg3 #Par�metro a ser escrito
		syscall
		j valorA #Pula para o numvalores, para uma nova leitura de valor v�lido
	valorB:
		li $v0,4 #Codigo Syscall para escrever string
		la $a0,msg2 #PAr�metro string a ser escrita
		syscall
		li $v0,5 #Codigo Syscall para ler inteiros
		syscall
		add $t1,$v0,$zero #Armazena em $t0 o numero de inteiros
		blt $t1, 1, invalidoB #Vai para invalido caso valor seja menor que 1
		j result #vai para o resultado desejado
	invalidoB:
		li $v0,4 #C�digo Syscall escrever string
		la $a0,msg3 #Par�metro a ser escrito
		syscall
		j valorB #Pula para o numvalores, para uma nova leitura de valor v�lido
	result:
		li $v0,4 #Codigo Syscall para escrever string
		la $a0,msg4 #PAr�metro string a ser escrita
		syscall
		li $v0,1 #Codigo Syscall para escrever inteiros
		add $a0,$zero,$t0 #Parametro inteiro a ser escrito
		syscall
		li $v0,4 #Codigo Syscall para escrever string
		la $a0,msg5 #PAr�metro string a ser escrita
		syscall
		mul $t1,$t1,$t0 #Final do intervalo, que � 'AxB'
		li $v0,1 #Codigo Syscall para escrever inteiros
		add $a0,$zero,$t1 #Parametro inteiro a ser escrito
		syscall
		li $v0,4 #Codigo Syscall para escrever string
		la $a0,msg6 #PAr�metro string a ser escrita
		syscall
		li $v0,1 #Codigo Syscall para escrever inteiros
		add $a0,$zero,$t0 #Parametro inteiro a ser escrito
		syscall
		add $t2, $zero, $t0 #Grava em $t2 o valor de 'A' que � $t0
		addi $t1,$t1,1 #Adiciona uma unidade no final para que seja intervalo fechado
	loop:
		addi $t2,$t2,1 #anda uma unidade com o valor
		beq $t1,$t2,final #se chegamos no valor de 'B' paramos de analisar
		div $t2, $t0 #divide um pelo outro pre ver se ser� exata
		mfhi $t3 #salva em $t3 o resto da divis�o
		beqz $t3, imprime #Se $t3 for zero � uma divisao exata, ent�o � divisivel um pelo outro
		j loop	#se nao for exato volta pro loop pra ir pro proximo numero	
	imprime:
		li $v0,4 #Codigo Syscall para escrever string
		la $a0,msg7 #PAr�metro string a ser escrita
		syscall
		li $v0,1 #Codigo Syscall para escrever inteiros
		add $a0,$zero,$t2 #Parametro inteiro a ser escrito
		syscall
		j loop #Volta para o loop de an�lise
	final:
		li $v0,5 #Para esperar um ENTER
		syscall
