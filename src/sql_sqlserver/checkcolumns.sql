select 
	count(*)
from 
	sys.tables as tab
inner join 
	sys.columns as col
on 
	tab.object_id = col.object_id
where 
	tab.name = 'oti_building'
and schema_name(tab.schema_id) = current_user
and col.name in ('OBJECTID'
                ,'NAME'
				,'BIN'
				,'BASE_BBL'
				,'CONSTRUCTION_YEAR'
				,'GEOM_SOURCE'
				,'LAST_STATUS_TYPE'
				,'DOITT_ID'
				,'HEIGHT_ROOF'
				,'FEATURE_CODE'
				,'STATUS'
				,'GROUND_ELEVATION'
				,'CREATED_USER'
				,'CREATED_DATE'
				,'LAST_EDITED_USER'
				,'LAST_EDITED_DATE'
				,'ADDRESSABLE'
				,'MAPPLUTO_BBL'
				,'CONDO_FLAGS'
				,'ALTERATION_YEAR')