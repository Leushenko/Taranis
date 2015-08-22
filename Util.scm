
;; General Utilities:
;; This file defines simple, generic macros and procedures that are of use
;; in more than one compiler module.

(define-macro (when c . b)
  `(if ,c (begin ,@b #!void) #!void) )
(define-macro (unless c . b)
  `(if ,c #!void (begin ,@b #!void)) )

(define-macro (while c . b)    ;procedural-style while loop
  `(let *while-loop* ()
    (if ,c
      (begin ,@b (*while-loop*))
      #!void) ))

;; These were appearing surprisingly often as lambdas - this is shorter
(define (id x) x)
(define (fst one two) one)
(define (snd one two) two)
(define (mid one two three) two)

(define (remp pred lst)      ;Useful func from R6RS
  (define (r-inner p src dst)
    (if (eq? src '())
        dst
        (if (p (car src))
            (r-inner p (cdr src) dst)
            (r-inner p (cdr src) (append dst (cons (car src) '()))))))
  (r-inner pred lst '()))

(define (string-downcase s)  ;Destructive string-to-lower function
  (let ((l (string-length s)))
    (do ((i 0 (fx+ 1 i)))
        ((fx= i l) s)
        (string-set! s i (char-downcase (string-ref s i))))))
