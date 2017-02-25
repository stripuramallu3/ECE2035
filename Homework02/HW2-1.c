/*    When Harry Met Sally

This program finds the earliest year in which Harry and Sally live in the same
city.

09/12/2015	               Sreeramamurthy Tripuramallu   */

#include <stdio.h>
#include <stdlib.h>

/* City IDs used in timelines. */
enum Cities{ London, Boston, Paris, Atlanta, Miami, 
             Tokyo, Metz, Seoul, Toronto, Austin };

int main(int argc, char *argv[]) {
   int	HarryTimeline[10];
   int	SallyTimeline[10];
   int	NumNums;
   int  Year = 0; 
   int  Load_Mem(char *, int *, int *);

   if (argc != 2) {
     printf("usage: ./HW2-1 valuefile\n");
     exit(1);
   }
   NumNums = Load_Mem(argv[1], HarryTimeline, SallyTimeline);
   if (NumNums != 20) {
     printf("valuefiles must contain 20 entries\n");
     exit(1);
   }
	//creates two integer array's of length 30
	//each element corresponds to a year 
   int newHarryTimeline[] = {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1};
   int newSallyTimeline[] = {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1};
   //creates counters for loops
   int i; 
   int j; 
   int z; 
   //set up differnce values
   int difference = 0;
   int difference1 = 0;
   //outer loop executes till the end of the timeline array's
   for (i = 0; i <= 8; i = i + 2) {
	   //if the index is at the end, then difference is determined with 2015
	   //otherwise the difference is the difference between current year and next year in the timeline arrays 
	if (i < 8) {
		difference = HarryTimeline[i+2] - HarryTimeline[i];
		difference1 = SallyTimeline[i+2] - SallyTimeline[i]; 
	} else {
		difference = 2015 - HarryTimeline[i]; 
		difference1 = 2015 - SallyTimeline[i]; 
	}
	//replaces the -1 values with the representing city
	for (j = 0; j < difference; j++) {
		newHarryTimeline[HarryTimeline[i] - 1986 + j] = HarryTimeline[i+1];  
	}   
	for (z = 0; z < difference1; z++) {
		newSallyTimeline[SallyTimeline[i] - 1986 + z] = SallyTimeline[i+1];  
	} 
   }
   //goes through two array's and finds where Harry/Sally are in the same city
	int check = 1;
	int k; 
	for (k = 0; k < 30; k++) {
		if (newHarryTimeline[k] == newSallyTimeline[k] && newHarryTimeline[k] != -1 && check == 1) {
			Year = k + 1986; 
			check = 0; 
		}
		
	}
   printf("Earliest year in which both lived in the same city: %d\n", Year);
   exit(0);
}
/* This routine loads in up to 20 newline delimited integers from
a named file in the local directory. The values are placed in the
passed integer array. The number of input integers is returned. */

int Load_Mem(char *InputFileName, int IntArray1[], int IntArray2[]) {
   int	N, Addr, Value, NumVals;
   FILE	*FP;

   FP = fopen(InputFileName, "r");
   if (FP == NULL) {
     printf("%s could not be opened; check the filename\n", InputFileName);
     return 0;
   } else {
     for (N=0; N < 20; N++) {
       NumVals = fscanf(FP, "%d: %d", &Addr, &Value);
       if (NumVals == 2)
	 if (N < 10)
	   IntArray1[N] = Value;
	 else
	   IntArray2[N-10] = Value;
       else
	 break;
     }
     fclose(FP);
     return N;
   }
}
