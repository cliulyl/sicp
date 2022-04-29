#lang sicp

(#%require "ch5-regsim.scm")

(define fact-machine
  (make-machine
    '(continue n val)
    (list (list '= =)
          (list '- -)
          (list '* *)
          )
    '(
      (perform (op initialize-stack))
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
      (perform (op print-stack-statistics))
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