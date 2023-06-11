--Реализуем функцию, возращающую скалярное значение
create or replace function GetCountEmployeesByName(name varchar(20)) returns numeric as
$$
    select Count(*) from "Employees" where "Name" = name group by "Name";
    $$ language sql;

select GetCountEmployeesByName('Алексей')

 
--Реализуем функцию, возращающую таблицу
create or replace function GetEmployeesByName(name varchar(20))
    returns TABLE
            (
                "LastName"   varchar(20),
                "Name"       varchar(20),
                "Patronymic" varchar(20)
            )
as
$$
select "LastName", "Name", "Patronymic" from "Employees" where "Name" = name
$$ language sql;

select * from GetEmployeesByName('Алексей')
