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
		# add more code here.

		addi    $2, $0, 1986	# guess 1986 (TEMP: replace this)
		swi     587		# give answer

                jr      $31             # return to caller
