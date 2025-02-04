select ps.Name as ProductSubCategoryName,
  Count (ProductID) as ProductID,
  Format (Sum(StandardCost),'C','en-us') as StandardCost,
  Format (Sum (ListPrice),'C','en-us') as ListPrice,
  Profit = Format (Sum(ListPrice) - Sum(StandardCost),'C','en-us'),
  MarkupPercentage = Format (((Sum(ListPrice - StandardCost)) / Sum(StandardCost)),'P0')
 From Production.Product as p
  Left join Production.ProductSubcategory as ps
  On p.ProductSubcategoryID = ps.ProductSubcategoryID
 Where ListPrice > 0 
       and 
       StandardCost > 0
Group By ps.Name
Order By ps.Name asc
