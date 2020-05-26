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
  chunks-of
  init
  repeat
  product
  scanl
  scanr
  sliding
  sum
  tail
  zip
  zip-with)


(define (adjacent-map lst f)
    (zip-with f (init lst) (tail lst)))


(define (chunks-of lst k)
  (sliding lst k k))


(define (init lst)
  (take lst (- (length lst) 1)))


(define (product lst)
  (foldl * 1 lst))


(define (repeat n val)
  (make-list n val))


(define (sliding lst size [step 1])
  (if (>= size (length lst))
      (list lst)
      (append (list (take lst size))
              (sliding (drop lst step) size step))))


(define (scanl proc lst)
  (foldl
   (λ (val acc)
     (append acc (list (proc val (last acc)))))
   (list (first lst))
   (rest lst)))


; TODO optimize
(define (scanr proc lst)
  (foldr
   (λ (val acc)
     (append (list (proc val (first acc))) acc))
   (list (last lst))
   (init lst)))


(define (sum lst)
  (foldl + 0 lst))


(define (tail lst)
  (cdr lst))


;; TODO make this variadic
(define (zip lst lst2)
  (map list lst lst2))


(define (zip-with proc list1 . lists)
  (apply map proc list1 lists))


(module+ test
  ;; Any code in this `test` submodule runs when this file is run using DrRacket
  ;; or with `raco test`. The code here does not run when this file is
  ;; required by another module.

  ;; Unit tests for adjacent-map
  (check-equal? (adjacent-map (range 5) +) '(1 3 5 7))
  (check-equal? (adjacent-map (range 5) -) (repeat 4 -1))
  (check-equal? (adjacent-map (range 5) *) '(0 2 6 12))

  ;; Unit tests for product
  (check-equal? (product '(3 2 1))            6)
  (check-equal? (product (range 1 11))  3628800)
  (check-equal? (product (range 1 6))       120)

  ;; Unit tests for repeat
  (check-equal? (repeat 3 1) '(1 1 1))
  (check-equal? (repeat 4 2) '(2 2 2 2))
  (check-equal? (repeat 2 "abc") '("abc" "abc"))
  (check-equal? (repeat 2 '(1 2)) '((1 2) (1 2)))

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

  ;; Unit tests for zip-with
  (check-equal? (zip-with + '(0 2) '(1 3)) '(1 5))
  (check-equal? (zip-with + '(0 1) '(2 3)) '(2 4))
  (check-equal? (zip-with * '(0 1) '(2 3) '(4 5)) '(0 15))
  (check-equal? (zip-with - '(0 1) '(2 3) '(4 5)) '(-6 -7))
  
  )
