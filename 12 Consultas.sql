--Productos mas vendidos con un precio menor o igual a 100
create procedure consulta_p as
begin
  declare @servidor nvarchar(100);
  declare @nom_bd nvarchar(100);
  declare @nom_tabla nvarchar(100);
  declare @esquema nvarchar(100);
  declare @servidor2 nvarchar(100);
  declare @nom_bd2 nvarchar(100);
  declare @nom_tabla2 nvarchar(100);
  declare @esquema2 nvarchar(100);
  declare @sql nvarchar(1000);
  declare @id int;

 set @id = 1;
 		  select @nom_bd = bd, @nom_tabla = ntabla, @esquema= esquema
		  from diccionario_dist
		  where id_dic = @id
set @id= 2;
		  select @servidor2 = servidor, @nom_bd2 = bd, @nom_tabla2 = ntabla, @esquema2= esquema
		  from diccionario_dist
		  where id_dic = @id

set @sql='select pp.ProductID, pp.Name,pp.ProductNumber, pp.ListPrice,
			count(ss.ProductID) as veces_vendido
			from Adventure.'+@esquema+'.'+@nom_tabla+' pp
			inner join '+@servidor2+'.'+@nom_bd2+'.'+@esquema2+'.'+@nom_tabla2+' ss
			on pp.ProductID = ss.ProductID
			where pp.ListPrice <=100 and pp.Color = ''Yellow''
			group by ss.ProductID, pp.Name, pp.ProductID,pp.ProductNumber, pp.ListPrice
			order by count(ss.ProductID) desc';
exec (@sql);

end
drop procedure consulta_p
exec consulta_p
select * from di
--Determinar el número de ventas en un territorio especifico
create procedure ventas_territorio @territorio varchar(10) as
begin
	declare @servidor nvarchar(100);
	declare @nom_bd nvarchar(100);
	declare @nom_tabla nvarchar(100);
	declare @esquema nvarchar(100);
	declare @servidor2 nvarchar(100);
	declare @nom_bd2 nvarchar(100);
	declare @nom_tabla2 nvarchar(100);
	declare @esquema2 nvarchar(100);
	declare @servidor3 nvarchar(100);
	declare @nom_bd3 nvarchar(100);
	declare @nom_tabla3 nvarchar(100);
	declare @esquema3 nvarchar(100);
	declare @sql nvarchar(1000);
	declare @id int;

set @id= 2;
  		  select @servidor = servidor, @nom_bd = bd, @nom_tabla = ntabla, @esquema= esquema
		  from diccionario_dist
		  where id_dic = @id
set @id= 3;
  		  select @servidor2 = servidor, @nom_bd2 = bd, @nom_tabla2 = ntabla, @esquema2= esquema
		  from diccionario_dist
		  where id_dic = @id
set @id= 4;
  		  select @servidor3 = servidor, @nom_bd3 = bd, @nom_tabla3 = ntabla, @esquema3= esquema
		  from diccionario_dist
		  where id_dic = @id

set @sql= 'select st.Name, sum(so.OrderQty * so.UnitPrice) as total_vendido
			from '+@servidor3+'.'+@nom_bd3+'.'+@esquema3+'.'+@nom_tabla3+' sh
			inner join '+@servidor+'.'+@nom_bd+'.'+@esquema+'.'+@nom_tabla+' so
			on sh.SalesOrderID = so.SalesOrderID
			inner join '+@servidor2+'.'+@nom_bd2+'.'+@esquema2+'.'+@nom_tabla2+' st
			on st.TerritoryID = sh.TerritoryID where st.TerritoryID ='+@territorio+'
			group by st.TerritoryID, st.Name';

exec (@sql);
end
  exec ventas_territorio @territorio = '1'
  exec ventas_territorio @territorio = '2'
  exec ventas_territorio @territorio = '3'
  exec ventas_territorio @territorio = '4'
  exec ventas_territorio @territorio = '5'
  exec ventas_territorio @territorio = '6'
  exec ventas_territorio @territorio = '7'

  
--Listar los productos más vendidos que tengan un precio mayor o igual a 600 
--y un nivel de cuidado del stock igual a 500  
create procedure Productos_Vendidos as
begin	
	declare @servidor nvarchar(100);
	declare @nom_bd nvarchar(100);
	declare @nom_tabla nvarchar(100);
	declare @esquema nvarchar(100);
	declare @servidor2 nvarchar(100);
	declare @nom_bd2 nvarchar(100);
	declare @nom_tabla2 nvarchar(100);
	declare @esquema2 nvarchar(100);
	declare @sql nvarchar(1000);
	declare @id int;
 set @id = 1;
 		  select @nom_bd = bd, @nom_tabla = ntabla, @esquema= esquema
		  from diccionario_dist
		  where id_dic = @id
set @id= 2;
  		  select @servidor2 = servidor, @nom_bd2 = bd, @nom_tabla2 = ntabla, @esquema2= esquema
		  from diccionario_dist
		  where id_dic = @id
		  
		  set @sql = 'select pp.ProductID, pp.Name, count(ss.ProductID) as veces_vendido
						from '+@nom_bd+'.'+@esquema+'.'+@nom_tabla+' pp
						inner join '+@servidor2+'.'+@nom_bd2+'.'+@esquema2+'.'+@nom_tabla2+' ss
						on pp.ProductID = ss.ProductID
						where pp.ListPrice >= 600 and pp.SafetyStockLevel = 500
						group by ss.ProductID, pp.Name, pp.ProductID
						order by count(ss.ProductID) desc;'

exec(@sql)

end
exec Productos_Vendidos


--Listar los productos más vendidos que tengan 
--un precio estándar menor o igual a 250 y el día de manufactura sea igual a 1
create procedure Productos_Vendidos2 as
begin
	declare @servidor nvarchar(100);
	declare @nom_bd nvarchar(100);
	declare @nom_tabla nvarchar(100);
	declare @esquema nvarchar(100);
	declare @servidor2 nvarchar(100);
	declare @nom_bd2 nvarchar(100);
	declare @nom_tabla2 nvarchar(100);
	declare @esquema2 nvarchar(100);
	declare @sql nvarchar(1000);
	declare @id int;

 set @id = 1;
 		  select @nom_bd = bd, @nom_tabla = ntabla, @esquema= esquema
		  from diccionario_dist
		  where id_dic = @id
set @id= 2;
  		  select @servidor2 = servidor, @nom_bd2 = bd, @nom_tabla2 = ntabla, @esquema2= esquema
		  from diccionario_dist
		  where id_dic = @id

		  set @sql = 'select pp.ProductID, pp.Name, count(ss.ProductID) as veces_vendido
						from '+@nom_bd+'.'+@esquema+'.'+@nom_tabla+' pp
						inner join '+@servidor2+'.'+@nom_bd2+'.'+@esquema2+'.'+@nom_tabla2+' ss
						on pp.ProductID = ss.ProductID
						where pp.StandardCost <= 250 and pp.DaysToManufacture = 1 
						group by ss.ProductID, pp.Name, pp.ProductID
						order by count(ss.ProductID) asc;'

exec(@sql)
end

exec Productos_Vendidos2


--listar por categoria los productos y su cantidad de ventas en el año de 2011 a 2012
create procedure consulta_5 as
begin
 
	declare @servidor4 nvarchar(100);
	declare @nom_bd4 nvarchar(100);
	declare @nom_tabla4 nvarchar(100);
	declare @esquema4 nvarchar(100);
	declare @servidor2 nvarchar(100);
	declare @nom_bd2 nvarchar(100);
	declare @nom_tabla2 nvarchar(100);
	declare @esquema2 nvarchar(100);
	declare @sql nvarchar(1000);
	declare @id int;

 set @id = 2;
			select @servidor2 = servidor, @nom_bd2 = bd, @nom_tabla2 = ntabla, @esquema2= esquema
			from diccionario_dist
			where id_dic = @id
set @id= 4;
 
            select @servidor4 = servidor, @nom_bd4 = bd, @nom_tabla4 = ntabla, @esquema4 = esquema
			from diccionario_dist
			where id_dic = @id

          set @sql = 'SELECT PC.Name AS Category, PS.Name AS Subcategory,
						DATEPART(yy, SOH.OrderDate) AS [Year]
						, ''Q'' + DATENAME(qq, SOH.OrderDate) AS [Qtr]
						, STR(SUM(DET.UnitPrice * DET.OrderQty)) AS [$ Sales]
						FROM Production.ProductSubcategory AS PS
						INNER JOIN '+@servidor4+'.'+@nom_bd4+'.'+@esquema4+'.'+@nom_tabla4+' AS SOH
						INNER JOIN '+@servidor2+'.'+@nom_bd2+'.'+@esquema2+'.'+@nom_tabla2+' DET ON SOH.SalesOrderID = DET.SalesOrderID
						INNER JOIN Production.Product P ON DET.ProductID = P.ProductID
						ON PS.ProductSubcategoryID = P.ProductSubcategoryID
						INNER JOIN Production.ProductCategory PC ON PS.ProductCategoryID = PC.ProductCategoryID
						WHERE YEAR(SOH.OrderDate) = ''2012'' or YEAR(SOH.OrderDate) =''2011''
						GROUP BY DATEPART(yy, SOH.OrderDate), PC.Name, PS.Name, ''Q''
						+ DATENAME(qq, SOH.OrderDate), PS.ProductSubcategoryID
						ORDER BY Category, SubCategory, [Qtr]'

exec(@sql)
end

exec consulta_5 

--listar los consumidores que han hecho ordenes durante el año de 2011
create procedure consulta_6 as
begin
  declare @servidor4 nvarchar(100);
  declare @nom_bd4 nvarchar(100);
  declare @nom_tabla4 nvarchar(100);
  declare @esquema4 nvarchar(100);
  declare @sql nvarchar(1000);
  declare @id int;

set @id= 4;
            select @servidor4 = servidor, @nom_bd4 = bd, @nom_tabla4 = ntabla, @esquema4 = esquema
			from diccionario_dist
			where id_dic = @id

          set @sql = 'SELECT Top 10 CustomerID, STR(SUM(TaxAmt)) AS Totals
						FROM '+@servidor4+'.'+@nom_bd4+'.'+@esquema4+'.'+@nom_tabla4+'
						WHERE [OrderDate] BETWEEN ''1/1/2011'' AND ''12/31/2011''
						GROUP BY CustomerID
						ORDER BY Totals DESC'

exec(@sql)
end

exec consulta_6

--listar los el precio promedio de los productos que hayan tenido una cantidad mayor a 10 ordenes en el 2011
create procedure consulta_7 as
begin  
  declare @servidor4 nvarchar(100);
  declare @nom_bd4 nvarchar(100);
  declare @nom_tabla4 nvarchar(100);
  declare @esquema4 nvarchar(100);
  declare @servidor2 nvarchar(100);
  declare @nom_bd2 nvarchar(100);
  declare @nom_tabla2 nvarchar(100);
  declare @esquema2 nvarchar(100);
  declare @sql nvarchar(1000);
  declare @id int;


 set @id = 2;
          select @servidor2 = servidor, @nom_bd2 = bd, @nom_tabla2 = ntabla, @esquema2= esquema
          from diccionario_dist
          where id_dic = @id

set @id= 4;
          select @servidor4 = servidor, @nom_bd4 = bd, @nom_tabla4 = ntabla, @esquema4 = esquema
          from diccionario_dist
          where id_dic = @id

          set @sql = 'SELECT sod.ProductID, AVG(sod.UnitPrice) AS [Average Price]
						FROM '+@servidor2+'.'+@nom_bd2+'.'+@esquema2+'.'+@nom_tabla2+' as sod
						INNER JOIN '+@servidor4+'.'+@nom_bd4+'.'+@esquema4+'.'+@nom_tabla4+' as soh
						ON soh.SalesOrderID = sod.SalesOrderID
						WHERE OrderQty > 10 AND YEAR(soh.OrderDate) = ''2011''
						GROUP BY ProductID
						ORDER BY [Average Price] DESC'

exec(@sql)
end

exec consulta_7;


--listar los descuentos que han tenido los productos
create procedure consulta_8 as
begin
  declare @servidor2 nvarchar(100);
  declare @nom_bd2 nvarchar(100);
  declare @nom_tabla2 nvarchar(100);
  declare @esquema2 nvarchar(100);
  declare @sql nvarchar(1000);
  declare @id int;


 set @id = 2;
          select @servidor2 = servidor, @nom_bd2 = bd, @nom_tabla2 = ntabla, @esquema2= esquema
          from diccionario_dist
          where id_dic = @id

          set @sql = 'SELECT Distinct p.Name AS ProductName,
						NonDiscountSales = (OrderQty * UnitPrice),
						Discounts = ((OrderQty * UnitPrice) * UnitPriceDiscount)
						FROM Production.Product AS p
						INNER JOIN '+@servidor2+'.'+@nom_bd2+'.'+@esquema2+'.'+@nom_tabla2+' AS sod ON p.ProductID = sod.ProductID
						ORDER BY ProductName DESC;'

exec(@sql)
end

exec consulta_8;

--listar el numero de orden, fecha, vendedor y cliente que ha hecho el cliente con el numero 11000
create procedure consulta_9 as
begin
	declare @servidor nvarchar(100);
	declare @nom_bd nvarchar(100);
	declare @nom_tabla nvarchar(100);
	declare @esquema nvarchar(100);
	declare @servidor2 nvarchar(100);
	declare @nom_bd2 nvarchar(100);
	declare @nom_tabla2 nvarchar(100);
	declare @esquema2 nvarchar(100);
	declare @sql nvarchar(1000);
	declare @id int;
set @id = 4;
 		  select @servidor = servidor, @nom_bd = bd, @nom_tabla = ntabla, @esquema= esquema
		  from diccionario_dist
		  where id_dic = @id;

set @id= 2; 
  		  select @servidor2 = servidor, @nom_bd2 = bd, @nom_tabla2 = ntabla, @esquema2= esquema
		  from diccionario_dist
		  where id_dic = @id;
set @sql = 'select H.SalesOrderID AS N_Orden, H.OrderDate AS Fecha, H.CustomerID AS Cliente, H.SalesPersonID AS Vendedor,
			SUM(D.OrderQty+D.UnitPrice) AS [Importe Vendido]
			FROM '+@servidor+'.'+@nom_bd+'.'+@esquema+'.'+@nom_tabla+' H  
			INNER JOIN '+@servidor2+'.'+@nom_bd2+'.'+@esquema2+'.'+@nom_tabla2+' D 
			ON H.SalesOrderID = D.SalesOrderID 
			AND CustomerID = 11000
			GROUP BY H.SalesOrderID, H.OrderDate, H.CustomerID, H.SalesPersonID;'

exec(@sql);
end

exec consulta_9;

--listar por territorio la cantidad de ventas, cuotas, comisiones, despidos, estado marital de los empleados que han trabajado
create procedure consulta_10 as
begin 
	declare @servidor nvarchar(100);
	declare @nom_bd nvarchar(100);
	declare @nom_tabla nvarchar(100);
	declare @esquema nvarchar(100);
	declare @servidor2 nvarchar(100);
	declare @nom_bd2 nvarchar(100);
	declare @nom_tabla2 nvarchar(100);
	declare @esquema2 nvarchar(100);
	declare @servidor3 nvarchar(100);
	declare @nom_bd3 nvarchar(100);
	declare @nom_tabla3 nvarchar(100);
	declare @esquema3 nvarchar(100);
	declare @sql nvarchar(1000);
	declare @id int;
set @id = 5;
 		  select @servidor = servidor, @nom_bd = bd, @nom_tabla = ntabla, @esquema= esquema
		  from diccionario_dist
		  where id_dic = @id;
set @id = 6;
 		  select @servidor2 = servidor, @nom_bd2 = bd, @nom_tabla2 = ntabla, @esquema2 = esquema
		  from diccionario_dist
		  where id_dic = @id;
set @id = 3;
 		  select @servidor3 = servidor, @nom_bd3 = bd, @nom_tabla3 = ntabla, @esquema3 = esquema
		  from diccionario_dist
		  where id_dic = @id;

		  set @sql = 'SELECT t.[TerritoryID],t.[Name] AS [Territory], s.SalesLastYear as [Emp Sales Last Year]
						, [SalesQuota] AS [Emp Sales Quota], s.SalesYTD AS [Emp Sales YTD]
						, [Bonus] AS [Emp Bonus], [CommissionPct] as [Emp Commission%]
						, [HireDate], [MaritalStatus], t.[SalesLastYear] AS [Territory Sales Last Year]
						, t.[SalesYTD] AS [Territory Sales YTD]
						from OPENQUERY('+@servidor+', ''SELECT * FROM ['+@nom_bd+'].['+@esquema+'].'+@nom_tabla+''') as e
						inner join '+@servidor2+'.'+@nom_bd2+'.'+@esquema2+'.'+@nom_tabla2+' as s on s.BusinessEntityID = e.BusinessEntityID
						inner join '+@servidor3+'.'+@nom_bd3+'.'+@esquema3+'.'+@nom_tabla3+' as t on t.[TerritoryID] = s.TerritoryID
						ORDER BY TerritoryID;'

exec(@sql);
end

exec consulta_10;

--listar el top 10 de los clientes con mas compras en el año del 2013
create procedure consulta_11 as
begin 
	declare @servidor nvarchar(100);
	declare @nom_bd nvarchar(100);
	declare @nom_tabla nvarchar(100);
	declare @esquema nvarchar(100);
	declare @sql nvarchar(1000);
	declare @id int;

set @id = 4;
 		  select @servidor = servidor, @nom_bd = bd, @nom_tabla = ntabla, @esquema= esquema
		  from diccionario_dist
		  where id_dic = @id;

set @sql =	'SELECT Top 10 CustomerID, STR(SUM(TaxAmt)) AS Totals
				FROM '+@servidor+'.'+@nom_bd+'.'+@esquema+'.'+@nom_tabla+'
				WHERE [OrderDate] BETWEEN ''1/1/2013'' AND ''12/31/2013''
				GROUP BY CustomerID
				ORDER BY Totals DESC'

exec (@sql)
end

exec consulta_11;

--listar la cantidad total de compras del cliente 11000
create procedure consulta_12 as
begin
	declare @servidor nvarchar(100);
	declare @nom_bd nvarchar(100);
	declare @nom_tabla nvarchar(100);
	declare @esquema nvarchar(100);
	declare @sql nvarchar(1000);
	declare @id int;

set @id = 4;
 		  select @servidor = servidor, @nom_bd = bd, @nom_tabla = ntabla, @esquema= esquema
		  from diccionario_dist
		  where id_dic = @id;

		  set @sql = 'SELECT CustomerID, SUM([TotalDue]) AS Totals
						FROM '+@servidor+'.'+@nom_bd+'.'+@esquema+'.'+@nom_tabla+'
						where CustomerID = 11000
						GROUP BY CustomerID
						ORDER BY Totals DESC'
exec(@sql);
end
exec consulta_12;

select * from diccionario_dist
insert into diccionario_dist values (3,'[LINKSERVER2]','AdventureSales','Sales','SalesTerritory');
insert into diccionario_dist values (4,'[LINKSERVER2]','AdventureSales','Sales','SalesOrderHeader');
insert into diccionario_dist values (5,'[LINKSERVER3]','AdventurePerson','HumanResources','Employee');
insert into diccionario_dist values (6,'[LINKSERVER2]','AdventureSales','Sales','SalesPerson');
