select ProductID,
  ProductNumber,
  p.Name as ProductName,
  pm.Name as ProductModelName,
  MakeFlag,
  FinishedGoodsFlag,
  StandardCost,
  ListPrice,
  ps.Name as ProductSubCategoryName,
  pc.Name as ProductCategoryName
 From Production.Product as p
  Left Join Production.ProductModel as pm
   On p.ProductModelID = pm.ProductModelID
  Left Join Production.ProductSubcategory as ps
   On p.ProductSubcategoryID = ps.ProductSubcategoryID
  Left Join Production.ProductCategory as pc
   On ps.ProductCategoryID = pc.ProductCategoryID
 Where ListPrice > 0 
    and 
	   StandardCost > 0
Order by ProductID asc


