use [Codex-Cluster]
create table CodexAuditLogs_Books (
	id int identity,
	[message] varchar(255) 
);
create table CodexAuditLogs_Category (
	id int identity,
	[message] varchar(255) 
);


create or alter trigger CodexTriggerAudit_Books
on Books 
after insert 
as 
	declare @bookID varchar(10);
	declare CodexAuditCursor cursor for select BookID from inserted
	open CodexAuditCursor 
	fetch next from CodexAuditCursor into @bookID
	while @@FETCH_STATUS = 0
	begin 
		declare @audit_message varchar(255) = 'New book with BookID: ' + CAST(@bookID as varchar(10)) + ' inserted into table successfully'
		insert into CodexAuditLogs_Books values (@audit_message);

		fetch next from CodexAuditCursor into @bookID
	end 
	close CodexAuditCursor
	deallocate CodexAuditCursor
	
create or alter trigger CodexTriggerAudit_Category
on Categories 
after insert 
as 
	declare @catID varchar(5);
	declare CodexAuditCursor cursor for select CatID from inserted
	open CodexAuditCursor 
	fetch next from CodexAuditCursor into @catID
	while @@FETCH_STATUS = 0
	begin 
		declare @audit_message varchar(255) = 'New book with CatID: ' + CAST(@catID as varchar(5)) + ' inserted into table successfully'
		insert into CodexAuditLogs_Books values (@audit_message);

		fetch next from CodexAuditCursor into @catID
	end 
	close CodexAuditCursor
	deallocate CodexAuditCursor