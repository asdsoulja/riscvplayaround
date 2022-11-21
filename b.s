.data
str: .byte 45 50 57 52 0
.text
.globl _start
_start: # WE ASSUME THAT ALWAYS A NULL-TERMINATED BYTE STRING IS INPUTTED

main:   
    la x10, str # our byte string
    lbu s1, (0)x10 # iterator
    li t1, 45 # minus value
    li t2, 43 # plus value
    li s7, 57 # max byte value
    li s8, 48 # min byte value
    li s5, 10 # value of 10
    li s2, 0 # value we will use to depict a number
    
    beq s1, t1, minus # if first sign inputted is -
    beq s1, t2, plus # if first sign inputted is +
    bgt s1, s7, exitCrash # if NaN is inputted
    blt s1, s8, exitCrash # if NaN is inputted
    j casual # if no sign is inputted
    
    
casual:
    beq s1, x0, exit # if null inputted - stop shifting
    bgt s1, s7, exitCrash # if NaN is inputted
    blt s1, s8, exitCrash # if NaN is inputted
    mul s2, s2, s5 # multiply by 10 to make the compostisdtion of a number easier
    add s2, s2, s1 # add next value read from the byte string
    sub s2, s2, s8 # substitute 48 to get a proper int value
    
    addi x10, x10, 1 # continue shifting (1/3)
    lbu s1, (0)x10 # continue shifting (2/3)
    j casual # continue shifting (3/3)
    
    
minus: # basically just to skip the "-" sign
    addi x10, x10, 1 # continue shifting (1/3)
    lbu s1, (0)x10 # continue shifting (2/3)
    j minusloop # continue shifting (3/3)
    
    
minusloop:
    beq s1, x0, exit # if null inputted - stop shifting
    bgt s1, s7, exitCrash # if NaN is inputted
    blt s1, s8, exitCrash # if NaN is inputted
    mul s2, s2, s5 # multiply by 10 to make the compostition of a number easier
    sub s2, s2, s1 # substitute* next value read from the byte string
    add s2, s2, s8 # add* 48 to get a proper int value
    
    addi x10, x10, 1 # continue shifting (1/3)
    lbu s1, (0)x10 # continue shifting (2/3)
    j minusloop # continue shifting (3/3)
    
    
plus: # same as minus, but we can use casual loop after, i.e. no need to code plusloop
    addi x10, x10, 1 # continue shifting (1/3)
    lbu s1, (0)x10 # continue shifting (2/3)
    j casual # continue shifting (3/3)
    
    
exit: # code to return the result and exit
    addi x10, s2, 0 # save the value we got to x10
    addi a0, x0, 0 # put 0 as exit code to the output field
    addi a7, x0, 93 # put the code to exit the program
    ecall
    

exitCrash: # if NaN entered
    li x10, -1 # save -1 error code to x10
    addi a0, x0, 0 # put 0 as exit code to the output field
    addi a7, x0, 93 # put the code to exit the program
    ecall