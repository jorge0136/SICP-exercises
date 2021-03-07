#lang sicp

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

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

(list->tree '(1 3 5 7 9 11))
; 1) Partial tree is called initially with the elements and the elements length. If the elements are empty we return an empty list.
;    If they are not empty we calculate the left size as the overall size divided by 2. We then save the left tree result by calling partial
;    tree again with the elements and the left size. We bind three more variables, the left-tree which is the first of the left result,
;    the non left elements, which are the rest of the left result, and the right size which is the converse size of the left. We then bind
;    this-entry to the first of the non left elements and bind right results to a recursive call to partial tree again for the right side.
;    Simmilarlly to left tree, we bind the right tree to the first of the right results, and the remaining elemnts to the rest of the right
;    results. We finally create a tree for the level we are on by consing a call to make tree, this, left, right to the remaining elements.

;    To summerize this, we're recursivly finding the middle element by number of elements in the list, selecting that as the current element,
;    then distributing elements less than the midpoint to the left branch and elements greater than the midpoint to the right branch.
;    This results in a balenced tree being produced from the list.
;   

;                              5
;                            /   \
;                          1      9
;                           \    / \
;                            3  7  11

; 2) We need to visit partial-tree once for each element in the list. Since the operations in partial tree, car, cdr, quotient, cons and make tree,
;    are O(1), the total grown will be O(n) for the whole operation.