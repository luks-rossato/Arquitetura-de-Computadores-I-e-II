.data
vetor: .word -2,4,7,-3,5,6
msg1: .asciiz "\nA soma dos valores positivos = "
msg2: .asciiz "\nA soma dos valores negativos = "
.text
.globl main
main:
	add $t0,$zero,$zero #Limpamos o conte�do de $t0 para garantir que seja zero
	add $t1,$zero,$zero #Limpamos o conte�do de $t1 para garantir que seja zero
	add $t2,$zero,$zero #Limpamos o conte�do de $t2 para garantir que seja zero
	add $t3,$zero,$zero #Limpamos o conte�do de $t3 para garantir que seja zero
	la $s0,vetor #carrega em $s0 a primeira posi��o do vetor
	lw $t0,($s0) #Carrega em $t0 o valor que est� em $s0
	somavalores:
		addi $t3,$t3,1 #soma um no contador
		bgt $t3,6,result #Se $t3 que � nosso contador for maior que 5 vai para os resultados
		ble $t0,0,somaneg #Se o $t0 for menor que 0, � negativo, ent�o vai pra soma negativa
		somapos:
			add $t1,$t1,$t0 #Soma no acumulador $t1 o valor que est� em $t0, que � o do vetor
			addi $s0,$s0,4 #Vai pra pr�xima posi��o do vetor
			lw $t0,($s0) #Carrega em $t0 o valor que est� em $s0
			j somavalores #vai para o soma valores
		somaneg:
			sub $t2,$t2,$t0 #"soma" no acumulador $t2
			addi $s0,$s0,4 #vai pra pr�xima posi��o do vetor
			lw $t0,($s0) #Carrega em $t0 o valor que est� em $s0
			j somavalores #vai para o soma valores
	result:
		li $v0,4 #Codigo Syscall para escrever string
		la $a0,msg1 #PAr�metro string a ser escrita
		syscall
		li $v0,1 #Codigo syscall para escrever inteiros
		add $a0, $zero, $t1 #Inteiro a ser escrito
		syscall
		li $v0,4 #Codigo Syscall para escrever string
		la $a0,msg2 #PAr�metro string a ser escrita
		syscall
		li $v0,1 #Codigo syscall para escrever inteiros
		sub $a0, $zero, $t2 #Inteiro a ser escrito
		syscall
		li $v0,5 #Para esperar um ENTER
		syscall