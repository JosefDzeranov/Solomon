uses
    testlib, SysUtils;
{$R+,Q+}
var
    ja, pa: string;
    aCount, i, n: longint;
    s, t, c, a : array[1..100000] of longint;
    realAns, sum : int64;
begin
    ja := ans.readword(blanks, blanks);
    pa := ouf.readword(blanks, blanks);
    if not (pa[1] in ['-', '0'..'9']) then
        quit(_pe, 'invalid character in answer');
    for i := 2 to length(pa) do
        if not (pa[i] in ['0'..'9']) then
            quit(_pe, 'invalid character in answer');
    realAns := strToInt64(ja);
    n := inf.readlongint;
    for i := 1 to n do begin
        s[i] := inf.readlongint;
        t[i] := inf.readlongint;
        c[i] := inf.readlongint;
    end;
    aCount := ouf.readlongint;
    if (aCount < 0) or (aCount > n) then
      quit(_wa, 'Too many tasks');
    sum := 0;
    for i := 1 to aCount do begin
        a[i] := ouf.readlongint;
        if (a[i] <= 0) or (a[i] > n) then begin                
           quit(_wa, 'Wrong task number ' + intToStr(a[i]));
        end;
        sum := sum + c[a[i]];
        if (i <> 1) and (s[a[i]] < s[a[i - 1]] + t[a[i - 1]]) then begin
                quit(_wa, 'Task ' + intToStr(a[i]) + ' starts before task ' + intToStr(a[i - 1]) + ' ends' );
        end
    end;
    if (intToStr(sum) <> pa) then begin
        quit(_wa, 'Promised sum: ' + pa + ' real sum: ' + intToStr(sum));
    end;

    if (sum > realAns) then begin
       quit(_fail, 'Contestant found better solution: ' + intToStr(sum) + ' instead of ' + intToStr(realAns));
    end;
    if (sum < realAns) then begin
       quit(_wa, 'Contestant solution is only ' + intToStr(sum) + ', but jury has ' + intToStr(realAns));
    end;
    quit(_ok, pa);
end.
