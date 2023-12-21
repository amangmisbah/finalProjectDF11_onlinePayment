SELECT * FROM {{ source('final_project', 'email') }}
ORDER BY idTransaction