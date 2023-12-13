WITH source AS (
    SELECT
        *
    FROM {{ source('brz_online_payment', 'brz_transaction') }}
)

SELECT
    idTransaction as transactionID,
    timestamp as transactionDatetime,
    type,
    ROUND(amount, 2) as amount,
    nameOrigin,
    ROUND(oldBalanceOrigin, 2) as oldBalanceOrig,
    ROUND(newBalanceOrigin, 2) as newBalanceOrig,
    nameDest,
    ROUND(oldbalanceDest, 2) as oldBalanceDest,
    ROUND(newbalanceDest, 2) as newBalanceDest,
    CAST(isFraud as BOOLEAN) as isFraud,
    CAST(isFlaggedFraud as BOOLEAN) as isFlaggedFraud
FROM
    source
ORDER BY transactionID
