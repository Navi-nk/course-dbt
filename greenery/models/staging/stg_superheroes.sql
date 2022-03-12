WITH superheroes_source AS (
    SELECT 
        *
    FROM 
        {{ source('postgres_source', 'superheroes') }}
)

SELECT
    id,
    name,
    gender,
    eye_color,
    race,
    hair_color,
    height,
    publisher,
    skin_color,
    alignment,
    weight,
    created_at,
    updated_at
FROM    
    superheroes_source