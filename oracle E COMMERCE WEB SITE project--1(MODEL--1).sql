
--==================TTD(Tirumala_tirupathi_devasthanam) for oraclePROJECT--1 ===========================

INDEPENDENT TABLES ;

TABLE:--1

-- user_addres_table  is independent
-- it is having basic address details of all the users along with the pincodes
-- I am not maintaining the H-NO here BECAUSE REDUSED THE DETA CONSISTENS

create table user_addres_table  (
                    addres_id number(5),                   
                    villege varchar2(20),
                    mandalam varchar2(20),
                    distric varchar2(20),
                    states varchar2(20),
                    pincode number(9) check(length(pincode)=6),
                    CONSTRAINT user_addres_pk primary key(addres_id)
                    ); 

  __1)  in above table addres_id is used SEQUENCE SCHEMA OBJECT	for ganareting the auto_adders id numbers 
  __2)   pincode must be enterd "6" letters to the check CONSTRAINT condistion 
   __3)   adders_id has maintained primary key 				

TABLE:--2
--  items table is used to store all the items available details in themarket
 
create table item_table(
            i_id number(4)primary key, 
            i_name varchar2(20),
            i_price number(10),
            i_discount number (10,2)
            );
			
__1)in above table i_id is used SEQUENCE SCHEMA OBJECT	for ganareting the auto_item_id numbers				
__2)i_id is also maintained primary key condition 

TABLE:--3

create table order_stutus_table(
               stastu_id number(3)primary key,
               status_type varchar2(8)
               );

/*order stauts table is used to maintain the status of the order
there are four statuses:
  1-->	orderEd   
  2-->  conform
  3-->  notplace
  4--> canceL*/

-- DEPENDENTS TABLES

 TABLE:--4
------USER TABLE FOR MATINE THE  registerd user details
---- USER_TABLE IS mantain the relation of user_addres_table 

create table user_table (
                    u_no number(6),
                    u_name varchar2(20) not null,
                    u_mobile number(10) check(length(u_mobile)=10), 
                   u_password  varchar2(30),
                    u_adders_id number(4),
					U_HNO NUMBER(3),
                    constraint user_if_pk primary key(u_no),
                    FOREIGN key(u_adders_id)  REFERENCES user_addres_table(addres_id)
                   );
				   
	__1)HEAR USER_ADDERS_ID IS FK of the user_adders_table 
	__2)u_no is maintain primary key CONSTRAINTS
	__3)u_mobile must  be entered "10" digits to the check constraint because every  person have 10 digites mobile number
	
	
	TABLE:--5
	
---booking order table is  use  to matein  the user booking item details
-- in the below table order_id maintained primary key because every order has uniq id & it's not maintened not null
__1)b_u_no is foreign  key to u_no in the user_table 
__2)b_i_id is foreign key to i_id in the item_table
__3)stastus_id is foreign key to stastus_id in the order_stutus_table


create table booking_order_table (
                order_id number(4) PRIMARY key,
                b_u_no number(6),
                b_u_name varchar2(20),
                b_i_id number(4),
                b_i_name varchar2(20),
                b_i_amount number(10),
                b_i_disc_persentage number(10),
                stastu_id number(3),
                CONSTRAINT fk_bot_ut FOREIGN key(b_u_no)  REFERENCES user_table(u_no),
               CONSTRAINT fk_bot_it  FOREIGN key(b_i_id)  REFERENCES item_table(i_id),
			    constraint fk_bot_stastus foreign key(stastu_id) references order_stutus_table(stastu_id)
                   );
				   
				

TABLE:--6
--->this TABLE is for the history table of the booking_order_table
--->is used for to maintaining the history
create table booking_order_table_history (
                order_id number(4),
                b_u_no number(6),
                b_u_name varchar2(20),
                b_i_id number(4),
                b_i_name varchar2(20),  
                b_i_amount number(10),
                b_i_disc_persentage number(10),
                stastu_id number(3),
                orderd_type varchar2(20),
                orderd_by varchar2(20),
                orderd_place_date timestamp  
                );
--->next step was to create trigger BETWEEN booking_order_table & booking_order_table_history-------> TRIGGER NAME:--"booking_trigger"
--->this trigger permistions are INSERT&DELETE ONLY

----> affter trigger creation to use PROCEDURE to insert the values in booking_order_table-------> PROCEDURE NAME:--"booking_p1"

-----> this trigger is used for to store booking_order_table_history data

----=============  TASKS ============
NO:-1 we have to insert user_no & item_id & stastu_id in procedure to store all columns data atomatically to  booking_order_table
       
NO:-2 we have to  insert stastu_id in function it's   ' return status_type 

NO:-3 this two sub_programs are stored packags and to called package name 
---------
create package that package name is :-- booking_package

before create package we have to check the procedure & function creation 

 --1st procedure name :-  parameters booking_pro1
          this procedure is for inserting the data 
		
		inserting parameters are these:- three
                    
                 ( pro1_user_no in number,
                  pro1_item_id in number,
                  pro1_stastus_id in number
                  );   
				  these are the three parameters
		                   to insert the each row of  booking_order_table	

--2nd procedure name :- booking_procedure_cancle
					this procedure is for delete the  DATA
					
					deleting parameters are these:-two
					
					( order_no in number, user_no in number); these are  the two parameters  to delete the row of booking_order_table

 function name is:- booking_function
					
					this function to is used to see the stastus_type 
					we enterd stastus_id it returns stastus_type
    we insert one parameter in this function         
             ( ord_state in varchar2) 
            return  varchar2;
       
	   
	   affter SUCCESSFULLY exicution of these sub_programs 
	   
	   we have to create package specification 
	   
	   ----> in this package specification we can decleare allready exction procedure& function 
	   
	   ----> after that we have to create package body creation 
	             
				 in this package body we have to write bussiness logic of the program 
				 
				 finally end the package 
				 
affter SUCCESSFUL exicution of package :-
        we can insert values using begin& end coomand
	---insert	
		 BEGIN
		 package_name.procedure_name(parameters);
		 end;

	--cancel 
	exec package_name.procedure_name(parameters);
	
	---calling function  to select statement 
	
	    select package_name.function_name (parameter) from dual;
		
		
													     --------- END ----------> TDD
	








======================================================================================================================================================================================
=============================================================================================================================================================================================
--perent table
create table user_addres_table  (
                    addres_id number(5),
                    villege varchar2(20),
                    mandalam varchar2(20),
                    distric varchar2(20),
                    states varchar2(20),
                    pincode number(9) check(length(pincode)=6),
                    CONSTRAINT user_addres_pk primary key(addres_id)
                    );
				--	drop table user_addres_table;
                    desc user_addres_table;
                                   
 --sequence create                   
   create sequence a
         minvalue 1
        maxvalue 99
        start with 1
      increment  by 1
         cycle;
		-- drop sequence a;
		 --insert values        
  insert into user_addres_table values (a.nextval,'yarajarala','ongole','prakasam','andrapradesh',523272);
  insert into user_addres_table values (a.nextval,'sdpalem','ongole','prakasam','andrapradesh',523252);
  insert into user_addres_table values (a.nextval,'vengampalem','ongole','prakasam','andrapradesh',523282);
  insert into user_addres_table values (a.nextval,'kanduluru','tanguturu','prakasam','andrapradesh',523292);
  insert into user_addres_table values (a.nextval,'marlapadu','tanguturu','prakasam','andrapradesh',523262);
 
   select*from user_addres_table;
   
   
   --chiled table  
 create table user_table (
                    u_no number(6),
                    u_name varchar2(20) not null,
                    u_mobile number(10)  CHECK(length(u_mobile)=10), 
                   u_password  varchar2(30),
                    u_adders_id number(4),
                    u_hno number(3),
                    constraint user_if_pk primary key(u_no),
                    FOREIGN key(u_adders_id)  REFERENCES user_addres_table(addres_id)
                   );
                   desc user_table;
                   
                   
                 ---  drop table order_stutus_table;                  
      create sequence b
            minvalue 1
           maxvalue 99
          start with 1
        increment  by 1
             cycle;    -- drop sequence b;
			 
			 ---insert values
insert into user_table values(b.nextval,'ramu',7032714834,'ramu123',1,50);

insert into user_table values(b.nextval,'vinay',1236985478,'vinay123',2,60);
insert into user_table values(b.nextval,'ravi',2359874612,'ravi123',3,70);
insert into user_table values(b.nextval,'krish',1874596423,'krish123',4,80);
insert into user_table values(b.nextval,'venu',8745963214,'venu236',5,90);
insert into user_table values(b.nextval, 'mahesh',1478965236,'mahesh456',6,30);---enter chesukodu because of forenkey relation

  select*from user_table;
  
  create table item_table(
            i_id number(4)primary key, 
            i_name varchar2(20),
            i_price number(10),
            i_discount number (10,2)
            );
            
 -----sequence  
 create sequence c
            minvalue 1
           maxvalue 99
          start with 1
        increment  by 1
             cycle;  --drop sequence c;
 -----insert values
 insert into item_table values (c.nextval,'t_v',30000,10);
  insert into item_table values (c.nextval,'AC',50000,15);
 insert into item_table values (c.nextval,'laptop',80000,11);
 insert into item_table values (c.nextval,'mobile',30000,12);
 insert into item_table values (c.nextval,'bike',2000,9);
 insert into item_table values (c.nextval,'toy',1000,10.5);

  select*from item_table;
  
  
  --------------------------------
 
 create table order_stutus_table(
               stastu_id number(3)primary key,
               status_type varchar2(8)
               );
             --  DROP TABLE order_stutus_table;
----sequence
create sequence d
            minvalue 1
           maxvalue 99
          start with 1
        increment by 1
             cycle;
             
          -- DROP sequence d;
 ----insert values
 
 INSERT into order_stutus_table values(d.nextval,'ordered');
  INSERT into order_stutus_table values(d.nextval,'conform');
 INSERT into order_stutus_table values(d.nextval,'notplace');
  INSERT into order_stutus_table values(d.nextval,'canceL');
  
  
  
 create table booking_order_table (
                order_id number(4) PRIMARY key,
                b_u_no number(6),
                b_u_name varchar2(20),
                b_i_id number(4),
                b_i_name VARCHAR2(20), 
                b_i_amount number(10),
                b_i_disc_persentage number(10),
                stastu_id number(3),  
                CONSTRAINT fk_bot_ut FOREIGN key(b_u_no)  REFERENCES user_table(u_no),
               CONSTRAINT fk_bot_it  FOREIGN key(b_i_id)  REFERENCES item_table(i_id),
               constraint   fk_bot_stastus foreign key(stastu_id) references order_stutus_table(stastu_id)
                   ); 
				   
				   create sequence f
            minvalue 1
           maxvalue 99
          start with 1
        increment  by 1
             cycle;   -- drop sequence f;
                                  
                   select*from booking_order_table;
				   
        -- TABLE:-6 trigger
 create table booking_order_table_history (
                order_id number(4),
                b_u_no number(6),
                b_u_name varchar2(20),
                b_i_id number(4),
                b_i_name varchar2(20), 
                b_i_amount number(10),
                b_i_disc_persentage number(10),
                stastu_id number(3),
                orderd_type varchar2(20),
                orderd_by varchar2(20),
                orderd_place_date timestamp   
                );
                
                select*from     booking_order_table_history;           
                desc booking_order_table_history;
				
				
				 --trigger creation
  ---create trigger
  CREATE OR REPLACE TRIGGER booking_trigger
 AFTER 
 INSERT or DELETE ----oparations yem yem cheyali anedi ekkad command cheyali
 ON booking_order_table
 FOR EACH ROW
 DECLARE
 ORDER_TRANSACTION VARCHAR2(40);
 BEGIN
 ORDER_TRANSACTION:=CASE
 WHEN INSERTING THEN 'order_place'---insert chesthe order_place ani vasthundi
 WHEN DELETING  THEN 'order_cancel'---insert chesthe order_cancel ani vasthundi
 END;
 INSERT INTO booking_order_table_history (
               order_id,
               b_u_no,
               b_u_name,
               b_i_id,
               b_i_name,
               b_i_amount,
               b_i_disc_persentage,
               stastu_id,
               orderd_type,
               orderd_by,
               orderd_place_date )
               
               VALUES (
               :NEW.order_id,
               :NEW.b_u_no,
               :NEW.b_u_name,
               :NEW.b_i_id,
               :NEW.b_i_name,
               :NEW.b_i_amount,
               :NEW.b_i_disc_persentage,
               :NEW.stastu_id,
               ORDER_TRANSACTION,
               
               USER,
               SYSTIMESTAMP);
               
               END;
			   
			   
			   
			   
			   ---create procedure
             ---cereate procedure to insert booking_order_table records

 create or replace procedure booking_pro1 (
                  pro1_user_no in number, -->pro1_user_no anedi manam mana perameter ki echhina name 
                  pro1_item_id in number,    -----e mudu  anevi manam pampe parameters 
                  pro1_stastus_id in number
                  )
                  is 
                  begin
                  
    -----EDI ONLY INSERT COMMAND               
                  insert into booking_order_table values (f.nextval,
                  (select (u_no) from user_table where u_no = pro1_user_no),----dini ardam select(u_no aedi) from user_table nuodi thisukovali
                                                                          ----adi u_no = pro1_user_no ante u_no = manam pampinche perameter number ki eqall avithe adi print avvali 
                (select (u_name) from user_table where u_no = pro1_user_no),
                 (select (i_id) from item_table where i_id = pro1_item_id),
                 (select (i_name) from item_table where i_id = pro1_item_id),
                  (select (i_price) from item_table where i_id = pro1_item_id),
                 (select (i_discount) from item_table where i_id = pro1_item_id),
                 pro1_stastus_id
                    );
                 commit;
                 end booking_pro1;
                 
 ----EDI DELITING COMMAND 
 ---cereate procedure to delete booking_order_table records
 create or replace procedure  booking_procedure_cancle ( order_no in number, user_no in number)
 is 
 begin 
 delete from booking_order_table where order_id = order_no and b_u_no = user_no;
 commit;
 end;
 
 ---insert delete command
       begin 
           booking_procedure_cancle(1,1); -----eila delete chesthunte booking_order_table_history table lo
           end;                           ---(order_id,b_u_no,b_u_name,b_i_id,b_i_name,b_i_amount,b_disc_persentage
                                      --- stastu_id) e columns names anevi "NULL" tho fill avuthunnaei
                                                
          
          select*from booking_order_table;
                 
                 
 ---create function
   create or replace function booking_function (
         ord_state in varchar2) ---
         -----manaki return lo stastu_type ravi adi string kanuka varchar2 echham 
       return varchar2           ---manaki  return lo yedi kavali  anukuntamo daniki sambandinchina data_type ni evvali
             is
       ord_number  varchar2(30) :=0; ----return avvina danni store chesukovali kanuka oka veriyable ni thisukunnm
         begin                              --variyable name yedi anna echhukovachhu
          select status_type into ord_number from order_stutus_table
         where  ord_state=stastu_id;
         return ord_number;
        end booking_function;
                                                                            
-----package   e package lo eppativarku create chesina procedure ni oka order lo pettukovadaniki
     create or replace package booking_package 
     as
     procedure booking_pro1 (
                  pro1_user_no in number,
                  pro1_item_id in number,
                  pro1_stastus_id in number
                  );
             
      procedure  booking_procedure_cancle ( order_no in number, user_no in number);
    
                  
         function booking_function (
         ord_state in varchar2) 
       return  varchar2;
       end booking_package;
 
 
 create or replace package body booking_package
    as 
    --insert procedure
     procedure booking_pro1 (
                  pro1_user_no in number,
                  pro1_item_id in number,
                  pro1_stastus_id in number
                  )
                  is 
                  begin
                  insert into booking_order_table values (f.nextval,
                  (select (u_no) from user_table where u_no = pro1_user_no),
                (select (u_name) from user_table where u_no = pro1_user_no),
                 (select (i_id) from item_table where i_id = pro1_item_id),
                 (select (i_name) from item_table where i_id = pro1_item_id),
                  (select (i_price) from item_table where i_id = pro1_item_id),
                 (select (i_discount) from item_table where i_id = pro1_item_id),
                 pro1_stastus_id
                    );
                 commit;
                 end booking_pro1;
                 
          --cancle procedure       
               procedure  booking_procedure_cancle ( order_no in number, user_no in number)
                        is 
                        begin 
               delete from booking_order_table where order_id = order_no and b_u_no = user_no;
                        commit;
                         end;             
                 
                 function booking_function (
         ord_state in varchar2) 
       return varchar2
             is
       ord_number  varchar2(30) :=0; 
         begin 
          select status_type into ord_number from order_stutus_table
         where  ord_state=stastu_id;
         return ord_number;
        end booking_function;
        
        end;
     
  --inseerting 
  begin                  
booking_package.booking_pro1(3,5,1);
dbms_output.put_line('data_insert');
end;

---cancle
exec booking_package.booking_procedure_cancle(21,3);---package lo petti call chesina history_table lo NULL values ni eisthundi

--calling function
select booking_package.booking_function(1) from dual;

 
 
 
 select*from booking_order_table; 
 select*from item_table;
 select*from booking_order_table_history;
 select*from user_addres_table;
  select*from user_table;
  select*from order_stutus_table;

 ---------------------
    -- diniki sencond model  next file lo vundi.......
     
     
 