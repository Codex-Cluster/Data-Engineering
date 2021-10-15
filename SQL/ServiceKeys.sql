use [Codex-Cluster]

create table ServiceKeys (
	id int identity,
	[key] char(10) unique not null,
	creator varchar(50) 
)

insert into ServiceKeys values ('qwerty1234', 'Anandu R')

-- drop table ServiceKeys

create or alter procedure CheckIfServiceKeyExists
@key varchar(25)
as
begin 
	SELECT
      CASE WHEN EXISTS 
      (
            SELECT * FROM ServiceKeys WHERE [key] like @key
      )
      THEN 'true'
      ELSE 'false'
   END 
end

exec CheckIfServiceKeyExists @key = 'qwerty1234'
