#lang racket
(define (make-account balance passwd)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  
  (define (dispatch try-passwd m)
    (if (eq? try-passwd passwd)
        (cond ((eq? m 'withdraw) withdraw)
            ((eq? m 'deposit) deposit)
            (else (error "Unknown request -- MAKE-ACCOUNT"
                        m)))
        incorrect))
  dispatch
)

(define (incorrect .args)  ; 为了能够接受参数amount而不报错，单独定义一个过程
    (display "Incorrect password"))

(define (make-joint account given-passwd another-passwd)
    (define (dispatch try-passwd m)
        (if (eq? try-passwd another-passwd)
            (account given-passwd m)
            incorrect))
    dispatch
)

(define peter-acc (make-account 100 'open-sesame))
(define paul-acc (make-joint peter-acc 'open-sesame 'rosebud))

((peter-acc 'open-sesame 'withdraw) 40)
((paul-acc 'rosebud 'deposit) 50)
((peter-acc 'open-sesame 'withdraw) 70)
((paul-acc 'open-sesame 'deposit) 50)