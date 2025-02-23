//----------------------------------------------------------------------------------------------------------------------
//                                      Gabriel Malone / Week 4 / Lab 4 / CS 210
//----------------------------------------------------------------------------------------------------------------------
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <math.h>
#include <stdbool.h>
//--struct for parsing floating point numbers---------------------------------------------------------------------------
struct flt {
    char         sign;
    uint8_t      expt;
    unsigned int mnts;
    float        decv;
};
//--struct for constructing IEEE7 int-----------------------------------------------------------------------------------
struct construct {
    uint8_t      sign;
    int          expt;
    int          intg;
    unsigned int deci;
    float        decf;
    int          IEE7;
    int          mtsa;
};
//--function prototypes-------------------------------------------------------------------------------------------------
struct construct  ascii_to_IEEE7(char *, int);               // creates an IEEE7 binary from user inputted decimal value
struct flt        parse_fraction(int);                                        // interprets each section of IEEE7 binary
float             f_b_10(unsigned int);                 // performs repeitive addition to create the final decimal value
void              printBinary(int);                                                               // prints IEEE7 binary
void              userConversion(void);                                                            // handles user input
//--IEEE7 hex test values-----------------------------------------------------------------------------------------------
int pi          = 0x40490FDB;
int one         = 0x3F800000;  //  1.0
int neg_one     = 0xBF800000;  // -1.0
int pdf_example = 0xC0D9999A;  // -6.8  
int neg_0       = 0xBEB851EC;  // -0.36
char usr_i        [50];        // user input
//--main----------------------------------------------------------------------------------------------------------------
int main(int argc, char** argv){
    printf("\nconfirm parse works with test value 0x40490FDB     pi  : %f", parse_fraction(pi).decv);
    printf("\nconfirm parse works with teat value 0x3F800000    1.0  : %f", parse_fraction(one).decv);
    printf("\nconfirm parse works with test value 0xBF800000   -1.0  : %f", parse_fraction(neg_one).decv);
    printf("\nconfirm parse works with test value 0xBEB851EC  -0.36  : %f", parse_fraction(neg_0).decv);
    userConversion();
}
//--convert IEEE7 binary to decimal-------------------------------------------------------------------------------------
struct flt parse_fraction(int fraction){ 
    struct flt x = {.sign = '\0', .expt = 0, .mnts = 0, .decv = 0.0f};                       // init with necessary vals
    x.sign  =  fraction >> 31  ? '-' : '+' ;        // shift fraction's HO bit to 2^0 position to peep it,  if 1 set '-'
    x.expt  =  fraction >> 23 ;                         // shift fraction 23 places into an 8 bit window to set exponent
    x.mnts |=  fraction << 9  ;         // shift mantissa portion of fraction into the appropriate 32 bit window and set
    x.decv  = ( x.sign == '-' ) ? (1+f_b_10(x.mnts))*pow(2,x.expt-127)*-1 : (1+f_b_10(x.mnts))*pow(2,x.expt-127);
    return x;
}
//--convert binary mantissa to base 10 fraction-------------------------------------------------------------------------
float f_b_10(unsigned int mantissa){
    int   shift = 31, power = 1;
    float total = 0;
    while (shift > 9)           // will iterate starting from bit 0 (LO mem position requiring a 31 bit shift) 23 times.
    {
        total += ( ( mantissa >> shift -- ) & 1 ) * ( 1.0f / ( power *= 2 ) ) ;
    }
    return total;
}
// ---------------------------------------------------------------------------------------------------------------------
struct construct ascii_to_IEEE7(char *ascii_number, int size){
//----------------------------------------------------------------------------------------------------------------------
    struct construct x = {.intg = 0, .deci = 0, .mtsa = 0, .decf = 0.0f};
    bool neg = false;
    bool zer = false;
    int  rdx = 0;
    //------------------------------------------------------------------------------------------------------------------
	for (int i = 0 ; i < size ; i ++ ) {                                    // convert everthing from ascii to int first
        if (*ascii_number == '-') neg = true, ascii_number ++ ;
        if (*ascii_number == '.') rdx = i,    ascii_number ++ ;
		else x.intg = x.intg * 10 + (  *ascii_number ++ &= ~( 3 << 4 ) );
	}  
    //------------------------------------------------------------------------------------------------------------------
    for (int i = 0 ; i < (size - rdx) - 1 ; i ++) {                                           // get the integer portion
        x.intg /=10;                              
    }
    //------------------------------------------------------------------------------------------------------------------
    int radx_pos = size - 1 - rdx;                                                            // get the decimal portion
    float div = 10;                                                    // make the decimal portion into decimal fraction
    ascii_number -= radx_pos;                                           // set pointer of array to after the radix point
    for (int i = 0 ; i < radx_pos; i ++ ) {        // iterate through each digit and divide them by greater powers of 10
		x.decf += 1.0f / div * *ascii_number ++ ;                                          // add each fraction together
        div *= 10;
	}
    //------------------------------------------------------------------------------------------------------------------
    x.sign = (neg) ? 1 : 0;                                                                              // set sign bit
    x.IEE7 |= (x.sign << 31);                                                                   // apply to final binary
    //------------------------------------------------------------------------------------------------------------------
    int shft = 31;                                                                                    // create mantissa
    int mnts_shft = 22;                                                       // in order to shift into mantissa spacing
    if (x.intg)                      // if input greater than or = 1, will and will create a positive exponent this loop
    {                          // when you run into a 1 in the binary, stop and calc how far from end of binary you are. 
        while (shft >= 0)                                                                 // loop until done with binary
        {
            int cur_val = ( ( x.intg >> shft -- ) & 1 );              // current bit of the integer portion of the value
            if (cur_val) // if at '1' leading zeros done / found start of the binary. spaces traversed will give exp val
            { 
                x.expt = (shft + 128) << 23;                  // get pos exponent val, add bias  shift to final IEEE pos
                while (shft >= 0)                                       // then place rest of the bits into the mantissa
                {                                               // now that found binary, add remaining bits to mantissa
                    x.mtsa |= ( ( (x.intg >> shft -- ) & 1 ) << mnts_shft -- ); // get, shift,set into mantissa position
                }
            }
        }
    //------------------------------------------------------------------------------------------------------------------
    } else {
        zer = true;                                                         // otherwise we have a 0 in theinteger field
    }
    //------------------------------------------------------------------------------------------------------------------
    // run the algo to create the mantissa from the decimal portion
    //------------------------------------------------------------------------------------------------------------------
    int extra_shift = 0;        // this needed to remove leading zeros in mantissa when dealing with negative exponenets                                           
    while (mnts_shft > 0)                                                                         // apply mantissa algo
    {
        x.decf *= 2;                                                                   // multiply decimal fraction by 2 
        if (x.decf >= 1){                                 // if result is greater or equal to 1, add bit '1' to mantissa
            if (!zer) x.mtsa |= ( 1 << mnts_shft );                // set the bit for mantissa  starting from the 'left'
            x.decf -= 1;                                                        // remove integer portion if '1' present
            if (zer) x.expt = (126 - ( 22 - mnts_shft ) ) << 23, zer = false, extra_shift = 23 - mnts_shft;
        }                                                                     // ^^^ if zero int, can calc neg expo here
        mnts_shft -- ;                                                       // repepat until all mantissa bits iterated
    }
    x.mtsa <<= extra_shift;
    x.IEE7 += x.expt + x.mtsa;                                                // construct final IEEE7 32 bit int binary
    return x;
}  
//----------------------------------------------------------------------------------------------------------------------
void printBinary(int bin){
//----------------------------------------------------------------------------------------------------------------------
    printf("\nIEE7 binary:      ");
    for (int i = 31; i >= 0; i--) {
        printf("%d", (bin >> i) & 1);
        if (i == 31 || i == 23) printf(" "); // Optional: Add space every 8 bits
    }
}
//----------------------------------------------------------------------------------------------------------------------
void userConversion(void){
//----------------------------------------------------------------------------------------------------------------------
    while (true){
        int cnt = 0;
        int idx = 0;
        printf("\nenter a pos or neg decimal fraction (q to quit): ");
        fgets(usr_i, sizeof(usr_i), stdin);
        while (usr_i[idx]) if (usr_i[idx ++ ] != '-') cnt ++ ;
        if (*usr_i == 'q') break;
        printf("\nhex IEEE7 output: %X", ascii_to_IEEE7(usr_i, cnt-1).IEE7);
        printBinary(ascii_to_IEEE7(usr_i, cnt-1).IEE7);
        printf("\nparsed hex value: %f\n", parse_fraction(ascii_to_IEEE7(usr_i, cnt-1).IEE7).decv);
    }
}
//----------------------------------------------------------------------------------------------------------------------
