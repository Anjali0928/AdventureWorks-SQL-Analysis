select DISTINCT
       OnlineOrderFlag,
	   SalesPersonID,
       PurchaseOrderNumber,
	   customertype = (case when personid is not null
                            and storeid is null
		                    then 'Individual'
				            when storeid is not null
				            and personid is null
				            then 'Store'
				            when storeid is not null
				            and personid is not null
				            then 'Store with contact'
				            else 'ERROR'
				            end),
	   OrderQty
	from sales.SalesOrderheader as soh
	left join sales.customer as sc
	On soh.CustomerID = sc.CustomerID
	left join sales.SalesOrderDetail as sd
	On soh.SalesOrderID = sd.SalesOrderID
Order by  OnlineOrderFlag desc, SalesPersonID desc
