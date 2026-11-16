USE DATABASE API_DATA_ENGINEERING;

CREATE SCHEMA IF NOT EXISTS DBT_DEV;

CREATE SCHEMA IF NOT EXISTS DBT_PROD;


DESCRIBE TABLE
    API_DATA_ENGINEERING.BRONZE.RAW_API_CUSTOMERS;



    EXECUTE DBT PROJECT FROM WORKSPACE
    "USER$"."PUBLIC"."snowflake-data-engineering"
    PROJECT_ROOT = '/starter_project'
    ARGS = 'build --select stg_customers --target dev';

SELECT *
FROM API_DATA_ENGINEERING.BRONZE.RAW_API_CUSTOMERS
LIMIT 5;



SELECT *
FROM API_DATA_ENGINEERING.DBT_DEV.STG_CUSTOMERS;


EXECUTE DBT PROJECT FROM WORKSPACE
    "USER$"."PUBLIC"."snowflake-data-engineering"
    PROJECT_ROOT = '/starter_project'
    ARGS = 'compile --target dev';


    EXECUTE DBT PROJECT FROM WORKSPACE
    "USER$"."PUBLIC"."snowflake-data-engineering"
    PROJECT_ROOT = '/starter_project'
    ARGS = 'build --select stg_customers --target dev';


    SELECT *
FROM API_DATA_ENGINEERING.DBT_DEV.STG_CUSTOMERS;



SHOW TABLES IN SCHEMA API_DATA_ENGINEERING.DBT_DEV;

SHOW VIEWS IN SCHEMA API_DATA_ENGINEERING.DBT_DEV;




EXECUTE DBT PROJECT FROM WORKSPACE
    "USER$"."PUBLIC"."snowflake-data-engineering"
    PROJECT_ROOT = '/starter_project'
    ARGS = 'build --select stg_customers --target dev';



    EXECUTE DBT PROJECT FROM WORKSPACE
    "USER$"."PUBLIC"."snowflake-data-engineering"
    PROJECT_ROOT = '/starter_project'
    ARGS = 'ls --resource-type model --target dev';