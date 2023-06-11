--Создание процедуры операции добавления:
CREATE or replace PROCEDURE add_color(title varchar(255))
LANGUAGE SQL
AS $$
insert into "Color" ("Id", "ColorTitle") VALUES (default, title)
$$;

select "ColorTitle"
from "Color";

call add_color('Аквамариновый');

select "ColorTitle"
from "Color";

 
--Создание процедуры операции удаления:

CREATE PROCEDURE delete_color(id int)
LANGUAGE SQL
AS $$
delete from "Color" where "Id" = id
$$;

select "ColorTitle"
from "Color";

call delete_color(10);

select "ColorTitle"
from "Color";

 
--Создание процедуры операции обновления:

CREATE PROCEDURE update_color(id int, new_title varchar(255))
LANGUAGE SQL
AS $$
update "Color"
set "ColorTitle" = new_title
where "Id" = id
$$;

select "ColorTitle"
from "Color"
where "Id" = 3;

call update_color(3, 'Цвет');

select "ColorTitle"
from "Color"
where "Id" = 3;

 
--Создание процедуры операции вычисления:

CREATE or replace PROCEDURE add_amount(INOUT result refcursor)
LANGUAGE 'plpgsql'
as $BODY$
    begin
    open result for select "DoorCount" + 1 as "Increment_DoorCount"
from "Model" limit 1;
        end;
$BODY$;

BEGIN;
select "DoorCount"
from "Model" limit 1;
CALL add_amount('test');
fetch all in "test";
COMMIT;
