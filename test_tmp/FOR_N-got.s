.globl func
.ent func
.type func, @function
func:
addiu $sp , $sp , -16
sw $31 , 12($sp)
sw $fp , 8($sp)
move $fp , $sp
addiu $2 , $0 , 0x5
sw $2 , 4($fp)
$L1:
lw $2 , 4($fp)
addiu $3 , $0 , 0x0
slt $2 , $2 , $3
xori $2 , $2 , 0x1
beq $2 , $0 , $L2
nop
lw $2 , 4($fp)
addiu $3 , $0 , 0x0
xor $2 , $2 , $3
sltu $2 , $2 , 1
beq $2 , $0 , $L3
nop
addiu $2 , $0 , 0x0
addu $2 , $2 , $0
b $E0
nop
$L3:
lw $2 , 4($fp)
addiu $3 , $0 , 0x1
subu $2 , $2 , $3
sw $2 , 4($fp)
b $L1
nop
$L2:
addiu $3 , $0 , 0x2
addu $2 , $3 , $0
b $E0
nop
$E0:
addu $sp , $fp , $0
lw $fp , 8($sp)
lw $31 , 12($sp)
addiu $sp , $sp , 16
j $31
nop
.end func
