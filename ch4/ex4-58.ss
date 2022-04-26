#lang sicp
(rule (big-person ?p ?department)
    (and (job ?p (?department . ?job-detail))
         (or (not (supervisor ?p ?visor))
             (and (supervisor ?p ?visor)
                  (not (job ?visor (?department . ?visor-job-detail)))))))