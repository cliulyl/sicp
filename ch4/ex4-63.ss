#lang sicp

(#%require "queryeval.scm")

(initialize-data-base 
  '(
    (son Adam Cain)
    (son Cain Enoch)
    (son Enoch Irad)
    (son Irad Mehujael)
    (son Mehujael Methushael)
    (son Methushael Lamech)
    (wife Lamech Ada)
    (son Ada Jabal)
    (son Ada Jubal)

    (rule (grandson ?g ?s)
        (and (general-son ?g ?p)
             (general-son ?p ?s)))
    (rule (general-son ?man ?s)
        (or (son ?man ?s)
            (and (son ?woman ?s)
                 (wife ?man ?woman))))
    ))

(easy-qeval '(grandson Cain ?son))

(easy-qeval '(general-son Lamech ?son))

(easy-qeval '(grandson Methushael ?son))


