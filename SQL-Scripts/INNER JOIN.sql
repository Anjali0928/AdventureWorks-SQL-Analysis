select pc.Name as ProductCategoryName,
 ps.Name as ProductSubcategoryName,
 ProductID,
 ProductNumber,
 p.Name
 from production.product as p
  INNER join Production.ProductSubcategory as ps
  On p.ProductSubcategoryID = ps.ProductSubcategoryID
  INNER Join Production.ProductCategory as pc
  On ps.ProductCategoryID = pc.ProductCategoryID
  where p.ProductSubcategoryID is not null
  Order by 
  pc.Name asc,
  ps.Name asc, 
  p.Name asc
