select
  ProductNumber,
  p.Name as ProductName,
  StandardCost,
  ListPrice,
  Profit = ListPrice - StandardCost,
  MarkupPercentage = ((ListPrice - StandardCost) / StandardCost) * 100
 From Production.Product as p
 Where ListPrice > 0 and 
	   StandardCost > 0
 Order by ProductID asc
