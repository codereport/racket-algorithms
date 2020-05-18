#lang scribble/manual
@(require (for-label racket
                     (only-in algorithms)))

@title{algorithms}
@author{Conor Hoekstra}

@defmodule[algorithms]

A package containing many useful algorithms (borrowed from many other programming languages).

@defproc[(chunks-of [lst (list?)] [k (integer?)]) (listof list?)]{
    Returns a list of lists of @racket[k] elements each. Note that this is a specialization of @racket[sliding] where @racket[size] is equal to @racket[step]. 
    
    This algorithms is the same as Haskell's @hyperlink["https://hackage.haskell.org/package/split-0.2.3.4/docs/Data-List-Split.html#v:chunksOf"]{chunksOf}.
}

@defproc[(init [lst (list?)]) list?]{
    Return all the elements of a list except the last one. 
    
    This algorithm comes from Haskell's @hyperlink["https://hackage.haskell.org/package/base-4.14.0.0/docs/Prelude.html#v:init"]{init}.
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

@defproc[(tail [lst (list?)]) list?]{
    Return all the elements of a list except the first one. 
    
    Note: this is the same as Racket's @racket[cdr] and @racket[rest].

    This algorithm comes from Haskell's @hyperlink["https://hackage.haskell.org/package/base-4.14.0.0/docs/Prelude.html#v:tail"]{tail}.
}
