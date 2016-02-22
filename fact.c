#include <stdio.h>
int main() {
	printf("factorial\n");
	printf("number: ");
	int input, i, result = 1;
	scanf("%d", &input);
	for (i = 1; i <= input; i ++) {
		result *= i;
	}	
	
	printf("fact(%d)= %d\n", input, result);
	return 0;
}
