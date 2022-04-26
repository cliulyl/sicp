#lang sicp

(#%require "ambeval.scm")

(easy-ambeval 10 '(begin

(define (require p)
  (if (not p) (amb)))

(define nouns '(noun student professor cat class meal))
(define verbs '(verb studies lectures eats sleeps))
(define articles '(article the a))
(define prepositions '(prep for to in by with))
(define adjectives '(adj nice good bad))

(define (length lst)
    (define (iter-base l ret)
        (if (null? l)
            ret
            (iter-base (cdr l) (+ ret 1))))
    (iter-base lst 0))

(define (generate-sentence n-word)
  (begin (set! *remaining-length* n-word)
         (let ((ret (append (generate-noun-phrase)
                            (generate-verb-phrase))))
              (begin (require (= (length ret) n-word))
                     (list 'sentence ret)))))

(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) (append (cdr list1) list2))))

(define (generate-noun-phrase)
  (define (maybe-extend noun-phrase)
    (amb noun-phrase
         (maybe-extend (append noun-phrase (generate-prepositional-phrase)))))
  (maybe-extend (generate-simple-noun-phrase)))

(define (generate-prepositional-phrase)
  (append (list (generate-word prepositions)) (generate-noun-phrase)))

(define (generate-verb-phrase)
  (define (maybe-extend verb-phrase)
    (amb verb-phrase
         (maybe-extend (append verb-phrase (generate-prepositional-phrase)))))
  (maybe-extend (list (generate-word verbs))))

(define (generate-simple-noun-phrase)
  (amb (list (generate-word articles)
             (generate-word nouns))
       (list (generate-word articles)
             (generate-word adjectives)
             (generate-word nouns))))

(define (an-element-of items)
  (require (not (null? items)))
  (amb (car items) (an-element-of (cdr items))))

(define (generate-word word-list)
    (begin (set! *remaining-length* (- *remaining-length* 1))
           (require (>= *remaining-length* 0))
           (an-element-of (cdr word-list))))

(define *remaining-length* 0)

))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(easy-ambeval 10 '(begin
                    (generate-sentence 10)
                    ))

