// Gabriel Malone | Week 5 lab | CS 210

#include <type_traits>

// #pragma pack(1)

// struct S{
//     char a;         // 1 byte  - next var i needs to be aligned to 4 bytes, so  + 3 bytes of padding added
//     int i;          // 4 bytes
//     char b;         // 1 byte  - next var j needs to be aligned to 4 bytes, so  + 3 bytes of padding added
//     int j;          // 4 bytes  
//     long long l;    // 8 bytes
//     char c;         // 1 byte
//                     // ---------
//                     // 19 bytes + 3 + 3 = 26, rounded to next multiple of largest var (8) = 32 bytes
// };

// #pragma pack()      // including this now returns the struct's size to 19, 
                       // im guessing it organized the vars by type so no padding needed -- nope just removes padding


struct S{
    long long l;    // 8 bytes
    int j;          // 4 bytes 
    int i;          // 4 bytes 
    char a;         // 1 byte 
    char b;         // 1 byte 
    char c;         // 1 byte
                    // ---------
                    // 19 bytes padded to 24 bytes since 24 is the closest multiple of 8 (padding with the largest var)
                    // if used pragma pack here, it would be more effective since vars aligned with mem and no slow down would occur 
};

int main (){
    // return std::alignment_of_v<int>;         // 4 bytes moved into return for int
    // return std::alignment_of_v<char>;        // 1 byte  moved into return for char
    // return std::alignment_of_v<float>;       // 4 bytes moved into return for float 
    // return std::alignment_of_v<double>;      // 8 bytes moved into return for double
    // return std::alignment_of_v<long long>;   // 8 bytes moved into return for long long 
    return sizeof(S);                           // 19 - 24 - 32 bytes
}