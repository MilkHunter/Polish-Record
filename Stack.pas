unit Stack;

interface

type
  TPCharStack = ^TCharStack;
  TCharStack = record
    ch: Char;
    prev: TPCharStack;
  end;

procedure push(var StackHead: TPCharStack; const value: Char); overload;
procedure pop(var StackHead: TPCharStack; var value: Char); overload;
procedure Delete(var StackHead: TPCharStack; const value: Char); overload;
function Get_Top(const StackHead: TPCharStack; var ch: Char): TPCharStack; overload;
function Get_Last(StackHead: TPCharStack; var ch: Char): TPCharStack; overload;
function Empty(const StackHead: TPCharStack): Boolean; overload;
function ElementsCount(StackHead: TPCharStack): Integer; overload;

implementation

procedure push(var StackHead: TPCharStack; const value: Char);
var
  temp: TPCharStack;
begin
  temp := StackHead;
  new(StackHead);
  StackHead.ch := value;
  StackHead.prev := temp;
end;

procedure pop(var StackHead: TPCharStack; var value: Char);
var
  temp: TPCharStack;
begin
  value := StackHead.ch;
  temp := StackHead.prev;
  Dispose(StackHead);
  StackHead := temp;
end;

procedure Delete(var StackHead: TPCharStack; const value: Char);
var
  last, temp: TPCharStack;
begin
  last := nil;
  temp := StackHead;
  while (temp <> nil) do
  begin
    last := temp;
    if temp.ch = value then
    begin
      if last = StackHead then   // if element located at the top of stack;
      begin
        StackHead := StackHead.prev;
        Dispose(temp);
      end
      else if last.prev = nil then   // if deleted element located at the end of stack;
      begin
        Dispose(last);
        last := nil;
      end
      else   // if element is located near or in the center of stack;
      begin
        Dispose(temp);
        last.prev := temp.prev;
      end;
      break;
    end;
    temp := temp.prev;
  end;
end;

function Get_Top(const StackHead: TPCharStack; var ch: Char): TPCharStack;
begin
  Result := StackHead;
  if StackHead <> nil then
    ch := StackHead.ch
  else
    ch := #0;
end;

function Get_Last(StackHead: TPCharStack; var ch: Char): TPCharStack;
begin
  Result := StackHead;
  if StackHead <> nil then
  begin
    while StackHead.prev <> nil do
      StackHead := StackHead.prev;
    ch := StackHead.ch;
    Result := StackHead;
  end;
end;

function Empty(const StackHead: TPCharStack): Boolean;
begin
  Result := False;
  if StackHead.ch = #0 then
    Result := True;
end;

function ElementsCount(StackHead: TPCharStack): Integer;
begin
  Result := 0;
  while StackHead.ch <> #0 do
  begin
    Inc(Result);
    StackHead := StackHead.prev;
  end;
end;

end.
