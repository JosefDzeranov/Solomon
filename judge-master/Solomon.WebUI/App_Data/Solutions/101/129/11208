#include <iostream>
#include <cassert>
#include <cstdio>
#include <ctime>
#include <cstdlib>
#include <string>
using namespace std;

#if LOCAL
    #define eprintf(...) fprintf(stderr, __VA_ARGS__)
#else
    #define eprintf(...) 42;
#endif

const int MAXN = 3003;
const string TYPES = "NESW.";

int n, m;
int board[MAXN][MAXN];
int qx[MAXN * MAXN];
int qy[MAXN * MAXN];
char buf[MAXN];
int up[MAXN];
int dn[MAXN];
int lf[MAXN];
int rg[MAXN];
bool was[MAXN][MAXN];
int qh, qt;

inline void add(int x, int y) {
    was[x][y] = true;
    qx[qt] = x;
    qy[qt] = y;
    qt++;
}

int main() {
    clock_t start = clock();
    freopen("alligator.in", "r", stdin);
    freopen("alligator.out", "w", stdout);
    scanf("%d%d", &n, &m);
    for (int i = 0; i < n; i++) {
        lf[i] = m + 1;
        rg[i] = -1;
    }
    for (int i = 0; i < m; i++) {
        up[i] = n + 1;
        dn[i] = -1;
    }
    for (int i = 0; i < n; i++) {
        scanf("%s", buf);
        for (int j = 0; j < m; j++) {
            board[i][j] = TYPES.find(buf[j]);
        }
        for (int j = 0; j < m; j++) {
            if (board[i][j] == 4) {
                continue;
            }
            up[j] = min(up[j], i);
            dn[j] = max(dn[j], i);
            lf[i] = min(lf[i], j);
            rg[i] = max(rg[i], j);
        }
    }
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            if (board[i][j] == 4) {
                continue;
            }
            if (board[i][j] == 0 && up[j] == i) {
                add(i, j);
            }
            if (board[i][j] == 1 && rg[i] == j) {
                add(i, j);
            }
            if (board[i][j] == 2 && dn[j] == i) {
                add(i, j);
            }
            if (board[i][j] == 3 && lf[i] == j) {
                add(i, j);
            }
        }
    }
    int answer = 0;
    while (qh < qt) {
        int x = qx[qh];
        int y = qy[qh];
        qh++;
        answer++;
        board[x][y] = 4;
        if (up[y] == x) {
            while (up[y] < n && board[up[y]][y] == 4) {
                up[y]++;
            }
            if (up[y] < n && board[up[y]][y] == 0 && !was[up[y]][y]) {
                add(up[y], y);
            }
        }
        if (rg[x] == y) {
            while (rg[x] >= 0 && board[x][rg[x]] == 4) {
                rg[x]--;
            }
            if (rg[x] >= 0 && board[x][rg[x]] == 1 && !was[x][rg[x]]) {
                add(x, rg[x]);
            }
        }
        if (dn[y] == x) {
            while (dn[y] >= 0 && board[dn[y]][y] == 4) {
                dn[y]--;
            }
            if (dn[y] >= 0 && board[dn[y]][y] == 2 && !was[dn[y]][y]) {
                add(dn[y], y);
            }
        }
        if (lf[x] == y) {
            while (lf[x] < m && board[x][lf[x]] == 4) {
                lf[x]++;
            }
            if (lf[x] < m && board[x][lf[x]] == 3 && !was[x][lf[x]]) {
                add(x, lf[x]);
            }
        }
    }
    printf("%d\n", answer);
    eprintf("time: %.3lf\n", (double)(clock() - start) / CLOCKS_PER_SEC);
    return 0;
}
