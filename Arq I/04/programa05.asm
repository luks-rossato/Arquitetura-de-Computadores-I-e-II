.data 
msg1: .asciiz "\nEntre com um valor 'N' que seja inteiro e (N>1):"
msg2: .asciiz " não é Perfeito!"
msg3: .asciiz " é Perfeito!"
msg4: .asciiz "\nO número digitado não é válido, tente novamente (N>1): "
msg5: .asciiz "\nO número "
msg6: .asciiz " é Perfeito! "
.text
.globl main
main:
	add $t0,$zero,$zero #Limpamos o conteúdo de $t0 para garantir que seja zero
	add $t1,$zero,$zero #Limpamos o conteúdo de $t1 para garantir que seja zero
	add $t2,$zero,$zero #Limpamos o conteúdo de $t2 para garantir que seja zero
	add $t3,$zero,$zero #Limpamos o conteúdo de $t2 para garantir que seja zero
	add $t4,$zero,$zero #Limpamos o conteúdo de $t2 para garantir que seja zero
	add $t5,$zero,$zero #Limpamos o conteúdo de $t2 para garantir que seja zero
	numeroN:
		li $v0,4 #Codigo Syscall para escrever string
		la $a0,msg1 #PArâmetro string a ser escrita
		syscall
		li $v0,5 #Codigo Syscall para ler inteiros
		syscall
		add $t0,$v0,$zero #Armazena em $t0 o numero de inteiros
		blt $t0, 1, invalido #Vai para invalido caso valor seja menor que 1
		j loop_calculodigitado #vai para analisar se o numero digitado é primo ou nao
	invalido:
		li $v0,4 #Código Syscall escrever string
		la $a0,msg4 #Parâmetro a ser escrito
		syscall
		j numeroN #Pula para o final, para aguardar um ultimo enter
		
	testeperfeito:
		beq $t4,$t0,perfeito #se so encotramos a soma dos divisiveis igual ao N é perfeito
		j naoperfeito #se o $t4 for diferente de N, entao o numeor nao é perfeito, e ja encerra o programa
	loop_calculodigitado:
		addi $t2,$t2,1 #anda uma unidade com o valor
		beq $t2,$t0,testeperfeito #Se já chegamos no valor analisado voltamos para o loop maior analisar o proximo numero
		div $t0, $t2 #divide um valor pelo outro
		mfhi $t3 #salva em $t3 o resto da divisão
		beqz $t3, achouumdiv #Se $t3 for zero é uma divisao exata, então é divisivel um pelo outro e vai pra o label que achou divisor
		j loop_calculodigitado	#se nao for exato volta pro loop pra ir pro proximo numero
	achouumdiv:
		add $t4,$t4,$t2 #adicionamos uma unidade no contador
		j loop_calculodigitado #volta pro loop de calculo
	perfeito:
		li $v0,4 #Codigo Syscall para escrever string
		la $a0,msg5 #Parâmetro string a ser escrita
		syscall
		li $v0,1 #Codigo Syscall para escrever inteiros
		add $a0,$zero,$t0 #Parametro inteiro a ser escrito
		syscall
		li $v0,4 #Codigo Syscall para escrever string
		la $a0,msg3 #Parâmetro string a ser escrita
		syscall
		j final
	naoperfeito:
		li $v0,4 #Codigo Syscall para escrever string
		la $a0,msg5 #Parâmetro string a ser escrita
		syscall
		li $v0,1 #Codigo Syscall para escrever inteiros
		add $a0,$zero,$t0 #Parametro inteiro a ser escrito
		syscall
		li $v0,4 #Codigo Syscall para escrever string
		la $a0,msg2 #Parâmetro string a ser escrita
		syscall
		j final
	final:
		li $v0,5 #Para esperar um ENTER
		syscall