.globl function
.ent function
.type function, @function
function:
addiu $sp , $sp , -8
sw $31 , 4($sp)
sw $fp , 0($sp)
move $fp , $sp
sw $4 , 8($fp)
sw $5 , 12($fp)
sw $6 , 16($fp)
sw $7 , 20($fp)
addiu $2 , $0 , 0x1
sw $2 , 8($fp)
addiu $2 , $0 , 0x1
sw $2 , 12($fp)
addiu $2 , $0 , 0x2
sw $2 , 16($fp)
addiu $2 , $0 , 0x1
sw $2 , 20($fp)
addiu $2 , $0 , 0x0
sw $2 , 24($fp)
lw $2 , 24($fp)
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
.end function
