#include <stdio.h> 
/*
	The following is "a" solution to a common Google interview question.
	Your task is to determine the question . . . Jeopardy Style.
	Also think in terms of efficiency notation.

	C Bitwise Operators
	===================
	| => bitwise or
	& => bitwise and
	^ => bitwise xor
	~ => bitwise not

	Reverse engineer the bitwise logic of the googleQuestion function.
	Add detailed comments describing what each line is doing and also
	show the bitwise operations and results in bits.

	You only need to worry about showing the low order byte. You do not need
	to pad to 32 bits (just for convenience). That is why they are small numbers.

	Also don't worry about trying to generalize the solution to all inputs

	You can compile and run this program with:

	$ gcc google_interview_question.c -o google -std=c99
	$ ./google
	> ./google.exe (windows)
*/

int googleQuestion(int*, int);

int main() {
	int arr[] = {1,9,1};			            // altered to find what this algo actually doing
	int n = sizeof(arr) / sizeof(arr[0]);					// get the size of the array
	printf("The answer is %d\n", googleQuestion(arr, n));	// call the function
	return 0;												// return 0
}
// What is the high value - (middle + low), Alex ?
int googleQuestion(int* arr, int n){
	//------------------------------------------------------------------------------------------------------------------
	int a = 0, b = 0, c = 0;
	//------------------------------------------------------------------------------------------------------------------
	// loop variable declaration in a for loop
	// may require the -std=c99 switch
	for( int i = 0; i < n; i++ ){
		a = a | (b & *arr);
		//--------------------------------------------------------------------------------------------------------------
		// loop 1 - a = 0 | (0000_0000 and 0000_0011), thus a = 0
		// loop 2 - a = 0 | (0000_0011 and 0000_0010), thus a = 2
		// loop 3 - a = 2 0000_0010 | (0000_0001 and 0000_0011 = 0000_0001) = 0000_0011 = a = 3
		// loop 4 - a = 1 0000_0001 |  (0000_0000 and 0000_0011 = 0000_0000) = 0000_0001 = a = 1
		//--------------------------------------------------------------------------------------------------------------
		b = b ^ *arr++;
		//--------------------------------------------------------------------------------------------------------------
		// loop 1 - b = 0 , 0 XOR 3 = 3, thus b = 3 and move to next element in array
		// loop 2 - b = 3, 3 0000_0011 XOR 2 0000_0010 = 1 0000_0001
		// loop 3 - b = 1 0000_0001 XOR 0000_0011 = 0000_0010, thus b = 2
		// loop 4 - b = 0 0000_0000 XOR 0000_0011 = 0000_0011, thus b = 3
		//--------------------------------------------------------------------------------------------------------------
		c = ~(b & a);
		//--------------------------------------------------------------------------------------------------------------
		// loop 1 - c = not (0 0000_0000 and 0000_0011 = 3 0000_00000) = 1111_11111, thus c = -1 (int is signed)
		// loop 2 - c = not (1 0000_0001 and 2 0000_0010 = 0000_0000)  = 1111_1111,  thus c = -1
		// loop 3 - c = not (2 0000_0010 and 3 0000_0011 = 0000_0010)  = 1111_1101,  thus c = -3
		// loop 4 - c = not (3 0000_0011 and 1 0000_0001 = 0000_0001)  = 1111_1110,  thus c = -2
		//--------------------------------------------------------------------------------------------------------------
		b &= c; // b equals b and c
		//--------------------------------------------------------------------------------------------------------------
		// loop 1 - (b = 0000_0011 and c = 1111_1111 = 0000_0011) = b = 3
		// loop 2 - (b = 0000_0001 and c = 1111_1111 = 0000_0001) = b = 1
		// loop 3 - (b = 0000_0010 and c = 1111_1101) = 0000_0000 = b = 0
		// loop 4 - (b = 0000_0011 and c = 1111_1110) = 0000_0010 = b = 2
		//--------------------------------------------------------------------------------------------------------------
		a &= c; // a equals a and c
		//--------------------------------------------------------------------------------------------------------------
		// loop 1 - (a = 0000_0000 and c = 1111_1111 = 0000_0000)  thus a = 0;
		// loop 2 - (a = 0000_0010 and c = 1111_1111 = 0000_0010)  thus a = 2
		// loop 3 - (a = 0000_0011 and c = 1111_1101) = 0000_0001, thus a = 1
		// loop 4 - (a = 0000_0001 and c = 1111_1110) = 0000_0000, thus a = 0
		//--------------------------------------------------------------------------------------------------------------
		// end loop 1) a = 0, b = 3, c = -1
		// end loop 2) a = 2, b = 1, c = -1
		// end loop 3) a = 1, b = 0, c = -3
		// end loop 4) a = 0, b = 2, c = -2
		//--------------------------------------------------------------------------------------------------------------
	}
	return b;
}