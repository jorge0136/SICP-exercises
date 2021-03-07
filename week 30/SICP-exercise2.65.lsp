#lang sicp


(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((= x (entry set)) true)
        ((< x (entry set))
         (element-of-set? 
          x 
          (left-branch set)))
        ((> x (entry set))
         (element-of-set? 
          x 
          (right-branch set)))))

(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list 
         (left-branch tree)
         (cons (entry tree)
               (copy-to-list 
                (right-branch tree)
                result-list)))))
  (copy-to-list tree '()))

(define (list->tree elements)
  (car (partial-tree 
        elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size 
             (quotient (- n 1) 2)))
        (let ((left-result 
               (partial-tree 
                elts left-size)))
          (let ((left-tree 
                 (car left-result))
                (non-left-elts 
                 (cdr left-result))
                (right-size 
                 (- n (+ left-size 1))))
            (let ((this-entry 
                   (car non-left-elts))
                  (right-result 
                   (partial-tree 
                    (cdr non-left-elts)
                    right-size)))
              (let ((right-tree 
                     (car right-result))
                    (remaining-elts 
                     (cdr right-result)))
                (cons (make-tree this-entry 
                                 left-tree 
                                 right-tree)
                      remaining-elts))))))))

(define (union-set set1 set2)
  (define (union s1 s2)
    (cond ((null? s1) s2)
          ((null? s2) s1)
          (else (let ((x1 (car s1)) (x2 (car s2)))
                  (cond ((= x1 x2) (cons x1 (union (cdr s1) (cdr s2))))
                        ((< x1 x2) (cons x1 (union (cdr s1) s2)))
                        ((> x1 x2) (cons x2 (union s1 (cdr s2)))))))))

  (list->tree (union (tree->list-2 set1) (tree->list-2 set2))))

(union-set (list->tree '()) (list->tree '())) ;=> ()
(union-set (list->tree '()) (list->tree '(1 2))) ;=> (1 () (2 () ()))
(union-set (list->tree '(1 2)) (list->tree '())) ;=> (1 () (2 () ()))
(union-set (list->tree '(1 2)) (list->tree '(1 2))); (1 () (2 () ()))
(union-set (list->tree '(1 2)) (list->tree '(3 4))) ; => (2 (1 () ()) (3 () (4 () ())))
(union-set (list->tree '(1 2)) (list->tree '(2 3))); => (2 (1 () ()) (3 () ()))
(union-set (list->tree '(3 4)) (list->tree '(2 3))) ; => (3 (2 () ()) (4 () ()))
(union-set (list->tree '(1 2 3 4)) (list->tree '(2 3 4 5))) ;=> (3 (1 () (2 () ())) (4 () (5 () ())))

(define (intersection-set s1 s2)
  (define (intersection set1 set2)
    (if (or (null? set1) (null? set2))
        '()
        (let ((x1 (car set1)) (x2 (car set2)))
          (cond ((= x1 x2)
                 (cons x1 (intersection
                           (cdr set1)
                           (cdr set2))))
                ((< x1 x2) (intersection 
                            (cdr set1) 
                            set2))
                ((< x2 x1) (intersection 
                            set1 
                            (cdr set2)))))))
  (list->tree (intersection (tree->list-2 s1) (tree->list-2 s2))))

(intersection-set (list->tree '(1 2 3)) (list->tree '(1 2 3))) ; =>  (2 (1 () ()) (3 () ()))
(intersection-set (list->tree '(1 2 3)) (list->tree '())) ; =>  ()
(intersection-set (list->tree '()) (list->tree '(1 2 3))) ; =>  ()
(intersection-set (list->tree '(1 2 3)) (list->tree '(2 3 4))) ; =>  (2 () (3 () ()))
(intersection-set (list->tree '(4 5 6)) (list->tree '(2 3 4))) ; =>  (4 () ())
(intersection-set (list->tree '(1 2 2 2 6)) (list->tree '(1 2 6 8))) ; =>  (2 (1 () ()) (6 () ()))
