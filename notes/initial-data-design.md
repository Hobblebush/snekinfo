
# litters

 - id
 - born
 - mother
 - father

# snakes

 - id
 - name (e.g. "spark", "snake 47")
 - litter_id
 - sex

# traits

 - id
 - name (e.g. "anery", "albino")
 - inheritance ("dominant", "recessive", "poly")

# snake_traits

 - id
 - snake_id
 - trait_id

# weights

 - id
 - snake_id
 - weight (grams)
 - timestamp

# feeds

 - id
 - snake_id
 - live?
 - weight
 - ate_it?
 - timestamp
 
