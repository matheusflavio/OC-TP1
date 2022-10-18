.data
vetor: .word 1 2 3 4 5 6 7 8 9 10 11
.text
main:
la x12, vetor
addi x13, x0, 11
jal x1, verificacpf
beq x0,x0,FIM
##### START MODIFIQUE AQUI START #####
verificacpf: jalr x0, 0(x1)
verificacnpj: jalr x0, 0(x1)
verificadastro: jalr x0, 0(x1)
##### END MODIFIQUE AQUI END #####
FIM: add x1, x0, x10