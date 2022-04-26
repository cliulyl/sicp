#lang sicp
(define (a-pythagorean-starting-from n)
  (let ((k (an-integer-starting-from (+ n 1))))
    (let ((j (an-integer-between n k)))
      (let ((i (an-integer-between n j)))
        (require (= (+ (* i i) (* j j)) (* k k)))
        (list i j k)))))