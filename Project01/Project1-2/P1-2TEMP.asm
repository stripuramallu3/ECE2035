#    Find George Possibly Incognito in a Crowd
#
#
# This routine finds an exact match of George's face (possibly incognito)
# in a crowd.
#
# 10/26/2015                               Sreeramamurthy Tripuramallu

.data
Array:  .alloc  1024

.text

FindGeorge:  addi $1, $0, Array
             swi    588         # generate crowd
             addi  $2, $0, -11  #Initalize colums
             addi $6, $0, 3
             addi $7, $0, 8

OuterLoop:   addi $2, $2, 11
             addi $3, $0, -64

InnerLoop:   addi $3, $3, 64
             slti $5, $3, 3585
             beq $5, $0, OuterLoop

LoadPixel:   add $4, $2, $3
             lb $5, Array($4)
CheckIfBack: beq $5, $6, MoveLeft
             bne $5, $7, InnerLoop


MoveLeft:    addi $4, $4, -1
             lb $5, Array($4)
             slti $5, $5, 9
             bne $5, $0, MoveLeft
             addi $4, $4, 1

MoveDL:      addi $4, $4, 63
             addi $3, $3, 64
             lb $5, Array($4)
             slti $5, $5, 9
             bne $5, $0, MoveDL
             addi $4, $4, -63
             addi $3, $3, -64

MoveD:       addi $4, $4, 64
             addi $3, $3, 64
             lb $5, Array($4)
             slti $5, $5, 9
             bne $5, $0, MoveD
             addi $4, $4, -64
             addi $3, $3, 448

CheckFace:   addi $4, $4, Array
             addi $1, $0, 5
             lb $5, 129($4)
             bne $5, $1, InnerLoop

             addi $1, $0, 1
             lb $5, -61($4)
             bne $5, $1, InnerLoop

CheckGeorge: addi $1, $0, 7
             lb $5, 66($4)
             bne $5, $1, CheckIGeorge

             addi $1, $0, 3
             lb $5, 0($4)
             bne $5, $1, CheckIGeorge

             lb $5, 450($4)
             bne $5, $1, CheckIGeorge

             addi $1, $0, 2
             lb $5, 260($4)
             beq $5, $1, End

CheckIGeorge: addi $1, $0, 3
              lb $5, 65($4)
              bne $5, $1, InnerLoop

              addi $1, $0, 8
              lb $5, 0($4)
              bne $5, $1, InnerLoop

              lb $5, 196($4)
              bne $5, $1, InnerLoop

              lb $5, 450($4)
              bne $5, $1, InnerLoop

End:         addi $1, $0, Array
             addi $2, $4, -251
             sub $2, $2, $1
             swi   553         # submit answer and check
             jr    $31         # return to caller

