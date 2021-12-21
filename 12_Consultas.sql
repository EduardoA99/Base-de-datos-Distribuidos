--1.- Listar el nombre, numero, precio de lista y veces vendidas de los productos, con un precio meno o igual
--a lo requerido
create procedure consulta_1 @precio varchar(10) as
begin
declare @sql nvarchar(1000);

set @sql='select pp.ProductID, pp.Name,pp.ProductNumber, pp.ListPrice,
			count(ss.ProductID) as veces_vendido
			from Adventure.Production.Product pp
			inner join [DESKTOP-I4B3KNS\MSSQLSERVER1].AdventureSales.Sales.SalesOrderDetail ss
			on pp.ProductID = ss.ProductID
			where pp.ListPrice <='+@precio+'
			group by ss.ProductID, pp.Name, pp.ProductID,pp.ProductNumber, pp.ListPrice';
exec (@sql);
end

exec consulta_1 @precio=100


--2.- Determinar el número de ventas en un territorio especifico
create procedure consulta_2 @territorio varchar(10) as
begin
	declare @sql nvarchar(1000);
set @sql= 'select st.Name, sum(so.OrderQty * so.UnitPrice) as total_vendido
			from [DESKTOP-I4B3KNS\MSSQLSERVER1].AdventureSales.Sales.SalesOrderHeader sh
			inner join [DESKTOP-I4B3KNS\MSSQLSERVER1].AdventureSales.Sales.SalesOrderDetail so
			on sh.SalesOrderID = so.SalesOrderID
			inner join [DESKTOP-I4B3KNS\MSSQLSERVER1].AdventureSales.Sales.SalesTerritory st
			on st.TerritoryID = sh.TerritoryID where st.TerritoryID ='+@territorio+'
			group by st.TerritoryID, st.Name';
exec (@sql);
end

  exec consulta_2 @territorio = '1'
  exec consulta_2 @territorio = '2'
  exec consulta_2 @territorio = '3'
  exec consulta_2 @territorio = '4'
  exec consulta_2 @territorio = '5'
  exec consulta_2 @territorio = '6'
  exec consulta_2 @territorio = '7'

  
--3.- Listar la cantidad de veces vendido de los productos con un precio mayor o igual a lo solicitado 
  
create procedure consulta_3 @precio varchar(10) as
begin	
	declare @sql nvarchar(1000);
	declare @id int;
		  set @sql = 'select pp.ProductID, pp.Name, count(ss.ProductID) as veces_vendido
						from Adventure.Production.Product pp
						inner join [DESKTOP-I4B3KNS\MSSQLSERVER1].AdventureSales.Sales.SalesOrderDetail ss
						on pp.ProductID = ss.ProductID
						where pp.ListPrice >= '+@precio+' 
						group by ss.ProductID, pp.Name, pp.ProductID;'
exec(@sql)
end

exec consulta_3 @precio=500;


--4.- Listar los productos junto a su cantidad de veces vendido que tengan 
--un precio menor o igual a lo solicitado 
create procedure consulta_4 @precio varchar(10) as
begin
	declare @sql nvarchar(1000);

		  set @sql = 'select pp.ProductID, pp.Name, count(ss.ProductID) as veces_vendido
						from Adventure.Production.Product pp
						inner join [DESKTOP-I4B3KNS\MSSQLSERVER1].AdventureSales.Sales.SalesOrderDetail ss
						on pp.ProductID = ss.ProductID
						where pp.StandardCost <= '+@precio+'  
						group by ss.ProductID, pp.Name, pp.ProductID;'
exec(@sql)
end

exec consulta_4 @precio = 250


--5.- listar por categoria los productos y su cantidad de ventas en el año de 2011 a 2012				
	SELECT DISTINCT PC.Name AS Categoria
    FROM Production.ProductSubcategory AS PS
	INNER JOIN Production.ProductCategory PC ON PS.ProductCategoryID = PC.ProductCategoryID
	GROUP BY PC.Name, PS.Name, PS.ProductSubcategoryID
						



--6.- listar los consumidores que han hecho ordenes durante el año de 2011
create procedure consulta_6 @año varchar(100)as
begin
declare @sql varchar(1000)
set @sql= 'SELECT TOP 10 CustomerID
                        FROM [DESKTOP-I4B3KNS\MSSQLSERVER1].AdventureSales.Sales.SalesOrderHeader
                        WHERE OrderDate BETWEEN ''1/1/'+@año+''' AND ''12/31/'+@año+'''
                        GROUP BY CustomerID'
exec (@sql);
end

exec consulta_6 @año=2011;

--7.- listar el precio promedio de la cantidad de pedidos que se indique en el año que se indique
create procedure consulta_7 @ordenes varchar(10), @año varchar(10) as
begin  
  
  declare @sql nvarchar(1000);

          set @sql = 'SELECT sod.ProductID, AVG(sod.UnitPrice) AS [Precio Promedio]
						FROM [DESKTOP-I4B3KNS\MSSQLSERVER1].AdventureSales.Sales.SalesOrderDetail as sod
						INNER JOIN [DESKTOP-I4B3KNS\MSSQLSERVER1].AdventureSales.Sales.SalesOrderHeader as soh
						ON soh.SalesOrderID = sod.SalesOrderID
						WHERE OrderQty = '+@ordenes+' AND YEAR(soh.OrderDate) = '+@año+'
						GROUP BY ProductID'

exec(@sql)
end

exec consulta_7 @ordenes = 10, @año = 2013;


--8.- listar los productos con su precio total respecto a su cantidad de pedidos
create procedure consulta_8 @cantidad varchar(10) as
begin
declare @sql  varchar(1000);
          set @sql = 'SELECT distinct p.Name AS ProductName,
						PrecioTotal = (OrderQty * UnitPrice)
						FROM Production.Product AS p
						INNER JOIN [DESKTOP-I4B3KNS\MSSQLSERVER1].AdventureSales.Sales.SalesOrderDetail AS sod ON p.ProductID = sod.ProductID
						where OrderQty = '+@cantidad+';'
						
		

exec(@sql)
end

exec consulta_8 @cantidad = 10;

--9.- Listar el numero de orden, fecha, vendedor e importe vendido del cliente 
create procedure consulta_9 @cliente varchar(10) as
begin
	
	declare @sql nvarchar(1000);


set @sql = 'select H.SalesOrderID AS N_Orden, H.OrderDate AS Fecha, H.CustomerID AS Cliente, H.SalesPersonID AS Vendedor,
			SUM(D.OrderQty+D.UnitPrice) AS [Importe Vendido]
			FROM [DESKTOP-I4B3KNS\MSSQLSERVER1].AdventureSales.Sales.SalesOrderHeader H  
			INNER JOIN [DESKTOP-I4B3KNS\MSSQLSERVER1].AdventureSales.Sales.SalesOrderDetail D 
			ON H.SalesOrderID = D.SalesOrderID 
			AND CustomerID = '+@cliente+'
			GROUP BY H.SalesOrderID, H.OrderDate, H.CustomerID, H.SalesPersonID;'
exec(@sql);
end

exec consulta_9 @cliente= 11000;

--10.- Listar los representativos de ventas por ID con el territorio al que estan ligado y su cantidad de ventas 
-- del año pasado respectivamente
SELECT distinct  e.BusinessEntityID, e.JobTitle, t.[Name] AS [Territory]
                        , t.[SalesLastYear] AS [Territory Sales Last Year] 
                        from OPENQUERY([LINKSERVER3], 'SELECT * FROM [AdventurePerson].[HumanResources].Employee') as e
                        inner join [DESKTOP-I4B3KNS\MSSQLSERVER1].AdventureSales.Sales.SalesPerson as s on s.BusinessEntityID = e.BusinessEntityID
                        inner join [DESKTOP-I4B3KNS\MSSQLSERVER1].AdventureSales.Sales.SalesTerritory as t on t.[TerritoryID] = s.TerritoryID

--11.- Listar el ID de los clientes que su tarjeta no fue aceptada
create procedure consulta_11 @fecha varchar(10) as
begin 

	declare @sql nvarchar(1000);

set @sql =	'SELECT CustomerID 
				FROM [DESKTOP-I4B3KNS\MSSQLSERVER1].AdventureSales.Sales.SalesOrderHeader
				WHERE CreditCardApprovalCode IS NULL and [OrderDate] BETWEEN ''1/1/'+@fecha+''' AND ''12/31/'+@fecha+''''

				

exec (@sql)
end

exec consulta_11 @fecha= '2012';

--12.- listar la cantidad total de compras del cliente 
create procedure consulta_12 @cliente varchar(10) as
begin
	declare @sql varchar(1000);
		  set @sql = 'SELECT CustomerID, SUM([TotalDue]) AS Totals
						FROM [DESKTOP-I4B3KNS\MSSQLSERVER1].AdventureSales.Sales.SalesOrderHeader
						where CustomerID = '+@cliente+'
						GROUP BY CustomerID
						ORDER BY Totals DESC'
exec(@sql);
end
exec consulta_12 @cliente=11000;

--Transaccion 1
drop procedure cambio_tel
create procedure cambio_tel @id int, @num nvarchar(25) as
begin 
    SET XACT_ABORT ON
    begin distributed transaction
    begin try 
    update [LINKSERVER3].AdventurePerson.Person.PersonPhone set PhoneNumber = @num where BusinessEntityID = @id;

    commit transaction
    end try
    begin catch
    rollback transaction
    print 'ha ocurrido un error'
    end catch
end 

select BusinessEntityID, PhoneNumber from [LINKSERVER3].AdventurePerson.Person.PersonPhone where BusinessEntityID = '1';

exec cambio_tel @id=1, @num= '697-555-0143'

--Transaccion 2
select BusinessEntityID, EmailAddress from [LINKSERVER3].AdventurePerson.Person.EmailAddress where BusinessEntityID = '1';

drop procedure cambio_email
create procedure cambio_email @id int, @email nvarchar(50) as
begin 
    DECLARE @fecha datetime;
    set @fecha = CURRENT_TIMESTAMP;
    SET XACT_ABORT ON
    begin distributed transaction
    begin try 
    update [LINKSERVER3].AdventurePerson.Person.EmailAddress set EmailAddress = @email, ModifiedDate = CURRENT_TIMESTAMP
    where BusinessEntityID = @id;

    commit transaction
    end try
    begin catch
    rollback transaction
    print 'ha ocurrido un error'
    end catch
end 


exec cambio_email @id=1, @email= 'eduaralien@hotmail.com'

--Transaccion 3
create procedure cambio_stock @id int,  @locid int, @cantidad int as
begin 
    DECLARE @fecha datetime;
    set @fecha = CURRENT_TIMESTAMP;
    SET XACT_ABORT ON
    begin distributed transaction
    begin try 
    update Adventure.Production.ProductInventory set Quantity = @cantidad, ModifiedDate = CURRENT_TIMESTAMP
    where ProductID = @id and LocationID = @locid;

    commit transaction
    end try
    begin catch
    rollback transaction
    print 'ha ocurrido un error'
    end catch
end

select ProductID, LocationID, Quantity from Production.ProductInventory where ProductID='1' and LocationID='1'

exec cambio_stock @id=1, @locid=1, @cantidad=499

--Optimizacion
create nonclustered index indice4 on Production.ProductSubcategory(ProductSubcategoryID)
drop index indice4 on Production.ProductSubcategory

create CLUSTERED index indice2 on Sales.SalesOrderHeader(SalesOrderID);
drop index indice2 on Sales.SalesOrderHeader

create clustered index indice3 on Sales.SalesOrderDetail(ProductID);
drop index indice3 on Sales.SalesOrderDetail

create index indice11 on Production.Product(ProductID)

create index indice9 on Production.ProductSubcategory(ProductSubCategoryID)

create index indice10 on Production.Product(ProductSubCategoryID)