.data
vetor: .word 1 2 3 4 5 6 7 8 9 10 11
.text
main:
la x12, vetor
addi x13, x0, 11
jal x1, verificadastro
beq x0,x0,FIM
##### START MODIFIQUE AQUI START #####
verificacpf:
	addi x14, x0, 11
    add x15, x0, x12
    addi x11, x0, 2
	jal x28, verificaDigitoCPF
    add x15, x0, x12
    add x8, x0, x0
	addi x14, x0, 12
    addi x11, x0, 2
    jal x28, verificaDigitoCPF
    addi x10, x0, 1
    jalr x0, 0(x1)

verificaDigitoCPF:
	lw x5, 0(x15) #x5 carregando o valor da memória do primeiro elemento do vetor
	addi x14, x14, -1
	add x8, x8, x0
    mul x7, x5, x14
	add x8, x8, x7 # Em x8 fica salvo os valores da soma do dígito * posição
    addi x15, x15, 4
    bgt x14, x11, verificaDigitoCPF
    addi x11, x0, 11
    div x7, x8, x11 # x7 passa a ser o valor da divisao
    mul x7, x7, x11 # x7 passa a ser o valor da multiplicação para depois pegar o resto
    sub x8, x8, x7 # x8 passa  a ser o resto de x8 - x7
    addi x11, x0, 2
  	lw x5, 0(x15)
    blt x8, x11, verificaZero
    addi x11, x0, 11
    sub x8, x11, x8
    bne x8, x5, retornaZero
    jalr x0, 0(x28)
    
verificaZero:
	bne x0, x5, retornaZero
    jalr x0, 0(x28)

verificacnpj:
    addi x13, x0, 14
    jalr x0, 0(x1)
    
verificadastro:
	slli x13, x13, 4
    add x12, x12, x13
    lw x6, 0(x12) # Carregando da memória, considerando que o valor 0/1 para saber se é CPF ou CNPJ vem após o vetor de dados (ex: xxx.xxx.xxx-xx 0 para o CPF)
    sub x12, x12, x13
    beq x6, x0, verificacpf
    addi sp, sp 4
    jal x1, verificacnpj
    jalr x0, 0(x1)

retornaZero:
	add x10, x0, x0
    jalr x0, 0(x1)
    
##### END MODIFIQUE AQUI END #####
FIM: add x1, x0, x10