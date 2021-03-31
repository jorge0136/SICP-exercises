#lang sicp

(define (make-table)
  (let ((local-table (list '*table*)))
    (define (lookup key-1 key-2)
      (let ((subtable (assoc key-1 (cdr local-table))))
        (if subtable
            (let ((record (assoc key-2 (cdr subtable))))
              (if record
                  (cdr record)
                  false))
            false)))
    (define (insert! key-1 key-2 value)
      (let ((subtable (assoc key-1 (cdr local-table))))
        (if subtable
            (let ((record (assoc key-2 (cdr subtable))))
              (if record
                  (set-cdr! record value)
                  (set-cdr! subtable
                            (cons (cons key-2 value)
                                  (cdr subtable)))))
            (set-cdr! local-table
                      (cons (list key-1
                                  (cons key-2 value))
                            (cdr local-table)))))
      'ok)    
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            (else (error "Unknown operation -- TABLE" m))))
    dispatch))

(define operation-table (make-table))
(define get (operation-table 'lookup-proc))
(define put (operation-table 'insert-proc!))


; Exercise 2.74.  Insatiable Enterprises, Inc., is a highly decentralized conglomerate company
; consisting of a large number of independent divisions located all over the world. The company's
; computer facilities have just been interconnected by means of a clever network-interfacing scheme
; that makes the entire network appear to any user to be a single computer. Insatiable's president,
; in her first attempt to exploit the ability of the network to extract administrative information
; from division files, is dismayed to discover that, although all the division files have been
; implemented as data structures in Scheme, the particular data structure used varies from division
; to division. A meeting of division managers is hastily called to search for a strategy to
; integrate the files that will satisfy headquarters' needs while preserving the existing autonomy
; of the divisions.

; Show how such a strategy can be implemented with data-directed programming. As an example,
; suppose that each division's personnel records consist of a single file, which contains a set of
; records keyed on employees' names. The structure of the set varies from division to division.
; Furthermore, each employee's record is itself a set (structured differently from division to
; division) that contains information keyed under identifiers such as address and salary. In
; particular:

; a.  Implement for headquarters a get-record procedure that retrieves a specified employee's
; record from a specified personnel file. The procedure should be applicable to any division's
; file. Explain how the individual divisions' files should be structured. In particular, what type
; information must be supplied?

; The type information can be distilled down to a single symbol. 
; Let's assume that symbol is a divsion signifer that has been placed at the head of each record. 
(define (division record) (car record))
(define (get-record personnel-file name)
  ; nil protection guard clause goodness goes here in the real world. 
  ((get 'get-employee-by-name (division (car personnel-file))) personnel-file name)) 

; ** NY **
(define (NY-make-record salary name address) (list 'NY salary name address))
(define (NY-name record) (caddr record))
; Example records: 
(define NY-record-harriet (NY-make-record 100 "Harriet" "36 harriet rd" ))
(define NY-record-kevin (NY-make-record 200 "Kevin" "12 short dr"))
(define NY-record-victor (NY-make-record 300 "Victor" "11 gangster ave"))
; A-Z order (Note this set could be organized a lot more optimally but that isn't the point of the exercise.)
(define NY-OFFICE (list NY-record-harriet NY-record-kevin NY-record-victor))

(define (install-NY)
  ; Ideally we would key by ID rather than name. I committed to name early, rolling with it.
  ; Also, there is no error handling if the employee doesn't exist, again not point of the exercise. 
  (define (get-employee-by-name personnel-file name)
    (cond ((null? personnel-file) false)
          ((equal? (NY-name (car personnel-file)) name) (car personnel-file))
          (else (get-employee-by-name (cdr personnel-file) name))))
  (put 'get-employee-by-name 'NY get-employee-by-name)
  'done)

; ** LA **
(define (LA-make-record address name salary) (list 'LA address name salary))
(define (LA-name record) (caddr record))
; Example records:
(define LA-record-phil (LA-make-record "99 percent dr" "Phil" 100))
(define LA-record-jill (LA-make-record "44 hell-ya rd" "Jill" 300))
(define LA-record-bill (LA-make-record "1212 fremont ave" "Bill" 200))
; Z-A order
(define LA-OFFICE (list LA-record-phil LA-record-jill LA-record-bill))

(define (install-LA)
  (define (get-employee-by-name personnel-file name)
    (cond ((null? personnel-file) false)
          ((equal? (LA-name (car personnel-file)) name) (car personnel-file))
          (else (get-employee-by-name (cdr personnel-file) name))))
  (put 'get-employee-by-name 'LA get-employee-by-name)
  'done)

(install-NY)
(install-LA)
(get-record NY-OFFICE "Harriet")
(get-record NY-OFFICE "Jill")

(get-record LA-OFFICE "Jill")
(get-record LA-OFFICE "Harriet")

; b.  Implement for headquarters a get-salary procedure that returns the salary information from a
; given employee's record from any division's personnel file. How should the record be structured
; in order to make this operation work?

(define (get-salary personnel-file name)
  ; nil protection guard clause goodness goes here in the real world. 
  ((get 'get-salary-by-name (division (car personnel-file))) personnel-file name))

; ** LA **
; Scoping choice for these depedent procedures is interesting food for thought. 
(define (LA-salary record) (cadddr record))

(define (install-LA-salary)
  (define (get-salary-by-name personnel-file name)
    (if (equal? (LA-name (car personnel-file)) name)
        (LA-salary (car personnel-file))
        (get-salary-by-name (cdr personnel-file) name))) 
  (put 'get-salary-by-name 'LA get-salary-by-name)
  'done)

; ** NY **
(define (NY-salary record) (cadr record))

; This is starting to feel repetitive when all that is changing is the selectors and symbols.
; There is more opportunity to continuing to abstracting this out further. 
(define (install-NY-salary)
  (define (get-salary-by-name personnel-file name)
    (if (equal? (NY-name (car personnel-file)) name)
        (NY-salary (car personnel-file))
        (get-salary-by-name (cdr personnel-file) name))) 
  (put 'get-salary-by-name 'NY get-salary-by-name)
  'done)

(install-NY-salary)
(install-LA-salary)
(get-salary NY-OFFICE "Harriet")
(get-salary LA-OFFICE "Jill")

; c.  Implement for headquarters a find-employee-record procedure. This should search all the
; divisions' files for the record of a given employee and return the record. Assume that this
; procedure takes as arguments an employee's name and a list of all the divisions' files.

(define personnel-data-base (list NY-OFFICE LA-OFFICE))
(define (get-record-company-wide personnel-data-base name)
  (let
      ((current-office (car (car personnel-data-base)))
       (office-results ((get 'get-employee-by-name (division (car (car personnel-data-base)))) (car personnel-data-base) name)))
    (if (not (equal? #f office-results))
        office-results 
        (get-record-company-wide (cdr personnel-data-base) name))))

(get-record-company-wide personnel-data-base  "Harriet")
(get-record-company-wide personnel-data-base  "Jill")

; d.  When Insatiable takes over a new company, what changes must be made in order to incorporate
; the new personnel information into the central system?

; Decide on a divisions symbolic representation. 
; Build selectors for records different values.
; Create get-x methods and install those in a package.
; Add the new personell file into the `personnel-data-base`.

