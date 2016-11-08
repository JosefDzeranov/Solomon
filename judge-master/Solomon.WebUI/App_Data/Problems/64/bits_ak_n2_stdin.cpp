#include <iostream>

int main()
{
     
     int left, right;
     std::cin >> left >> right;
     int ans = 0;
     for (int x = left; x <= right; x++)
     {
          for (int y = left; y <= right; y++)
          {
               int z = (x | y) ^ y;
               if (left <= z && z <= right)
                    ans++;
          }
     }
     std::cout << ans << "\n";
}
