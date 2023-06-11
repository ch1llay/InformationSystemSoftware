--Создание таблицы для логов

create table contract_logs
(
    "BeginDate"     date,
    "Id"            serial
        constraint contract_logs_pk
            primary key,
    "ContractId"    integer,
    "ServiceName"   varchar(50),
    "CustomerFIO"   varchar(255),
    "Cost"          integer,
    "EmployeeFIO"   varchar(255),
    "DayCount"      integer,
    "OperationType" varchar(30)
);

alter table contract_logs
    owner to postgres;

create unique index contract_logs_id_uindex
    on contract_logs ("Id");


--Создание  тригера на добавление
create or replace function add_contract_logs_inserted() returns trigger as
$$
begin
    insert into contract_logs("BeginDate", "ServiceName", "EmployeeFIO", "CustomerFIO", "DayCount","Cost", "ContractId",
                              "OperationType")
    select New."BeginDate",
           "AS"."Title",
           concat("Employees"."LastName", ' ', "Employees"."Name", ' ', "Employees"."Patronymic"),
           concat("Customer"."LastName", ' ', "Customer"."Name", ' ', "Customer"."Patronymic"),
           "DayCount",
           "Cost",
           New."Id",
           'inserted'
    from "Contract" C
             join "AdditionalServices" "AS" on "AS"."Id" = C."ServiceId"
             join "Employees" on C."EmployeeId" = "Employees"."Id"
             join "Customer" on C."CustomerId" = "Customer"."Id"
             join "Car" C2 on C2."Id" = C."CarId"
             join "Model" M on C2."ModelId" = M."Id"
    where C."Id" = New."Id";
    return New;
end
$$
    language plpgsql;

CREATE TRIGGER contract_logs_insert
    AFTER INSERT
    ON "Contract"
    REFERENCING NEW TABLE AS inserted
    FOR EACH ROW
EXECUTE FUNCTION add_contract_logs_inserted();
 
 

--Создание  тригера на обновление


create or replace function add_contract_logs_updated() returns trigger as
$$
begin
    insert into contract_logs("BeginDate", "ServiceName", "EmployeeFIO", "CustomerFIO", "DayCount", "Cost", "ContractId",
                              "OperationType")
    select New."BeginDate",
           "AS"."Title",
           concat("Employees"."LastName", ' ', "Employees"."Name", ' ', "Employees"."Patronymic"),
           concat("Customer"."LastName", ' ', "Customer"."Name", ' ', "Customer"."Patronymic"),
           "DayCount",
           "Cost",
           New."Id",
           'updated'
    from "Contract" C
             join "AdditionalServices" "AS" on "AS"."Id" = C."ServiceId"
             join "Employees" on C."EmployeeId" = "Employees"."Id"
             join "Customer" on C."CustomerId" = "Customer"."Id"
             join "Car" C2 on C2."Id" = C."CarId"
             join "Model" M on C2."ModelId" = M."Id"
    where C."Id" = New."Id";
    return New;
end
$$
    language plpgsql;

CREATE TRIGGER contract_logs_update
    AFTER Update
    ON "Contract"
    REFERENCING NEW TABLE AS updated
    FOR EACH ROW
EXECUTE FUNCTION add_contract_logs_updated();
 
 
--Создание  тригера на удаление

create or replace function add_contract_logs_deleted() returns trigger as
$$
declare
    employee_fio          varchar(255);
    declare customer_fio  varchar(255);
    declare service_title varchar(255);

begin

    select concat("Employees"."LastName", ' ', "Employees"."Name", ' ', "Employees"."Patronymic")
    into employee_fio
    from "Employees"
    where "Id" = Old."EmployeeId";
    select concat("Customer"."LastName", ' ', "Customer"."Name", ' ', "Customer"."Patronymic")
    into customer_fio
    from "Customer"
    where "Id" = Old."CustomerId";
    select "AdditionalServices"."Title" into service_title from "AdditionalServices" where "Id" = Old."ServiceId";
    insert into contract_logs("BeginDate", "ServiceName", "EmployeeFIO", "CustomerFIO", "DayCount", "Cost", "ContractId",
                              "OperationType")
    values (Old."BeginDate", service_title, employee_fio, customer_fio, Old."DayCount", Old."Cost", Old."Id", 'deleted');
    return Old;
end
$$
    language plpgsql;
CREATE TRIGGER contract_logs_delete
    AFTER DELETE
    ON "Contract"
    REFERENCING Old TABLE AS deleted
    FOR EACH ROW
EXECUTE FUNCTION add_contract_logs_deleted();
