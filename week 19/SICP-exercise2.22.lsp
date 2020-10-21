#lang sicp
;; Exercise 2.22.  Louis Reasoner tries to rewrite the first square-list procedure of exercise 2.21 so that it evolves an iterative process:

;; (define (square-list items)
;;   (define (iter things answer)
;;     (if (null? things)
;;         answer
;;         (iter (cdr things)
;;               (cons (square (car things))
;;                     answer))))
;;   (iter items nil))

;; Unfortunately, defining square-list this way produces the answer list in the reverse order of the one desired. Why?

 ;; Cause it's backwards! It `cons`es the last item from the front of the list to the answer, then gets the next item from the front, etc. 

;; Louis then tries to fix his bug by interchanging the arguments to cons:

;; (define (square-list items)
;;   (define (iter things answer)
;;     (if (null? things)
;;         answer
;;         (iter (cdr things)
;;               (cons answer
;;                     (square (car things))))))
;;   (iter items nil))

;; This doesn't work either. Explain.


;; The reason why is that it keeps new upping a list each time. We saw this in 2.17 as an example. 