set SERVEROUTPUT ON
declare
 
-- atmrow NSBT_ATM_TRX_LOG%rowtype;
 
 hostrow nsbt_host_trx_log%rowtype;
 atmrow nsbt_atm_trx_log%rowtype;
 
 atm_id nsbt_atm_trx_log.TRANSACTION_ID%type;
 
  CURSOR cursatm is 
      select distinct T1.TRANSACTION_ID from NSBT_ATM_TRX_LOG T1 where exists (select distinct T2.TRANSACTION_ID from NSBT_HOST_TRX_LOG T2
      where T2.TRANSACTION_ID= T1.TRANSACTION_ID);
begin
OPEN cursatm; 
  LOOP 
   FETCH cursatm into atm_id;
   dbms_output.put_line(atm_id);
   select * into hostrow from NSBT_HOST_TRX_LOG where nsbt_host_trx_log.TRANSACTION_ID=atm_id;
   
   select * into atmrow from NSBT_atm_TRX_LOG where nsbt_atm_trx_log.TRANSACTION_ID=atm_id;
       
        dbms_output.put_line(hostrow.transaction_id||'  '||hostrow.CUSTOMER_ID);
        
        dbms_output.put_line(atmrow.transaction_id||'  '||atmrow.CUSTOMER_ID);
   
      EXIT WHEN cursatm%notfound;    
    
   END LOOP; 
   CLOSE cursatm; 

   end;