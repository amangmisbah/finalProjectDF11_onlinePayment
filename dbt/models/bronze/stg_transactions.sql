WITH source AS (

    select * from {{ source('final_project', 'transaction') }}

)

SELECT
    idTransaction as transactionID,
    timestamp as transactionDatetime,
    type,
    ROUND(amount, 2) as amount,
    nameOrig,
    ROUND(oldbalanceOrg, 2) as oldBalanceOrig,
    ROUND(newbalanceOrig, 2) as newBalanceOrig,
    nameDest,
    ROUND(oldbalanceDest, 2) as oldBalanceDest,
    ROUND(newbalanceDest, 2) as newBalanceDest,
    CAST(isFraud as BOOLEAN) as isFraud,
    CAST(isFlaggedFraud as BOOLEAN) as isFlaggedFraud
FROM
    source
ORDER BY transactionID
