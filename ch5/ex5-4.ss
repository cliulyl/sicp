; part a
(controller
   (assign continue (label expon-done))

 expon-loop
   (test (op =) (reg n) (const 0))
   (branch (label basic-case))
   (save continue)
   (assign continue (label after-expon))
   ; (save n)   ; 这里save和restore（下文）没有任何必要
   (assign n (op -) (reg n) (const 1))
   (goto (label expon-loop))

 after-expon
   ; (restore n)
   (restore continue)
   (assign val (op *) (reg val) (reg b))
   (goto (reg continue))
 
 basic-case
   (assign val (const 1))
   (goto (reg continue))
 expon-done)
 
 ; part b
(controller
   (assign counter (reg n))  ; 这里其实也不需要n和counter两个寄存器，保留一个即可
   (assign product (const 1))

expon-loop
   (test (op =) (reg counter) (const 0))
   (branch (label expon-done))
   (assign counter (op -) (reg counter) (const 1))
   (assign product (op *) (reg b) (reg product))
   (goto (label expon-loop))
 expon-done)
