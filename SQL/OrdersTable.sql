use [Codex-Cluster]

create table Orders (
	orderID int identity,
	userID char(10),
	books varchar(120),
	[datetime] date,
)

alter table Orders add couponUsed varchar(16)
alter table Orders add AmountPaid float
alter table Orders add [Address] varchar(120)

select * from Orders

create or alter trigger OrdersAddDate
on Orders 
instead of insert
as
	declare @userID char(10)
	declare @books varchar(120)
	declare @coupon varchar(16)
	declare @amt float
	declare @address varchar(120)
	declare @datetime date
	select	@userID = userID, @books = books, @coupon = couponUsed, @amt = AmountPaid, @address = [Address] from inserted
	select @datetime = GETDATE();
	insert into Orders(userID, books, [datetime], couponUsed, AmountPaid, [Address]) values (@userID, @books, @datetime, @coupon, @amt, @address);

create or alter procedure MakeOrder
@userID char(10),
@books varchar(120),
@coupon varchar(16),
@amt float,
@address varchar(120)
as
begin
	insert into Orders(userID, books, couponUsed, AmountPaid, [Address]) values (@userID, @books, @coupon, @amt, @address)
end

exec MakeOrder @userID = 'user_00008', @books = 'book00204:1+book00186:2', @coupon = 'AXTJWWDJCOWNQPWM', @amt = 12.97, @address = 'Shipping address'

select * from Orders
-- truncate table Orders

create or alter procedure OrderedBooks
@userID char(10)
as 
begin 
	select books, [datetime], AmountPaid, [Address] from Orders where userID = @userID
	return
end

exec OrderedBooks @userId = 'user_00012'

select * from Orders where userID = 'user_00012'


-- Cancelling orders

create or alter procedure CancelOrder
@orderID int,
@userID char(10)
as
begin
	delete from Orders where orderID=@orderID and userID = @userID
end

exec CancelOrder @orderID = 3, @userID = 'user_00012'
select * from Orders where userID = 'user_00012'
