#     When Harry Met Sally
#
#
# This program finds the earliest point at which Harry and Sally lived in the
# same city.
#
#  required output register usage:
#  $2: earliest year in same city
#
# <insert date>					<student name here>

.data
Harry:  .alloc  10               # allocate static space for 5 moves
Sally:  .alloc  10               # allocate static space for 5 moves

.text
WhenMet:	addi  $1, $0, Harry     # set memory base
        	swi     586             # create timelines and store them	
			lw $1, Harry($0)
			lw $2, Sally($0)
			slt $3, $1, $2
			beq $3, $0, next
			add $4, $0, $2	
continue:	addi $26, $0, 1985
			add $7, $0, $0
			add $8, $0, $0
			add $9, $0, $0
			add $10, $0, $0
			add $11, $0, $0
			addi $13, $0, 8
			add $16, $0, $0
			add $18, $0, $0
wLoop: 		slt $3, $26, $4
			slti $5, $4, 2015
			and $3, $3, $5
			beq $3, $0, end
fLoop1: 	slti $3, $7, 9
			beq $3, $0, end
			beq $7, $13, setUpper1
			lw $14, Harry($16)
			addi $20, $16, 8
			lw $11, Harry($20)
			addi $16, $16, 8
			addi $7, $7, 1
comeBack1: 	slt $3, $4, $11
			bne $3, $0, fLoop1
			addi $14, $14, -1
			slt $5, $14, $4
			and $3, $3, $5
			beq $3, $0, fLoop1
			sub $8, $8, $8
			addi $17, $16, 4
			lw $8, Harry($17)
			j fLoop1
setUpper1:	sub $11, $11, $11
			addi $11, $11, 2015  
			j comeBack1
fLoop2: 	slti $3, $9, 9
			beq $3, $0, end
			beq $9, $13, setUpper2
			lw $14, Sally($18)
			addi $21, $18, 8	
			lw $12, Sally($21)
			addi $18, $18, 8
			addi $9, $9, 1
comeBack2: 	slt $3, $4, $12
			bne $3, $0, fLoop1
			addi $14, $14, -1
			slt $5, $14, $4
			and $3, $3, $5
			beq $3, $0, fLoop2
			sub $10, $10, $10
			addi $19, $18, 4
			lw $10, Sally($19)
			j fLoop2
setUpper2: 	sub $12, $12, $12
			addi $12, $12, 2015
			j comeBack2
checkPos: 	beq $8, $10, out
			addi $4, $4, 1	 
			j wLoop 
			sub $2, $2, $2
end: 		swi 587
			jr $31
out: 		sub $2, $2, $2
			add $2, $4, $0
			j end
next: 		add $4, $0, $1
			j continue
