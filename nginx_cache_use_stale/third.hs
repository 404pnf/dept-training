third :: [a] -> [a]
-- third [] = []
third (x1 : x2 : x : xs)  = x : third xs
third _ = []


