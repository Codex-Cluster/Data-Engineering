use [Codex-Cluster]
create or alter trigger CodexPositionInsertTrigger
on Books 
after update 
as 
	declare @pos bigint
	declare @bookID varchar(10)
	declare InsertedRecord cursor for select Position, BookID from inserted
	open InsertedRecord 
	fetch first from InsertedRecord into @pos, @bookID
	if(@pos < (select count(*) from Books))
	begin
		update Books set Position = (Position + 1) where Position >= @pos and BookID != @bookID
	end
	close InsertedRecord
	deallocate InsertedRecord