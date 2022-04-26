#lang sicp
(#%require "queryeval.scm")

(initialize-data-base 
  '(
    (rule (append-to-form () ?y ?y))
    (rule (append-to-form (?u . ?v) ?y (?u . ?z))
          (append-to-form ?v ?y ?z))
          
    (rule (reverse (?x) (?x)))
    (rule (reverse (?u . ?v) ?rev)
        (and (reverse ?v ?v-rev)
             (append-to-form ?v-rev (?u) ?rev)))
    
    ))

(easy-qeval '(reverse (1 2 3) ?x))