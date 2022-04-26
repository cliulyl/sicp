#lang sicp
(define (tree-map proc tree)
    (map (lambda (subtree)
                 (if (pair? subtree)
                     (tree-map proc subtree)
                     (proc subtree)))
         tree)
)

(define (square x) (* x x))

(define (square-tree tree) (tree-map square tree))

(define x (list 1 (list 2 (list 3 4) 5) (list 6 7)))