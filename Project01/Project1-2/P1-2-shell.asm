#    Find George Possibly Incognito in a Crowd
#
#
# This routine finds an exact match of George's face (possibly incognito)
# in a crowd.
#
# 10/23/2015                               Sreeramamurthy Tripuramallu

.data
Array:  .alloc	1024

.text

FindGeorge:	 addi	$1, $0, Array		# point to array base
		     swi	588			# generate crowd
             add $2, $0, $0
             addi $4, $0, -1
             addi $5, $0, -1
             addi $9, $0, 3
             addi $10, $0, 4
OuterL:      slti $6, $4, 64
             bnq $2, $0, End
InnerL:      slti $6, $5, 64
             bnq $2, $0, IncrementRow
             bnq $6, $0, IncrementRow
             addi $7, $31, 0
             jal pixelAtIndex
             addi $31, $7, 0
             slti $6, $8, 9
             beq $6, $0, IncrementCol
             addi $5, $5, 3
             add $3, $2, $0

             addi $7, $31, 0
             jal widthOfRow
             addi $31, $7, 0
             bnq $8, $9, Next
             addi $5, $5, -1
Next:        addi $7, $31, 0
             jal widthOfRow
             addi $31, $7, 0
             beq $8, $10, Next1
             addi $3, $3, -1
             j Next
Next1:       addi $7, $31, 0
             addi $5, $5, 1
             jal pixelAtIndex
             addi $31, $7, 0
             addi $5, $5, -1
             slti $6, $8, 9
             bnq $6, $0, Next2
             addi $5, $5, 1
             j Next1
Next2:  //check facial features

IncrementCol: addi $5, $5, 1
              j InnerL
IncrementRow: addi $5, $0, 0
              addi $4, $4, 12
              j OuterL
		      swi	553			# submit answer and check
		      jr	$31			# return to caller

pixelAtIndex: