; MIT License
;
; Copyright (c) 2020 Conor Hoekstra
;
; Permission is hereby granted, free of charge, to any person obtaining a copy
; of this software and associated documentation files (the "Software"), to deal
; in the Software without restriction, including without limitation the rights
; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
; copies of the Software, and to permit persons to whom the Software is
; furnished to do so, subject to the following conditions:
;
; The above copyright notice and this permission notice shall be included in all
; copies or substantial portions of the Software.
;
; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
; SOFTWARE.

#lang racket

(module+ test
  (require rackunit))

(provide
  adjacent-map
  all?
  any?
  chunk-by
  chunks-of
  generate
  increasing?
  init
  juxt
  repeat
  replicate
  product
  scanl
  scanr
  sliding
  sorted?
  sum
  tail
  zip
  zip-with)


(define (adjacent-map f lst)
  (zip-with f (init lst) (tail lst)))


(define (all? lst)
  (andmap identity lst))


(define (any? lst)
  (ormap identity lst))


(define (chunk-by pred lst)
  (letrec ([aux (λ (lst chunk result)
                  (cond [(null? lst) (reverse (cons (reverse chunk) result))]
                        [(null? (cdr lst)) (reverse (cons (reverse (cons (car lst) chunk)) result))]
                        [(pred (car lst) (cadr lst)) (aux (cdr lst) (cons (car lst) chunk) result)]
                        [else (aux (cdr lst) '() (cons (reverse (cons (car lst) chunk)) result))]))])
    (aux lst '() '())))


(define (chunks-of lst k)
  (sliding lst k k))


(define (generate n proc)
  (for/list ((_ n)) (proc)))


(define (increasing? lst)
  (all? (adjacent-map < lst)))


(define (init lst)
  (drop-right lst 1))


(define (juxt . procs)
  (λ args
    (map (λ (proc) (apply proc args)) procs)))


(define (product lst)
  (foldl * 1 lst))


(define repeat make-list)


(define (replicate lst lst2)
  (flatten (zip-with make-list lst lst2)))


(define (sliding lst size [step 1])
  (when (or (<= step 0) (> step (length lst)))
    (error "step has to be equal to or smaller than the length of the list"))

  (let recur [(lst lst)
              (len (length lst))]
    (if (>= len size)
      (cons (take lst size)
            (recur (drop lst step)
                   (- len step)))
      empty)))


(define (scanl proc lst)
  (foldl
   (λ (val acc)
     (append acc (list (proc val (last acc)))))
   (list (first lst))
   (rest lst)))


(define (scanr proc lst)
  (foldl
   (λ (a acc)
     (cond ((null? acc) (cons a acc))
           (else (cons (proc a (car acc)) acc))))
   '()
   (reverse lst)))


(define (sorted? lst)
  (all? (adjacent-map <= lst)))


(define (sum lst)
  (foldl + 0 lst))


(define tail cdr)


(define (zip lst . lsts)
  (apply map list lst lsts))


(define (zip-with proc list1 . lists)
  (apply map proc list1 lists))


(module+ test
  ;; Any code in this `test` submodule runs when this file is run using DrRacket
  ;; or with `raco test`. The code here does not run when this file is
  ;; required by another module.

  ;; Unit tests for adjacent-map
  (check-equal? (adjacent-map + (range 5)) '(1 3 5 7))
  (check-equal? (adjacent-map - (range 5)) (repeat 4 -1))
  (check-equal? (adjacent-map * (range 5)) '(0 2 6 12))

  ;; Unit tests for all?
  (check-equal? (all? '()) #t)
  (check-equal? (all? '(#t)) #t)
  (check-equal? (all? '(#t #t #t #t)) #t)
  (check-equal? (all? '(#t #t #t #f)) #f)
  (check-equal? (all? (map positive? '(1 2 3))) #t)
  (check-equal? (all? (map positive? (range 3))) #f)

  ;; Unit tests for any?
  (check-equal? (any? '()) #f)
  (check-equal? (any? '(#t)) #t)
  (check-equal? (any? '(#f #f #f #t)) #t)
  (check-equal? (any? '(#f #f)) #f)
  (check-equal? (any? (map positive? '(-1 -2 3))) #t)
  (check-equal? (any? (map positive? (range 2))) #t)

  ;; Unit tests for chunk-by
  (check-equal? (chunk-by eq? '(1 1 3 2 2)) '((1 1) (3) (2 2)))
  (check-equal? (chunk-by < '(1 2 1 3 4 3)) '((1 2) (1 3 4) (3)))

  ;; Unit tests for chunks-of
  (check-equal? (chunks-of '(1 2 1 3 4 3) 2) '((1 2) (1 3) (4 3)))
  (check-equal? (chunks-of '(1 2 1 3 4 3) 3) '((1 2 1) (3 4 3)))

  ;; Unit tests for generate
  (check-equal? (generate 3 (λ () 1)) '(1 1 1))
  (check-equal? (generate 0 (λ () 1)) '())

  ;; Unit tests for increasing?
  (check-equal? (increasing? '(1)) #t)
  (check-equal? (increasing? '(1 2)) #t)
  (check-equal? (increasing? '(1 1)) #f)
  (check-equal? (increasing? (range 10)) #t)
  (check-equal? (increasing? '(2 1 2 1)) #f)

  ;;Unit tests for init
  (check-equal? (init '(1 2 3 4)) '(1 2 3))
  (check-equal? (init '(1)) '())

  ;;Unit tests for juxt
  (check-equal? ((juxt + *) 2 3) '(5 6))
  (check-equal? ((juxt first last) '(1 2 3)) '(1 3))
  (check-equal? ((juxt zip append)  '(1 2 3) '(4 5 6)) '(((1 4) (2 5) (3 6)) (1 2 3 4 5 6)))

  ;; Unit tests for product
  (check-equal? (product '(3 2 1))            6)
  (check-equal? (product (range 1 11))  3628800)
  (check-equal? (product (range 1 6))       120)

  ;; Unit tests for repeat
  (check-equal? (repeat 3 1) '(1 1 1))
  (check-equal? (repeat 4 2) '(2 2 2 2))
  (check-equal? (repeat 2 "abc") '("abc" "abc"))
  (check-equal? (repeat 2 '(1 2)) '((1 2) (1 2)))

  ;; Unit tests for replicate
  (check-equal? (replicate '(1 0 1) '(a b c)) '(a c))
  (check-equal? (replicate '(0 1 2) '(a b c)) '(b c c))
  (check-equal? (replicate (range 5) '(a b c d e)) '(b c c d d d e e e e))
  (check-equal? (replicate (repeat 5 2) '(a b c d e)) '(a a b b c c d d e e))
  (check-equal? (replicate (repeat 5 3) '(a b c d e)) '(a a a b b b c c c d d d e e e))

  ;; Unit tests for scanl
  (check-equal? (scanl + '(1 2 3 4)) '(1 3 6 10))
  (check-equal? (scanl * '(1 2 3 4)) '(1 2 6 24))

  ;; Unit tests for scanr
  (check-equal? (scanr + '(1 2 3 4)) '(10 9 7 4))
  (check-equal? (scanr * '(1 2 3 4)) '(24 24 12 4))

  ;; Unit tests for sliding
  (check-equal? (sliding '(1 2 3 4) 2) '((1 2) (2 3) (3 4)))
  (check-equal? (sliding '(1 2 3 4 5) 2 3) '((1 2) (4 5)))
  (check-equal? (sliding '(1 2) 2 2) '((1 2)))
  (check-equal? (sliding '(1 2 3) 1 3) '((1 2 3)))
  (check-exn
    #rx"step has to be equal to or smaller than length of the list"
    (thunk (sliding '(1 2 3) 1 4)))

  ;; Unit tests for sorted?
  (check-equal? (sorted? '(1)) #t)
  (check-equal? (sorted? '(1 2)) #t)
  (check-equal? (sorted? '(1 1)) #t)
  (check-equal? (sorted? (range 10)) #t)
  (check-equal? (sorted? '(2 1 2 1)) #f)

  ;; Unit tests for sum
  (check-equal? (sum '(3 2 1))     6)
  (check-equal? (sum (range 11))  55)
  (check-equal? (sum (range 1 7)) 21)

  ;; Unit tests for tail
  (check-equal? (tail (range 3)) '(1 2))
  (check-equal? (tail (range 4)) '(1 2 3))
  (check-equal? (tail '(10 9))   '(9))

  ;; Unit tests for zip
  (check-equal? (zip '(0 2) '(1 3)) (chunks-of (range 4) 2))
  (check-equal? (zip '(0 1) '(2 3)) '((0 2) (1 3)))
  (check-equal? (zip '(0 1) '(2 3) '(5 7)) '((0 2 5) (1 3 7)))
  (check-equal? (zip '() '() '()) '())
  (check-equal? (zip (range 4)) '((0) (1) (2) (3)))

  ;; Unit tests for zip-with
  (check-equal? (zip-with + '(0 2) '(1 3)) '(1 5))
  (check-equal? (zip-with + '(0 1) '(2 3)) '(2 4))
  (check-equal? (zip-with * '(0 1) '(2 3) '(4 5)) '(0 15))
  (check-equal? (zip-with - '(0 1) '(2 3) '(4 5)) '(-6 -7)))
