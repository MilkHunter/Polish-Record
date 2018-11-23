program Polskaya_zapis;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Stack in '..\Units\Stack.pas',
  _2kyString in '..\Units\_2kyString.pas';

type
  TPriorityArr = array of set of Char;
  TIndex = Integer;

var
  PriorArr: TPriorityArr;
  RelativeArr: TPriorityArr;
  MainStr: String;
  MainStack: TPCharStack;

function Get_Priority(const arr: TPriorityArr; const ch: Char): Integer;
var
  i  : TIndex;
  len: Integer;
begin
  Result := -1;
  len := length(arr);
  for i := 0 to len-1 do
  begin
    if ch in arr[i] then
      Result := i;
  end;
end;

procedure Init_Arr(var PriorArr, RelativeArr: TPriorityArr);
begin
  SetLength(PriorArr, 6);
  PriorArr[0] := [#0]; // top of the stack;
  PriorArr[1] := [')'];
  PriorArr[2] := ['('];
  PriorArr[3] := ['+','-'];
  PriorArr[4] := ['*','/'];
  PriorArr[5] := ['^'];

  SetLength(RelativeArr, 7);
  RelativeArr[0] := [')'];
  RelativeArr[1] := ['+','-'];
  RelativeArr[2] := ['*','/'];
  RelativeArr[3] := ['('];
  RelativeArr[4] := ['?'];
  RelativeArr[5] := ['?'];
  RelativeArr[6] := ['^'];
end;

function Convert_Polish_Record(const str: String): String;
var
  i, j: TIndex;
  len, prior, relprior: Integer;
  ch: Char;
begin
  i := 1;
  len := length(str);
  while i <= len  do
  begin
    //ch := str[i];
    prior := Get_Priority(PriorArr, str[i]);
    relprior := Get_Priority(RelativeArr, str[i])+1;
    if prior = -1 then
      Result := Result + str[i]
    else if prior = 2 then
         push(MainStack, str[i])
    else
    begin
      Get_Top(MainStack, ch);
      if (prior > Get_Priority(PriorArr, ch)) then
      begin
        push(MainStack, str[i])
      end
      else if prior = 1 then   // its occured when ')' appears;
      begin
        while ch <> '(' do
        begin
          pop(MainStack, ch);
          Result := Result + ch;
          Get_Top(MainSTack, ch);
        end;
        pop(MainStack, ch); // we should pulll out this '(' brace
      end
      else if prior <= Get_Priority(PriorArr, ch) then
      begin
        if relprior < Get_Priority(PriorArr, str[i]) then
        begin
          Get_Top(MainStack, ch);
          while Get_Priority(PriorArr, ch) >= prior do
          begin
            pop(MainStack, ch);
            Result := Result + ch;
            Get_Top(MainStack, ch);
          end;
          push(MainStack, str[i]);
        end
        else                    // it occures when we have 2 '^'
          push(MainStack, str[i]);
      end;
    end;
    inc(i);
  end;
  while not(Empty(MainStack)) do
  begin
    pop(MainStack, ch);
    Result := Result + ch;
  end;
end;

function Get_Rang(const str: String): Integer;
var
  operators, operands, len: Integer;
  OperandsSet, OperatorsSet: set of Char;
  i: TIndex;
begin
  OperatorsSet := ['+','-','*','/','^'];
  OperandsSet := ['a'..'z','A'..'Z'];
  operators := 0;
  operands := 0;
  len := length(str);
  for i := 1 to len do
  begin
    if str[i] in OperandsSet then
    begin
      inc(Operands);
    end
    else
    begin
      inc(Operators);
    end;
  end;
  Result := Operands - Operators;
end;

begin
  Init_Arr(PriorArr, RelativeArr);
  New(MainStack);
  MainStack.ch := #0;
  MainStack.prev := nil;
  Write('Enter str as infix record: ');
  Readln(MainStr);
  _TrimAll(MainStr);
  MainStr := Convert_Polish_Record(MainStr);
  Writeln('Polish record: ', MainStr);
  Writeln('Rang of record: ', Get_Rang(MainStr));
  Readln;
end.
