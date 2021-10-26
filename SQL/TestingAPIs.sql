use [Codex-Cluster]
	select * from CodexAuditLogs_Books

select * from Books
select * from Books where BookID = 'book18828'

delete from Books where BookID = 'book18828'

truncate table CodexAuditLogs_Books

update Books set Author='name', Title='title', CatID='catid', ISBN='12312312', Image='http://www.google.com/images/some-image', Rating='3.2', Format='paperback', Price='50', OldPrice='90', Description='{9}', Position='18828' ,Status='NoStock', Year='2012-12-12' where BookID='book18828';

select count(*) from Users;

select * from Users;

update Users set Wishlist = 'book00524:2+book00264:1+book01222:1'
update Users set Cart = 'book01334:2+book01111:3+book11222:4'


select Cart, Wishlist from Users where UserID='user_00008'

select * from Books