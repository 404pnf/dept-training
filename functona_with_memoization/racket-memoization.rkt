#lang racket
(require (planet dherman/memoize:3:1))

(define (fib n)
    (if (<= n 1) 1 (+ (fib (- n 1)) (fib (- n 2)))))

;(time (fib 35))

(define/memo (fibo n)
      (if (<= n 1) 1 (+ (fibo (- n 1)) (fibo (- n 2)))))

(time (fibo 11135))