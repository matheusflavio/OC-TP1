.data
vetor: .word 1 2 3 4 5 6 7 # Vetor para ser invertido. O acompanhamento da situação pode ser visto na aba Simulator > Memory > Jump to Data

.text
main:
la x12, vetor
addi x13, x0, 7
addi x13, x13, -1
slli x13, x13, 2
add x13, x13, x12
jal x1, inverte
beq x0, x0, FIM

##### START MODIFIQUE AQUI START #####
inverte: 
##### Processo de troca de posição de x12 e x13 #####
    lw x8, 0(x12) # Carrega o endereço de x12 em x8
    lw x9, 0(x13) # Carrega o endereço de x13 em x9
    sw x8, 0(x13) # Armazena na posição x13 do vetor o valor da posição x12
    sw x9, 0(x12) # Armazena na posição x12 do vetor o valor da posição x13

##### Processo de incremento de x12 e decremento de x13. São dois "ponteiros" que andam em um direção ao outro #####
    addi x12,x12,4 # x12 passa a ser o primeiro valor do vetor original que ainda não foi invertido
    addi x13,x13,-4 # x13 passa a ser o último valor do vetor original que ainda não foi invertido
    ble x13, x12, FIM_INVERTE # Caso x13 <= x12, termina o processo de inversão, pois não há nada mais a ser invertido
    addi sp, sp, 4 # Atualiza o sp para ser sp anterior + 4
    sw x1, 0(sp) # Armazena o valor de x1 na posição sp anterior + 4
    jal x1, inverte # Caso não saia, continua o processo de inversão

FIM_INVERTE:
    lw x1, 0(sp) # Carrega em x1 o endereço armazenado anteriormente em sp
    addi sp, sp, -4 # Atualiza a posição do sp para sp - 4
    jalr x0, 0(x1) 

##### END MODIFIQUE AQUI END #####
FIM:
    add x1, x0, x0

##### A meu ver o main poderia ser reduzido assim #####
#la x12, vetor # Carregando a posição inicial do vetor em x12
#addi x13, x0, 24 # Alocando x13 como sendo 24 para armazenar a posição final do vetor
#add x13, x13, x12 # Colocando x13 na posição final do vetor
#E o fim do procedimento seria dado dentro da "função" inverte mesmo.
#### Fim de comentário dando pitaco #####
