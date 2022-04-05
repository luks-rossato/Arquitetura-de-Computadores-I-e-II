.data 
msg1: .asciiz "sum= "
msg2: .asciiz "\n"
.text
	squares:
	.align 2
	.space 256
.globl main

	storeValues:
		addi $sp,$sp,-4 #alocamos espaço para uma variavel temporaria
		sw $t0,0($sp) #Salvamos $t0 na stack
		
		add $v0,$t0,$zero #resultado da conta
		
		lw $t0,0($sp) #Restore $s0
		addi $sp,$sp,4 #desalocamos o espaço da variavel temporaria
		
		jr $ra #Volta pra rotina que chamou
	
	computeSum:
		addi $sp,$sp,-8 #alocamos espaço para uma variavel temporaria
		
		add $v0,$t0,$zero #resultado da conta
		addi $sp,$sp,8 #desalocamos o espaço da variavel temporaria
		jr $ra #Volta pra rotina que chamou
		
main:
	add $t0,$zero,$zero #Limpamos o conteúdo de $t0 para garantir que seja zero
	add $t1,$zero,$zero #Limpamos o conteúdo de $t1 para garantir que seja zero
	add $t2,$zero,$zero #Limpamos o conteúdo de $t2 para garantir que seja zero
	add $t3,$zero,$zero #Limpamos o conteúdo de $t2 para garantir que seja zero
	add $t4,$zero,$zero #Limpamos o conteúdo de $t2 para garantir que seja zero
	add $t5,$zero,$zero #Limpamos o conteúdo de $t2 para garantir que seja zero
	
	li $v0,5 #Codigo Syscall para ler inteiros
	syscall
	add $t0,$v0,$zero #Armazena em $t0 o numero de inteiros
	
	la $a0, squares
	
		