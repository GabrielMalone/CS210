//----------------------------------------------------------------------------------------------------------------------
// Gabriel Malone / CS4 / Lab 2
//----------------------------------------------------------------------------------------------------------------------
#include "stdio.h"
#include <assert.h>
//----------------------------------------------------------------------------------------------------------------------
// masking and bit shifting method to extract and print data from 32bit data
//----------------------------------------------------------------------------------------------------------------------
void parse_date_time(size_t time){
	//------------------------------------------------------------------------------------------------------------------
	// creates masks and shift them left into position
	//------------------------------------------------------------------------------------------------------------------
	size_t yer_msk = 0x7F << 25;                                        // 7 bits (1111_1110), needs to be shifted << 25
	size_t mon_msk = 0x0F << 21;                                        // 4 bits (0000_1111), needs to be shifted << 21
	size_t day_msk = 0x1F << 16;                                        // 5 bits (0001_1111), needs to be shifted << 16
	size_t hor_msk = 0x1F << 11;                                        // 5 bits (0001_1111), needs to be shifted << 11
	size_t min_msk = 0x3F << 5;                                         // 6 bits (0011_1111), needs to be shifted << 05
	size_t sec_msk = 0x1F;                                                   // 5 bits (0001_1111), no shifting since LO
	//------------------------------------------------------------------------------------------------------------------
	// apply mask, shift back to the right
	//------------------------------------------------------------------------------------------------------------------
	size_t hmn_yer = (time & yer_msk) >> 25;
	size_t hmn_mon = (time & mon_msk) >> 21;
	size_t hmn_day = (time & day_msk) >> 16;
	size_t hmn_hor = (time & hor_msk) >> 11;
	size_t hmn_min = (time & min_msk) >> 5;
	size_t hmn_sec = (time & sec_msk);

	printf("%zu/%zu/%zu , %zu:%zu:%zu\n", 1980 + hmn_yer, hmn_mon, hmn_day, hmn_hor, hmn_min, hmn_sec * 2);

}
//----------------------------------------------------------------------------------------------------------------------
size_t encode_date(size_t day, size_t month, size_t year){
	return (year << 9) + (month << 5) + day;                         // shift year and month into their 16 bit positions
}
//----------------------------------------------------------------------------------------------------------------------
size_t encode_time(size_t hr, size_t mn, size_t sc){
	return (hr << 11) + (mn << 5) + sc;                           // shift hours and minutes into their 16 bit positions
}
//----------------------------------------------------------------------------------------------------------------------
size_t encode_date_time(size_t day, size_t month, size_t year, size_t hr, size_t mn, size_t sc){
	return (encode_date(day, month, year-1980) << 16) + encode_time(hr, mn, sc/2);// shift date into its final 32bit pos
}
//----------------------------------------------------------------------------------------------------------------------
int main(){

	parse_date_time(0x4F3249E8);                                                           // test date given in lab pdf
	parse_date_time(encode_date_time(20, 4, 2020, 11, 34, 12));                        // should result in inputted date

	//------------------------------------------------------------------------------------------------------------------
	// ASSERTION TESTING
	//------------------------------------------------------------------------------------------------------------------
	assert(encode_date_time(18,9,2019,9,15,16) == 0x4F3249E8); 	      // known hex date 0x4F3249E8 = 2019/9/18 , 9:15:16
	assert(encode_date_time(22,6,1983,0,0,0) == 0x06D60000); 	                         // my bday = 06/22/1983 , 0:0:0
						// 0000_011^0_110^1_0110 my bday in 16 bit binary --> HO year = 3 (1983-1980), month = 6, day 22
						// 0      6     D     6      <--- HEX
						// and now I'm tired of writing these
	//------------------------------------------------------------------------------------------------------------------
	return 0;
}
//----------------------------------------------------------------------------------------------------------------------