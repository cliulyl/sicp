#lang sicp
; part a
; ......
afterfib-n-2                        ; upon return, val contains Fib(n - 2)
  (restore n)                       ; n now contains Fib(n - 1)
  (restore continue)
  (assign val                       ; Fib(n - 2) + Fib(n - 1)
          (op +) (reg val) (reg n))
; .......

;part b
(define (make-save inst machine stack pc)
  (let ((reg (get-register machine
                           (stack-inst-reg-name inst))))
    (lambda ()
      (push stack (cons (stack-inst-reg-name inst) (get-contents reg)))
      (advance-pc pc))))

(define (make-restore inst machine stack pc)
  (let ((reg (get-register machine
                           (stack-inst-reg-name inst)))
        (reg-name (stack-inst-reg-name inst)))
    (lambda ()
      (let ((top (pop stack)))
          (if (eq? reg-name (car top))
              (begin (set-contents! reg (cdr top))
                     (advance-pc pc))
              (error "restore to a wrong reg" reg-name))))))

