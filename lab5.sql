--Найти модель автомобиля с самой высокой максимальной скоростью
select "ModelTitle", "EngineVolume", "MaxSpeed", "DoorCount", "PlaceCount"
from "Model" M1
where "MaxSpeed" = (select Max("MaxSpeed") from "Model" M2)

 

--Найти сотрудников, которые родились от 01.01.1995, 01.01.2000
select "LastName", "Name", "Patronymic", "Birthday", "Phone"
from "Employees"
where "Birthday" between '01.01.1993' and '01.01.2000'
 
--Найти самого зрелого сотрудника
select "LastName", "Name", "Patronymic", "Birthday", "Phone"
from "Employees" E1
where E1."Birthday" = (select Min("Birthday") from "Employees" E2)
 

--Вывести автомобиль с самой низкой максимальной скоростью
select  C2."ColorTitle", "TransmissionCode", "RegNumber", "BodyCode", "EngineCode", "ReleaseDate", M."ModelTitle"
from "Car" C
join "Model" M on C."ModelId" = M."Id"
join "Color" C2 on C."ColorId" = C2."Id"
where M."MaxSpeed" = (select Max(M1."MaxSpeed") from "Model" as M1)
 
--Вывести все автомобили, у которых цвет синий
select "TransmissionCode", "RegNumber", "BodyCode", "EngineCode", "ReleaseDate", "ColorId", Cl."ColorTitle"
from "Car" C
join "Color" Cl on C."ColorId" = Cl."Id"
join "Model" M on C."ModelId" = M."Id"
where Cl."ColorTitle" = 'Синий'
 
--Вывести всех клиентов, имя которых начинается на Ив
select "LastName", "Name", "Patronymic", "Birthday", "Phone"
from "Employees"
where "Name" like '%Ив%'
 
--Вывести количество автомобиля каждой модели
select M1."ModelTitle", Count(C1."Id") as "Count"
from "Car" C1
         join "Model" M1 on M1."Id" = C1."ModelId"
group by M1."Id", M1."ModelTitle"
 
--Вывести все автомобили, которые сейчас арендуются
select C."TransmissionCode", "RegNumber", "BodyCode", "EngineCode", "ReleaseDate", M."ModelTitle", C2."BeginDate", C2."DayCount"
from "Car" C
join "Contract" C2 on C."Id" = C2."CarId"
join "Model" M on C."ModelId" = M."Id"
join "Color" C3 on C."ColorId" = C3."Id"
where C2."BeginDate" + "DayCount" > Now()
 
--Вывести всех клиентов, у которых прошел договор аренды
select C."Name", C."LastName", C."Patronymic", C."PassportData", C."CustomerTitle", C2."BeginDate", C2."DayCount"
from "Customer" C
join "Contract" C2 on C."Id" = C2."CarId"
where C2."BeginDate" + "DayCount" < Now()
 

--Вывести договор с самой высокой ценой за дополнительную услугу
select C."BeginDate", C."DayCount", A."PricePerDay", A."Title"
from "Contract" C
         join "AdditionalServices" A on C."ServiceId" = A."Id"
order by A."PricePerDay" desc
                         limit 1

