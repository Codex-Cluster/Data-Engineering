use [Codex-Cluster]

create table Promoted (
	[id] int identity,
	bookID char(10),
	expiresOn date,
)

insert into Promoted values ('book00008', '2021-11-12')

update Promoted set BookID = 'book00009', expiresOn='2012-12-12' where id = 1

delete Promoted where id = 1

truncate table Promoted

select * from Promoted