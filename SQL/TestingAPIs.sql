use [Codex-Cluster]
	select * from CodexAuditLogs_Books

select * from Books
select * from Books where BookID = 'book18828'

delete from Books where BookID = 'book18828'

truncate table CodexAuditLogs_Books

update Books set Author='name', Title='title', CatID='catid', ISBN='12312312', Image='http://www.google.com/images/some-image', Rating='3.2', Format='paperback', Price='50', OldPrice='90', Description='{9}', Position='18828' ,Status='NoStock', Year='2012-12-12' where BookID='book18828';

select count(*) from Users;