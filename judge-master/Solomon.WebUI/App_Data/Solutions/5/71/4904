/**
 * Author: Sergey Kopeliovich (Burunduk30@gmail.com)
 * Date: 2013.11.15
 *
 * Comment: O(1), try +-1000
 */

#include <cstdio>
#include <cstdlib>
#include <cassert>
#include <iostream>
#include <algorithm>

using namespace std;

#define forn(i, n) for (int i = 0; i < (int)(n); i++)
#define forab(i, a, b) for (int i = (a); i <= (b); i++)

typedef long long ll;
typedef long double dbl;

int main()
{
  #define NAME "sweets"
  assert(freopen(NAME ".in", "r", stdin));
  assert(freopen(NAME ".out", "w", stdout));

  int n, a, b, c;
  assert(scanf("%d%d%d%d", &n, &a, &b, &c) == 4);

  int x0 = n / (3 * a);
  int y0 = n / (3 * b);
  int z0 = n / (3 * c);
  int res[] = {x0, y0, z0};
  dbl best = (ll)x0 * y0 * z0, tmp;
  int best_shift = 0;

  int p[] = {0, 1, 2};
  int A[] = {a, b, c};
  do
  {
    const int M = 500;
    int a = A[p[0]], b = A[p[1]], c = A[p[2]];
    int x0 = n / (3 * a);
    forab(x, x0 - M, x0 + M)
      if (1 <= x && (ll)x * a <= n)
      {
        int n0 = n - x * a;
        int y0 = n0 / (2 * b);
        forab(y, y0 - M, y0 + M)
          if (1 <= y && (ll)y * b <= n0)
          {
            int z = (n0 - y * b) / c;
            int shift = max(abs(x - x0), abs(y - y0));
            if ((tmp = (dbl)x * y * z) > best || (tmp == best && best_shift > shift)) 
            {
              best = tmp;
              best_shift = shift;
              res[p[0]] = x;
              res[p[1]] = y;
              res[p[2]] = z;
            }
          }
      }
  } while (next_permutation(p, p + 3));
  
  fprintf(stderr, "shift = %d\n", best_shift);
  printf("%d %d %d\n", a * res[0], b * res[1], c * res[2]);
  return 0;
}
                        