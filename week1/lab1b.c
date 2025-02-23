//----------------------------------------------------------------------------------------------------------------------
// Gabriel Malone // CSIV // Lab 1 exercise B // 1/29/2025
//----------------------------------------------------------------------------------------------------------------------
#include <stdio.h>
#define SIZE 10
int main () {
	//------------------------------------------------------------------------------------------------------------------
	// In a new C file declare small arrays of different primitive types: char, int, float and double
	// Declare pointers to the first elements
	//------------------------------------------------------------------------------------------------------------------
	int*    int_arr = (int[SIZE])    {1, 2, 3, 4, 5};                                                // 32 bits -4 bytes
	char*   chr_arr = (char[SIZE])   {'a', 'b', 'c', 'd', 'e'};                 // 8 bits - 1 byte =  10 bits of spacing
	float*  flt_arr = (float[SIZE])  {0.1f, 0.2f, 0.3f, 0.4f, 0.5f};            // 32 bit - 4 bytes = 42 bits of spacing
	double* dbl_arr = (double[SIZE]) {0.1, 0.2, 0.3, 0.4, 0.5};                 // 64 bit - 8 bytes = 84 bits of spacing
	//------------------------------------------------------------------------------------------------------------------
	// Print the beginning address of each array
	//------------------------------------------------------------------------------------------------------------------
	printf("beginning address of the int array    = %p\n", int_arr); // my compiler places the last declared variables..
	printf("beginning address of the char array   = %p\n", chr_arr);                                // ..first in memory
	printf("beginning address of the float array  = %p\n", flt_arr);
	printf("beginning address of the double array = %p\n", dbl_arr);
	//------------------------------------------------------------------------------------------------------------------
	// Using the pointers, compute the difference between each contiguous array and display the values
	//------------------------------------------------------------------------------------------------------------------
	size_t diff1 = (size_t)flt_arr-(size_t)dbl_arr;
	size_t diff2 = (size_t)chr_arr-(size_t)flt_arr;
	size_t diff3 = (size_t)int_arr-(size_t)chr_arr;                                            // my compiler places ...
	printf("\ndifference between mem address of dbl array and float array  = %td\n", diff1);      // 2x expected spacing
	printf("difference between mem address of float array and char array = %td\n", diff2);          // for each type ...
	printf("difference between mem address of char array and int array   = %td\n", diff3);                  // padding ?
	//------------------------------------------------------------------------------------------------------------------
	// Use a loop to print the memory address and value of
	// each element in each of the arrays. Also show the difference between each address
	//------------------------------------------------------------------------------------------------------------------
	// INT ARRAY 4 BYTE JUMPS
	//------------------------------------------------------------------------------------------------------------------
	printf("\n");
	size_t start1 = (size_t)int_arr;                 // jumps 4 bytes per pointer increment, which is the size of an int
	for (int i = 0 ; i < 5 ; i ++){                                                       // mem in array is continguous
		size_t dif = (size_t)int_arr - start1;          // this means pointers can be used as index trackers with arrays
		printf("mem address of element [%d] = %d in the int_array = %p\ndifference between elements: %td\n",
			   i, *int_arr, int_arr, dif);
		start1 = (size_t)int_arr;
		int_arr++;
	}
	//------------------------------------------------------------------------------------------------------------------
	// CHAR ARRAY 1 BYTE JUMPS
	//------------------------------------------------------------------------------------------------------------------
	printf("\n");
	size_t start2 = (size_t)chr_arr;           // jumps 1 byte per pointer increment, which is the size of a char in mem
	for (int i = 0 ; i < 5 ; i ++){                                                       // mem in array is continguous
		size_t dif = (size_t)chr_arr - start2;
		printf("mem address of element [%d] = %c in the char_array = %p\ndifference between elements: %td\n",
			   i, *chr_arr, chr_arr, dif);
		start2 = (size_t)chr_arr;
		chr_arr++;
	}
	//------------------------------------------------------------------------------------------------------------------
	// DOUBLE ARRAY 8 BYTE JUMPS
	//------------------------------------------------------------------------------------------------------------------
	printf("\n");
	size_t start3 = (size_t)dbl_arr;             // jumps 8 bytes per pointer incrememnt, which is size of double in mem
	for (int i = 0 ; i < 5 ; i ++){                                                       // mem in array is continguous
		size_t dif = (size_t)dbl_arr - start3;
		printf("mem address of element [%d] = %f in the double_array = %p\ndifference between elements: %td\n",
			   i, *dbl_arr, dbl_arr, dif);
		start3 = (size_t)dbl_arr;
		dbl_arr++;
	}
	//------------------------------------------------------------------------------------------------------------------
	// FLOAT ARRAY 4 BYTE JUMPS
	//------------------------------------------------------------------------------------------------------------------
	printf("\n");
	size_t start4 = (size_t)flt_arr;                        // jumps 4 bytes per pointer increment, size of float in mem
	for (int i = 0 ; i < 5 ; i ++){                                                       // mem in array is continguous
		size_t dif = (size_t)flt_arr - start4;
		printf("mem address of element [%d] = %f in the float_array = %p\ndifference between elements: %td\n",
			   i, *flt_arr, flt_arr, dif);
		start4 = (size_t)flt_arr;
		flt_arr++;
	}
	//------------------------------------------------------------------------------------------------------------------
	return 0;
}
