SELECT [ProductID] as PrdctID
      ,[Name]
      ,[ProductNumber] as PrdctNo
      ,[MakeFlag] as MakeFlg
      ,[FinishedGoodsFlag] as Fnsdgoodsflg
      ,[Color]
      ,FORMAT ([SafetyStockLevel],'N0','en-us') as SftyStckLvl
      ,FORMAT ([ReorderPoint],'N0','en-us') as ReodrPt
      ,FORMAT ([StandardCost],'c','en-us') as Stdcost
      ,FORMAT ([ListPrice],'c','en-us') as Listprc
      ,[Size]
      ,[SizeUnitMeasureCode] as SizeUntMsurCode
      ,[WeightUnitMeasureCode] as WgtUntMsurCode
      ,FORMAT ([Weight],'N2','en-us') as Wgt
      ,[DaysToManufacture] as DaystoMnufctur
      ,[ProductLine]
      ,[Class]
      ,[Style]
      ,[ProductSubcategoryID] as PrdctSubCatgry
      ,[ProductModelID] as PrdctModeID
      ,FORMAT ([SellStartDate],'MM/dd/yyyy','en-us') as SellStrtDt
      ,FORMAT ([SellEndDate],'MM/dd/yyyy','en-us') as SellEndDt
      ,FORMAT ([DiscontinuedDate],'MM/dd/yyyy','en-us') as DscntDt
       FROM [AdventureWorks2017].[Production].[Product]
