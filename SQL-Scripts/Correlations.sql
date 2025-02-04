select ProductID,
ProductNumber,
Name,
ProductSubcategoryID,
FinishedGoodsFlag,
ProductModelID
from production.Product
where FinishedGoodsFlag = 1 and ProductModelID is not null
