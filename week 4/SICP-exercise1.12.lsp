;; Exercise 1.12.  The following pattern of numbers is called Pascal's triangle.

;;     1
;;    1 1
;;   1 2 1
;;  1 3 3 1
;; 1 4 6 4 1

;; The numbers at the edge of the triangle are all 1, and each number inside the triangle is the sum of the two numbers above it.
;; Write a procedure that computes elements of Pascal's triangle by means of a recursive process.

(define (pascals-triangulator depth)
         ;; TODO: Pick up here and finish formatting. Need to flip the triangle too. 
         (display (~a (expt 11 depth) #:min-width (+ depth 4) #:align 'center #:left-pad-string " " #:right-pad-string " "))
         (display "\n")
         (if (> depth 1)
             (pascals-triangulator (- depth 1))
             (display 1)))

(pascals-triangulator 4)

