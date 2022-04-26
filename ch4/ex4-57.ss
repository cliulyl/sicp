#lang sicp
(rule (substitude ?a ?b)
    (and (job ?a ?a-job)
         (job ?b ?b-job)
         (or (can-do-job ?a-job ?b-job)
             (same ?a-job ?b-job))
         (not (same ?a ?b))))
