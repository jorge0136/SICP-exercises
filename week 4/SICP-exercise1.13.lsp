;; Exercise 1.13.  Prove that Fib(n) is the closest integer to n/5, where  = (1 + 5)/2.
;; Hint: Let  = (1 - 5)/2. Use induction and the definition of the Fibonacci numbers
;; (see section 1.2.2) to prove that Fib(n) = (n - n)/5.

(define phi
  (/ (+ 1 (sqrt 5)) 2))

(define (^ base exponent)
   (define (*^ exponent acc)
       (if (= exponent 0)
           acc
           (*^ (- exponent 1) (* acc base))))
   (*^ exponent 1))

(define (f n)
  (/ (^ phi n) (sqrt 5)))


(define (fib n)
  (fib-iter 1 0 n))


(define (fib-iter a b count)
  (if (= count 0)
        b
        (fib-iter (+ a b) a (- count 1))))
