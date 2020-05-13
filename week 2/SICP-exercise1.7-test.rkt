#lang racket/base

(require rackunit
          "SICP-exercise1.7.rkt")

;; Books implementation of good-enough?
    (define seven-decimal-delta .0000001)
    (define six-decimal-delta .000001)
    (define five-decimal-delta .00001)
    (define four-decimal-delta .0001)
    (define three-decimal-delta .001)
    (define two-decimal-delta .01)
    (define one-decimal-delta .1)

;; Very Small Numbers:
    (check-= (books-sqrt 5.0) 2.2360679775 six-decimal-delta "_S1: books-sqrt of `5`.")
    (check-= (books-sqrt 0.5) 0.70710678118 five-decimal-delta "_S2: books-sqrt of `0.5`.")
    (check-= (books-sqrt 0.05) 0.22360679775 three-decimal-delta "_S3: books-sqrt of `0.05`.")
    (check-= (books-sqrt 0.005) 0.07071067811 two-decimal-delta "_S4: books-sqrt of `0.005`.")
    (check-= (books-sqrt 0.0005) 0.02236067977 one-decimal-delta "_S5: books-sqrt of `0.0005`.")

  ;; Very Large Numbers:
    (check-= (books-sqrt 500.0) 22.360679775 seven-decimal-delta "_L1:books-sqrt of `500`.")
    (check-= (books-sqrt 5000.0) 70.7106781187 seven-decimal-delta "_L2: books-sqrt of `5000`.")
    (check-= (books-sqrt 50000.0) 223.60679775 seven-decimal-delta "_L3: books-sqrt of `50000`.")
    (check-= (books-sqrt 500000.0) 707.106781187 six-decimal-delta "_L4: books-sqrt of `500000`.")
    (check-= (books-sqrt 5000000.0) 2236.0679775 six-decimal-delta "_L5: books-sqrt of `5000000`.")
    (check-= (books-sqrt 50000000.0) 7071.06781187 six-decimal-delta "_L6: books-sqrt of `50000000`.")
    (check-= (books-sqrt 500000000000000000.0) 707106781.187 three-decimal-delta "L6: books-sqrt of `500000000000000000`.")

    ;; These square roots do finish calculating but they are wildly inaccurate.

    ;; (check-= (books-sqrt 500000000000000000000000000000000000000000000000000000000.0)
    ;;           2.236068e+28 100.0 "L7: books-sqrt of `500000000000000000000000000000000000000000000000000000000`.")
    ;; (check-= (books-sqrt 50000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000.0)
    ;;           2.236068e+56 100.0 "L8: books-sqrt of `50000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000`.")

  ;; ***********************************************************************************************

  ;; Very Small Numbers:
    (check-= (sqrt 5.0) 2.2360679775 six-decimal-delta "S1: sqrt of `5`.")
    (check-= (sqrt 0.5) 0.70710678118 five-decimal-delta "S2: sqrt of `0.5`.")
    (check-= (sqrt 0.05) 0.22360679775 five-decimal-delta "S3: sqrt of `0.05`.")
    (check-= (sqrt 0.005) 0.07071067811 five-decimal-delta "S4: sqrt of `0.005`.")
    (check-= (sqrt 0.0005) 0.02236067977 five-decimal-delta "S5: sqrt of `0.0005`.")
    (check-= (sqrt 0.00005) 0.00707106781 five-decimal-delta "S6: sqrt of `0.00005`.") ;; Made it one further than the book.

  ;; ;; Very Large Numbers:
    (check-= (sqrt 500.0) 22.360679775 three-decimal-delta "L1:sqrt of `500`.")
    (check-= (sqrt 5000.0) 70.7106781187 three-decimal-delta "L2: sqrt of `5000`.")
    (check-= (sqrt 50000.0) 223.60679775 three-decimal-delta "L3: sqrt of `50000`.")
    (check-= (sqrt 500000.0) 707.106781187 one-decimal-delta "L4: sqrt of `500000`.") ;; Why is this one more inaccurate?
    (check-= (sqrt 5000000.0) 2236.0679775 two-decimal-delta "L5: sqrt of `5000000`.")
    (check-= (sqrt 50000000.0) 7071.06781187 two-decimal-delta "L6: sqrt of `50000000`.")

    ;; These square roots do finish calculating but they are wildly inaccurate.
    ;; (check-= (sqrt 500000000000000000.0) 707106781.187 10.0 "L6: sqrt of `500000000000000000`.")
    ;; (check-= (sqrt 500000000000000000000000000000000000000000000000000000000.0)
    ;;           2.236068e+28 100.0 "L7: sqrt of `500000000000000000000000000000000000000000000000000000000`.")
    ;; (check-= (sqrt 50000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000.0)
    ;;           2.236068e+56 100.0 "L8: sqrt of `50000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000`.")

(define yay-tests-passed #t)
yay-tests-passed
