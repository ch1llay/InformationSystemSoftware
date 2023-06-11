--Создаем изменяемое представление
create view NeedEmployeeAge as
    select "LastName", "Name", "Patronymic", "Birthday", "Phone"
from "Employees"
where "Birthday" between '01.01.1988' and '01.01.2000';

select *
from NeedEmployeeAge;


-- update NeedEmployeeAge
-- set "Name" = 'Петр'
-- where "Name" = 'Сергей';

-- select *
-- from NeedEmployeeAge
 
 

--Создаем неизменяемое представление
create view MostExpensiveService as
select  A."PricePerDay", A."Title"
from "Contract" C
         join "AdditionalServices" A on C."ServiceId" = A."Id"
order by A."PricePerDay" desc
                         limit 1;

select * from MostExpensiveService;

-- update MostExpensiveService
-- set "Title" = 'Измененная услуга'
 
--Создаем агрегирующее представление
create view CountCarModel as
SELECT m."ModelTitle",
       count(c."Id") AS "CarCount"
FROM "Car" c
         JOIN "Model" m ON m."Id" = c."ModelId"
GROUP BY m."Id";

select * from CountCarModel

 

--Создаем представление, основанное на нескольких таблицах
create view AllRentCarNow as
select C.*, C2."BeginDate", C2."DayCount"
from "Car" C
join "Contract" C2 on C."Id" = C2."CarId"
where C2."BeginDate" + "DayCount" > Now();

select * from AllRentCarNow

