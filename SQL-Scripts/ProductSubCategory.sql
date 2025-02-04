select ps.Name as ProductSubcategoryName,
 ProductID,
 ProductNumber,
 p.Name
 from production.product as p
  left join Production.ProductSubcategory as ps 
  On p.ProductSubcategoryID = ps.ProductSubcategoryID 
  where p.ProductSubcategoryID is not null
  Order by 
  ps.Name asc, 
  p.Name asc
