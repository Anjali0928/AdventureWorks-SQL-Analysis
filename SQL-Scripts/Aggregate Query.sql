select ps.Name as ProductSubCategoryName,
  Count (ProductID) as ProductID,
  Sum (StandardCost) as StandardCost,
  Sum (ListPrice) as ListPrice,
  Profit = Sum(ListPrice) - Sum(StandardCost),
  MarkupPercentage = ((Sum(ListPrice - StandardCost)) / Sum(StandardCost)) * 100
 From Production.Product as p
  Left join Production.ProductSubcategory as ps
  On p.ProductSubcategoryID = ps.ProductSubcategoryID
 Where ListPrice > 0 
       and 
       StandardCost > 0
Group By ps.Name
Order By ps.Name
