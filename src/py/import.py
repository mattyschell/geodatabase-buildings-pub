import sys
import os
import logging
import pathlib

# SET PYTHONPATH=C:\xxx\geodatabase-toiler\src\py
import gdb
import fc
import cx_sde


def fetchsql(whichsql
            ,database):

    sqlfilepath = pathlib.Path(__file__).parent \
                                        .joinpath('sql_{0}'.format(database)) \
                                        .joinpath(whichsql)
        
    with open(sqlfilepath, 'r') as sqlfile:
        sql = sqlfile.read() 

    return sql 


if __name__ == "__main__":

    targetfcname = sys.argv[1]
    sourcefc     = sys.argv[2]

    targetsdeconn = os.environ['SDEFILE']
    targetgdb = gdb.Gdb(None
                       ,'sqlserver')

    logging.basicConfig(level=logging.INFO)
    logger = logging.getLogger(__name__)

    logger.info('importing {0}'.format(targetfcname))

    # We do not overwrite, we do not trust me  
    # Caller must delete as an explicit decision if thats desired on this target
    targetgdb.importfeatureclass(sourcefc
                                ,targetfcname)

    targetfc = fc.Fc(targetgdb
                    ,targetfcname)  

    logger.info('indexing {0} on {1}'.format('BIN'
                                             ,targetfcname))
    output = targetfc.index('BIN')

    logger.info('indexing {0} on {1}'.format('BASE_BBL'
                                             ,targetfcname))
    
    output = targetfc.index('BASE_BBL')

    # reminder: "unique indexes cant be specified for multiversioned tables"
    logger.info('indexing {0} on {1}'.format('DOITT_ID'
                                             ,targetfcname))
    output = targetfc.index('DOITT_ID'
                           ,True)

    logger.info('updating statistics on {0}'.format(targetfcname))

    output = targetfc.analyze(['BUSINESS'])

    logger.info('completed import of {0}'.format(targetfcname))
