#    Find George Possibly Incognito in a Crowd
#
#
# This routine finds an exact match of George's face (possibly incognito)
# in a crowd.
#
# 10/26/2015                               Sreeramamurthy Tripuramallu

.data
Array:  .alloc  1024
#$1 The base of the Array and base colors of George or Incognito George 
#$2 The column index
#$3 The row index
#$4 The offset index
#$5 Temporary register 
.text

FindGeorge:  addi $1, $0, Array
             swi    588         # generate crowd
             addi  $2, $0, -11  # Initialie columns

             #Set up outer loop 
OuterLoop:   addi $2, $2, 11    
			 #Set up rows (also resets rows, when end of column is reached)
             addi $3, $0, -64   


             #Increment rows 
InnerLoop:   addi $3, $3, 64    

			 #Checks if row is less than max value for row
             slti $5, $3, 3585  

             #Jumps to out loop if row exceeds max 
             beq $5, $0, OuterLoop 

             #Stores offset location of pixel
LoadPixel:   add $4, $2, $3   

 			 #Loads pixel at offset 
             lb $5, Array($4) 

             #Checks if pixel is not a background color
CheckIfBack: slti $5, $5, 9   

			 #Jumps to inner loop if pixel is a background color 
             beq $5, $0, InnerLoop 

			 #At this point a face has been found

 			 #Moves the offset location all the way to the left as long as the pixel is not a background color 
MoveLeft:    addi $4, $4, -1     
             lb $5, Array($4)
             slti $5, $5, 9
             bne $5, $0, MoveLeft
             addi $4, $4, 1

             #Move the offset location down and to the left as long as the pixel is not a background color 
MoveDL:      addi $4, $4, 63
             addi $3, $3, 64
             lb $5, Array($4)
             slti $5, $5, 9
             bne $5, $0, MoveDL
             addi $4, $4, -63
             addi $3, $3, -64

             #Move the offset location down as long as the pixel is not a background color 
MoveD:       addi $4, $4, 64
             addi $3, $3, 64
             lb $5, Array($4)
             slti $5, $5, 9
             bne $5, $0, MoveD
             addi $4, $4, -64
             addi $3, $3, 448

             #At this point the offset location is at the left corner on the brim of the hat
             #Start checking facial features, based on offset location, to see if face matches George or Incognito George 

             #Checks the color of the face (both have the same color face)
CheckFace:   addi $4, $4, Array
             addi $1, $0, 5
             lb $5, 129($4)
             bne $5, $1, InnerLoop

             #Checks the strip color on the hat (both have the same hat strip color (and strip orientation))
             addi $1, $0, 1
             lb $5, -61($4)
             bne $5, $1, InnerLoop

             #Now start checking George's specific facial features 

             #Checks George's eye 
CheckGeorge: addi $1, $0, 7
             lb $5, 66($4)
             bne $5, $1, CheckIGeorge

             #Checks George's hat and collar  
             addi $1, $0, 3
             lb $5, 0($4)
             bne $5, $1, CheckIGeorge

             lb $5, 450($4)
             bne $5, $1, CheckIGeorge

             #Checks George's smile 
             addi $1, $0, 2
             lb $5, 260($4)
             beq $5, $1, End

              #Now start checking Incognito George's specific facial features

              #Checks Incognito George's eye/glasses
CheckIGeorge: addi $1, $0, 3
              lb $5, 65($4)
              bne $5, $1, InnerLoop

              #Checks Incognito George's hat, smile, and collar 
              addi $1, $0, 8
              lb $5, 0($4)
              bne $5, $1, InnerLoop

              lb $5, 196($4)
              bne $5, $1, InnerLoop

              lb $5, 450($4)
              bne $5, $1, InnerLoop

             #Ends the alogrithm when George or Ingonito George is found 
End:         addi $1, $0, Array
             addi $2, $4, -251
             sub $2, $2, $1
             swi   553         # submit answer and check
             jr    $31         # return to caller

