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
	for (int i = 0 ; i < 100 ; i ++ ) if (seive(100)[i]) std::cout << i << " ";
	return 0;
}