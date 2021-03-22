#lang sicp
(#%require sicp-pict)

(define (beside painter1 painter2)
  (let ((split-point (make-vect 0.5 0.0)))
    (let ((paint-left  (transform-painter 
                        painter1
                        (make-vect 0.0 0.0)
                        split-point
                        (make-vect 0.0 1.0)))
          (paint-right (transform-painter
                        painter2
                        split-point
                        (make-vect 1.0 0.0)
                        (make-vect 0.5 1.0))))
      (lambda (frame)
        (paint-left frame)
        (paint-right frame)))))

(define (rotate-90-counter-clockwise painter)
  (transform-painter painter
                     (make-vect 1.0 0.0)
                     (make-vect 1.0 1.0)
                     (make-vect 0.0 0.0)))

(define (rotate-90-clockwise painter)
  (transform-painter painter
                     (make-vect 0.0 1.0)
                     (make-vect 0.0 0.0)
                     (make-vect 1.0 1.0)))

(define (rotate-270 painter)

  (transform-painter 
   painter
   (make-vect 1.0 0.0)   ; new origin
   (make-vect 1.0 1.0)   ; new end of edge1
   (make-vect 0.0 0.0))) ; new end of edge2

(define (below painter1 painter2)
  (let ((split-point (make-vect 0.0 0.5)))
    (let ((paint-bottom  (transform-painter 
                          painter1
                          (make-vect 0.0 0.0)
                          (make-vect 1.0 0.0)
                          split-point
                          ))
          (paint-top (transform-painter
                      painter2
                      split-point
                      (make-vect 1.0 0.5)
                      (make-vect 0.0 1.0))))
      (lambda (frame)
        (paint-top frame)
        (paint-bottom frame)
        ))))

(define (below-2 painter1 painter2)
  (rotate-90-counter-clockwise (beside (rotate-90-clockwise painter1)
                                       (rotate-90-clockwise painter2))))

(paint (below einstein einstein))
(paint (below-2 einstein einstein))