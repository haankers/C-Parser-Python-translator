.globl function
.ent function
.type function, @function
function:
.frame $fp,16, $ra
.mask 0x40000000, -4
.fmask 0x00000000, 0
addiu $sp , $sp , -16
sw $31 , 12($sp)
sw $fp , 8($sp)
addu $fp , $sp , $0
addiu $2 , $0 , 0x5
sw $2 , 0($fp)
addiu $2 , $0 , 0x0
sw $2 , 4($fp)
$L1:
lw $2 , 4($fp)
addiu $3 , $0 , 0x5
slt $2 , $3 , $2
beq $2 , $0 , $L2
nop
lw $2 , 0($fp)
addiu $3 , $0 , 0x1
subu $2 , $2 , $3
sw $2 , 0($fp)
lw $2 , 4($fp)
addiu $3 , $0 , 0x1
addu $2 , $2 , $3
sw $2 , 4($fp)
b $L1
nop
$L2:
lw $3 , 0($fp)
addu $2 , $3 , $0
andi $2 , $2 , 0x00ff
b $E0
nop
$E0:
addu $sp , $fp , $0
lw $fp , 8($sp)
sw $31 , 12($sp)
addiu $sp , $sp , 16
j $31
nop
.end function
