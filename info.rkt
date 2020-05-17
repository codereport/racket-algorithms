#lang info
(define collection "algorithms")
(define deps '("base"))
(define build-deps '("scribble-lib" "racket-doc" "rackunit-lib"))
(define scribblings '(("scribblings/algorithms.scrbl" ())))
(define pkg-desc "A package containing many useful algorithms (borrowed from many other programming languages).")
(define version "0.3")
(define pkg-authors '(cph))
