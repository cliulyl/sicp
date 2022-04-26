#lang sicp

(define (scan-base vars vals var null-op find-op)
    (cond ((null? vars) (null-op))
          ((eq? var (car vars)) (find-op vars vals))
          (else (scan-base (cdr vars) (cdr vals) var null-op find-op))))

(define (lookup-variable-value var env)
    (define (env-loop env)
        (if (eq? env the-empty-environment)
            (error "Unbound variable" var)
            (let ((frame (first-frame env)))
                 (scan-base (frame-variables frame)
                            (frame-values frame)
                            var
                            (lambda () (env-loop (enclosing-environment env)))
                            (lambda (vars vals) (car vals))))))
    (env-loop env))

(define (set-variable-value! var val env)
    (define (env-loop env)
        (if (eq? env the-empty-environment)
            (error "Unbound variable -- SET!" var)
            (let ((frame (first-frame env)))
                 (scan-base (frame-variables frame)
                            (frame-values frame)
                            var
                            (lambda () (env-loop (enclosing-environment env)))
                            (lambda (vars vals) (set-car! vals val))))))
    (env-loop env))

(define (define-variable! var val env)
    (let ((frame (first-frame env)))
        (scan-base (frame-variables frame)
                   (frame-values frame)
                   var
                   (lambda () (add-binding-to-frame! var val frame))
                   (lambda (vars vals) (set-car! vals val)))))