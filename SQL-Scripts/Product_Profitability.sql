select ProductNumber,
	   p.Name as ProductName,
	   sum (OrderQty) as OrderQty,
	   Cost = sum (OrderQty * StandardCost),
	   sum (LineTotal) as Revenue,
	   Profit = sum(LineTotal) - sum(OrderQty * StandardCost),
	   MarkupPercentage = (sum(LineTotal - (OrderQty * StandardCost)) / sum(OrderQty * StandardCost)) * 100
from sales.SalesOrderDetail as s
	left join Production.Product as p
	On s.ProductID = p.ProductID
	left join production.ProductSubcategory as ps
	on p.ProductSubcategoryID = ps.ProductSubcategoryID
	left join Production.ProductCategory as pc
	on ps.ProductCategoryID = pc.ProductCategoryID
	left join Production.ProductModel as pm
	On p.ProductModelID = pm.ProductModelID
	where OrderQty is not null
Group by ProductNumber, p.Name
Order by Profit asc
