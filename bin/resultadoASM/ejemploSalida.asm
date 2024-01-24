.data
helloworld: .asciiz "Hello World!"

.text
printHello:
    li $v0, 4         # Cargar el código del sistema para imprimir una cadena
    la $a0, helloworld  # Cargar la dirección de la cadena a imprimir
    syscall           # Llamar al sistema para imprimir la cadena
    j exit           # Saltar a la etiqueta "exit"

main:
    j printHello     # Saltar a la etiqueta "printHello"

exit:
    li $v0, 10        # Cargar el código del sistema para salir
    syscall           # Llamar al sistema para salir