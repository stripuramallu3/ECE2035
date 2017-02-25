/*  Sreeramamurthy Tripuramallu
This program finds George (possibly incognito) in a crowd. */

#include <stdio.h>
#include <stdlib.h>
int pixelAtIndex(int row, int col, int CrowdInts[]);
int checkAbove(int row, int col, int CrowdInts[]);
//this helper method determines the pixel at a specific index of the image array
int pixelAtIndex(int row, int col, int CrowdInts[]) {
    int temp = CrowdInts[row * 16 + (col/4)];
    int pixel  = (temp >> (col % 4) * 8) & 0xFF;
    return pixel;
}
int checkAbove(int row, int col, int CrowdInts[]) {
  int num = 0;
  int i = 0;
  for (i = 2; i > 0; i--) {
    if (pixelAtIndex(row - i, col, CrowdInts) < 9) {
      num++;
    }
  }
}
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
   int check = 1;
    int num = 0;
    int tempCol = 0;
    int tempRow = 0;
    int row = 0;
    int col = 0;
    for (col = 0; col < 64 && check == 1; col+=11) {
      for (row = 0; row < 64 && check == 1; row++) {
        if (pixelAtIndex(row, col, CrowdInts) < 9) {
          tempCol = col;
          tempRow = row;
          num = checkAbove(tempRow, tempCol, CrowdInts);
          if (num == 0) {
            tempRow += -2;
          } else if (num == 1) {
            tempRow += -3;
          } else {
            tempRow += -4;
          }
          tempCol += 5;
          int hatColor = pixelAtIndex(row, tempCol, CrowdInts);
          int hatStripColor = pixelAtIndex(row + 1, tempCol -1, CrowdInts);
          int eyeColor = pixelAtIndex(row + 5, tempCol + 1, CrowdInts);
          int faceColor = pixelAtIndex(row + 9, tempCol, CrowdInts);
          int smileColor = pixelAtIndex(row + 8, tempCol, CrowdInts);
          int smileColor2 = pixelAtIndex(row + 8, tempCol -1, CrowdInts);
          int collarColor = pixelAtIndex(row + 11, tempCol, CrowdInts);
          if ((hatColor == 3 && hatStripColor == 1 && eyeColor == 7 && faceColor == 5 && smileColor == 2 && collarColor == 3 && smileColor2 == 2)
                || (hatColor == 8 && hatStripColor == 1 && eyeColor == 3 && faceColor == 5 && smileColor == 8 && smileColor2 == 5 && collarColor == 8)) {
            Location = tempRow * 64 + tempCol;
            check = 0;
          } else {
            row += 12;
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
