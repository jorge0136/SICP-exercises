#lang racket/base

(require rackunit
          "SICP-exercise1.8.rkt")

  (define five-decimal-delta .00001)
  (define three-decimal-delta .001)

  (check-= (cube-root 0.8) 0.92831776672 three-decimal-delta "1: cube-root of `0.8`.")
  (check-= (cube-root 8.0) 2.0 five-decimal-delta "2: cube-root of `8.0`.")
  (check-= (cube-root 80.0) 4.30886938006 three-decimal-delta "3: cube-root of `80.0`.")
