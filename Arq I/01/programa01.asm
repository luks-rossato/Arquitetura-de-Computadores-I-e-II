.data 
msg1: .asciiz "\nEntre com um valor inteiro (N>1):"
msg2: .asciiz "\nO valor digitado N tem que ser maior que 1."
msg3: .asciiz "\nA soma dos valores inteiros de 1 at� N = "
.text
.globl main
main:
	add $t0,$zero,$zero #Limpamos o conte�do de $t0 para garantir que seja zero
	add $t1,$zero,$zero #Limpamos o conte�do de $t1 para garantir que seja zero
	add $t2,$zero,$zero #Limpamos o conte�do de $t2 para garantir que seja zero
	numvalores:
		li $v0,4 #Codigo Syscall para escrever string
		la $a0,msg1 #PAr�metro string a ser escrita
		syscall
		li $v0,5 #Codigo Syscall para ler inteiros
		syscall
		add $t0,$v0,$zero #Armazena em $t0 o numero de inteiros
		blt $t0, 1, invalido #Vai para invalido caso valor seja menor que 1
		j loop_valores #vai para loop_valores
	invalido:
		li $v0,4 #C�digo Syscall escrever string
		la $a0,msg2 #Par�metro a ser escrito
		syscall
		j numvalores #Pula para o numvalores, para uma nova leitura de valor v�lido
	loop_valores:
		addi $t1,$t1,1 #acrescenta uma unidade ao contador
		add $t2,$t2,$t1 #Soma a vari�vel que armazenamos o resultado ao contador
		blt $t1,$t0,loop_valores #Vai para loop_valores caso $t0 seja menor que $t1
	li $v0,4 #Codigo Syscall para escrever string
	la $a0,msg3 #PAr�metro string a ser escrita
	syscall
	li $v0,1 #Codigo syscall para escrever inteiros
	add $a0, $zero, $t2 #Inteiro a ser escrito
	syscall
	li $v0,5 #Para esperar um ENTER
	syscall
		
	
