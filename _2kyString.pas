unit _2kyString;

interface

type
  TStrIndex = Integer;

function _Length(const str: String): Integer; overload;
procedure _TrimAll(var str: String);

implementation

procedure _TrimAll(var str: String);
var
  i: TStrIndex;
begin
  i := 1;
  while i <= _Length(str) do
  begin
    if str[i] = ' ' then
      Delete(str,i,1)
    else
      inc(i);
  end;
end;

function _Length(const str: String): Integer;
var
  i: TStrIndex;
begin
  Result := 0;
  i := 1;
  while str[i] <> #0 do
  begin
    inc(Result);
    inc(i);
  end;
end;

end.
