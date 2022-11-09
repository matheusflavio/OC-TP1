.data
vetor: .word 1 2 3 4 5 6 7 8 9 10 11
.text
main:
la x12, vetor
addi x13, x0, 11
addi x14, x0, 0
jal x1, verificacpf
beq x0,x0,FIM

##### START MODIFIQUE AQUI START #####

# Mesmo olhando no fórum não entendi como que o valor para definir se é CPF ou CNPJ é passado (e julgo que ele não é necessário, #
# dá para decidir apenas com as dimensões passadas no x13) #

# Se for passado direto que nem o x13, não precisa pegar na memória https://virtual.ufmg.br/20222/mod/forum/discuss.php?d=21791 #

# Se for passado como vetor na memória, ele será um adicional ao vetor original (por exemplo vetor de CPF xx.xxx.xxx-xx0) #
# ou será um outro vetor? https://virtual.ufmg.br/20222/mod/forum/discuss.php?d=19620 #

### ASSIM SENDO, FIZ 4 IMPLEMENTAÇÕES DE PASSAGEM DE DADOS PARA O verificadastro ###
### ELAS SE ENCONTRAM COM 3 COMENTADAS E 1 SEM ESTAR COMENTADA NA IMPLEMENTAÇÃO DE verificadastro ###
### Favor considerar que, mediante minha dúvida, implementei todas as formas que pensei e estão funcionais. Basta utilizar a forma que preferir ###

verificacpf:
    addi x13, x0, 11 # Seta x13 como sendo 10+1, para utilizar na soma do algoritmo de CPF 
    add x8, x0, x0    # Zera o valor de x8
    jal x28, somaDigitos # Soma os valores dos algarismos multipliados pelo dígito de posição
    jal x28, verificaDigito # Verifica se o primeiro dígito do CPF está correto
    add x8, x0, x0 # Zera o valor de x8
    addi x13, x0, 12 # Seta x13 como sendo 11+1, para utilizar na soma do algoritmo de CPF 
    jal x28, somaDigitos # Soma os valores dos algarismos multipliados pelo dígito de posição
    jal x28, verificaDigito # Verifica se o segundo dígito do CPF está correto
    addi x10, x0, 1 # Seta x10 como sendo 1 para retorno caso os dígitos estejam corretos
    jalr x0, 0(x1)

verificacnpj:
    addi x13, x0, 6 # Seta x13 como sendo 5+1, para utilizar na soma do algoritmo de CNPJ 
    add x8, x0, x0 # Zera o valor de x8
    jal x28, somaDigitos # Soma os primeiros valores dos algarismos multipliados pelo dígito de posição
    addi x13, x0, 10 # Seta x13 como sendo 9+1, para utilizar na soma do algoritmo de CNPJ 
    jal x28, somaDigitos # Soma o restante dos valores dos algarismos multipliados pelo dígito de posição sem zerar x8 para armazenar a soma completa
    jal x28, verificaDigito # Verifica se o primeiro dígito do CNPJ está correto
    addi x13, x0, 7 # Seta x13 como sendo 6+1, para utilizar na soma do algoritmo de CNPJ 
    add x8, x0, x0 # Zera o valor de x8
    jal x28, somaDigitos # Soma os primeiros valores dos algarismos multipliados pelo dígito de posição
    addi x13, x0, 10 # Seta x13 como sendo 9+1, para utilizar na soma do algoritmo de CNPJ 
    addi x11, x0, 2 # Seta x11 como sendo 2, sendo esse o menor valor em que algum algarismo é multiplicado no algoritmo do CPF
    jal x28, somaDigitos # Soma o restante dos valores dos algarismos multipliados pelo dígito de posição sem zerar x8 para armazenar a soma completa
    jal x28, verificaDigito # Verifica se o segundo dígito do CNPJ está correto
    addi x10, x0, 1 # Seta x10 como sendo 1 para retorno caso os dígitos estejam corretos
    jalr x0, 0(x1)

verificadastro:
###########################################################################################################################################################
    ## Implementação em que é passado direto ##
    #beq x0, x14, verificacpf
    #jal x28, verificacnpj

    ## Implementação em que é alocado ao final do vetor original ##
    #slli x13, x13, 2
    #add x12, x12, x13
    #lw x14, 0(x12)
    #sub x12, x12, x13
    #srli x13, x13, 2
    #beq x0, x14, verificacpf
    #jal x28, verificacnpj

    ## Implementação em que é alocado em um outro vetor ##
    #la x14, outrovetor
    #lw x15, 0(x14)
    #beq x0, x15, verificacpf
    #jal x28, verificacnpj

    ## Implementação em que não precisa da decisão, apenas analisa as dimensões ##
    addi x11, x0, 14
    blt x13, x11, verificacpf
    jal x28, verificacnpj
###########################################################################################################################################################

somaDigitos:
    addi x11, x0, 2 # Seta x11 como sendo 2, sendo esse o menor valor em que algum algarismo é multiplicado no algoritmo do CPF
    lw x5, 0(x12) # x5 carregando o valor da memória do primeiro elemento do vetor
    addi x13, x13, -1 # Reduz em uma unidade o valor de x13 para ser utilizado como multiplicação de posição
    mul x7, x5, x13 # Seta x7 como sendo dígito atual * valor da posição
    add x8, x8, x7 # Em x8 fica salvo os valores da soma do dígito * posição
    addi x12, x12, 4 # Atualiza x12 para a próxima posição do vetor
    bgt x13, x11, somaDigitos # Caso x13 > x11 (2), continua a soma
    jalr x0, 0(x28)

verificaDigito:
    addi x11, x0, 11 # x11 passa a ser 11 para pegar o resto
    div x7, x8, x11 # x7 passa a ser o valor da divisao
    mul x7, x7, x11 # x7 passa a ser o valor da multiplicação para depois pegar o resto
    sub x8, x8, x7 # x8 passa a ser o resto de x8 - x7
    addi x11, x0, 2 # x11 passa a ser 2
    lw x5, 0(x12) # Carrega o próximo elemento do vetor
    la x12, vetor # Retoma o valor original de x12 como sendo o início do vetor
    blt x8, x11, verificaZero # Se x8 é menor que 2, verifica se ele é 0
    addi x11, x0, 11 # x11 passa a ser 11 para definir o valor do dígito
    sub x8, x11, x8 # x8 = 11 - resto
    bne x8, x5, retornaZero # Se o valor de x8 não for o valor que está no vetor, retorna 0 indicando que o vetor não é válido
    jalr x0, 0(x28)

verificaZero:
    bne x0, x5, retornaZero # Caso o algarismo não seja 0, retorna 0
    jalr x0, 0(x28)

retornaZero:
    add x10, x0, x0 # Define retorno 0 como sendo CPF/CNPJ inválido
    jalr x0, 0(x1)

##### END MODIFIQUE AQUI END #####
FIM: add x1, x0, x10