uses
  testlib, SysUtils;

const
	digits = 9;

var
    ja, pa, eps: extended;
    i: longint;

begin
	eps := 1;
	for i := 1 to digits do
		eps := eps / 10;

  ja := ans.readreal;
  pa := ouf.readreal;

  if abs(ja - pa) < eps then
    quit(_ok, floattostr(pa));

  if (abs(ja) > eps) and (abs(ja - pa) / abs(ja) < eps) then
    quit(_ok, floattostr(pa));

  quit(_wa, 'Expected: ' + floattostr(ja) + ', found: ' + floattostr(pa));
end.