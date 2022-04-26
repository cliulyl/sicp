#lang racket
(require ( planet "sicp.ss" ( "soegaard" "sicp.plt" 2 1)))

;;;;;; libs
; (define (frame-coord-map frame)
;   (lambda (v)
;     (add-vect
;      (origin-frame frame)
;      (add-vect (scale-vect (xcor-vect v)
;                            (edge1-frame frame))
;                (scale-vect (ycor-vect v)
;                            (edge2-frame frame))))))

; (define (segments->painter segment-list)
;   (lambda (frame)
;     (for-each
;      (lambda (segment)
;        (draw-line
;         ((frame-coord-map frame) (start-segment segment))
;         ((frame-coord-map frame) (end-segment segment))))
;      segment-list)))

; ;;;;;;;

; ;;;; vector (ex2-46)
; (define (make-vect x y) (cons x y))

; (define (xcor-vect v) (car v))

; (define (ycor-vect v) (cdr v))

; (define (add-vect v1 v2)
;     (make-vect (+ (xcor-vect v1) (xcor-vect v2))
;                (+ (ycor-vect v1) (ycor-vect v2)))
; )

; (define (sub-vect v1 v2)
;     (make-vect (- (xcor-vect v1) (xcor-vect v2))
;                (- (ycor-vect v1) (ycor-vect v2)))
; )

; (define (scale-vect s v)
;     (make-vect (* s (xcor-vect v))
;                (* s (ycor-vect v)))
; )
; ;;;;;

; ;;;;; frame (ex2-47)
; (define (make-frame origin edge1 edge2)
;   (list origin edge1 edge2))

; (define (origin-frame frame) (car frame))

; (define (edge1-frame frame) (cadr frame))

; (define (edge2-frame frame) (caddr frame))
; ;;;;;;;

; ;;;;; segment (ex2-48)
; (define (make-segment s e) (cons s e))

; (define (start-segment seg) (car seg))

; (define (end-segment seg) (cdr seg))
; ;;;;;;

; part a
(define border-painter (segments->painter (list (make-segment (make-vect 0 0) (make-vect 0 1))
                                                (make-segment (make-vect 0 1) (make-vect 1 1))
                                                (make-segment (make-vect 1 1) (make-vect 1 0))
                                                (make-segment (make-vect 1 0) (make-vect 0 0)))))