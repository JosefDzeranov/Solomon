uses
  testlib, SysUtils;

const
  MAXC = 1000000000;

var
  n, k : integer;
  x1, y1, x2, y2 : array[1..100000] of longint;
  pl, jl : int64;
  pa, ja : string;
  i, j, x, y, nx, ny, xx, yy, pn, jn, ndir, dir : longint;
  tests : string;

function inside(a : double; b1, b2 : longint) : boolean;
var t : longint;
begin
  if (b2 < b1) then begin
    t := b1; b1 := b2; b2 := t;
  end;
  inside := (a > b1) and (a < b2);
end;

function crossx(x, yy1, yy2 : longint) : boolean;
var
  i : integer;
begin
  crossx := false;
  for i := 1 to n do begin
    if (inside(x, x1[i], x2[i])) then begin
      if (inside(yy1, y1[i], y2[i])) or (inside(yy2, y1[i], y2[i])) or (inside((yy1 + yy2) / 2, y1[i], y2[i])) then begin
        crossx := true;
        exit;
      end;
      if (inside(y1[i], yy1, yy2)) or (inside(y2[i], yy1, yy2)) then begin
        crossx := true;
        exit;
      end;
    end;
  end;
end;

function crossy(y, xx1, xx2 : longint) : boolean;
var
  i : integer;
begin
  crossy := false;
  for i := 1 to n do begin
    if (inside(y, y1[i], y2[i])) then begin
      if (inside(xx1, x1[i], x2[i])) or (inside(xx2, x1[i], x2[i])) or (inside((xx1 + xx2) / 2, x1[i], x2[i])) then begin
        crossy := true;
        exit;
      end;
      if (inside(x1[i], xx1, xx2)) or (inside(x2[i], xx1, xx2)) then begin
        crossy := true;
        exit;
      end;
    end;
  end;
end;

function badSegment(x1, y1, x2, y2, dir : longint) : boolean;
begin
  if (x1 = x2) then begin
    if (y1 < y2) and (dir <> 0) then begin
      badSegment := true;
      exit;
    end;
    if (y1 > y2) and (dir <> 2) then begin
      badSegment := true;
      exit;
    end;
    badSegment := crossx(x1, y1, y2);
  end else if (y1 = y2) then begin
    if (x1 < x2) and (dir <> 1) then begin
      badSegment := true;
      exit;
    end;
    if (x1 > x2) and (dir <> 3) then begin
      badSegment := true;
      exit;
    end;
    badSegment := crossy(y1, x1, x2);
  end else begin
    badSegment := true;
  end;
end;

begin
  n := inf.readlongint;
  k := inf.readlongint;
  for i := 1 to n do begin
    x1[i] := inf.readlongint;
    y1[i] := inf.readlongint;
    x2[i] := inf.readlongint;
    y2[i] := inf.readlongint;
  end;

  for i := 1 to k do begin
    tests := 'Test ' + IntToStr(i) + ': ';
    x := inf.readlongint;
    y := inf.readlongint;

    pa := ouf.readword(blanks, blanks);
    ja := ans.readword(blanks, blanks);
    if (pa <> 'YES') and (pa <> 'NO') then
      quit(_pe, tests + 'YES or NO expected, ' + pa + ' found');
    if (pa = 'NO') and (ja = 'YES') then
      quit(_wa, tests + ja + ' expected, ' + pa + ' found');
    if (pa = 'YES') then begin
      pn := ouf.readlongint;
      if (pn < 0) or (pn > 2) then
        quit(_wa, tests + 'Wrong number of turns: ' + IntToStr(pn));
      xx := 0; yy := 0;
      pl := 0;
      dir := 0;
      ndir := 0;
      for j := 1 to pn + 1 do begin
        if (j <> pn + 1) then begin
          nx := ouf.readlongint;
          if (nx < -MAXC) or (nx > MAXC) then
            quit(_wa, tests + 'Too big coordinate: ' + IntToStr(nx));
          ny := ouf.readlongint;
          if (ny < -MAXC) or (ny > MAXC) then
            quit(_wa, tests+ 'Too big coordinate: ' + IntToStr(ny));
          ndir := ouf.readlongint;
          if (ndir <> -1) and (ndir <> 1) then
            quit(_wa, tests + 'Wrong turn direction: ' + IntToStr(ndir));
        end else begin
          nx := x;
          ny := y;
        end;
        if (badSegment(xx, yy, nx, ny, dir)) then
          quit(_wa, tests + 'Wrong segment from ' + IntToStr(xx) + ' ' + IntToStr(yy) + ' to ' + IntToStr(nx) + ' ' + IntToStr(ny));
        dir := (dir + ndir + 4) mod 4;
        pl := pl + abs(xx - nx) + abs(yy - ny);
        xx := nx;
        yy := ny;
      end;

      if (ja = 'NO') then
        quit(_fail, 'NO expected, YES found');
      
      jn := ans.readlongint;
      xx := 0; yy := 0;
      jl := 0;
      for j := 1 to jn + 1 do begin
        if (j <> jn + 1) then begin
          nx := ans.readlongint;
          ny := ans.readlongint;
          ans.readlongint;
        end else begin
          nx := x;
          ny := y;
        end;
        jl := jl + abs(xx - nx) + abs(yy - ny);
        xx := nx;
        yy := ny;
      end;

      if (pl > jl) then
        quit(_wa, tests + 'Participant path is longer');
      if (pl < jl) then
        quit(_fail, tests + 'Shorter path found');
    end;
  end;

  quit(_ok, 'OK');
end.