#     When Harry Met Sally
#
#
# This program finds the earliest point at which Harry and Sally lived in the
# same city.
#
#  required output register usage:
#  $2: earliest year in same city
#
# 9/12/6				Sreeramamurthy Tripuramallu

.data
Harry:  .alloc  10               # allocate static space for 5 moves
Sally:  .alloc  10               # allocate static space for 5 moves

.text

WhenMet:	addi  $1, $0, Harry     # set memory base
        	swi     586             # create timelines and store them
            add $2, $0, $0          # Variable
            add $3, $0, $0          #Harry's city and upperbound
            add $4, $0, $0          #Sally's city and upperbound
            addi $6, $0, -4         #Harry's loop counter
            addi $7, $0, -4         #Sally's loop counter
            add $8, $0, $0          #Register for logicals

Loop1:      addi $6, $6, 8           #Adds 8 to $6
            addi $7, $0, -4         #Resets Sally's counter
Loop2:      addi $7, $7, 8
            lw $3, Harry($6)        #Obtains Harry/Sally cities
            lw $4, Sally($7)
            bne $3, $4, Loop2End    #Checks if cities match
            addi $3, $0, 36         #If cities match, then the bounds of the year's are checked
            beq $7, $3, setUpper2   #Set's Sally's Upperbound
            addi $1, $7, 4
            lw $4, Sally($1)
            j next2
setUpper2:  addi $4, $0, 2015       #If the counter reaches the end, then the upperbound is 2015
next2:      beq $6, $3, setUpper1   #Set's Harry's Upperbound
            addi $1, $6, 4
            lw $3, Harry($1)
            j next1
setUpper1:  addi $3, $0, 2015       #If the counter reaches the end, then the upperbound is 2015
next1:      addi $1, $6, -4         #Store the city into $2
            lw $2, Harry($1)
            slt $8, $2, $4
            beq $8, $0, Loop2End
            addi $1, $7, -4
            lw $2, Sally($1)
            slt $8, $2, $3
            beq $8, $0, Loop2End     #Determines which year is greater
            lw $2, Sally($1)
            addi $1, $6, -4
            lw $4, Harry($1)
            slt $8, $2, $4
            beq $8, $0, Year
            add $2, $0, $4
            j KickOut
Year:       add $2, $0, $2
            j KickOut
Loop2End:   slti $8, $7, 29
            bne $8, $0, Loop2
Loop1End:   slti $8, $6, 29
            bne $8, $0, Loop1
            slti $3, $4, 10
            beq $3, $0, KickOut
            sub $2, $2, $2
KickOut:    swi 587		       # give answer
            jr  $31                  # return to caller
