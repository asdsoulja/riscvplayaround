.data
.text
.globl _start
_start: # setup the parameters to implement Fib(x) function.

main:
    
    li s1, 0 # value of 0
    li s2, 1 # value of 1
    li s3, 0 # first processing number
    li s4, 1 # second processing number
    li x10, 7 # input x value, target value
    li s6, 1 # sequential counter for the value contained in the bigger processing value
    beq x10, s2, exit1 # first number of Fibonacci sequence is 1, so if 1 is inputted - return 1
    j loop # jump to the looping part where the result is calculated
    
    
loop:
    
    beq s6, x10, exit # if counter reached target value we can quit the program
    add t1, s3, s4 # create temp value to store the new value of fib sequence
    ori s3, s4, 0 # set first value = second value
    ori s4 t1, 0 # set second value = new value
    addi s6, s6, 1 # add +1 to counter
    j loop # repeat the loop
    
    
exit: # code to return the result and exit
    
    add a0, x0, s4 # put s4 to the output field as output value
    addi a7, x0, 1 # put the code for output
    ecall
    addi a0, x0, 0 # put 0 as exit code to the output field
    addi a7, x0, 93 # put the code to exit the program
    ecall
    
    

exit1: # code to return 1 and exit
    
    li a0, 1 # put 1 to the output field as output value
    addi a7, x0, 1 # put the code for output
    ecall
    addi a0, x0, 0 # put 0 as exit code to the output field
    addi a7, x0, 93 # put the code to exit the program
    ecall