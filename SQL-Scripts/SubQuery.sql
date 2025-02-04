select 
cr.Name as CountryRegion,
st.Name as Territory,
SalesQuota,
Bonus,
CommissionPct,
OrderDate,
OnlineOrderFlag,
SaleType = (case when OnlineOrderFlag = 0
                      then 'Wholesale'
                      when OnlineOrderFlag = 1
                      then 'Retail'
					  end),
customertype = (case  when personid is not null
                      and storeid is null
		              then 'Person'
				      when storeid is not null
				      and personid is null
				      then 'Store'
				      when storeid is not null
				      and personid is not null
				      then 'Store with contact'
				      else 'ERROR'
				      end),
customername = (case  when personid is not null
                      and storeid is null
                      then CONCAT(LastName,' , ',FirstName,' ',(case when MiddleName is null 
							                                               then ' '
											                          when len(middlename) = 1
											                          then concat(middlename,'.')
											                          when len(middlename) = 2
											                          then middlename
											                          when len(middlename) > 2
											                          then concat(left(middlename, 1),'.')
											                          end))
			           when storeid is not null
				       and personid is null
				       then s.name
				       when storeid is not null
			           and personid is not null
		               then concat(s.name,'-',CONCAT(LastName,' , ',FirstName,' ',(case when MiddleName is null
											                                                 then ' '
											                                                 when len(middlename) = 1
											                                                 then concat(middlename,'.')
											                                                 when len(middlename) = 2
											                                                 then middlename
											                                                 when len(middlename) > 2
											                                                 then concat(left(middlename, 1),'.')
											                                             end)))
				       else 'ERROR'
				       end),
SalesOrderNumber,
Description as SpecOfferDesc,
Type as SpecOfferType,
p.Name as ProductName,
ProductNumber,
pm.Name as ProductModelName,
ps.Name as ProdSubCatName,
pc.Name as ProdCatName,
StandardCost,
ListPrice,
UnitPrice,
OrderQty,
UnitPriceDiscount,
DiscountPct,
LineTotal as TotalRevenue,
TotalCost = OrderQty * StandardCost,
TotalProfit = (LineTotal - (OrderQty * StandardCost)),
MarkupPercentage = ((LineTotal - (OrderQty * StandardCost)) / (OrderQty * StandardCost)),
PriceDiscount = (case when ListPrice = 0
                      then 0
                      else ((ListPrice - UnitPrice) / ListPrice)
					  end),
DiscountDiscount = (case when DiscountPct = 0 and UnitPriceDiscount = 0
                         then 0
						 when DiscountPct = 0 and UnitPriceDiscount <> 0
						 then 1000
						 when DiscountPct <> 0 and UnitPriceDiscount = 0
						 then -1
						 else (DiscountPct - UnitPriceDiscount)/ DiscountPct
						 end),
   (select sales.salesreason.name 
   from sales.salesorderheader as soh
   left join sales.SalesOrderHeaderSalesReason as sr
   On soh.SalesOrderID = sr.SalesOrderID
   left join sales.SalesReason
   On sr.SalesReasonID = sales.SalesReason.SalesReasonID
   where sod.SalesOrderID = sr.SalesOrderID and sr.SalesReasonID = 1) as [Price SR],

   (select sales.salesreason.name 
   from sales.salesorderheader as soh
   left join sales.SalesOrderHeaderSalesReason as sr
   On soh.SalesOrderID = sr.SalesOrderID
   left join sales.SalesReason
   On sr.SalesReasonID = sales.SalesReason.SalesReasonID
   where sod.SalesOrderID = sr.SalesOrderID and sr.SalesReasonID = 2) as [On Promotion SR],

   (select sales.salesreason.name 
   from sales.salesorderheader as soh
   left join sales.SalesOrderHeaderSalesReason as sr
   On soh.SalesOrderID = sr.SalesOrderID
   left join sales.SalesReason
   On sr.SalesReasonID = sales.SalesReason.SalesReasonID
   where sod.SalesOrderID = sr.SalesOrderID and sr.SalesReasonID = 3) as [Magazine Advertisement SR],

   (select sales.salesreason.name 
   from sales.salesorderheader as soh
   left join sales.SalesOrderHeaderSalesReason as sr
   On soh.SalesOrderID = sr.SalesOrderID
   left join sales.SalesReason
   On sr.SalesReasonID = sales.SalesReason.SalesReasonID
   where sod.SalesOrderID = sr.SalesOrderID and sr.SalesReasonID = 4) as [Television Advertisement SR],

   (select sales.salesreason.name 
   from sales.salesorderheader as soh
   left join sales.SalesOrderHeaderSalesReason as sr
   On soh.SalesOrderID = sr.SalesOrderID
   left join sales.SalesReason
   On sr.SalesReasonID = sales.SalesReason.SalesReasonID
   where sod.SalesOrderID = sr.SalesOrderID and sr.SalesReasonID = 5) as [Manufacturer SR],

   (select sales.salesreason.name 
   from sales.salesorderheader as soh
   left join sales.SalesOrderHeaderSalesReason as sr
   On soh.SalesOrderID = sr.SalesOrderID
   left join sales.SalesReason
   On sr.SalesReasonID = sales.SalesReason.SalesReasonID
   where sod.SalesOrderID = sr.SalesOrderID and sr.SalesReasonID = 6) as [Review SR],

   (select sales.salesreason.name 
   from sales.salesorderheader as soh
   left join sales.SalesOrderHeaderSalesReason as sr
   On soh.SalesOrderID = sr.SalesOrderID
   left join sales.SalesReason
   On sr.SalesReasonID = sales.SalesReason.SalesReasonID
   where sod.SalesOrderID = sr.SalesOrderID and sr.SalesReasonID = 7) as [Demo Event SR],

   (select sales.salesreason.name 
   from sales.salesorderheader as soh
   left join sales.SalesOrderHeaderSalesReason as sr
   On soh.SalesOrderID = sr.SalesOrderID
   left join sales.SalesReason
   On sr.SalesReasonID = sales.SalesReason.SalesReasonID
   where sod.SalesOrderID = sr.SalesOrderID and sr.SalesReasonID = 8) as [Sponsorship SR],

   (select sales.salesreason.name 
   from sales.salesorderheader as soh
   left join sales.SalesOrderHeaderSalesReason as sr
   On soh.SalesOrderID = sr.SalesOrderID
   left join sales.SalesReason
   On sr.SalesReasonID = sales.SalesReason.SalesReasonID
   where sod.SalesOrderID = sr.SalesOrderID and sr.SalesReasonID = 9) as [Quality SR],

   (select sales.salesreason.name 
   from sales.salesorderheader as soh
   left join sales.SalesOrderHeaderSalesReason as sr
   On soh.SalesOrderID = sr.SalesOrderID
   left join sales.SalesReason
   On sr.SalesReasonID = sales.SalesReason.SalesReasonID
   where sod.SalesOrderID = sr.SalesOrderID and sr.SalesReasonID = 10) as [Other SR]

from Sales.SalesOrderDetail as sod
 Left Join Production.Product as p
 On sod.ProductID = p.ProductID
 Left Join Production.ProductModel as pm
 On p.ProductModelID = pm.ProductModelID
 Left Join Production.ProductSubcategory as ps
 On p.ProductSubcategoryID = ps.ProductSubcategoryID
 Left Join Production.ProductCategory as pc
 On ps.ProductCategoryID = pc.ProductCategoryID
 Left join Sales.SalesOrderHeader as soh
 On sod.SalesOrderID = soh.SalesOrderID 
 Left Join Sales.Customer as c
 On soh.CustomerID = c.CustomerID
 left join sales.store as s
 on c.StoreID = s.BusinessEntityID
 left join person.Person as pp
 on c.PersonID = pp.BusinessEntityID
 Left Join Sales.SalesTerritory as st
 On soh.TerritoryID = st.TerritoryID
 Left Join person.CountryRegion as cr
 On st.CountryRegionCode = cr.CountryRegionCode
 Left Join Sales.SalesPerson as sp
 On soh.SalesPersonID = sp.BusinessEntityID
 Left Join Sales.SpecialOffer as so
 On sod.SpecialOfferID = so.SpecialOfferID
