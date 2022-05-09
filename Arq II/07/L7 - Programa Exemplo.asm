.data
Arquivo: .asciiz "teste_escrita.txt"
Msg: .asciiz "Escrevendo em um arquivo"
.text
main:
	la $a0, Arquivo
	li $a1, 1
	li $v0, 13
	syscall
	move $a0, $v0
	li $v0,
	bl