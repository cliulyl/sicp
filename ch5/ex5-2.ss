; ex5.2 in p348

(controller
   (assign product (const 1))
   (assign counter (const 1))
 test-c
   (test (op >) (reg counter) (reg n))
   (branch (label factorial-done))
   (assign product (op *) (reg product) (reg counter))
   (assign counter (op +) (reg counter) (const 1))
   (goto (label test-c))
 factorial-done)