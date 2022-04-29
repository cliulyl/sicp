#lang sicp
;; 关键思想，就是在machine里面用一个局部变量the-labels记录下所有的标号，并使用相应的过程来为它添加标号数据
;; 需要修改assemble以便返回labels。有助于理解assemble返回的值

(#%require "ch5-regsim.scm")
(#%require "ch5support.scm")

(redefine (make-new-machine)
  (let ((pc (make-register 'pc))
        (flag (make-register 'flag))
        (stack (make-stack))
        (the-instruction-sequence '())
        (trace #f)
        (the-labels '()))     ;;;;;; ++++++
    (let ((the-ops
            (list (list 'initialize-stack
                        (lambda () (stack 'initialize)))
                  ;;**next for monitored stack (as in section 5.2.4)
                  ;;  -- comment out if not wanted
                  (list 'trace-on   ;;;; +++++++
                        (lambda ()
                                (set! trace #t)))
                  (list 'trace-off  ;;;; ++++++
                        (lambda ()
                                (set! trace #f)))
                  (list 'print-stack-statistics
                        (lambda () (stack 'print-statistics)))))
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

      (define (set-breakpoint label-name n)    ;;;; +++++
        (let ((label-entry (assoc label-name the-labels))
              (breakpoint (make-breakpoint label-name n)))
            (if label-entry
                (set-inst-breakpoint! (list-ref (cdr label-entry) (- n 1)) breakpoint)
                (error "no such label" label-name))))
      (define (cancel-breakpoint label-name n)    ;;;; +++++
        (let ((label-entry (assoc label-name the-labels)))
            (if label-entry
                (cancel-inst-breakpoint (list-ref (cdr label-entry) (- n 1)))
                (error "no such label" label-name))))
      (define (cancle-all-breakpoints)       ;;;;; ++++++
        (for-each (lambda (inst)
                          (cancel-inst-breakpoint inst))
                  the-instruction-sequence))
      (define (print-breakpoint breakpoint)     ;;;; +++++
        (display "BREAKPOINT ")
        (display (car breakpoint))
        (display ": ")
        (display (cdr breakpoint))
        (newline))

      (define (execute)
        (let ((insts (get-contents pc)))
          (if (null? insts)
              'done
              (let ((breakpoint (get-inst-breakpoint (car insts))))   ;;;; modified
                (if (not (null? breakpoint))
                    (print-breakpoint breakpoint)
                    (begin
                        (cond (trace     ;;;; +++++++
                            (display (instruction-text (car insts)))
                            (newline)))
                        ((instruction-execution-proc (car insts)))
                        (execute)))))))
      (define (proceed)    ;;;;; ++++++
        (let ((inst (car (get-contents pc))))
          (cancel-inst-breakpoint inst)
          (execute)))

      (define (dispatch message)
        (cond ((eq? message 'start)
               (set-contents! pc the-instruction-sequence)
               (execute))
              ((eq? message 'install-instruction-sequence)
               (lambda (seq) (set! the-instruction-sequence seq)))
              ((eq? message 'install-labels)   ;;;; +++++
               (lambda (x) (set! the-labels x)))
              ((eq? message 'set-breakpoint)    ;;;; +++++
               (lambda (label-name n) (set-breakpoint label-name n)))
              ((eq? message 'cancel-breakpoint)    ;;;; +++++
               (lambda (label-name n) (cancel-breakpoint label-name n)))
              ((eq? message 'cancel-all-breakpoints) cancle-all-breakpoints) ;;;; ++++
              ((eq? message 'proceed) proceed)
              ((eq? message 'allocate-register) allocate-register)
              ((eq? message 'get-register) lookup-register)
              ((eq? message 'install-operations)
               (lambda (ops) (set! the-ops (append the-ops ops))))
              ((eq? message 'stack) stack)
              ((eq? message 'operations) the-ops)
              (else (error "Unknown request -- MACHINE" message))))
      dispatch)))

(define (set-breakpoint machine label-name n)
  ((machine 'set-breakpoint) label-name n))

(define (make-breakpoint name n)
    (cons name n))

(define (cancel-breakpoint machine label-name n)
  ((machine 'cancel-breakpoint) label-name n))

(define (cancel-all-breakpoints machine)
  ((machine 'cancel-all-breakpoints)))

(define (get-inst-breakpoint inst)
    (caddr inst))

(define (set-inst-breakpoint inst breakpoint)
    (set-car! (cddr inst) breakpoint))

(define (cancel-inst-breakpoint inst)
    (set-car! (cddr inst) '()))

(define (proceed-machine machine)
    ((machine 'proceed)))

;;; need to make changes in the ch5-regsim.scm
(define (make-machine register-names ops controller-text)
  (let ((machine (make-new-machine)))
    (for-each (lambda (register-name)
                ((machine 'allocate-register) register-name))
              register-names)
    ((machine 'install-operations) ops)    
    (let ((result (assemble controller-text machine)))
        ((machine 'install-instruction-sequence) (car result))
        ((machine 'install-labels) (cdr result)))
    machine))

(define (assemble controller-text machine)
  (extract-labels controller-text
                  (lambda (insts labels)
                    (update-insts! insts labels machine)
                    (cons insts labels))))

(define (make-instruction text)
  (list text '() '()))

(define (instruction-execution-proc inst)
  (cadr inst))

(define (set-instruction-execution-proc! inst proc)
  (set-car! (cdr inst) proc))
;;;; ------------

; to test 
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

(set-breakpoint fact-machine 'fact-loop 2)
(set-breakpoint fact-machine 'after-fact 4)

(cancel-all-breakpoints fact-machine)

(set-register-contents! fact-machine 'n 10)
(start fact-machine)
(get-register-contents fact-machine 'val)

; (proceed-machine fact-machine)
; (get-register-contents fact-machine 'val)