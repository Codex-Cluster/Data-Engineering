use [Codex-Cluster]

create table CouponCodes (
	id int identity,
	code char(16) unique not null,
	discount varchar(3),
	[status] varchar(10), 
	creator varchar(50),
)	

create or alter procedure AddCouponCode
@code char(16),
@status varchar(10),
@creator varchar(50),
@discount varchar(3)
as
begin
	if cast(@discount as int)>=0 and cast(@discount as int)<=100
	begin
		insert into CouponCodes(code, [status], creator, discount) values(@code, @status, @creator, @discount)
		if @@ERROR = 0 
		begin 
			select 'Success'
			return
		end
	end
	select 'Failure'
	return
end

exec AddCouponCode @code = '12345667890123123', @status = 'active', @creator = 'Anandu R', @discount = 12

select * from CouponCodes

-- Modify Coupon code


create or alter procedure ModifyCoupon
@code char(16),
@status varchar(10),
@creator varchar(50),
@discount varchar(3),
@id int
as
begin
	if cast(@discount as int)>=0 and cast(@discount as int)<=100
	begin
		update CouponCodes  set code = @code, [status] = @status, creator = @creator, discount = @discount where id = @id
		if @@ERROR = 0 
		begin 
			select 'Success'
			return
		end
	end
	select 'Failure'
	return
end

exec ModifyCoupon @code = '9334566782323123', @status = 'active', @creator = 'Anandu R', @discount = 20, @id = 1

select * from CouponCodes


-- Remove Coupon procedure


create or alter procedure RemoveCoupon
@id int
as
begin
	delete from CouponCodes where id = @id
	if @@ERROR = 0 
	begin 
		select 'Success'
		return
	end
	select 'Failure'
	return
end

exec RemoveCoupon @id = 1
select * from CouponCodes
-- truncate table CouponCodes


