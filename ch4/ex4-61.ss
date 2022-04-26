#lang sicp

(#%require "queryeval.scm")

(initialize-data-base 
  '(
    (rule (?x next-to ?y in (?x ?y . ?u)))
    (rule (?x next-to ?y in (?v . ?z))
          (?x next-to ?y in ?z))
    ))

(easy-qeval (?x next-to ?y in (1 (2 3) 4)))
(easy-qeval (?x next-to 1 in (2 1 3 1)))