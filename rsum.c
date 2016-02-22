#include <stdio.h>
int recurs(int a[], int size, int i);
int main() {
        int n, i;
        printf("rsum\nn: ");
        scanf("%d", &n);
        int a[n];
        for (i = 0; i < n; i ++) {
                printf("%d: ", i + 1);
                
		scanf("%d", &a[i]);
        }

	printf("sum:%d\n", recurs(a, n, n - 1));
        return 0;
}


int recurs(int a[], int size, int i) {
	if (i == 0) {
		return a[i];
	} else {
		return a[i] + recurs(a, size, i - 1);
	}
}
