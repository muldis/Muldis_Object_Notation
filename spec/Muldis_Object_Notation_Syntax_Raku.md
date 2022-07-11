# NAME

Muldis Object Notation (MUON) - Source code and data interchange format

# VERSION

The fully-qualified name of this document is
`Muldis_Object_Notation https://muldis.com 0.300.0`.

# PART

This artifact is part 7 of 15 of the document
`Muldis_Object_Notation https://muldis.com 0.300.0`;
its part name is `Syntax_Raku`.

# SYNOPSIS

```
    :Syntax(("Muldis_Object_Notation", "https://muldis.com", "0.300.0") =>
        :Model(("Muldis_Data_Language", "https://muldis.com", "0.300.0") =>
            :Relation(Set.new(
                {name => "Jane Ives", birth_date => :Calendar_Instant({y=>1971,m=>11,d=>6}),
                    phone_numbers => Set.new("+1.4045552995", "+1.7705557572")},
                {name => "Layla Miller", birth_date => :Calendar_Instant({y=>1995,m=>8,d=>27}),
                    phone_numbers => Set.new()},
                {name => "岩倉 玲音", birth_date => :Calendar_Instant({y=>1984,m=>7,d=>6}),
                    phone_numbers => Set.new("+81.9072391679")},
            ))
        )
    )
```

# DESCRIPTION

This document consists of multiple parts; for a directory to all of the
parts, see [Overview](Muldis_Object_Notation.md).

This part of the **Muldis Object Notation** document specifies the
canonical concrete Raku hosted syntax of MUON,
which expresses a MUON artifact in terms of a native in-memory value or
object of the Raku programming language,
version 6.d (2018) or later,
as a non-cyclic data structure composed only using system-defined types.

The MUON `Syntax_Raku` is derived from and maps with the MUON
[Syntax_Abstract](Muldis_Object_Notation_Syntax_Abstract.md); see that plus
[Semantics](Muldis_Object_Notation_Semantics.md) for further context.

The MUON Raku-hosted format is semi-lightweight and designed to support
interchange of source code and data between any 2 environments that do have
a common working memory and run the Raku programming language, such as
because they collectively are part of a single process of a
MoarVM.  One typical use case is a Raku library generic API that
accepts or returns structured data using a well-defined protocol such that
the library and its users require no common dependencies besides Raku
standard library classes.  Another typical use case is the bridge format of
a Raku library for generating or parsing MUON `Syntax_Plain_Text`.
The format is fairly easy for humans to read and write in terms of plain
Raku source code.  It is fairly easy for machines to parse and generate.

See also <https://raku.org>.

# SIMPLE PRIMARY DATA TYPE POSSREPS

## Ignorance

An **Ignorance** artifact is any of the following:

* The only object of the Raku singleton class `Nil`.

Not permitted is any of the following, to keep things more correct and simpler:

* Any *undefined* value of some other type.

## Boolean

A **Boolean** artifact is any of the following:

* Any value of the Raku enum `Bool`.

Not permitted is any of the following, to keep things more correct and simpler:

* Any value of any numeric type such that zero/one represents false/true.

* Any value of some other type that might represent a boolean.

* Any value of some other type such that a Raku operator like `?` or `so`
would coerce it to a `Bool`.

## Integer

An **Integer** artifact is any of the following:

* Any object of the Raku class `Int`.

* Any object of any of the Raku classes `int`, `uint`, `atomicint`.

* Any object of any of the Raku classes `int32`, `uint32`, `int64`, `uint64`.

Note that `UInt` is a Raku subset of `Int`.

Not permitted is any of the following, to keep things more correct and simpler:

* Any object of any of the Raku classes `byte`, `int8`, `uint8`, `int16`, `uint16`.

* Any object of the Raku class `IntStr` or of any other allomorphic class.

* Any value of some boolean type such that false/true represents zero/one.

* Any value of any character string type such that it represents a
sequence of digits or anything else resembles a numeric literal.

## Fraction

A **Fraction** artifact is any of the following:

* Any *SYS_Fraction*.

* Any *SYS_Duo* such that its *SYS_this* is the **Text** artifact `Fraction`
and its *SYS_that* is the *significand*.

* Any *SYS_Duo* such that its *SYS_this* is the **Text** artifact `Fraction`
and its *SYS_that* is any *SYS_Array* having exactly 1 element which
is the *significand*.

* Any *SYS_Duo* such that its *SYS_this* is the **Text** artifact `Fraction`
and its *SYS_that* is any *SYS_Array* having exactly 2 elements which in
ascending order are the *numerator* and *denominator*.

* Any *SYS_Duo* such that its *SYS_this* is the **Text** artifact `Fraction`
and its *SYS_that* is any *SYS_Array* having exactly 3 elements which in
ascending order are the *significand*, *radix*, and *exponent*.

* Any *SYS_Duo* such that its *SYS_this* is the **Text** artifact `Fraction`
and its *SYS_that* is any *SYS_Array* having exactly 4 elements which in
ascending order are the *numerator*, *denominator*, *radix*, and *exponent*.

A *significand* is any *SYS_Fraction* or any **Integer** artifact.

A *numerator* is any **Integer** artifact.

A *denominator* is any **Integer** artifact which denotes a nonzero integer.

A *radix* is any **Integer** artifact which denotes an integer that is at least 2.

An *exponent* is any **Integer** artifact.

A *SYS_Fraction* is any of the following:

* Any object of the Raku class `Rat`.

* Any object of the Raku class `FatRat` whose denominator is non-zero.

* Any object of the Raku class `Num`
that represents a finite number or signed zero value;
both signed zeroes are treated as the same plain zero.

* Any object of any of the Raku classes `num`, `num32`, `num64`
that represents a finite number or signed zero value;
both signed zeroes are treated as the same plain zero.

Not permitted for a *SYS_Fraction* is any of the following,
to keep things more correct and simpler:

* Any object of the Raku class `FatRat` whose denominator is zero.

* Any object of any Raku class that composes the Raku role `Rational`
besides `Rat` and `FatRat`.

* Any object of the Raku class `Num` that represents an infinity or NaN.

* Any object of any of the Raku classes `num`, `num32`, `num64`
that represents an infinity or NaN.

* Any object of any of the Raku classes `RatStr` or `NumStr`
or of any other allomorphic class.

* Any value of any character string type such that it represents a
sequence of digits or anything else resembles a numeric literal.

## Bits

A **Bits** artifact is any of the following:

* Any *SYS_Duo* such that its *SYS_this* is the **Text** artifact `Bits`
and its *SYS_that* is any object of any Raku class that composes the Raku role `Blob`.

Not permitted is any of the following, to prevent ambiguity and simplify things:

* Any object of any Raku class that composes the Raku role `Blob`.
This is because that would be interpreted as a **Blob** artifact.

## Blob

A **Blob** artifact is any of the following:

* Any object of any Raku class that composes the Raku role `Blob`.

Note that the Raku role `Buf` composes the Raku role `Blob` and so objects
of classes that compose the latter also compose the former.

Not permitted is any of the following, to prevent ambiguity and simplify things:

* Any object of the Raku class `List` whose elements are **Integer** artifacts.
This is because that would be interpreted as a **Lot** artifact all of whose
members are any **Integer** artifacts.

## Text / Attribute Name

A **Text** artifact is any of the following:

* Any object of the Raku class `Str` that is *well formed*.

* Any object of the Raku class `Uni` that is *well formed*.

Note that *well formed* means there are no UTF-16 surrogate code points
defined in it that aren't in valid surrogate pairs.

Not permitted is any of the following, to keep things more correct and simpler:

* Any object of the Raku class `Str` that is not *well formed*,
if such a thing exists.

* Any object of the Raku class `Uni` that is not *well formed*,
if such a thing exists.

* Any object of any of the Raku classes `IntStr` or `RatStr` or `NumStr`
or of any other allomorphic class.

## Nesting / Attribute Name List

A **Nesting** artifact is any of the following:

* Any *SYS_Duo* such that its *SYS_this* is the **Text** artifact `Nesting`
and its *SYS_that* is any *SYS_Array*
such that every element is any **Text** artifact.

* Any *SYS_Duo* such that its *SYS_this* is the **Text** artifact `Nesting`
and its *SYS_that* is any **Text** artifact.

Not permitted is any of the following, to prevent ambiguity and simplify things:

* Any object of the Raku class `List` whose elements are **Text** artifacts.
This is because that would be interpreted as a **Lot** artifact all of whose
members are any **Text** artifacts.

# COLLECTIVE PRIMARY DATA TYPE POSSREPS

## Duo

A **Duo** artifact is any of the following:

* Any *SYS_Duo* such that its *SYS_this* is *this* (any **Any** artifact
except for any *Primary_Possrep_Name*) and its *SYS_that* is *that* (any
**Any** artifact).

* Any *SYS_Duo* such that its *SYS_this* is the **Text** artifact `Duo` and
its *SYS_that* is any *SYS_Duo* such that its *SYS_this* is *this* (any
**Any** artifact) and its *SYS_that* is *that* (any **Any** artifact).

A *SYS_Duo* is any of the following:

* Any object of the Raku class `Pair`
such that its `key` property is *SYS_this* and its `value` property is *SYS_that*.

Not permitted for a *SYS_Duo* is any of the following,
to keep things more correct and simpler:

* Any values or objects of N-ary collection types having exactly 2 elements.

## Lot

A **Lot** artifact is any of the following:

* Any *SYS_Array* such that each of its elements in turn is *member*
(any **Any** artifact) and its corresponding *multiplicity* is 1.

* Any *SYS_Duo* such that its *SYS_this* is the **Text** artifact `Lot` and
its *SYS_that* is any *SYS_Array* such that each of its elements in turn is
*multiplied member*, which is any *SYS_Duo* such that its
*SYS_this* is *member* (any **Any** artifact) and its *SYS_that* is
*multiplicity* (any **Any** artifact but conceptually a real number).

A *SYS_Array* is any of the following:

* Any object of the Raku class `List`.

Note that the Raku classes `Array` and `Slip` are subtypes of `List` and
so their objects can be used anywhere `List` objects can be used.

## Kit / Multi-Level Tuple

A **Kit** artifact is any of the following:

* Any *SYS_Dictionary* such that each of its elements in turn is
*multi-level attribute* whose element key is *name* (any **Nesty** artifact)
and whose element value is *asset* (any **Any** artifact);
this is the simplest format for the general case of any **Kit** having
named attributes for which we *don't* need the system to persist the
literal order of attributes in the source code.

* Any *SYS_Duo* such that its *SYS_this* is the **Text** artifact `Kit` and
its *SYS_that* is any *SYS_Array* such that each of its elements in turn is
*attribute asset* (any **Any** artifact) and its corresponding
*attribute name* is the ordinal position of that element;
this is the simplest format for a **Kit** having only normalized ordered
attributes and with no special handling for nested tuples.

* Any *SYS_Duo* such that its *SYS_this* is the **Text** artifact `Kit` and
its *SYS_that* is any *SYS_Duo* such that its *SYS_this* is the **Text**
artifact `named` and its *SYS_that* is any *SYS_Array* such that each of
its elements in turn is *multi-level attribute*, which is any *SYS_Duo*
such that its *SYS_this* is *name* (any **Nesty** artifact) and its
*SYS_that* is *asset* (any **Any** artifact); this is the format for the
general case of any **Kit** having named attributes for which we *do* need
the system to persist the literal order of attributes in the source code.

*TODO: Consider adding Raku `Capture` objects as an option if feasible.*

*TODO: Consider adding Raku anonymous types as an option if feasible.*

A *SYS_Dictionary* is any of the following:

* Any object of the Raku class `Map`.

Note that the Raku classes `Hash` and `Stash` and `PseudoStash`are subtypes
of `Map` and so their objects can be used anywhere `Map` objects can be used.

Note that a *SYS_Dictionary* is actually limited such that it can only have
single-level attributes, because its keys can only be **Text**, not **Nesting**.

Not permitted for a *SYS_Dictionary* is any of the following,
to keep things more correct and simpler:

* Any object of any Raku class that composes the Raku role `Associative`
besides `Map`.  This is because many Raku classes compose this role and we
want to avoid matching other classes as **Kit** that we don't mean to.

Note that an object of the Raku class `Capture` is a direct `Kit`/`Tuple`
analogy which extends to the fact that a primary purpose of both is to
represent a collection of arguments for a routine.

## Article / Labelled Tuple

An **Article** artifact is any of the following:

* Any *SYS_Duo* such that its *SYS_this* is the **Text** artifact `Article`
and its *SYS_that* is any *SYS_Duo* such that its *SYS_this* is *label*
(any **Nesty** artifact) and its *SYS_that* is *attributes* (any **Kit**
artifact such that every one of its *multi-level attribute names* has
exactly 1 element).

## Excuse

An **Excuse** artifact is any of the following:

* Any *SYS_Duo* such that its *SYS_this* is the **Text** artifact `Excuse`
and its *SYS_that* is any *SYS_Duo* such that its *SYS_this* is *label*
(any **Nesty** artifact) and its *SYS_that* is *attributes* (any **Kit**
artifact such that every one of its *multi-level attribute names* has
exactly 1 element).

Note that an object of the Raku class `Failure` is a direct `Excuse` analogy.

# ADDITIONAL SECONDARY DATA TYPE POSSREP FORMATS

## Calendar Duration

A **Calendar Duration** artifact is additionally any of the following:

* Any object of the Raku class `Duration`.

## Calendar Instant

A **Calendar Instant** artifact is additionally any of the following:

* Any object of any of the Raku classes `Date`, `DateTime`, `Instant`.

## Set

A **Set** artifact is additionally any of the following:

* Any object of any of the Raku classes `Set`, `SetHash`
such that each of its elements in turn is *member* (any **Any** artifact).

## Bag / Multiset

A **Bag** artifact is additionally any of the following:

* Any object of any of the Raku classes `Bag`, `BagHash`
such that each of its elements in turn is *member* (any **Any** artifact).

## Mix

A **Mix** artifact is additionally any of the following:

* Any object of any of the Raku classes `Mix`, `MixHash`
such that each of its elements in turn is *member* (any **Any** artifact).

## Interval

An **Interval** artifact is additionally any of the following:

* Any object of the Raku class `Range`
such that each of its `min` and `max` properties is any **Any** artifact.

# SEE ALSO

*TODO.*

# AUTHOR

Darren Duncan - darren@DarrenDuncan.net

# LICENSE AND COPYRIGHT

This file is part of the formal specification named
**Muldis Object Notation** (**MUON**).

MUON is Copyright © 2002-2022, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of [Overview](Muldis_Object_Notation.md) for details.

# TRADEMARK POLICY

The TRADEMARK POLICY in [Overview](Muldis_Object_Notation.md) applies to this file too.

# ACKNOWLEDGEMENTS

The ACKNOWLEDGEMENTS in [Overview](Muldis_Object_Notation.md) apply to this file too.
