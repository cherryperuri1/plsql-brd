set SERVEROUTPUT ON
declare 
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
   EXIT WHEN cursatm%notfound;
   dbms_output.put_line(atm_id);
   select * into hostrow from NSBT_HOST_TRX_LOG where nsbt_host_trx_log.TRANSACTION_ID=atm_id;
   
   select * into atmrow from NSBT_atm_TRX_LOG where nsbt_atm_trx_log.TRANSACTION_ID=atm_id;
       
         IF (atmrow.customer_id!=hostrow.customer_id) THEN 
--        dbms_output.put_line(hostrow.transaction_id||'  '||hostrow.CUSTOMER_ID);
        
            insert into log_table (TRANSACTION_ID,description) values(atm_id,'There is a mismatch in the customer_id values');
            
             END IF;
   
         IF (atmrow.ACCOUNT_NUMBER!=hostrow.ACCOUNT_NUMBER) THEN 
         
            insert into log_table (TRANSACTION_ID,description) values(atm_id,'There is a mismatch in the ACCOUNT_NUMBER values');
         
          END IF;
         
         IF (atmrow.TRANSACTION_TYPE!=hostrow.TRANSACTION_TYPE) THEN 
         
            insert into log_table (TRANSACTION_ID,description) values(atm_id,'There is a mismatch in the TRANSACTION_TYPE values');
         
       END IF;
   
          
    
   END LOOP; 
   CLOSE cursatm; 

   end;