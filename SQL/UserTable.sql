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
