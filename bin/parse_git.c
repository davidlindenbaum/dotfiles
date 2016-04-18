#include <stdio.h>
#include <string.h>

#define RED "%{\033[01;31m%}"
#define GREEN "%{\033[01;32m%}"
#define MAGENTA "%{\033[01;35m%}"
#define RESET "%{\033[00m%}"

int main() {
    char branches[64] = {0}, *separator;
    int ahead = 0, i;
    if (scanf("## %63s [ahead %d]", branches, &ahead) && *branches) {
        if (separator = strstr(branches, "...")) *separator = 0;
        printf(" %s%s", getchar() == -1 ? GREEN : RED, branches);
        if (ahead) printf(" %s+%d", MAGENTA, ahead);
    }
    printf("%s", RESET);
}
