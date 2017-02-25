# Homework 3
#
# <insert date>					<student name here>
#
# DO NOT DELETE THIS LINE: Homework 3 Alternative starting point: altHW2-2.asm
# 
#     When Harry Met Sally
#
#
# This program finds the earliest point at which Harry and Sally lived in the
# same city.
#
#  required output register usage:
#  $2: earliest year in same city
#
# Baseline Solution
#
# $1:  Harry base address
# $2:  answer given to swi 587
# $3:  max H index (8*4)
# $11: current time interval start time in Harry timeline
# $12: current city in Harry timeline
# $13: current time interval end time in Harry timeline
# $14: current time interval start time in Sally timeline
# $15: current city in Sally timeline
# $16: current time interval end time in Sally timeline
# $17: max S index
# $18: temp value
# $19: temp value
# $20: predicate register
# $21: Harry timeline index
# $22: Sally timeline index
	
.data
Harry:  .alloc  10               # allocate static space for 5 moves
Sally:  .alloc  10               # allocate static space for 5 moves

.text
WhenMet:	addi  $1, $0, Harry     # set memory base
        	swi   586               # create timelines and store them

		addi  $21, $0, 0	# initialize index into Harry TL
		
Loop:		addi  $3, $0, 40	# max H index
		addi  $22, $0, 0	# reset index into Sally TL
		slt   $20, $21, $3      # is H index still < max?
	        beq   $20, $0, Exit	# if not, exit loop
		lw    $11, Harry($21)	# read current interval start time (H)
		addi  $21, $21, 4	# compute index for current city (H)
		lw    $12, Harry($21)	# read current city (H)
		addi  $21, $21, 4	# compute index for next interval start
		bne   $21, $3, NextHYr  # is index != max index?
		addi  $13, $0, 2015	# if index=max, then end time = 2015 
		j     Inner   		#               and start inner loop
NextHYr:        lw    $13, Harry($21)	# else end time = next start time-1 (H)
		addi  $13, $13, -1	#      and start inner loop
Inner:          addi  $17, $0, 40	# max S index
		slt   $20, $22, $17     # is S index still < max?
		beq   $20, $0, ExitInner # if not, exit inner loop
		lw    $14, Sally($22)	# read current interval start time (S)
		addi  $22, $22, 4	# compute index for current city (S)
		lw    $15, Sally($22)	# read current city (S)
		addi  $22, $22, 4	# compute index for next interval start
	
		bne   $22, $3, NextSYr  # is index != max index?
		addi  $16, $0, 2015	# if index=max, then end time = 2015 
		j     CheckEndpts	# and check for time interval overlap
NextSYr:        lw    $16, Sally($22)   # else end time = next start time-1 (S)
		addi  $16, $16, -1	# and check for time interval overlap
CheckEndpts:	sub   $19, $16, $11	# S end - H start
		slt   $20, $19, $0	# Is (S end - H start) < 0?
		bne   $20, $0, Inner	# if so, continue inner loop
		sub   $18, $13, $14     # H end - S start 
		slti  $20, $18, 0	# is (H end - S start) < 0?
		bne   $20, $0, Inner	# if so, continue inner loop
		bne   $15, $12, Inner   # if S city!=H city, continue inner loop
		slt   $20, $14, $11	# S start < H start?
		bne   $20, $0, Skip	# if so, answer = H start
		add   $2, $14, $0	# else answer = S start
		j     End     		# exit nested loop and report answer
Skip:		add   $2, $11, $0	# answer = H start
		j     End     		# exit nested loop and report answer

ExitInner:      j     Loop    		# continue outer loop
Exit:           addi  $2, $0, 0		# if fall out of nested loop, answer=0

End:		swi   587		# give answer
                jr    $31               # return to caller
