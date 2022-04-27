; ex5.3 in p349

; assuming good-enough? and improve are available ops
(controller
   (assign guess (const 1.0))
 test-guess
   (test (op good-enough) (reg guess))
   (branch (label sqrt-done))
   (assign guess (op improve) (reg guess))
   (goto (label test-guess))
 sqrt-done)

 ; using basic ops
(controller
   (assign guess (const 1.0))
 test-guess
   ; (test (op good-enough) (reg guess))
   (assign tmp (op *) (reg guess) (reg guess))
   (assign tmp (op -) (reg tmp) (reg x))
   (test (op >=) (reg tmp) (const 0))
   (branch (label got-abs))
   (assign tmp (op -) (reg tmp))
 got-abs
   (test (op <) (reg tmp) (const 0.001))
   ; --------

   (branch (label sqrt-done))
   ; (assign guess (op improve) (reg guess))
   (assign tmp (op /) (reg x) (reg guess))
   (assign tmp (op +) (reg guess) (reg tmp))
   (assign guess (op /) (reg tmp) (const 2))
   ; ---------

   (goto (label test-guess))
 sqrt-done)