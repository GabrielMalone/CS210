#include <stdio.h>
//----------------------------------------------------------------------------------------------------------------------
// Gabriel Malone / CS4 / LAB 2
//----------------------------------------------------------------------------------------------------------------------
void encryptFile(char* og_img, char* en_img){
//----------------------------------------------------------------------------------------------------------------------
	FILE *og = fopen(og_img, "rb");                                                 // open an image and read its binary
	FILE *nf = fopen(en_img, "wb");                                   // open image file for writing the encrypted bytes
	int c;                                                                        // int to hold each byte of the binary
	while ((c = fgetc(og)) != EOF)                                                // read byte by byte until end of file
		fputc(c ^ 0xAA, nf);         // perform XOR on the bit with key 1010_1010 and write the new byte to the new file
	fclose(og);                                                                                       // close the files
	fclose(nf);
}
//----------------------------------------------------------------------------------------------------------------------
int main(int argc, char *argv[]){
//----------------------------------------------------------------------------------------------------------------------
	if (argc < 3) return 1;                                                                // must have 2 file name args
	char* og_img = argv[1];                                                                  // image to encrypt/decrypt
	char* en_img = argv[2];                                                                         // new image created

	encryptFile(og_img, en_img);                                                                    // encrypt / decrypt

	return 0;
}