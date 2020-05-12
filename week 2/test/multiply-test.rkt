#lang racket/base

(require rackunit
         "multiply.rkt")
(define yay-tests-passed #t)

(check-equal? (sum 2 2) 4 "Simple addition")
(check-equal? (multiply 1 2) 2 "Simple multiplication")

yay-tests-passed