#lang sicp
; part a
(meeting ?department (Friday ?time))

; part b
(rule (meeting-time ?person ?day-and-time)
    (or (meeting whole-company ?day-and-time)
        (and (job ?person (?department . ?job-detail))
             (meeting ?department ?day-and-time))))

; part c
(meeting-time (Hacker Alyssa P) (Wednesday ?time))