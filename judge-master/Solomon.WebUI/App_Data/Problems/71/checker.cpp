#include "testlib.h"

#include <cctype>

#include <string>

using namespace std;

#define forn(i, n) for (int i = 0; i < (int)(n); i++)

typedef long long ll;
                    
int n, a, b, c;

struct num
{
  static const int len = 100;

  ll a[len];

  void clear()
  {
    memset(a, 0, sizeof(a));
  }

  void read( InStream &inf )
  {
    string s = inf.readWord();
    int n = s.length();
    clear();
    if (n > len - 1)
      inf.quitf(_pe, "too long answer");
    forn(i, n)
    {
      if (!isdigit(s[i]))
        inf.quitf(_pe, "only digits are allowed");
      a[n - i - 1] = s[i] - '0';
    }
  }

  num()
  {
    clear();
  }

  num( ll x )
  {
    clear();
    for (int i = 0; x > 0; i++)
      a[i] = x % 10, x /= 10;
  }

  int n()
  {
    int i = len - 1;
    while (i && !a[i])
      i--;
    return i + 1;
  }

  string str()
  {
    string res = "";
    for (int i = n() - 1; i >= 0; i--)
      res += (char)(a[i] + '0');
    return res;
  }

  num & cor()
  {
    forn(i, len)
      if (a[i] >= 10)
        a[i + 1] += a[i] / 10, a[i] %= 10;
    return *this;
  }

  num & operator = ( const num &x )
  {
    memcpy(a, x.a, sizeof(a));
    return *this;
  }

  num & operator *= ( int x )
  {
    forn(i, len)
      a[i] *= x;
    return cor();
  }

  num operator * ( int k ) { num x = *this; x *= k; return x; }

  int cmp( const num &x )
  {
    for (int i = len - 1; i >= 0; i--)
      if (a[i] != x.a[i])
        return a[i] - x.a[i];
    return 0;
  }

  bool operator != ( const num &x ) { return cmp(x) != 0; }
  bool operator == ( const num &x ) { return cmp(x) == 0; }
  bool operator >= ( const num &x ) { return cmp(x) <= 0; }
  bool operator <= ( const num &x ) { return cmp(x) >= 0; }
  bool operator <  ( const num &x ) { return cmp(x) <  0; }
  bool operator >  ( const num &x ) { return cmp(x) >  0; }
};

void readInput( InStream &in )
{
  n = in.readInt();
  a = in.readInt();
  b = in.readInt();
  c = in.readInt();
}

num checkOutput( InStream &out )
{
  int ra = out.readInt();
  int rb = out.readInt();
  int rc = out.readInt();
  if (ra < 0 || rb < 0 || rc < 0)
    out.quitf(_pe, "a, b, c can not be negative");
  if ((ll)ra + rb + rc > n)
    out.quitf(_wa, "a + b + c > n");

  ra /= a, rb /= b, rc /= c;
  //printf("ra = %d, rb = %d, rc = %d\n", ra, rb, rc);
  return num(ra) * rb * rc;
}

int main(int argc, char *argv[])
{
  registerTestlibCmd(argc, argv);

  readInput(inf);

  num ja = checkOutput(ans);
  num ca = checkOutput(ouf);

  if (ca != ja)
    quitf(ca > ja ? _fail : _wa, "Contestant says %s, jury say %s", ca.str().c_str(), ja.str().c_str());
  quitf(_ok, "OK (n = %d, a = %d, b = %d, c = %d, answer = %s)", n, a, b, c, ca.str().c_str());
  return 0;
}
