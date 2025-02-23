//----------------------------------------------------------------------------------------------------------------------
// Gabriel Malone // CSIV // Lab 1 exercise A // 1/29/2025
//----------------------------------------------------------------------------------------------------------------------
#include <stdio.h>
#include <stdlib.h>						                                                                // rand function
#include <time.h>						                                                                // time function
#define SIZE 10						                                                         // macro to define the size
//----------------------------------------------------------------------------------------------------------------------
int main(){
	//------------------------------------------------------------------------------------------------------------------
	srand(time(0));								                                                // seed number generator
	//------------------------------------------------------------------------------------------------------------------
	int* buckets = (int[SIZE]){0};				  // buckets to count how many of each number will be in the array below
	int* arr = (int[SIZE]){0};                                                 // array to be filled with random numbers
	//------------------------------------------------------------------------------------------------------------------
	for(int i = 0; i < SIZE; ++i){                     // fill the array with random numbers and fill buckets with count
		int num = ( rand() % (SIZE/2) );		                                // scale the number to the desired range
		*arr++   = num;                                // fill the array via dereferenced pointer then increment pointer
		buckets  += num;                                               // shift pointer on buckets to the correct bucket
		*buckets += 1;                                                             // increment that dereferenced bucket
		buckets  -= num;                                                              // reset buckets to start of array
	}
	//------------------------------------------------------------------------------------------------------------------
	arr -= SIZE ;                                                        // move array pointer back to starting position
	for(int i = 0; i < SIZE; ++i)                                           // confirm arr is filled with random numbers
		printf("arr[%d] = %d\n", i, *arr ++);
	//------------------------------------------------------------------------------------------------------------------
	int uniques = 0;                                                                              // counter for uniques
	for(int i = 0; i < SIZE; ++i) {                                        // confirm counts for each number are correct
		if (*buckets) {                                                                   // if at an incremented bucket
			printf("%d's = %d\n", i, *buckets);
			uniques ++ ;                              // each bucket that has been incremented represents a unique value
		}
		buckets ++ ;                                                                                // increment pointer
	}
	printf("There are %d unique numbers\n", uniques);
	//------------------------------------------------------------------------------------------------------------------
	return 0;
}