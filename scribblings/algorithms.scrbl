#lang scribble/manual
@(require (for-label racket
                     (only-in algorithms)))

@title{algorithms}
@author{Conor Hoekstra}

@defmodule[algorithms]

A package containing many useful algorithms (borrowed from many other programming languages).

@defproc[(adjacent-map [proc (-> any/c any/c any/c)] [lst list?]) (listof any/c)]{
@margin-note{This algorithm is similar to Haskell's
@hyperlink["https://hackage.haskell.org/package/utility-ht-0.0.15/docs/Data-List-HT.html#v:mapAdjacent"]{mapAdjacent}.}
Returns a list of elements after apply @racket[proc] to adjacent elements.

Examples:
@codeblock|{
  > (adjacent-map * '(1 2 3 4 5 6))
  '(2 6 12 20 30)
  > (adjacent-map  < '(1 2 1 3 4 3))
  '(#t #f #t #t #f)
}|}

@defproc[(all? [lst (listof boolean?)]) (boolean?)]{
@margin-note{This algorithm is similar to Python's
@hyperlink["https://docs.python.org/3/library/functions.html#all"]{all}.}
Returns @racket[#t] if all the elements of @racket[lst] are @racket[#t], otherwise returns @racket[#f].

Examples:
@codeblock|{
  > (all? '(#t #t #t))
  #t
  > (all? '(#t #t #f))
  #f
}|}

@defproc[(any? [lst (listof boolean?)]) (boolean?)]{
@margin-note{This algorithm is similar to Python's
@hyperlink["https://docs.python.org/3/library/functions.html#any"]{any}.}
Returns @racket[#t] if any of the elements of @racket[lst] are @racket[#t], otherwise returns @racket[#f].

Examples:
@codeblock|{
  > (any? '(#f #t #f))
  #t
  > (any? '(#f #f #f))
  #f
}|}

@defproc[(chunks-of [lst list?] [k exact-nonnegative-integer?]) (listof list?)]{
@margin-note{This algorithms is the same as Haskell's
@hyperlink["https://hackage.haskell.org/package/split-0.2.3.4/docs/Data-List-Split.html#v:chunksOf"]{chunksOf}.
and similar to Python's @hyperlink["https://docs.python.org/3/library/itertools.html#itertools.batched"]{itertools.batched}}
Returns a list of lists of @racket[k] elements each.
Note that this is a specialization of @racket[sliding] where @racket[size] is equal to @racket[step].

Examples:
@codeblock|{
  > (chunks-of '(1 2 1 3 4 3) 2)
  '((1 2) (1 3) (4 3))
  > (chunks-of '(1 2 1 3 4 3) 3)
  '((1 2 1) (3 4 3))
}|}

@defproc[(generate [n exact-nonnegative-integer?] [proc (-> any/c)]) (listof any/c)]{
@margin-note{This algorithm is similar to C++'s
@hyperlink["https://en.cppreference.com/w/cpp/algorithm/generate"]{generate}.}
Returns a list of @racket[n] elements generated from invoking @racket[proc] @racket[n] times.

Examples:
@codeblock|{
  > (generate 3 *)
  '(1 1 1)
  > (generate 3 +)
  '(0 0 0)
}|}

@defproc[(increasing? [lst (listof real?)]) (boolean?)]{
Returns @racket[#t] if all the elements of @racket[lst] are strictly increasing,
otherwise returns @racket[#f].

Examples:
@codeblock|{
  > (increasing? '(1 2 3 4))
  #t
  > (increasing? '(1 2 3 5))
  #t
  > (increasing? '(1 2 2 3))
  #f
}|}

@defproc[(init [lst list?]) list?]{
@margin-note{This algorithm comes from Haskell's
@hyperlink["https://hackage.haskell.org/package/base-4.14.0.0/docs/Prelude.html#v:init"]{init}.}
Return all the elements of a list except the last one.

Examples:
@codeblock|{
  > (init '(1 2 3 4))
  '(1 2 3)
  > (init '((1 2) (3 4) (5 6)))
  '((1 2) (3 4))
}|}

@defproc[(product [lst (listof real?)]) real?]{
Returns the product of the elements in @racket[lst].

Examples:
@codeblock|{
  > (product '(1 2 3))
  6
  > (product '(1 2 3 4))
  24
}|}

@defproc[(repeat [n exact-nonnegative-integer?] [val any/c?]) list?]{
@margin-note{This algorithms is the same as Clojures's
@hyperlink["https://clojuredocs.org/clojure.core/repeat"]{repeat} and D's
@hyperlink["https://dlang.org/library/std/range/repeat.html#0"]{repeat}.}
Returns a list of @racket[val] repeated @racket[n] times.

Examples:
@codeblock|{
  > (repeat 5 #t)
  '(#t #t #t #t #t)
  > (repeat 5 '())
  '(() () () () ())
}|}

@defproc[(replicate [lst (listof exact-nonnegative-integer?)] [lst2 list?]) list?]{
@margin-note{This algorithms is the similar to APL's
@hyperlink["https://microapl.com/apl_help/ch_020_020_840.htm"]{replicate.}}
Returns a list of of the @racket[lst2] values each repeated n times where n is the corresponding element in @racket[lst].

Examples:
@codeblock|{
  > (replicate '(1 0 1) '(a b c))
  '(a c)
  > (replicate '(0 1 2) '(a b c))
  '(b c c)
}|}

@defproc[(scanl [lst list?]) list?]{
@margin-note{This algorithm originally comes from APL's monadic
@hyperlink["http://microapl.com/apl_help/ch_020_020_820.htm"]{\ scan} operator. It is more similar to Haskell's
@hyperlink["https://hackage.haskell.org/package/base-4.14.0.0/docs/Prelude.html#v:scanl1"]{scanl1} however.}
@racket[scanl] is similar to @racket[foldl], but returns a list of successive reduced values from the left.

Examples:
@codeblock|{
  > (scanl + '(1 2 3 4))
  '(1 3 6 10)
  > (scanl * '(1 2 3 4))
  '(1 2 6 24)
}|}

@defproc[(scanr [lst list?]) list?]{
@margin-note{This algorithm originally comes from APL's monadic
@hyperlink["http://microapl.com/apl_help/ch_020_020_820.htm"]{\ scan} operator. It is more similar to Haskell's
@hyperlink["https://hackage.haskell.org/package/base-4.14.0.0/docs/Prelude.html#v:scanr1"]{scanr1} however.}
@racket[scanr] is similar to @racket[foldr], but returns a list of successive reduced values from the right.

Examples:
@codeblock|{
  > (scanr + '(1 2 3 4))
  '(10 9 7 4)
  > (scanr * '(1 2 3 4))
  '(24 24 12 4)
}|}

@defproc[(sliding [lst list?] [size exact-nonnegative-integer?] [step exact-nonnegative-integer? 1]) (listof list?)]{
@margin-note{This algorithm is the same as Haskell's
@hyperlink["https://hackage.haskell.org/package/split-0.2.3.4/docs/Data-List-Split.html#v:divvy"]{divvy}, Clojure's
@hyperlink["https://clojuredocs.org/clojure.core/partition"]{partition} and D's
@hyperlink["https://dlang.org/library/std/range/slide.html"]{slide}.}
Returns a list of lists of @racket[size] elements each, at offset @racket[step] apart.

@racket[step] has to be equal to or smaller then length of the @racket[lst].

Examples:
@codeblock|{
  > (sliding '(1 2 3 4) 2)
  '((1 2) (2 3) (3 4))
  > (sliding '(1 2 3 4 5) 2 3)
  '((1 2) (4 5))
  > (sliding '(1 2) 2 2)
  '((1 2))
}|}

@defproc[(sorted? [lst list?]) (boolean?)]{
@margin-note{This algorithm is similar to C++'s
@hyperlink["https://en.cppreference.com/w/cpp/algorithm/is_sorted"]{std::is_sorted}.}
Returns @racket[#t] if all the elements of @racket[lst] are in sorted order, otherwise returns @racket[#f].

Examples:
@codeblock|{
  > (sorted? '(1 2 3 4))
  #t
  > (sorted? '(1 2 3 3))
  #t
  > (sorted? '(1 2 3 2))
  #f
}|}

@defproc[(sum [lst (listof real?)]) real?]{
Returns the sum of the elements in @racket[lst].

Examples:
@codeblock|{
  > (sum '(1 2 3 4))
  10
  > (sum '())
  0
}|}

@defproc[(tail [lst list?]) list?]{
@margin-note{This algorithm comes from Haskell's
@hyperlink["https://hackage.haskell.org/package/base-4.14.0.0/docs/Prelude.html#v:tail"]{tail}.}
Return all the elements of a list except the first one. 
    
Note: this is the same as Racket's @racket[cdr] and @racket[rest] and therefore isn't really necessary.

Examples:
@codeblock|{
  > (tail '(1 2 3))
  '(2 3)
  > (tail '(1))
  '()
}|}

@defproc[(zip [lst list?] ...) (listof list?)]{
@margin-note{This algorithm is similar to Haskell's
@hyperlink["https://hackage.haskell.org/package/base-4.14.0.0/docs/Prelude.html#v:zip"]{zip}
and Python's @hyperlink["https://docs.python.org/3/library/functions.html#zip"]{zip}.}
Returns a list of lists of elements from each of lists passed to the procedure.

Another way to think of @racket[zip] is that it turns rows into columns, and columns into rows.
This is similar to @hyperlink["https://en.wikipedia.org/wiki/Transpose"]{transposing a matrix}.

Examples:
@codeblock|{
  > (zip '(1 2 3) '(4 5 6))
  '((1 4) (2 5) (3 6))
  > (zip '() '())
  '()
  > (zip '(0 1) '(2 3) '(5 7))
  '((0 2 5) (1 3 7))
}|}

@defproc[(zip-with [proc (-> any/c ... any/c)] [lst list?] ...) (listof any/c)]{
@margin-note{This algorithm is similar to Haskell's
@hyperlink["https://hackage.haskell.org/package/base-4.14.0.0/docs/Prelude.html#v:zipWith"]{zipWith}.}
Returns a list after zipping together the variadic number of @racket[lst]s and applying @racket[proc]
to each of the "zipped together" elements.

Examples:
@codeblock|{
  > (zip-with + '(1 2 3) '(4 5 6))
  '(5 7 9)
  > (zip-with + '(1 2 3) '(4 5 6) '(7 8 9))
  '(12 15 18)
}|}
