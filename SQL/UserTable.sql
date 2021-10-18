use [Codex-Cluster]
create table [Users](
	UserID char(11) unique,
	[Name] varchar(52),
	Email varchar(60),
	[Password] varchar(25),
	Mobile varchar(13),
	Active varchar(6),
	Roles varchar(120),
	Cart varchar(120),
	Wishlist varchar(120),
	[Address] varchar(120)
)

alter table [Users] 
ADD CONSTRAINT Users_register_df_active
DEFAULT 'True' FOR Active;

alter table [Users] 
ADD CONSTRAINT Users_cart_df_active
DEFAULT '' FOR Cart;

alter table [Users] 
ADD CONSTRAINT Users_wishlist_df_active
DEFAULT '' FOR Wishlist;

alter table [Users] 
Add constraint Users_roles_df_active
default 'default' for Roles;

alter table [Users] 
alter column Password varchar(100);

alter table [Users]
add [Address] varchar(120);

-- PROCEDURE TO GET USER CART 
create or alter procedure GetUserCart
@userID char(10)
as
begin 
	SELECT Cart FROM Users WHERE UserID like @userID
end

select * from Users

exec GetUserCart @userID = 'user_1'

-- PROCEDURE TO GET USER WISHLIST
create or alter procedure GetUserWishlist
@userID char(10)
as
begin 
	SELECT Wishlist FROM Users WHERE UserID like @userID
end

select * from Users

exec GetUserCart @userID = 'user_1'


-- PROCEDURE TO MODIFY ITEM(S) IN USER CART 
create or alter procedure ModifyUserCart
@item varchar(120), @userID char(10)
as
begin 
	update Users set Cart = @item where UserID = @userID
end

select * from Users

exec AddItemToUserCart @item = 'cabbage', @userID = 'user_00002'

-- PROCEDURE TO MODIFY ITEM(S) IN USER WISHLIST
create or alter procedure ModifyUserWishlist
@item varchar(120), @userID char(10)
as
begin 
	update Users set Wishlist = @item where UserID = @userID
end

select * from Users

exec AddItemToUserCart @item = 'cabbage', @userID = 'user_00002'


-- Altering the UserID column

alter table [Users] drop constraint UQ__Users__1788CCADF71F023F

alter table [Users]
alter column UserID char(10) not null 

alter table [Users] add constraint PK_Users primary key (UserID)


-- Last userID
create or alter procedure LastUserID
as 
begin 
	declare @userID char(10)
	declare User_cursor_ID cursor scroll for select UserID from Users
	open User_cursor_ID
	fetch last from User_cursor_ID into @userID
	close User_cursor_ID
	deallocate User_cursor_ID
	if @userID is null or @userID = ''
	begin
		select CAST(SUBSTRING('user_00000',6,5) as int) as userID;
		return
	end
	else
	begin
		select CAST(SUBSTRING(@userID,6,5) as int) as userID
		return
	end
end

exec LastUserID

-- Address 
create or alter procedure ModifyAddress
@userID char(10),
@address varchar(120)
as
begin
	update Users set [address] = @address where UserID = @userID;
	if @@ERROR = 0
		begin 
			select 'Success' as Status
			return
		end
	else
		begin
			select 'Failure' as Status
			return
		end
end

select * from Users
exec ModifyAddress @userID = 'user_00001', @address = 'This is murica'

-- Modify user details 
create or alter procedure ModifyUserInfo
@userID char(10),
@name varchar(52),
@email varchar(60),
@mobile varchar(13),
@address varchar(120)
as
	begin
		update Users set [Name] = @name, Email = @email, Mobile = @mobile, [address] = @address where UserID = @userID;
	end

exec ModifyUserInfo @userID = 'user_00001', @name = 'alkatraz', @email = 'prophet.nano@crytek.net', @mobile = '1239129332', @address = 'New York'

select * from Users

