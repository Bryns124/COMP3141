module QuizTesting where

-- import Control.Monad.State
import System.IO
-- import Test.QuickCheck
import Text.Read (readMaybe)
import Data.List (nub)
import Data.Char (isDigit)

b :: IO ()
b = do x <- getLine
       putStrLn (filter (not . isDigit) x)
       b

a :: IO ()
a = do getLine >>= \x -> putStrLn (filter (not . isDigit) x); a