select 
       AccountNumber,
       customertype = (case
							when storeid is not null
							and personid is not null
							then 'Store with contact'
							end),
			customername = (case  when storeid is not null
						          and personid is not null
				                  then concat(s.name,'-',CONCAT(LastName,',',FirstName,' ',(case when MiddleName is null 
                                                         then ''
                                                         when len(middlename) = 1
			                                             then concat(middlename,'.')
			                                             when len(middlename) = 2
			                                             then middlename
		                                                 when len(middlename) > 2
                                                         then concat(left(middlename, 1),'.')
					                                     end)))
						end)
 from sales.customer as c
 left join sales.store as s
 on c.StoreID = s.BusinessEntityID
 left join person.Person as p
 on c.PersonID = p.BusinessEntityID
 where StoreID is not null
        and 
       PersonID is not null
 Order by AccountNumber asc
