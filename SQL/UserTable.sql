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
@userID varchar(25)
as
begin 
	SELECT Cart FROM Users WHERE UserID like @userID
end

select * from Users

exec GetUserCart @userID = 'user_1'

-- PROCEDURE TO GET USER WISHLIST
create or alter procedure GetUserWishlist
@userID varchar(25)
as
begin 
	SELECT Wishlist FROM Users WHERE UserID like @userID
end

select * from Users

exec GetUserCart @userID = 'user_1'


-- PROCEDURE TO MODIFY ITEM(S) IN USER CART 
create or alter procedure ModifyUserCart
@item varchar(120), @userID varchar(25)
as
begin 
	update Users set Cart = @item where UserID = @userID
end

select * from Users

exec AddItemToUserCart @item = 'cabbage', @userID = 'user_1'

-- PROCEDURE TO MODIFY ITEM(S) IN USER WISHLIST
create or alter procedure ModifyUserWishlist
@item varchar(120), @userID varchar(25)
as
begin 
	update Users set Wishlist = @item where UserID = @userID
end

select * from Users

exec AddItemToUserCart @item = 'cabbage', @userID = 'user_1'
