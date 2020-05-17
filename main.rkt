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

; FUNCTION init
(define (init lst)
  (take lst (- (length lst) 1)))

; FUNCTION tail
(define (tail lst)
  (drop lst 1))

; FUNCTION sliding
(define (sliding lst size [step 1])
  (if (>= size (length lst))
      (list lst)
      (append (list (take lst size))
              (sliding (drop lst step) size step))))

; FUNCTION chunks-of
(define (chunks-of lst k)
  (sliding lst k k))

; FUNCTION chunk-by
; TODO

; FUNCTION scanl
; TODO optimize
(define (scanl proc lst)
  (foldl
   (λ (val acc)
     (append acc (list (proc val (last acc)))))
   (list (first lst))
   (rest lst)))

; FUNCTION scanr
; TODO optimize
(define (scanr proc lst)
  (foldr
   (λ (val acc)
     (append (list (proc val (first acc))) acc))
   (list (last lst))
   (init lst)))

; FUNCTION repeat
; is `duplicate` or `replicate` or repeat with an overload a better name?
(define (repeat n val)
  (build-list n (const val)))

(module+ test
  ;; Any code in this `test` submodule runs when this file is run using DrRacket
  ;; or with `raco test`. The code here does not run when this file is
  ;; required by another module.

  (check-equal? (+ 2 2) 4))
