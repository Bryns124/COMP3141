module Ex02(append,Promote(New),testAssoc,testUnit,
            MinMonoid(EmbMM, Infinity),minMonoidOp,
            isSparseList,SparseList(SparseList),
            testSparseList,testAssocSparseList,
            testUnitSparseList,promoteOp) where
-- The module declaration above specifies which symbols
-- are exported. Don't tinker with this line. The
-- automarking scripts will expect all of the above
-- to exist, and to have their declared type from the
-- template.
import Data.Semigroup
import Test.QuickCheck



-- PART 1 --

-- In this part you will establish that any semigroup can be
-- "promoted" to a monoid simply by adjoining a new element,
-- and decreeing this new element to be the monoid identity.

-- The elements of `Promote s` consist of the following:
-- 1. all elements of s (in the form `Emb x`)
-- 2. a new element `New`, distinct from all elements of s.

data Promote s
  = Emb s
  | New
  deriving (Show, Eq)

instance (Arbitrary s) => Arbitrary (Promote s) where
  arbitrary =
    (\f x -> f x) <$> oneof [return (const New), return Emb]
                  <*> arbitrary

-- Task 1.1: Define a monoid operation `promoteOp` on
-- the type `Promote g` so that the adjoined element `New`
-- functions as the identity element of the resulting monoid.

promoteOp :: (Semigroup g) => Promote g -> Promote g -> Promote g
promoteOp (Emb x) (Emb y) = Emb (x <> y)
promoteOp (Emb x) New = Emb x
promoteOp New (Emb y) = Emb y
promoteOp New New = New

-- Task 1.2: Define the appropriate `Semigroup` and `Monoid`
-- instances for `Promote s`, using `promoteOp` as the monoid
-- operation.

instance (Semigroup s) => Semigroup (Promote s) where
  (<>) = promoteOp

instance (Semigroup s) => Monoid (Promote s) where
  mempty = New
  mappend = (<>)

-- Task 1.3: Write two predicates that QuickCheck can use
-- to test if a given monoid operation is lawful.
-- The first should test that the monoid operation is
-- associative, while the second should test that the identity
-- element satisfies the required laws.

testAssoc :: (Monoid g, Eq g) => g -> g -> g -> Bool
testAssoc x y z = (x <> y) <> z == x <> (y <> z)

testUnit :: (Monoid g, Eq g) => g -> Bool
testUnit x = mempty <> x == x && x <> mempty == x

-- PART 2 --

-- In this part you will show that any ordered type gives rise
-- to a monoid where the monoid operation corresponds to
-- taking the minimum.

data MinMonoid t
  = EmbMM t
  | Infinity
  deriving (Show, Eq)

instance (Arbitrary t) => Arbitrary (MinMonoid t) where
  arbitrary =
    (\f -> \x -> f x) <$> oneof [pure (const Infinity), pure EmbMM]
                      <*> arbitrary

-- Task 2.1: Define a monoid operation `minMonoidOp` (`<>`)
-- in such a way that given any list [x1,x2,...,xn] of values,
-- evaluating `EmbMM x1 <> EmbMM x2 <> ... <> EmbMM xn`
-- results in `EmbMM xi`, where xi = minimum of [x1,x2,...,xn].

minMonoidOp :: (Ord t) => MinMonoid t -> MinMonoid t -> MinMonoid t
minMonoidOp Infinity y = y
minMonoidOp x Infinity = x
minMonoidOp (EmbMM x) (EmbMM y) = EmbMM (min x y)


-- Task 2.2: Define Semigroup and Monoid instaces for `MinMonoid`
-- using the `minMonoidOp` defined above.

instance (Ord t) => Semigroup (MinMonoid t) where
  (<>) = minMonoidOp

instance (Ord t) => Monoid (MinMonoid t) where
  mempty = Infinity
  mappend = (<>)

testIsMinimum :: [Int] -> Bool
testIsMinimum xs
  | null xs = mconcat (map EmbMM xs) == Infinity
  | otherwise = mconcat (map EmbMM xs) == EmbMM (minimum xs)

-- PART 3 --

-- A SparseList is an alternative representation of lists, designed to
-- require less memory for lists where adjacent elements are mostly
-- equal.

newtype SparseList a = SparseList [(Int,a)] deriving (Show,Eq)

-- To each element we attach a positive number, representing its
-- multiplicity. Thus, the list
--    ['a','a','a','b','b','a','a']    aka   "aaabbaa"
-- Is represented as follows in a SparseList:
--    [(3,'a'),(2,'b'),(2,'a')]
-- The price we pay for this is that the element type must be
-- an instance of Eq.

instance (Arbitrary a, Eq a) => Arbitrary (SparseList a) where
  arbitrary = fromList <$> arbitrary

-- The `SparseList` constructor is not supposed to be invoked directly
-- by users. Instead, we use the "smart constructor" `fromList`
-- defined below. This smart constructor ensures that lists of type
-- `SparseList a` are well-formed.

fromList :: Eq a => [a] -> SparseList a
fromList [] = SparseList []
fromList (x:xs) =
  SparseList $ (n+1,x):result where
  SparseList result = fromList rest
  n = length $ takeWhile (==x) xs
  rest = drop n xs

-- Task 3.1: Define, as a predicate specifying what it means for a
-- sparse list to be well-formed. In a well-formed sparse list, all
-- multiplicities need to be positive, and the list must be maximally
-- packed (so that adjacent elements must be distinct).
isSparseList :: (Eq a) => [(Int,a)] -> Bool
isSparseList [] = True
isSparseList [(n, _)] = n > 0
isSparseList ((n1, x1) : (n2, x2) : xs) = n1 > 0 && n2 > 0 && x1 /= x2 && isSparseList ((n2, x2) : xs)

-- Task 3.2: Define the append operation on SparseLists.  Feel free to
-- use the template below.  Hint: the last element of xs in the final
-- clause needs to be treated specially.
append :: Eq a => SparseList a -> SparseList a -> SparseList a
append (SparseList []) sl = sl
append sl (SparseList []) = sl
append (SparseList xs) (SparseList ((m,y):ys)) = SparseList (xs ++ [(m, y)]) `append` SparseList ys

-- Task 3.3: Write a predicate that tests whether the `append`
-- operation preserves the `isSparseList` invariant defined above,
-- i.e. that appending two sparse lists yields a well-formed
-- sparse list.
toList :: SparseList a -> [(Int, a)]
toList (SparseList xs) = xs

testSparseList :: SparseList Int -> SparseList Int -> Bool
testSparseList sl1 sl2 = isSparseList (toList (sl1 `append` sl2))

-- Task 3.4: Define a semigroup and monoid instance for `SparseList a`
-- with monoid operation `append`. Write tests for the monoid laws.

instance (Eq t) => Semigroup (SparseList t) where
  (<>) = append

instance (Eq t) => Monoid (SparseList t) where
  mempty = SparseList []
  mappend = (<>)

testAssocSparseList :: SparseList Int -> SparseList Int -> SparseList Int -> Bool
testAssocSparseList sl1 sl2 sl3 = (sl1 <> sl2) <> sl3 == sl1 <> (sl2 <> sl3)

testUnitSparseList :: SparseList Int -> Bool
testUnitSparseList sl = mempty <> sl == sl && sl <> mempty == sl

