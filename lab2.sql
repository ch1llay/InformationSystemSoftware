3.	create table "Color"
(
    "Id"         serial
        constraint "Color_pkey"
            primary key
        constraint "Color_Id_check"
            check (("Id" >= 1) AND ("Id" <= 999)),
    "ColorTitle" varchar(255) not null
        constraint "Color_ColorTitle_check"
            check (("ColorTitle")::text ~ '^[a-zA-Zа-яА-Я]+$'::text)
);

alter table "Color"
    owner to postgres;

create table "Model"
(
    "Id"           serial
        constraint "Model_pkey"
            primary key
        constraint "Model_Id_check"
            check (("Id" >= 1) AND ("Id" <= 999)),
    "ModelTitle"   varchar(30) not null
        constraint "Model_ModelTitle_check"
            check (("ModelTitle")::text ~ '^[a-zA-Z0-9\-]+$'::text),
    "EngineVolume" real
        constraint "Model_EngineVolume_check"
            check (("EngineVolume" >= (0.0)::double precision) AND ("EngineVolume" <= (30.0)::double precision)),
    "MaxSpeed"     integer
        constraint "Model_MaxSpeed_check"
            check (("MaxSpeed" >= 30) AND ("MaxSpeed" <= 400)),
    "DoorCount"    integer
        constraint "Model_DoorCount_check"
            check (("DoorCount" >= 1) AND ("DoorCount" <= 8)),
    "PlaceCount"   integer
        constraint "Model_PlaceCount_check"
            check (("PlaceCount" >= 1) AND ("PlaceCount" <= 8))
);

alter table "Model"
    owner to postgres;

create table "Car"
(
    "Id"               serial
        constraint "Car_pkey"
            primary key
        constraint "Car_Id_check"
            check (("Id" >= 1) AND ("Id" <= 999)),
    "ModelId"          serial
        constraint "Car_ModelId_fkey"
            references "Model"
        constraint "Car_ModelId_check"
            check (("ModelId" >= 1) AND ("ModelId" <= 999)),
    "TransmissionCode" varchar(30) not null
        constraint "Car_TransmissionCode_check"
            check (("TransmissionCode")::text ~ '^[a-zA-Z0-9\-]+$'::text),
    "RegNumber"        varchar(30) not null
        constraint "Car_RegNumber_check"
            check (("RegNumber")::text ~ '^[a-zA-Zа-яА-Я0-9]+$'::text),
    "BodyCode"         varchar(30) not null
        constraint "Car_BodyCode_check"
            check (("BodyCode")::text ~ '^[a-zA-Z0-9\-]+$'::text),
    "EngineCode"       varchar(30) not null
        constraint "Car_EngineCode_check"
            check (("EngineCode")::text ~ '^[a-zA-Z0-9\-]+$'::text),
    "ReleaseDate"      date        not null
        constraint "Car_ReleaseDate_check"
            check (("ReleaseDate" >= '1980-01-01'::date) AND ("ReleaseDate" <= CURRENT_DATE)),
    "ColorId"          integer     not null
        constraint "Car_ColorId_fkey"
            references "Color"
        constraint "Car_ColorId_check"
            check (("ColorId" >= 1) AND ("ColorId" <= 999))
);

alter table "Car"
    owner to postgres;

create table "Customer"
(
    "Id"            serial
        constraint "Customer_pkey"
            primary key
        constraint "Customer_Id_check"
            check (("Id" >= 1) AND ("Id" <= 999)),
    "LastName"      varchar(30) not null
        constraint "Customer_LastName_check"
            check (("LastName")::text ~ '^[a-zA-Zа-яА-Я]+$'::text),
    "Name"          varchar(30) not null
        constraint "Customer_Name_check"
            check (("Name")::text ~ '^[a-zA-Zа-яА-Я]+$'::text),
    "Patronymic"    varchar(30) not null
        constraint "Customer_Patronymic_check"
            check (("Patronymic")::text ~ '^[a-zA-Zа-яА-Я]+$'::text),
    "CustomerTitle" varchar(30) not null
        constraint "Customer_CustomerTitle_check"
            check (("CustomerTitle")::text ~ '^[a-zA-Zа-яА-Я\s]*$'::text),
    "PassportData"  varchar(10) not null
        constraint "Customer_PassportData_check"
            check (("PassportData")::text ~ '^[0-9]{10}$'::text),
    "Phone"         varchar(30) not null
        constraint "Customer_Phone_check"
            check (("Phone")::text ~ '^\+[0-9]{11}$'::text)
);

alter table "Customer"
    owner to postgres;

create table "Employees"
(
    "Id"         serial
        constraint "Employees_pkey"
            primary key
        constraint "Employees_Id_check"
            check (("Id" >= 1) AND ("Id" <= 999)),
    "LastName"   varchar(30) not null
        constraint "Employees_LastName_check"
            check (("LastName")::text ~ '^[a-zA-Zа-яА-Я]+$'::text),
    "Name"       varchar(30) not null
        constraint "Employees_Name_check"
            check (("Name")::text ~ '^[a-zA-Zа-яА-Я]+$'::text),
    "Patronymic" varchar(30) not null
        constraint "Employees_Patronymic_check"
            check (("Patronymic")::text ~ '^[a-zA-Zа-яА-Я]+$'::text),
    "Birthday"   date        not null
        constraint "Employees_Birthday_check"
            check (("Birthday" >= '1980-01-01'::date) AND ("Birthday" <= CURRENT_DATE)),
    "Phone"      varchar(30) not null
        constraint "Employees_Phone_check"
            check (("Phone")::text ~ '^\+[0-9]{11}$'::text)
);

alter table "Employees"
    owner to postgres;

create table "AdditionalServices"
(
    "Id"          serial
        constraint "AdditionalServices_pkey"
            primary key
        constraint "AdditionalServices_Id_check"
            check (("Id" >= 1) AND ("Id" <= 999)),
    "Title"       varchar(30) not null
        constraint "AdditionalServices_Title_check"
            check (("Title")::text ~ '^[a-zA-Zа-яА-Я\s]+$'::text),
    "PricePerDay" integer     not null
        constraint "AdditionalServices_PricePerDay_check"
            check (("PricePerDay" >= 1) AND ("PricePerDay" <= 999))
);

alter table "AdditionalServices"
    owner to postgres;

create table "Contract"
(
    "Id"         serial
        constraint "Contract_pkey"
            primary key
        constraint "Contract_Id_check"
            check (("Id" >= 1) AND ("Id" <= 999)),
    "CustomerId" integer not null
        constraint "Contract_CustomerId_fkey"
            references "Customer"
        constraint "Contract_CustomerId_check"
            check (("CustomerId" >= 1) AND ("CustomerId" <= 999)),
    "EmployeeId" integer not null
        constraint "Contract_EmployeeId_fkey"
            references "Employees"
        constraint "Contract_EmployeeId_check"
            check (("EmployeeId" >= 1) AND ("EmployeeId" <= 999)),
    "CarId"      integer not null
        constraint "Contract_CarId_fkey"
            references "Car"
        constraint "Contract_CarId_check"
            check (("CarId" >= 1) AND ("CarId" <= 999)),
    "BeginDate"  date    not null
        constraint "Contract_BeginDate_check"
            check (("BeginDate" >= '1980-01-01'::date) AND ("BeginDate" <= CURRENT_DATE)),
    "DayCount"   integer not null
        constraint "Contract_DayCount_check"
            check (("DayCount" >= 1) AND ("DayCount" <= 999)),
    "ServiceId"  integer not null
        constraint "Contract_ServiceId_fkey"
            references "AdditionalServices"
        constraint "Contract_ServiceId_check"
            check (("ServiceId" >= 1) AND ("ServiceId" <= 999)),
    "Cost"       integer not null
        constraint "Contract_Cost_check"
            check (("Cost" >= 1) AND ("Cost" <= 999999))
);

alter table "Contract"
    owner to postgres;
