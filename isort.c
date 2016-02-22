#include <stdio.h>
int main() {
	printf("isort\nn: ");
	int n, i, j, cur;

	scanf("%d", &n);
	i = 1;
	int a[n];
	while (i <= n) {
		printf("%d: ", i);
		scanf("%d", &a[i - 1]);
		i ++;
	}

	for (i = 1; i < n; i ++) {
		cur = a[i];
		for (j = i -1; j >= 0 && a[j] > cur; j -- ) {
			a[j + 1] = a[j];
			
		}
		a[j + 1] = cur;
	}
	
	i = 0;
	while (i < n) {
		printf("%d\n", a[i ++]);
	}

}
