x:
.word 10
.align 2
.type x, @object
.size x, 4


.global glob
.ent glob
.type glob, @function
glob:
addiu $sp , $sp , -8
sw $31 , 4($sp)
sw $fp , 0($sp)
addu $fp , $sp , $0
addiu $2 , $0 , 0x0
sw $2 , %lo(x)(2)
lui $2 , %hi(x)
lw $2 , %lo(x)($2)
addu $2 , $2 , $0
andi $2 , $2 , 0x00ff
b $E0
nop
$E0:
addu $sp , $fp , $0
lw $fp , 0($sp)
sw $31 , 4($sp)
addiu $sp , $sp , 8
j $31
nop
.end glob
