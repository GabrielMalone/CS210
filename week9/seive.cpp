#include <iostream>
#include <vector>
#include <cmath>
std::vector<bool> seive (int n) {
	std::vector<bool> primes (n , true);
	primes[0] = primes[1] = false;
	for ( int i = 2 ; i < std::sqrt(n) ; i ++ )
		if (primes[i]) for (int j = i * i ; j <= n ; j += i) primes[j] = false;
	return primes;
}
int main() {
	int ptf = 1000;
	std::vector<bool> res = seive(ptf);
	for (int i = 0 ; i < ptf ; i ++ ) if (res[i]) std::cout << i << " ";
	return 0;
}