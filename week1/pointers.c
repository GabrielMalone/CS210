/*
	C Program to illustrate pointer creation, assignment, dereferencing and math
	Pay close attention to the memory addresses as they are dereferenced and manipulated
	Especially the array traversal
	The association of strongly typed languages and array indexing is of particular interest

	Building and running this example using GCC and the terminal
	Ignore compiler warnings for now. This isn't "best practice" code, just a concept example

	LINUX
	=====
	Build Syntax: 	cc pointers.c
	Executable: 	a.out
	Execute: 		./a.out

	MAC OSX (UNIX)
	==============
	Build Syntax: 	cc pointers.c
	Executable: 	a.out
	Execute: 		./a.out

	WINDOWS
	=======
	Windows users will need to download a port of GCC. MinGW is the best alternative
	https://www.mingw-w64.org/

	Build Syntax: 	gcc pointers.c
	Executable: 	a.exe
	Execute: 		a.exe
*/

#include <stdio.h>									// need the IO abilities and printf
#define SIZE 10										// macro to define the array size

int main(int argc, char** argv){					// c main function allows command line args to be provided
													// first arg is the count, second arg is the sequence of values

	// 32 BIT INTEGERS and POINTERS
	// ============================
	int x = 42;										// regular ole 32 bit int
	int *pointer_to_int = &x;						// pointer to an int holding the address of x

	printf("\n\nValue of x: %d, Address of x: %p, Value of pointer: %p \n\n", x, &x, pointer_to_int);

	++x;											// add one to x
	++pointer_to_int;								// add one to pointer // increases by 4 bytes, the size of an int

	printf("Value of x: %d, Address of x: %p, Value of pointer: %p \n\n", x, &x, pointer_to_int);

	printf("Value at: %p is: %d \n\n", pointer_to_int, *pointer_to_int);

	// 16 BIT SHORTS and POINTERS
	// ==========================
	short y = 11;									// regular ole 16 bit short
	short *pointer_to_short = &y;					// pointer to a short holding the address of y

	printf("Value of y: %d, Address of y: %p, Value of pointer: %p \n\n", y, &y, pointer_to_short);

	++y;											// add one to y
	++pointer_to_short;								// add one to pointer

	printf("Value of y: %d, Address of y: %p, Value of pointer: %p \n\n", y, &y, pointer_to_short);

	// 8 BIT CHARS and POINTERS
	// ========================
	char z = 1;										// regular ole 8 bit char
	char *pointer_to_char = &z;						// pointer to a char holding the address of z

	printf("Value of z: %d, Address of z: %p, Value of pointer: %p \n\n", z, &z, pointer_to_char);

	++z;											// add one to y
	++pointer_to_char;								// add one to pointer

	printf("Value of z: %d, Address of z: %p, Value of pointer: %p \n\n", z, &z, pointer_to_char);

	// ARRAY CREATION, ACCESS and TRAVERSAL USING POINTERS
	// ===================================================

    int *p = (int [SIZE]) {3, 0, 3, 4, 1};	    	// pointer to an array of SIZE elements
    												// first 5 have been specified, next 5 will be 0

    for(int i = 0; i < SIZE; ++i)					// iterate through array	
       printf("Address: %p, value: %d\n", p++, *p); // pointer manipulation and dereferencing

	// DEMONSTRATE RELATIONSHIP of CHARs and ASCII INTEGERS
	// ====================================================
    char *alpha = (char [26]) {0};					// pointer to a 26 element array of type char
    for(char c = 'a'; c <= 'z'; ++c)				// start at 'a', loop until 'z'
		*alpha++ = c;								// obscure syntax. What's going on here?
    
    alpha -= 26;									// move pointer back 26 bytes. How?

    for(char c = 'a'; c <= 'z'; ++c)				// dereference array element as ASCII number and character
        printf("alpha Address: %p, ASCII: %3d, value: %c\n", alpha++, *alpha, *alpha); 
    
    return 0;
}

