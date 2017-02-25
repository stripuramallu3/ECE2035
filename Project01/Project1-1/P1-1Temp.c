/*  Sreeramamurthy Tripuramallu
This program finds George (possibly incognito) in a crowd. */

#include <stdio.h>
#include <stdlib.h>
int pixelAtIndex(int row, int col, int CrowdInts[]);
int widthOfRow(int row, int col, int CrowdInts[]);
int main(int argc, char *argv[]) {
   int                CrowdInts[1024];
   int                NumInts, Location=0;
   int               Load_Mem(char *, int *);

   if (argc != 2) {
     printf("usage: ./P1-1 valuefile\n");
     exit(1);
   }
   NumInts = Load_Mem(argv[1], CrowdInts);
   if (NumInts != 1024) {
      printf("valuefiles must contain 1024 entries\n");
      exit(1);
   }
    int pixelAtIndex(int row, int col, int CrowdInts[]) {
      int temp = CrowdInts[row * 16 + (col/4)];
      int pixel  = (temp >> (col % 4) * 8) & 0xFF;
      return pixel;
    }
    int widthOfRow(int row, int col, int CrowdInts[]) {
      int count = 0;
      int i; 
      for (i = -3; i < 4; i++) {
        count += (pixelAtIndex(row, col + i, CrowdInts) < 9);
       }
      return count;
    }
    int check = 1;
    int tempRow = 0;
    int row = 0;
    int col; 
    for (row = 0; row < 64 && check ==1; row += 12) {
	    for (col = 0; col < 64 && check == 1; col++) {
	        if (pixelAtIndex(row, col, CrowdInts) < 9 ) {
		        col += 3;
		        tempRow = row;
		        //special case of neck
		        if (widthOfRow(row, col, CrowdInts) == 3) {
		           col -= 1;
		        }
		        //keep moving up until we get a width of 4
		        while (widthOfRow(tempRow, col, CrowdInts) != 4) {
		           tempRow -= 1;
		        }
		        //keep moving right, until you hit first background pixel
		        while (pixelAtIndex(tempRow, col + 1, CrowdInts) < 9) {
		           col += 1;
		        }
		        // after this loop executes, we know the rop right pixel of the face (the top right of the hat)
		        int hatColor = pixelAtIndex(tempRow, col, CrowdInts);
		        int hatStripColor = pixelAtIndex(tempRow + 1, col -1, CrowdInts);
		        int eyeColor = pixelAtIndex(tempRow + 5, col + 1, CrowdInts);
		        int faceColor = pixelAtIndex(tempRow + 9, col, CrowdInts);
		        int smileColor = pixelAtIndex(tempRow + 8, col, CrowdInts);
		        int collarColor = pixelAtIndex(tempRow + 11, col, CrowdInts);
		        if ((hatColor == 3 && hatStripColor == 1 && eyeColor == 7 && faceColor == 5 && smileColor == 2 && collarColor == 3) || (hatColor == 8 && hatStripColor == 1 && eyeColor == 3 && faceColor == 5 && smileColor == 8 && collarColor == 8)) {
		           Location = tempRow * 64 + col;
		           check = 0;
		        } else {
		           col += 6;
		        } 
	    	} 
	   	}
	}


   printf("The rightmost pixel at the top of George's hat is located at: %4d.\n", Location);
   exit(0);
}

/* This routine loads in up to 1024 newline delimited integers from
a named file in the local directory. The values are placed in the
passed integer array. The number of input integers is returned. */

int Load_Mem(char *InputFileName, int IntArray[]) {
   int   N, Addr, Value, NumVals;
   FILE  *FP;

   FP = fopen(InputFileName, "r");
   if (FP == NULL) {
      printf("%s could not be opened; check the filename\n", InputFileName);
      return 0;
   } else {
      for (N=0; N < 1024; N++) {
         NumVals = fscanf(FP, "%d: %d", &Addr, &Value);
         if (NumVals == 2)
            IntArray[N] = Value;
         else
            break;
      }
      fclose(FP);
      return N;
   }
}
