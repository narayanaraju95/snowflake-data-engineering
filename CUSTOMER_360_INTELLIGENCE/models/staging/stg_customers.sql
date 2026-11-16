
{{
    config(
        materialized='view'
    )
}}

WITH source_data AS (

    SELECT
        BATCH_ID,
        SOURCE_NAME,
        RAW_PAYLOAD,
        INGESTED_AT

    FROM {{ source('bronze_api', 'raw_api_customers') }}

),

extracted AS (

    SELECT
        BATCH_ID,
        SOURCE_NAME,

        TRY_TO_NUMBER(
            RAW_PAYLOAD:customer_id::STRING
        ) AS CUSTOMER_ID,

        TRIM(
            RAW_PAYLOAD:customer_name::STRING
        ) AS CUSTOMER_NAME,

        LOWER(
            TRIM(RAW_PAYLOAD:email::STRING)
        ) AS EMAIL,

        TRIM(
            RAW_PAYLOAD:country::STRING
        ) AS COUNTRY,

        TRIM(
            RAW_PAYLOAD:city::STRING
        ) AS CITY,

        TRIM(
            RAW_PAYLOAD:postal_code::STRING
        ) AS POSTAL_CODE,

        UPPER(
            TRIM(RAW_PAYLOAD:status::STRING)
        ) AS STATUS,

        INGESTED_AT

    FROM source_data

),

deduplicated AS (

    SELECT *

    FROM extracted

    QUALIFY ROW_NUMBER() OVER (
        PARTITION BY CUSTOMER_ID
        ORDER BY
            INGESTED_AT DESC,
            BATCH_ID DESC
    ) = 1

)

SELECT
    CUSTOMER_ID,
    CUSTOMER_NAME,
    EMAIL,
    COUNTRY,
    CITY,
    POSTAL_CODE,
    STATUS,
    SOURCE_NAME,
    BATCH_ID,
    INGESTED_AT

FROM deduplicated
