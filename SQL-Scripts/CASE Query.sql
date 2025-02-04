select 
       AccountNumber,
     customertype = (case     when personid is not null
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

	customername = (case    when personid is not null
                                                            and storeid is null
                                                            then CONCAT(LastName,' , ',FirstName,' ',(case when MiddleName is null
											then ' '
											when len(middlename) = 1
											then concat(middlename,'.')
											when len(middlename) = 2
											then middlename
											when len(middlename) > 2
											then                   concat(left(middlename, 1),'.')
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
							end)
 from sales.customer as c
 left join sales.store as s
 on c.StoreID = s.BusinessEntityID
 left join person.Person as p
 on c.PersonID = p.BusinessEntityID
 Order by AccountNumber asc
