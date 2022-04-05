.data 
msg1: .asciiz "\nEntre com um valor 'N' que seja inteiro e (N>1):"
msg2: .asciiz "\nO n�mero digitado n�o � primo!"
msg3: .asciiz "\nO n�mero digitado � primo!"
msg4: .asciiz "\nOs n�meros primos que v�o at� o numero "
msg5: .asciiz "\nOs "
msg6: .asciiz " primeiros n�meros primos s�o: "
msg7: .asciiz " s�o os seguintes: "
msg8: .asciiz ", "
.text
.globl main
main:
	add $t0,$zero,$zero #Limpamos o conte�do de $t0 para garantir que seja zero
	add $t1,$zero,$zero #Limpamos o conte�do de $t1 para garantir que seja zero
	add $t2,$zero,$zero #Limpamos o conte�do de $t2 para garantir que seja zero
	add $t3,$zero,$zero #Limpamos o conte�do de $t2 para garantir que seja zero
	add $t4,$zero,$zero #Limpamos o conte�do de $t2 para garantir que seja zero
	add $t5,$zero,$zero #Limpamos o conte�do de $t2 para garantir que seja zero
	valorN:
		li $v0,4 #Codigo Syscall para escrever string
		la $a0,msg1 #PAr�metro string a ser escrita
		syscall
		li $v0,5 #Codigo Syscall para ler inteiros
		syscall
		add $t0,$v0,$zero #Armazena em $t0 o numero de inteiros
		blt $t0, 1, invalido #Vai para invalido caso valor seja menor que 1
		j loop_calculodigitado #vai para analisar se o numero digitado � primo ou nao
	invalido:
		li $v0,4 #C�digo Syscall escrever string
		la $a0,msg2 #Par�metro a ser escrito
		syscall
		j final #Pula para o final, para aguardar um ultimo enter
	
	eprimo:
		blt  $t4,3,primosateN #se so encotramos 2 divisiveis o numero � primo
		j invalido #se o $t4 for maior que 3, entao o numeor nao � primo, e ja encerra o programa
	loop_calculodigitado:
		addi $t2,$t2,1 #anda uma unidade com o valor
		bgt $t2,$t0,eprimo #Se j� chegamos no valor analisado voltamos para o loop maior analisar o proximo numero
		div $t0, $t2 #divide um valor pelo outro
		mfhi $t3 #salva em $t3 o resto da divis�o
		beqz $t3, achouumdiv #Se $t3 for zero � uma divisao exata, ent�o � divisivel um pelo outro e vai pra o label que achou divisor
		j loop_calculodigitado	#se nao for exato volta pro loop pra ir pro proximo numero
	achouumdiv:
		addi $t4,$t4,1 #adicionamos uma unidade no contador
		j loop_calculodigitado #volta pro loop de calculo
				
	primosateN:
		add $t1,$zero,$zero #Limpamos o conte�do de $t1 para garantir que seja zero
		add $t2,$zero,$zero #Limpamos o conte�do de $t2 para garantir que seja zero
		add $t3,$zero,$zero #Limpamos o conte�do de $t2 para garantir que seja zero
		add $t4,$zero,$zero #Limpamos o conte�do de $t2 para garantir que seja zero
		li $v0,4 #Codigo Syscall para escrever string
		la $a0,msg3 #Par�metro string a ser escrita
		syscall
		li $v0,4 #Codigo Syscall para escrever string
		la $a0,msg4 #Par�metro string a ser escrita
		syscall
		li $v0,1 #Codigo Syscall para escrever inteiros
		add $a0,$zero,$t0 #Parametro inteiro a ser escrito
		syscall
		li $v0,4 #Codigo Syscall para escrever string
		la $a0,msg7 #Par�metro string a ser escrita
		syscall
		li $v0,1 #Codigo Syscall para escrever inteiros
		add $a0,$zero,1 #Parametro inteiro a ser escrito
		syscall
		addi $t1,$t1,1 #Come�amos a analisar a partir do 2 ent�o, Se o numero digitado for 1 ele vai analisar o $t1 e ir pro final
		j loop_primosateN #n�o queremos que analise o zero como primo, ent�o pulamos nesse primeiro loop o seraqueeprimo
	seraqueeprimo:
		blt  $t4,3,imprime_primosateN #se so encotramos 2 divisiveis o numero � primo
	loop_primosateN:
		addi $t1,$t1,1 #somamos uma unidade no nosso valor
		add $t2,$zero,$zero #Limpamos o conte�do de $t2 para garantir que seja zero
		add $t4,$zero,$zero #Limpamos o conte�do de $t2 para garantir que seja zero
		bgt $t1,$t0,nprimos #usando o bgt e n�o beq garantimos que o N tambem ser� impresso, e ja terminamos os primos
	loop_calculoprimo:
		addi $t2,$t2,1 #anda uma unidade com o valor
		bgt $t2,$t1,seraqueeprimo #Se j� chegamos no valor analisado voltamos para o loop maior analisar o proximo numero
		div $t1, $t2 #divide um valor pelo outro
		mfhi $t3
		beqz $t3, achoudiv #vai para label onde soma um no contador
		j loop_calculoprimo	
	achoudiv:
		addi $t4,$t4,1 #adicionamos uma unidade no contador
		j loop_calculoprimo	
	imprime_primosateN:
		li $v0,4 #Codigo Syscall para escrever string
		la $a0,msg8 #PAr�metro string a ser escrita
		syscall
		li $v0,1 #Codigo Syscall para escrever inteiros
		add $a0,$zero,$t1 #Parametro inteiro a ser escrito
		syscall
		j loop_primosateN #Volta para o loop de an�lise		
		
	nprimos:
		add $t1,$zero,$zero #Limpamos o conte�do de $t1 para garantir que seja zero
		li $v0,4 #Codigo Syscall para escrever string
		la $a0,msg5 #Par�metro string a ser escrita
		syscall
		li $v0,1 #Codigo Syscall para escrever inteiros
		add $a0,$zero,$t0 #Parametro inteiro a ser escrito
		syscall
		li $v0,4 #Codigo Syscall para escrever string
		la $a0,msg6 #Par�metro string a ser escrita
		syscall
		li $v0,1 #Codigo Syscall para escrever inteiros
		add $a0,$zero,1 #Parametro inteiro a ser escrito
		syscall
		addi $t5,$t5,1 #J� imprimimos o primeiro primo ent�o ja somamos 1 no contador
		addi $t1,$t1,1 #Come�amos a analisar a partir do 2 ent�o, Se o numero digitado for 1 ele vai analisar o $t5 e ir pro final
		j loop_nprimos #n�o queremos que analise o zero como primo, ent�o pulamos nesse primeiro loop o seraqueeprimo
	seraqueeprimo2:
		blt  $t4,3,imprime_nprimos #se so encotramos 2 divisiveis o numero � primo
	loop_nprimos:
		addi $t1,$t1,1 #somamos uma unidade no nosso valor
		add $t2,$zero,$zero #Limpamos o conte�do de $t2 para garantir que seja zero
		add $t4,$zero,$zero #Limpamos o conte�do de $t2 para garantir que seja zero
		bge $t5,$t0,final #usando o bgt e n�o beq garantimos que o N tambem ser� impresso, e ja terminamos os primos
	loop_calculoprimo2:
		addi $t2,$t2,1 #anda uma unidade com o valor
		bgt $t2,$t1,seraqueeprimo2 #Se j� chegamos no valor analisado voltamos para o loop maior analisar o proximo numero
		div $t1, $t2 #divide um valor pelo outro
		mfhi $t3
		beqz $t3, achoudiv2 #vai para label onde soma um no contador
		j loop_calculoprimo2	
	achoudiv2:
		addi $t4,$t4,1 #adicionamos uma unidade no contador
		j loop_calculoprimo2	
	imprime_nprimos:
		addi $t5,$t5,1 #somamos uma unidade no contador de primos encontrados
		li $v0,4 #Codigo Syscall para escrever string
		la $a0,msg8 #PAr�metro string a ser escrita
		syscall
		li $v0,1 #Codigo Syscall para escrever inteiros
		add $a0,$zero,$t1 #Parametro inteiro a ser escrito
		syscall
		j loop_nprimos #Volta para o loop de an�lise			
		
	final:
		li $v0,5 #Para esperar um ENTER
		syscall
