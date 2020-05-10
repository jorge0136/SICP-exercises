#lang sicp
;; Exercise 1.7: The good-enough? test used in computing
;; square roots will not be very effective for finding the square
;; roots of very small numbers. Also, in real computers, arithmetic operations are almost always
;; performed with limited precision. This makes our test inadequate for very large
;; numbers. Explain these statements, with examples showing
;; how the test fails for small and large numbers. An alternative strategy for implementing 
;; good-enough? is to watch how guess changes from one iteration to the next and to
;; stop when the change is a very small fraction of the guess.
;; Design a square-root procedure that uses this kind of end
;; test. Does this work better for small and large numbers?

;; Original implementation shown in the book is as follows: 
  (define ( square x ) (* x x))

  (define (average x y)
    (/ (+ x y) 2))

  ;; We use the Babylonian method ("Heron's method") of approximating square roots. 
  ;; This is a quadratically convergent algorithm, which means that the number of correct digits 
  ;; of the approximation roughly doubles with each iteration.
  (define (improve guess x)
    (average guess (/ x guess)))

  (define (good-enough? guess x)
    (< 
      (abs 
        (- 
          (square guess) 
          x)) 
      0.001))

  (define (sqrt-iter guess x)
    (if (good-enough? guess x)
            guess
            (sqrt-iter (improve guess x) x)))

  (define (sqrt x)
    (sqrt-iter 1.0 x))


  ;; Let's use english to describe to algorithim of `improve`. 
    ;; (averaging `guess`
    ;;           `number x, whose square root we are finding` / `guess`.)

  ;; Let's try out the book's original implementation on some small and large numbers. 
  (sqrt 5)

  (sqrt .5)
  (sqrt .05)
  (sqrt .005)
  (sqrt .0005)
  (sqrt .00005)
  (sqrt .000005)
  (sqrt .0000005)
  (sqrt .00000005)
  (sqrt .000000005)
  (sqrt .000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000005)
  (sqrt .00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000005)

  ;; Large numbers examples. 
  (sqrt 500)
  (sqrt 5000)
  (sqrt 50000)
  (sqrt 500000)
  (sqrt 5000000)
  (sqrt 50000000)
  (sqrt 500000000)
  (sqrt 5000000000)
  (sqrt 50000000000)
  ;; finally broke here. Starting from one, it's a long way to go from 1 as a starting guess to 50000000000
  ;; This algorithim is slow to find the number. 

  ;; An alternative strategy for implementing good-enough? is to watch how guess changes from one 
  ;; iteration to the next and to stop when the change is a very small fraction of the guess.