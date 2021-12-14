create procedure cambio_tel @id int, @num nvarchar(25) as
begin 
	SET XACT_ABORT ON
	begin distributed transaction
	begin try 
	update [LINKSERVER3].AdventurePerson.Person.PersonPhone set PhoneNumber = @num where BusinessEntityID = @id;
	select * from [LINKSERVER3].AdventurePerson.Person.PersonPhone
	commit transaction
	end try
	begin catch
	rollback transaction
	print 'ha ocurrido un error'
	end catch
end 

exec cambio_tel @id=20778, @num= '697-555-0143'
drop procedure cambio_tel


create procedure cambio_email @id int, @email nvarchar(50) as
begin 
	DECLARE @fecha datetime;
	set @fecha = CURRENT_TIMESTAMP;
	SET XACT_ABORT ON
	begin distributed transaction
	begin try 
	update [LINKSERVER3].AdventurePerson.Person.EmailAddress set EmailAddress = @email, ModifiedDate = CURRENT_TIMESTAMP
	where BusinessEntityID = @id;
	select * from [LINKSERVER3].AdventurePerson.Person.EmailAddress;
	commit transaction
	end try
	begin catch
	rollback transaction
	print 'ha ocurrido un error'
	end catch
end 

exec cambio_email @id= 1, @email= 'ken1230@adventure-works.com'  



create procedure cambio_stock @id int,  @locid int, @cantidad int as
begin 
	DECLARE @fecha datetime;
	set @fecha = CURRENT_TIMESTAMP;
	SET XACT_ABORT ON
	begin distributed transaction
	begin try 
	update Adventure.Production.ProductInventory set Quantity = @cantidad, ModifiedDate = CURRENT_TIMESTAMP
	where ProductID = @id and LocationID = @locid;
	select * from Adventure.Production.ProductInventory;
	commit transaction
	end try
	begin catch
	rollback transaction
	print 'ha ocurrido un error'
	end catch
end 

exec cambio_stock @id=1, @locid = 7, @cantidad=325;