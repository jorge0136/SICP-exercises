#lang racket
(require racket/trace)
;; Exercise 1.7: The good-enough? test used in computing square roots will not be very effective
;; for finding the square roots of very small numbers. Also, in real computers, arithmetic
;; operations are almost always performed with limited precision. This makes our test inadequate
;; for very large numbers.
;; Explain these statements, with examples showing how the test fails for small and large numbers.
;; An alternative strategy for implementing  good-enough? is to watch how `guess` changes from one
;; iteration to the next and to stop when the change is a very small fraction of the guess.
;; Design a square-root procedure that uses this kind of end test. Does this work better for small
;; and large numbers?

  ;; Before implementing the new solution, let's show the original implementation as shown in the book.
  (define ( square x ) (* x x))

  (define (average x y)
    (/ (+ x y) 2))

  ;; The book uses the Babylonian method ("Heron's method") of approximating square roots.
  ;; This is a quadratically convergent algorithm, which means that the number of correct digits
  ;; of the approximation roughly doubles with each iteration.
  (define (books-improve guess x)
    (average guess (/ x guess)))

  (define (books-good-enough? guess x)
    (<
      (abs (- (square guess) x))
      0.001))

  (define (books-sqrt-iter guess x)
    (if (books-good-enough? guess x)
            guess
            (books-sqrt-iter (books-improve guess x) x)))

  (define (books-sqrt x)
    (books-sqrt-iter 1.0 x))

  ;; Very small numbers:

    ;; Very small numbers won't work very well as the `good enough` threshold is 0.001. The algorithim
    ;; used in the book's implementation is the Babylonian method ("Heron's method"). This method is
    ;; a quadratically convergent algorithm, which means that the number of correct digits
    ;; of the approximation roughly doubles with each iteration. For small numbers we will stop the
    ;; iterations only a few steps in, which will impact the accuracy in a signficant way.

  ;;   ;; Let's try out the book's original implementation on some small and large numbers.
    (trace books-good-enough?)
    ;; (books-sqrt 5)
  ;;   (books-sqrt .5)
    (books-sqrt .05)
  ;;   (books-sqrt .005)
  ;;   ;; --> 0.0722471690979458. Actual per google is 0.07071067811
  ;;   (books-sqrt .0005)
  ;;   ;; --> 0.03640532954316447. Actual per google is 0.02236067977

  ;; ;; Very large numbers:

  ;;   ;; For very large numbers, the limited precision provided by a division is insufficient to ever
  ;;   ;; reach our threshold value 0.001. That means that our algorthim will fall into a never ending
  ;;   ;; loop attempting to reach a level of precision that the computer will never provide.

  ;;   ;; Large numbers examples.
  ;;   (books-sqrt 500)
  ;;   (books-sqrt 5000)
  ;;   (books-sqrt 50000)
  ;;   (books-sqrt 500000)
  ;;   (books-sqrt 5000000)
  ;;   (books-sqrt 50000000)
  ;;   (books-sqrt 500000000)
  ;;   (books-sqrt 5000000000)
  ;;   (books-sqrt 50000000000)
  ;;   (books-sqrt 500000000000)
  ;;   (books-sqrt 500000000000000)
  ;;   (books-sqrt 50000000000000000000000000000)
  ;;   (books-sqrt 500000000000000000000000000000000000000000000000000000000)
  ;;   (books-sqrt 50000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000)

  ;; ***********************************************************************************************

  ;; An alternative strategy for implementing good-enough? is to watch how guess changes from one
  ;; iteration to the next and to stop when the change is a very small fraction of the guess.

  (define (improve guess x)
    (average guess (/ x guess)))

  (define (improved-guess-delta old_guess x)
    (- (improve old_guess x)
        old_guess))

  ;; Watch how guess change from one iteration to the next and stop when the change is a very small
  ;; fraction of the guess.
  (define (good-enough? guess x)
    (<
       (abs (improved-guess-delta guess x))
       (* guess 0.001)))

  (define (sqrt-iter guess x)
    (if (good-enough? guess x)
            guess
            (sqrt-iter (improve guess x) x)))

  (define (sqrt x)
    (sqrt-iter 1.0 x))

  ;; (sqrt 500)

;; Very small numbers:

  ;; (sqrt 5)
  ;; (sqrt .5)
  ;; (sqrt .05)
  ;; (sqrt .005)
  ;; ;; --> 0.0722471690979458. Actual per google is 0.07071067811
  ;; (sqrt .0005)
  ;; ;; --> 0.03640532954316447. Actual per google is 0.02236067977

;; Large numbers examples.
  ;; (sqrt 500)
  ;; (sqrt 5000)
  ;; (sqrt 50000)
  ;; (sqrt 500000)
  ;; (sqrt 5000000)
  ;; (sqrt 50000000)
  ;; (sqrt 500000000)
  ;; (sqrt 5000000000)
  ;; (sqrt 50000000000)
  ;; (sqrt 500000000000)
  ;; (sqrt 5000000000000)
  ;; (sqrt 500000000000000)
  ;; --> 22360679.774997897 Actual per google is 22360679.775
  ;; (sqrt 50000000000000000000000000000)
  ;; --> 223606_797749978.97 Actual per google is 2.236068e+14.
  ;; (sqrt 500000000000000000000000000000000000000000000000000000000)
  ;; (sqrt 50000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000)

  ;; ;; MY NOTES:
    ;; Let's use english to describe to algorithim of `improve`.
    ;; (averaging `guess`
    ;;           `number x, whose square root we are finding` / `guess`.)

;; Provide the square root functions for testing.
(provide sqrt
         books-sqrt)
