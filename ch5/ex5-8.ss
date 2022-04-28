#lang sicp
(#%require "ch5-regsim.scm")

; part a
(define there-machine
  (make-machine
    '(a)
    '()
    '(start
        (goto (label here))
      here
        (assign a (const 3))
        (goto (label there))
      here
        (assign a (const 4))
        (goto (label there))
      there)))

(start there-machine)

(get-register-contents there-machine 'a)

; part b
(define (extract-labels text receive)
  (if (null? text)
      (receive '() '())
      (extract-labels (cdr text)
                      (lambda (insts labels)
                        (let ((next-inst (car text)))
                          (if (symbol? next-inst)
                              (if (assoc next-inst labels)
                                  (error "Duplicated labels!" next-inst)
                                  (receive insts
                                           (cons (make-label-entry next-inst
                                                                   insts)
                                             labels)))
                              
                              (receive (cons (make-instruction next-inst)
                                             insts)
                                       labels)))))))

