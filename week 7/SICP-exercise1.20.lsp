; Exercise 1.20: The process that a procedure generates is of course dependent on the rules used by
; the interpreter. As an example, consider the iterative gcd procedure given above. Suppose we were
; to interpret this procedure using normal-order evaluation, as discussed in 1.1.5. (The
; normal-order-evaluation rule for if is described in Exercise 1.5.) Using the substitution method
; (for normal order), illustrate the process generated in evaluating (gcd 206 40) and indicate the
; remainder operations that are actually performed. How many remainder operations are actually
; performed in the normal-order evaluation of (gcd 206 40)? In the applicative-order evaluation?

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

;Normal order

(gcd 206 40)
(if (= 40 0)
  206
  (gcd 40 (remainder(206 40))))

(gcd 40 (remainder(206 40)))

(if (= 0 (remainder(206 40)))
  40
  (gcd
    (remainder(206 40))
    (remainder 40 (remainder(206 40)))))

(if (= 0 6)   ;  1 remainder evaluated
  40
  (gcd
    (remainder(206 40))
    (remainder 40 (remainder(206 40)))))

  (gcd
    (remainder(206 40))
    (remainder 40 (remainder(206 40))))

(if (= 0 (remainder 40 (remainder(206 40)))))
  (remainder(206 40))
  (gcd
    (remainder 40 (remainder(206 40)))
    (remainder
      (remainder(206 40))
      (remainder 40 (remainder(206 40)))))

(if (= 0 4)) ; 2 remainders evaluated
  (remainder(206 40))
  (gcd
    (remainder 40 (remainder(206 40)))
    (remainder
      (remainder(206 40))
      (remainder 40 (remainder(206 40)))))

  (gcd
    (remainder 40 (remainder(206 40)))
    (remainder
      (remainder(206 40))
      (remainder 40 (remainder(206 40)))))

(if (= 0 (remainder
                 (remainder(206 40))
                       (remainder 40 (remainder(206 40)))))
  (remainder 40 (remainder(206 40)))
  (gcd
    (remainder
            (remainder(206 40))
                  (remainder 40 (remainder(206 40))))
    (remainder
      (remainder 40 (remainder(206 40)))
      (remainder
              (remainder(206 40))
                    (remainder 40 (remainder(206 40)))))))

(if (= 0 2) ; 4 remainders evaluated
  (remainder 40 (remainder(206 40)))
  (gcd
    (remainder (remainder(206 40)) (remainder 40 (remainder(206 40))))
    (remainder
      (remainder 40 (remainder(206 40)))
      (remainder (remainder(206 40)) (remainder 40 (remainder(206 40)))))))

  (gcd
    (remainder (remainder(206 40)) (remainder 40 (remainder(206 40))))
    (remainder (remainder 40 (remainder(206 40))) (remainder (remainder(206 40)) (remainder 40 (remainder(206 40))))))

(if (= 0 0) ; 7 remainders evaluated
    (remainder (remainder(206 40)) (remainder 40 (remainder(206 40))))
    (gcd
      (remainder (remainder 40 (remainder(206 40)))
                 (remainder (remainder(206 40)) (remainder 40 (remainder(206 40)))))
      (remainder (remainder (remainder(206 40)) (remainder 40 (remainder(206 40))))
                 (remainder (remainder 40 (remainder(206 40)))
                 (remainder (remainder(206 40)) (remainder 40 (remainder(206 40))))))))

(remainder (remainder(206 40)) (remainder 40 (remainder(206 40)))) ; 4 remainding remainders evaluated

1 + 2 + 4 +7 +4 = 18 remainders evaluated

;Applicative order

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(gcd 206 40)
(if (= 40 0)
  206
 (gcd 40 (remainder 206 40)))

 (gcd 40 (remainder 206 40))

(gcd 40 6) ; 1st remainder evaluated

(if (= 0 6)
  40
  (gcd 6 (remainder 40 6))
  )

(gcd 6 4) ; 2nd remainder evaluated

(if (= 0 4)
  6
  (gcd 4 (remainder 6 4)))

(gcd 4 (remainder 6 4))
(gcd 4 2) ; 3rd remainder evaluated

(if (= 0 2)
  4
  (gcd 2 (remainder 4 2)))

(gcd 2 (remainder 4 2))

(gcd 2 0) ; 4th remainder evaluated

(if (= 0 0)
  2
  (gcd 0 (remainder 2 0)))

= 2 ; 4 remainders evaluated
