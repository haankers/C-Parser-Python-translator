.globl MAIN
.ent MAIN
.type MAIN, @function
MAIN:
addiu $sp , $sp , -8
sw $31 , 4($sp)
sw $fp , 0($sp)
move $fp , $sp
addiu $2 , $0 , 0x1
addu $2 , $2 , $0
b $E0
nop
$E0:
addu $sp , $fp , $0
lw $fp , 0($sp)
lw $31 , 4($sp)
addiu $sp , $sp , 8
j $31
nop
.end MAIN
