# HW1-3
# Student Name: Sreeramamurthy	Tripuramallu
# Date: 09/02/2015
#
# This program computes the difference in the frequency of
# boiling temperatures and the frequency of freezing temperatures in a
# set of 25 integers, Temps.

.data
Temps:    .word 110, 5, 200, -73, 0
          .word 17, 9, -7, -3, 100
          .word 25, 242, -126, 108, -60
          .word 26, 8, 60, 27, 117,
          .word 8, 7, 33, 100, 125
FreqDiff: .alloc 1

.text
	start: 		add $1, $0, $0    	#Register to store number of boiling temperatures
				add $2, $0, $0    	#Register to store number of freezing temperatures
				addi $10, $0, 99  	#Register to store immediate 99
				add $3, $0, $0	  	#Stores offset value, used to traverse Temps
				lw $6, Temps($3)  	#Loads first index of Temps into $6
	initalize: 	add $8, $0, $0    	#Register that keeps count of for-loop iterations
				addi $4, $0, 25	  	#Initalizes maximum number of iterations
	predicate: 	slt $5, $8, $4	  	#Checks if for-loop iteration is less than 25	
				beq $5, $0, endfor	#If it is, then continues, if not, for loop ends
	consequent: slti $5, $6, 1		#Checks if temperature is less than 1
				beq $5, $0, else	#If it is, then continues, if not, then moves to next label
				addi $2, $2, 1		#Increments freezing tempeatures if above condition is satisfied 
	else: 		slt $5, $10, $6		#Checks if temperature is greater than 99
				beq $5, $0, endif 	#If it is, then continues, if not then moves to next label
				addi $1, $1, 1 		#Increments boiling temperatures if above condition is satisfied
	endif: 		addi $8, $8, 1		#Increments the number for-loop iterations
				addi $3, $3, 4		#Increments the offset value 
				lw $6, Temps($3)	#Loads next temperature in Temps
				j predicate			#Repeats for-loop
	endfor: 	sub $1, $1, $2		#Subtracts freezing temperatures from boiling temperatures, and stores into $1
	end: 		sw $1, FreqDiff($0)	#Stores value in $1 into FreqDiff
				jr $31   			# return to OS
				


