module Practice01 where

import Data.List

-- mySum :: [Int] -> Int
-- mySum [] = 0
-- mySum (n:ns) = n + mySum ns

-- myProduct :: [Int] -> Int
-- myProduct [] = 1
-- myProduct (n:ns) = n * myProduct ns

myBinop :: (Int -> Int -> Int) -> Int -> ([Int] -> Int)
myBinop _ z [] = z
myBinop f z (n:ns) = f n (myBinop f z ns)

-- mySum :: [Int] -> Int
-- mySum ns = myBinop (+) 0 ns

-- myProduct :: [Int] -> Int
-- myProduct ns = myBinop (*) 1 ns

mySum :: [Int] -> Int
mySum ns = foldl (+) 0 ns

myProduct :: [Int] -> Int
myProduct ns = foldl (*) 1 ns

fizzBuzz :: Int -> [String]
fizzBuzz n =  map convertNumber [1..n]

convertNumber :: Int -> String
convertNumber n
  | n `mod` 3 == 0 && n `mod` 5 == 0 = "FizzBuzz"
  | n `mod` 5 == 0 = "Buzz"
  | n `mod` 3 == 0 = "Fizz"
  | otherwise = show n