.data
helloworld: .asciiz "Hello World!"
m0: .asciiz "hola"
m1: .asciiz "
adios"
m2: .asciiz "	alvez"
m3: .asciiz "
no"


.text
exit:
	li $v0, 10
	syscall

bloquePrint0:
	li $v0, 4
	la $a0, m0
	syscall

bloquePrint1:
	li $v0, 4
	la $a0, m1
	syscall

bloquePrint2:
	li $v0, 4
	la $a0, m2
	syscall

bloquePrint3:
	li $v0, 4
	la $a0, m3
	syscall

	j exit
main:
	j bloquePrint0
	j bloquePrint1
	j bloquePrint2
	j bloquePrint3
	j exit