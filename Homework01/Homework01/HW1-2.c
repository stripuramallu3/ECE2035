#include <stdio.h>
#include <stdlib.h>

/* 
 Student Name: Sreeramamurthy Tripuramallu
 Date: 09/02/2015

ECE 2035 Homework 1-2

This is the only file that should be modified for the C implementation
of Homework 1.

This program computes and prints the difference in the frequency of
boiling temperatures and the frequency of freezing temperatures in a
set of 25 integers, Temps.
*/

int Temps[] = {110, 5, 200, -73, 0,
	       17, 9, -7, -3, 100,
	       25, 242, -126, 108, -60,
	       26, 8, 60, 27, 117,
               8, 7, 33, 100, 125};

int main() {
  int FreqDiff = 0; 							//initalize variable for frequency difference
  int i; 	    								//initalize counter 
  int boil = 0; 								//initalize number for boiling temperatures
  int freeze = 0;								//initalize number for freezing temperatures 
  int length = sizeof(Temps)/sizeof(Temps[0]);	//determines the length of the array				
  for (i = 0; i < length; i++) { 				//loop that iterates through temperature array
	if (Temps[i] >= 100) {						//checks if temperature is greater than or equal to 100	
		boil++;									//increments number of boiling temperatures if necessary
	} else if(Temps[i] <= 0) {					//checks if temperature is less than or equal to 0
		freeze++; 								//increments number of freezing temperatures if necessary
	}
  }
  FreqDiff = boil - freeze;						//calculates frequency difference 
  printf("FreqDiff: %d\n", FreqDiff);			//prints value 
  return 0;
}

