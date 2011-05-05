import System(getArgs)

-- Bankers Deque - From Okasaki's Purely Functional Data Structures
data BankersDeque a = BD Int [a] Int [a]
c = 3
check lenf f lenr r
  | lenf > c * lenr + 1 = BD i (take i f) j (r ++ reverse (drop i f))
  | lenr > c * lenf + 1 = BD j (f ++ reverse (drop i r)) i (take i r)
  | otherwise           = BD lenf f lenr r
    where i = (lenf + lenr) `div` 2
          j = lenf + lenr - i

-- Only implement Deque methods which we use for sliding window
isEmpty (BD lenf _ lenr _) = lenf + lenr == 0
append (BD lenf f lenr r) x = check lenf f (lenr + 1) (x:r)

front (BD _ [] _ (x:_)) = x
front (BD _ (x:_) _ _)  = x

back (BD _ (x:_) _ []) = x
back (BD _ _ _ (x:_))  = x

popBack (BD lenf (x:_) lenr []) = BD 0 [] 0 []
popBack (BD lenf f lenr (x:r')) = check lenf f (lenr - 1) r'

popFront (BD lenf [] lenr (x:_)) = BD 0 [] 0 []
popFront (BD lenf (x:f') lenr r) = check (lenf - 1) f' lenr r

-- Sliding window code
slidingWindow :: (Ord a) => Int -> [a] -> [a]
slidingWindow = slidingWindow' (BD 0 [] 0 []) 0

slidingWindow' :: (Ord a) => BankersDeque (a, Int) -> Int -> Int -> [a] -> [a]
slidingWindow' _ _ _ [] = []
slidingWindow' q i k xss@(x:xs)
  | not (isEmpty q) && x <= fst (back q)        = slidingWindow' (popBack q)  i k xss
  | not (isEmpty q) && snd (front q) <= (i - k) = slidingWindow' (popFront q) i k xss
  | otherwise                                   = getMin : slidingWindow' (append q (x, i)) (i+1) k xs
    where getMin = if isEmpty q then x else fst (front q)

-- Support command line interface
main = do
  args <- getArgs
  k  <- return $ (read (head args) :: Int)
  xs <- return $ map (read :: String -> Int) (tail args)
  putStr . unlines . map show $ slidingWindow k xs