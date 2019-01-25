 set SERVEROUTPUT ON
 declare
 emprow employees%rowtype;
 begin
 select * into emprow from employees where employee_id=104;
 dbms_output.put_line(emprow.first_name||'  '||emprow.last_name);
 end;
 
 desc nsbt_host_trx_log;
 desc nsbt_atm_trx_log;
 desc log_table;
 CREATE TABLE NSBT_HOST_TRX_LOG (
  BUSINESS_DATE DATE ,
  TRANSACTION_ID NUMBER(10) NOT NULL,
  TRANSACTION_DATE DATE , 
   TRANSACTION_TIME TIMESTAMP(6) ,
  TRANSACTION_VALUE_DATE DATE ,
  TRANSACTION_TYPE VARCHAR2(2) NOT NULL,
  CUSTOMER_ID NUMBER NOT NULL,
  ACCOUNT_NUMBER VARCHAR2(20) NOT NULL,
    TRANSACTION_AMOUNT NUMBER(16,3) NOT NULL,
   PRIMARY KEY (TRANSACTION_ID)
)

CREATE TABLE nsbt_atm_trx_log(
  BUSINESS_DATE DATE ,
  TRANSACTION_ID NUMBER(10) NOT NULL,
  TRANSACTION_DATE DATE , 
   TRANSACTION_TIME TIMESTAMP(6) ,
  TRANSACTION_VALUE_DATE DATE ,
  TRANSACTION_TYPE VARCHAR2(2) NOT NULL,
  CUSTOMER_ID NUMBER NOT NULL,
  ACCOUNT_NUMBER VARCHAR2(20) NOT NULL,
    TRANSACTION_AMOUNT NUMBER(16,3) NOT NULL,
   PRIMARY KEY (TRANSACTION_ID)
)


commit;

drop table log_table;
CREATE table log_table(
 
  TRANSACTION_ID NUMBER(10) NOT NULL,
   description varchar2(100)
)


delete from NSBT_ATM_TRX_LOG;
delete from NSBT_HOST_TRX_LOG;

rollback;
commit;

select count(*) from NSBT_ATM_TRX_LOG;
select count(*) from NSBT_host_TRX_LOG;

delete from log_table;

select * from log_table;
select * from NSBT_ATM_TRX_LOG;
select * from NSBT_host_TRX_LOG;

INSERT INTO NSBT_ATM_TRX_LOG(Business_Date,Transaction_ID,Transaction_Date,Transaction_Time,Transaction_Value_Date,Transaction_Type,Customer_ID,Account_Number,Transaction_Amount) VALUES(Sysdate,1,Sysdate,Sysdate,Sysdate,1,1001,100001,1000);
INSERT INTO NSBT_HOST_TRX_LOG(Business_Date,Transaction_ID,Transaction_Date,Transaction_Time,Transaction_Value_Date,Transaction_Type,Customer_ID,Account_Number,Transaction_Amount) VALUES(Sysdate,1,Sysdate,Sysdate,Sysdate,1,1001,100001,1000);


/*id2*/
INSERT INTO NSBT_ATM_TRX_LOG(Business_Date,Transaction_ID,Transaction_Date,Transaction_Time,Transaction_Value_Date,Transaction_Type,Customer_ID,Account_Number,Transaction_Amount) VALUES(Sysdate,2,Sysdate,Sysdate,Sysdate,2,1002,100002,1001);

/*id3*/
INSERT INTO NSBT_HOST_TRX_LOG(Business_Date,Transaction_ID,Transaction_Date,Transaction_Time,Transaction_Value_Date,Transaction_Type,Customer_ID,Account_Number,Transaction_Amount) VALUES(Sysdate,a3,Sysdate,Sysdate,Sysdate,3,1003,100003,1003);



set SERVEROUTPUT ON
 declare
 host_mid number;
 atm_mid number;
 
 host_minid number;
 atm_minid number;
 
 host_count number;
 atm_count number;
 
 transrow NSBT_ATM_TRX_LOG%rowtype;
 begin
 select max(TRANSACTION_ID) into atm_mid from NSBT_atm_TRX_LOG;
 select max(TRANSACTION_ID) into host_mid from NSBT_host_TRX_LOG;
 
  select min(TRANSACTION_ID) into atm_minid from NSBT_atm_TRX_LOG;
 select min(TRANSACTION_ID) into host_minid from NSBT_host_TRX_LOG;
 
 select count(*) into atm_count from NSBT_ATM_TRX_LOG;
 select count(*) into host_count from NSBT_HOST_TRX_LOG;
 
  IF(atm_count>=host_count) THEN 
  DBMS_OUTPUT.PUT_LINE('atm has more or equal to');
  
  
  ELSE
  dbms_output.put_line('atm has lesser'); 
  
  
  end if;
  
   dbms_output.put_line(atm_minid||'  '||host_minid);
   dbms_output.put_line(atm_mid||'  '||host_mid);
   
 select * into transrow from NSBT_ATM_TRX_LOG where TRANSACTION_ID=2;
 dbms_output.put_line(transrow.TRANSACTION_ID ||'  '||transrow.TRANSACTION_AMOUNT);
 end;




set SERVEROUTPUT ON
 declare
 transrow NSBT_host_TRX_LOG%rowtype;
 begin
 select * into transrow from NSBT_host_TRX_LOG where TRANSACTION_ID=3;
 dbms_output.put_line(transrow.TRANSACTION_ID ||'  '||transrow.TRANSACTION_AMOUNT);
 end;


commit;
select * from NSBT_ATM_TRX_LOG minus select * from nsbt_host_trx_log;
rollback;

desc NSBT_ATM_TRX_LOG;
desc NSBT_HOST_TRX_LOG

select distinct T1.TRANSACTION_ID
  from NSBT_ATM_TRX_LOG T1
 where not exists (select distinct T2.TRANSACTION_ID
                     from NSBT_HOST_TRX_LOG T2
                    where T2.TRANSACTION_ID= T1.TRANSACTION_ID);
                    
select distinct T2.TRANSACTION_ID from NSBT_HOST_TRX_LOG T2 where not exists(select distinct T1.TRANSACTION_ID from NSBT_ATM_TRX_LOG T1 where T2.TRANSACTION_ID= T1.TRANSACTION_ID);
