program Check;

uses
  testlib, SysUtils;

type
  mas = array[0..2000] of string;

const
  MAXLEN = 100;

var
  ja, pa: string;
  pn, jn: longint;
  i: longint;
  l: longint;
  pmas, jmas: mas;

function compress(s: string): string;
begin
    if length(s) < 100 then
        compress := s
    else
        compress := copy(s, 1, 50) + '..' + copy(s, length(s) - 24, 50);
end;

function Less(s, t: string): boolean;
begin
  if (length(s) < length(t)) then Less := true
  else if (length(s) = length(t)) and (s < t) then Less := true
  else Less := false;
end;

procedure Swap(var a, b: string);
var
  c: string;
begin
  c := a;
  a := b;
  b := c;
end;

procedure Sort(var b: mas; l, r: Longint);
var
  i, j: longint;
  x: string;
begin
  i := l; j := r; x := b[i + random(j - i + 1)];
  repeat
    while Less(b[i], x) do inc(i);
    while Less(x, b[j]) do dec(j);
    if i <= j then begin
      swap(b[i], b[j]);
      inc(i); dec(j);
    end;
  until i > j;
  if i < r then Sort(b, i, r);
  if j > l then Sort(b, l, j);
end;


begin 
  l := 0;
  pn := ouf.readlongint;
  jn := ans.readlongint;
  if (pn <> jn) then
      quit(_wa, 'Line ' + inttostr(l) + ' - expected: "' + inttostr(pn) + '", found: "' + inttostr(jn) + '"');
  
  while not ouf.eof and not ans.eof do begin
    inc(l);
    pa := ouf.readstring;
    ja := ans.readstring;

    if (length(pa) > MAXLEN)  then
      quit(_WA, 'Too long number: ' + compress(pa));

    i := length(pa);
    while (i > 0) and (pa[i] = ' ') do dec(i);
    delete(pa, i + 1, length(pa) - i);
    i := length(ja);
    while (i > 0) and (ja[i] = ' ') do dec(i);
    delete(ja, i + 1, length(ja) - i);
    pmas[l] := pa;
    jmas[l] := ja;	
  end;
  
  Sort(pmas, 1, l);
  Sort(jmas, 1, l);

  for i := 1 to l do
    if (pmas[i] <> jmas[i]) then
      quit(_wa, 'Line ' + inttostr(l) + ' - expected: "' + pmas[i] + '", found: "' + jmas[i] + '"');

  if ouf.seekEof and not ans.seekEof then begin
    QUIT (_WA, 'Not enough lines! "' + compress(ans.readString) + '" expected' );
  end;
  if ans.seekEof and not ouf.seekEof then begin
    QUIT (_WA, 'Extra lines! "' + compress(ouf.readString) + '" encountered' );
  end;
  QUIT ( _OK, inttostr(pn) + ' schools' );
end.