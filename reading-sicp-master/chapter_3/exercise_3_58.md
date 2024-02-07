## P231 - [练习 3.58]

[完整测试代码](./exercise_3_58.scm)

``` Scheme
(define (expand num den radix)
  (cons-stream
    (quotient (* num radix) den)
    (expand (remainder (* num radix) den) den radix)))
```

expand 其实在模拟手算的过程，计算分数在 n 进制中的小数数字。其中 num 表示分子(numerator), den 表示分母(denominator)，radix 表示进制。

比如 `(expand 1 7 10)`, 表示分数 1/7 在 10 进制中的小数数字。前 20 项为

```
(1 4 2 8 5 7 1 4 2 8 5 7 1 4 2 8 5 7 1 4)
```

而 `1/7 = 0.14285714285714`。多输出几位，前 40 项为

```
(1 4 2 8 5 7 1 4 2 8 5 7 1 4 2 8 5 7 1 4 2 8 5 7 1 4 2 8 5 7 1 4 2 8 5 7 1 4 2 8)
```
就表示 `1/7 = 0.1428571428571428571428571428571428571428`。可知 1/7 的小数数字在 142857 中不断循环。


同理 `(expand 3 8 10)`, 表示分数 3/8 在 10 进制中的小数数字。前 20 项为

```
(3 7 5 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
```

而 `3/8 = 0.375`。假如可以除尽，expand 计算出的后边数字就总是 0。

再测试 `(expand 71 7 10)`, 表示分数 71/7 在 10 进制中的小数数字。前 20 项为

```
(101 4 2 8 5 7 1 4 2 8 5 7 1 4 2 8 5 7 1 4)
```

而 `71/7 = 10.142857142857`。可知，expand 计算出的第一个数字 101, 其实是表示 10.1。
