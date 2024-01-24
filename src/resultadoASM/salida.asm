.data
helloworld: .asciiz "Hello World!"
m0: .asciiz "entra func 1"
m1: .asciiz "do"
m2: .asciiz "entra al if"
m3: .asciiz "entra a elif"
m4: .asciiz "entra al for anidado"
m5: .asciiz "segundo elif"
m6: .asciiz dir
m7: .asciiz "final"


.text
exit:
	li $v0, 10
	syscall

lw $t0, dir
lw $t1, dir
add $t2, $t0, $t1 
bloquePrint0:
	li $v0, 4
	la $a0, m0
	syscall

lw $t0, 30
lw $t1, 2
mul $t2, $t0, $t1 
bloquePrint1:
	li $v0, 4
	la $a0, m1
	syscall

lw $t0, 34
lw $t1, 33
add $t2, $t0, $t1 
bloquePrint2:
	li $v0, 4
	la $a0, m2
	syscall

bloquePrint3:
	li $v0, 4
	la $a0, m3
	syscall

lw $t0, 30
lw $t1, 2
mul $t2, $t0, $t1 
lw $t0, 30
lw $t1, 2
mul $t2, $t0, $t1 
bloquePrint4:
	li $v0, 4
	la $a0, m4
	syscall

bloquePrint5:
	li $v0, 4
	la $a0, m5
	syscall

bloquePrint6:
	li $v0, 4
	la $a0, m6
	syscall

bloquePrint7:
	li $v0, 4
	la $a0, m7
	syscall

	j exit
main:
	j bloquePrint0
	j bloquePrint1
	j bloquePrint2
	j bloquePrint3
	j bloquePrint4
	j bloquePrint5
	j bloquePrint6
	j bloquePrint7
	j exit