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
  (define (improve guess x)
    (average guess (/ x guess)))

  (define (books-good-enough? guess x)
    (<
      (abs (- (square guess) x))
      0.001))

  (define (books-sqrt-iter guess x)
    (if (books-good-enough? guess x)
            guess
            (books-sqrt-iter (improve guess x)
                              x)))

  (define (books-sqrt x)
    (books-sqrt-iter 1.0 x))

  ;; Very small numbers:

    ;; Very small numbers won't work very well as the `good enough` threshold is 0.001. The algorithim
    ;; used in the book's implementation is the Babylonian method ("Heron's method"). This method is
    ;; a quadratically convergent algorithm, which means that the number of correct digits
    ;; of the approximation roughly doubles with each iteration. For small numbers we will stop the
    ;; iterations only a few steps in, which will impact the accuracy in a signficant way.

  ;; Very large numbers:

    ;; For very large numbers, the limited precision provided by a division is insufficient to ever
    ;; reach our threshold value 0.001. That means that our algorthim will fall into a never ending
    ;; loop attempting to reach a level of precision that the computer will never provide.....
    ;; Except I can't get it to do that. I got it to happen once but I haven't been able to get it to do it again.

  ;; ***********************************************************************************************

  ;; An alternative strategy for implementing good-enough? is to watch how guess changes from one
  ;; iteration to the next and to stop when the change is a very small fraction of the guess.

  (define (improved-guess-delta old_guess x)
    (- (improve old_guess x)
        old_guess))

  (define (good-enough? guess x)
    (<
       (abs (improved-guess-delta guess x))
       (* guess 0.0001)))

  (define (sqrt-iter guess x)
    (if (good-enough? guess x)
            guess
            (sqrt-iter (improve guess x) x)))

  (define (sqrt x)
    (sqrt-iter 1.0 x))

  ;; ;; MY NOTES:
    ;; Let's use english to describe to algorithim of `improve`.
    ;; (averaging `guess`
    ;;           `number x, whose square root we are finding` / `guess`.)

(trace good-enough?)
(trace books-good-enough?)

;; Provide the square root functions for testing.
(provide sqrt
         books-sqrt)
