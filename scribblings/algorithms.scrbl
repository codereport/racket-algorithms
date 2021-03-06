#lang scribble/manual
@(require (for-label racket
                     (only-in algorithms)))

@title{algorithms}
@author{Conor Hoekstra}

@defmodule[algorithms]

A package containing many useful algorithms (borrowed from many other programming languages).

@defproc[(adjacent-map [lst (list?)] [proc (-> any/c any/c any/c)]) (listof any/c)]{
    Returns a list of elements after apply @racket[proc] to adjacent elements. 

    This algorithm is similar to Haskell's @hyperlink["https://hackage.haskell.org/package/utility-ht-0.0.15/docs/Data-List-HT.html#v:mapAdjacent"]{mapAdjacent}.
}

@defproc[(all? [lst (listof boolean?)]) (boolean?)]{
    Returns @racket[#t] if all the elements of @racket[lst] are @racket[#t], otherwise returns @racket[#f].

    This algorithm is similar to Python's @hyperlink["https://docs.python.org/3/library/functions.html#all"]{all}.
}

@defproc[(any? [lst (listof boolean?)]) (boolean?)]{
    Returns @racket[#t] if any of the elements of @racket[lst] are @racket[#t], otherwise returns @racket[#f].

    This algorithm is similar to Python's @hyperlink["https://docs.python.org/3/library/functions.html#any"]{any}.
}

@defproc[(chunks-of [lst (list?)] [k (integer?)]) (listof list?)]{
    Returns a list of lists of @racket[k] elements each. Note that this is a specialization of @racket[sliding] where @racket[size] is equal to @racket[step]. 
    
    This algorithms is the same as Haskell's @hyperlink["https://hackage.haskell.org/package/split-0.2.3.4/docs/Data-List-Split.html#v:chunksOf"]{chunksOf}.
}

@defproc[(generate [n (integer?)] [proc (-> any/c)]) (listof any/c)]{
    Returns a list of @racket[n] elements generated from invoking @racket[proc] @racket[n] times.

    This algorithm is similar to C++'s @hyperlink["https://en.cppreference.com/w/cpp/algorithm/generate"]{generate}.
}

@defproc[(increasing? [lst (list?)]) (boolean?)]{
    Returns @racket[#t] if all the elements of @racket[lst] are strictly increasing, otherwise returns @racket[#f].
}

@defproc[(init [lst (list?)]) list?]{
    Return all the elements of a list except the last one. 
    
    This algorithm comes from Haskell's @hyperlink["https://hackage.haskell.org/package/base-4.14.0.0/docs/Prelude.html#v:init"]{init}.
}

@defproc[(product [lst (listof Real)]) Real]{
    Returns the product of the elements in @racket[lst].
}

@defproc[(repeat [n (integer?)] [val (integer?)]) list?]{
    Returns a list of @racket[val] repeated @racket[n] times.

    This algorithms is the same as Clojures's @hyperlink["https://clojuredocs.org/clojure.core/repeat"]{repeat} and D's @hyperlink["https://dlang.org/library/std/range/repeat.html#0"]{repeat}.
}

@defproc[(scanl [lst (list?)]) list?]{
    @racket[scanl] is similar to @racket[foldl], but returns a list of successive reduced values from the left.

    This algorithm originally comes from APL's monadic @hyperlink["http://microapl.com/apl_help/ch_020_020_820.htm"]{\ scan} operator. It is more similar to Haskell's @hyperlink["https://hackage.haskell.org/package/base-4.14.0.0/docs/Prelude.html#v:scanl1"]{scanl1} however.
}

@defproc[(scanr [lst (list?)]) list?]{
    @racket[scanr] is similar to @racket[foldr], but returns a list of successive reduced values from the right.

    This algorithm originally comes from APL's monadic @hyperlink["http://microapl.com/apl_help/ch_020_020_820.htm"]{\ scan} operator. It is more similar to Haskell's @hyperlink["https://hackage.haskell.org/package/base-4.14.0.0/docs/Prelude.html#v:scanr1"]{scanr1} however.
}

@defproc[(sliding [lst (list?)] [size (integer?)] [step (integer?)]) (listof list?)]{
    Returns a list of lists of @racket[size] elements each, at offset @racket[step] apart. Note that @racket[step] is defaulted to 1. 
    
    This algorithms is the same as Haskell's @hyperlink["https://hackage.haskell.org/package/split-0.2.3.4/docs/Data-List-Split.html#v:divvy"]{divvy}, Clojure's @hyperlink["https://clojuredocs.org/clojure.core/partition"]{partition} and D's @hyperlink["https://dlang.org/library/std/range/slide.html"]{slide}.
}

@defproc[(sorted? [lst (list?)]) (boolean?)]{
    Returns @racket[#t] if all the elements of @racket[lst] are in sorted order, otherwise returns @racket[#f].

    This algorithm is similar to C++'s @hyperlink["https://en.cppreference.com/w/cpp/algorithm/is_sorted"]{std::is_sorted}.
}

@defproc[(sum [lst (listof Real)]) Real]{
    Returns the sum of the elements in @racket[lst].
}

@defproc[(tail [lst (list?)]) list?]{
    Return all the elements of a list except the first one. 
    
    Note: this is the same as Racket's @racket[cdr] and @racket[rest] and therefore isn't really necessary.

    This algorithm comes from Haskell's @hyperlink["https://hackage.haskell.org/package/base-4.14.0.0/docs/Prelude.html#v:tail"]{tail}.
}

@defproc[(zip [lst (list?)] [lst2 (list?)]) (listof list?)]{
    Returns a list of corresponding pairs when given two lists.

    This algorithm is similar to Haskell's @hyperlink["https://hackage.haskell.org/package/base-4.14.0.0/docs/Prelude.html#v:zip"]{zip}.
}

@defproc[(zip-with [proc (-> any/c ... any/c)] [lst (list?)] ...) (listof any/c)]{
    Returns a list after zipping together the variadic number of @racket[lst]s and applying @racket[proc] to each of the "zipped together" elements. 

    This algorithm is similar to Haskell's @hyperlink["https://hackage.haskell.org/package/base-4.14.0.0/docs/Prelude.html#v:zipWith"]{zipWith}.
}