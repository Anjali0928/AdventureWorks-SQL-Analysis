select pc.Name as ProductCategoryName,
          ps.Name as ProductSubCategoryName,
	   pm.Name as ProductModelName,
	   ProductNumber,
	   p.Name as ProductName,
	   OrderQty,
	   Cost = (OrderQty * StandardCost),
	   LineTotal as Revenue,
	   Profit = (LineTotal - (OrderQty * StandardCost)),
	   MarkupPercentage = ((LineTotal - (OrderQty * StandardCost)) / (OrderQty * StandardCost)) * 100
from sales.SalesOrderDetail as s
	left join Production.Product as p
	On s.ProductID = p.ProductID
	left join production.ProductSubcategory as ps
	on p.ProductSubcategoryID = ps.ProductSubcategoryID
	left join Production.ProductCategory as pc
	on ps.ProductCategoryID = pc.ProductCategoryID
	left join Production.ProductModel as pm
	On p.ProductModelID = pm.ProductModelID
Order by Profit asc
