#lang sicp

(define (analyze-if-fail exp)
    (let ((pproc (analyze (if-fail-predicate exp)))
          (aproc (analyze (if-fail-alternative exp))))
        (lambda (env succeed fail)
            (pproc env
                   (lambda (pred-value fail2)    ;;注意：这行及下一行，可以简化为succeed
                       (succeed pred-value fail2))
                   (lambda ()
                       (aproc env
                              (lambda (alter-value fail3) ;;注意：这行及下一行，可以简化为succeed
                                  (succeed alter-value fail3))
                              fail))))))

(define (if-fail? exp) (tagged-list? exp 'if-fail))

(define (if-fail-predicate exp) (cadr exp))

(define (if-fail-alternative exp) (caddr exp))
