#lang sicp

(#%require "ch5-regsim.scm")
(#%require "ch5support.scm")

(redefine (make-new-machine)
  (let ((pc (make-register 'pc))
        (flag (make-register 'flag))
        (stack (make-stack))
        (the-instruction-sequence '())
        (trace #f))            ;;;; +++++++++++++
    (let ((the-ops
            (list (list 'initialize-stack
                        (lambda () (stack 'initialize)))
                  ;;**next for monitored stack (as in section 5.2.4)
                  ;;  -- comment out if not wanted
                  (list 'print-stack-statistics
                        (lambda () (stack 'print-statistics)))
                  (list 'trace-on   ;;;; +++++++
                        (lambda ()
                                (set! trace #t)))
                  (list 'trace-off  ;;;; ++++++
                        (lambda ()
                                (set! trace #f)))))
          (register-table
            (list (list 'pc pc) (list 'flag flag))))
      (define (allocate-register name)
        (if (assoc name register-table)
            (error "Multiply defined register: " name)
            (set! register-table
                  (cons (list name (make-register name))
                        register-table)))
        'register-allocated)
      (define (lookup-register name)
        (let ((val (assoc name register-table)))
          (if val
              (cadr val)
              (error "Unknown register:" name))))
      (define (execute)
        (let ((insts (get-contents pc)))
          (if (null? insts)
              'done
              (begin
                (cond (trace     ;;;; +++++++
                        (display (instruction-text (car insts)))
                        (newline)))   
                ((instruction-execution-proc (car insts)))
                (execute)))))
      (define (dispatch message)
        (cond ((eq? message 'start)
               (set-contents! pc the-instruction-sequence)
               (execute))
              ((eq? message 'install-instruction-sequence)
               (lambda (seq) (set! the-instruction-sequence seq)))
              ((eq? message 'allocate-register) allocate-register)
              ((eq? message 'get-register) lookup-register)
              ((eq? message 'install-operations)
               (lambda (ops) (set! the-ops (append the-ops ops))))
              ((eq? message 'stack) stack)
              ((eq? message 'operations) the-ops)
              (else (error "Unknown request -- MACHINE" message))))
      dispatch)))

; to test the moniter added above
(define fact-machine
  (make-machine
    '(continue n val)
    (list (list '= =)
          (list '- -)
          (list '* *)
          )
    '(
      (perform (op trace-on))
      (assign continue (label fact-done))     ; set up final return address
      fact-loop
      
      (test (op =) (reg n) (const 1))
      (branch (label base-case))
      ;; Set up for the recursive call by saving n and continue.
      ;; Set up continue so that the computation will continue
      ;; at after-fact when the subroutine returns.
      (save continue)
      (save n)
      (assign n (op -) (reg n) (const 1))
      (assign continue (label after-fact))
      (goto (label fact-loop))
      after-fact
      (restore n)
      (restore continue)
      (assign val (op *) (reg n) (reg val))   ; val now contains n(n - 1)!
      (goto (reg continue))                   ; return to caller
      base-case
      (assign val (const 1))                  ; base case: 1! = 1
      (goto (reg continue))                   ; return to caller
      fact-done
      )))

(define (loop)
    (newline)
    (display "please input n:")
    (newline)
    (let ((n (read)))
        (set-register-contents! fact-machine 'n n)
        (start fact-machine)
        (let ((ret (get-register-contents fact-machine 'val)))
            (newline)
            (display (list "fact of n is" ret)))
        (loop)))

(loop)
