select 
	count(*)
FROM 
	oti_building
WHERE
	shape.STIsValid() = 0