/*anonymous blocks*/
set SERVEROUTPUT ON
declare 
a number:=123;
b number:=234;
c number;
begin
c:=a+b;
DBMS_OUTPUT.PUT_LINE('sum is:'||c);
end;



set SERVEROUTPUT ON
declare 
ename varchar2(20);
 ename1 char(20);
begin 
ename:='charan';
ename1:='charan';
DBMS_OUTPUT.PUT_LINE(length(ename));
DBMS_OUTPUT.PUt_line(length(ename1));
end;



set SERVEROUTPUT ON
declare 
empid number(6);
ename varchar2(20);
begin
select employee_id, first_name into empid,ename from employees where employee_id=100;
DBMS_OUTPUT.PUT_LINE(empid||' '||ename);
end;




set SERVEROUTPUT ON
declare
 empid employees.employee_id%type;
 ename employees.first_name%type;
 begin
select employee_id,first_name into empid , ename from employees where employees.employee_id=101;
DBMS_OUTPUT.PUT_LINE(empid||''||ename);
end;


set SERVEROUTPUT ON
declare
 emprow employees%rowtype;
 begin
 select * into emprow from employees where employee_id=104;
 DBMS_OUTPUT.PUT_LINE(emprow.first_name||'  '||emprow.last_name);
 end;
 
 
 
 
 
 
 
 
 
 set SERVEROUTPUT ON
declare
a number:=123;
b number:=234;
begin 
 DBMS_OUTPUT.PUT_LINE(a||'=a b='||b);
  declare
  a number:=1;
  b number:=3;
  begin
   DBMS_OUTPUT.PUT_LINE(a||'=a b='||b);
  end;
     DBMS_OUTPUT.PUT_LINE(a||'=a b='||b);
  end;
    




set SERVEROUTPUT ON
declare
a number:=123;
b number:=234;
begin 
 DBMS_OUTPUT.PUT_LINE(a||'=a b='||b);
  declare
  a number:=1;
  b number:=3;
     begin
     DBMS_OUTPUT.PUT_LINE(a||'=a b='||b);
      declare
        a number:=6;
         b number:=7;
       begin
        DBMS_OUTPUT.PUT_LINE(a||'=a b='||b);
       end;
    end;
     DBMS_OUTPUT.PUT_LINE(a||'=a b='||b);
  end;
  
  
  
  
  /*this is not named */  
     set SERVEROUTPUT ON
 <<outblock>>
declare
a number:=123;
b number:=234;
begin 
 DBMS_OUTPUT.PUT_LINE(a||'=a b='||b);
 <<inblock>>
  declare
  a number:=1;
  b number:=3;
  begin
   DBMS_OUTPUT.PUT_LINE('inside inblock printint inblock values');
   DBMS_OUTPUT.PUT_LINE(a||'=a b='||b);
     DBMS_OUTPUT.PUT_LINE('inside inblock printint out values');
   DBMS_OUTPUT.PUT_LINE(outblock.a||'=a b='||outblock.b);
  end;
     DBMS_OUTPUT.PUT_LINE('inside outblock printint out values');
     DBMS_OUTPUT.PUT_LINE(a||'=a b='||b);
  end;
   
   
   
   
   
   
   
   
   
   
    
/*named  pro*/
 set SERVEROUTPUT ON
create or replace procedure p1
as 
begin
DBMS_OUTPUT.PUT_LINE('procedure one');
end p1;


set SERVEROUTPUT ON
begin 
p1;
end;
 

 set SERVEROUTPUT ON
create or replace procedure p1
as 
begin
DBMS_OUTPUT.PUT_LINE('procedure one');
end p1;

execute p1;






/*named  fun*/
 set SERVEROUTPUT ON
create or replace function f1
return number
as 
begin
return 5000;
end;


set SERVEROUTPUT ON
begin 
DBMS_OUTPUT.PUT_LINE(f1);
end;






