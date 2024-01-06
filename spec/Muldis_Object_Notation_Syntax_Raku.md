<a name="TOP"></a>

# NAME

Muldis Object Notation (MUON) - Source code and data interchange format

# VERSION

The fully-qualified name of this document is
`Muldis_Object_Notation https://muldis.com 0.400.0`.

# PART

This artifact is part 10 of 22 of the document
`Muldis_Object_Notation https://muldis.com 0.400.0`;
its part name is `Syntax_Raku`.

# CONTENTS

- [SYNOPSIS](#SYNOPSIS)
- [DESCRIPTION](#DESCRIPTION)
- [SIMPLE DATA TYPE POSSREPS](#SIMPLE-DATA-TYPE-POSSREPS)
    - [Ignorance](#Ignorance)
    - [Boolean](#Boolean)
    - [Integer](#Integer)
    - [Rational](#Rational)
    - [Binary](#Binary)
    - [Decimal](#Decimal)
    - [Bits](#Bits)
    - [Blob](#Blob)
    - [Text / Attribute Name](#Text---Attribute-Name)
    - [Nesting / Attribute Name List](#Nesting---Attribute-Name-List)
- [COLLECTIVE DATA TYPE POSSREPS](#COLLECTIVE-DATA-TYPE-POSSREPS)
    - [Pair](#Pair)
    - [Lot](#Lot)
    - [Kit](#Kit)
- [AUTHOR](#AUTHOR)
- [LICENSE AND COPYRIGHT](#LICENSE-AND-COPYRIGHT)

[RETURN](#TOP)

<a name="SYNOPSIS"></a>

# SYNOPSIS

```
    (Muldis_Object_Notation_Syntax=>(("Raku", "https://muldis.com", "0.400.0")=>
        (Muldis_Object_Notation_Model=>(("Muldis_Data_Language", "https://muldis.com", "0.400.0")=>
            (Relation=>(
                (Kit_na=>(
                    name => "Jane Ives",
                    birth_date => (Calendar_Instant=>(Kit_na=>(y=>1971,m=>11,d=>6))),
                    phone_numbers => (Set=>("+1.4045552995", "+1.7705557572")),
                )),
                (Kit_na=>(
                    name => "Layla Miller",
                    birth_date => (Calendar_Instant=>(Kit_na=>(y=>1995,m=>8,d=>27))),
                    phone_numbers => (Set=>()),
                )),
                (Kit_na=>(
                    name => "岩倉 玲音",
                    birth_date => (Calendar_Instant=>(Kit_na=>(y=>1984,m=>7,d=>6))),
                    phone_numbers => (Set=>("+81.9072391679",)),
                )),
            ))
        ))
    ))
```

[RETURN](#TOP)

<a name="DESCRIPTION"></a>

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

The MUON Raku hosted format is semi-lightweight and designed to support
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

The prescribed standard *syntax base name* of a *syntax-qualified artifact*
for a MUON Raku hosted artifact is `Raku`.

See also <https://raku.org>.

[RETURN](#TOP)

<a name="SIMPLE-DATA-TYPE-POSSREPS"></a>

# SIMPLE DATA TYPE POSSREPS

[RETURN](#TOP)

<a name="Ignorance"></a>

## Ignorance

An **Ignorance** artifact is any of the following:

* The only object of the Raku singleton class `Nil`.

Not permitted for an **Ignorance** is any of the following,
to keep things more correct and simpler:

* Any *undefined* value of some other type.

[RETURN](#TOP)

<a name="Boolean"></a>

## Boolean

A **Boolean** artifact is any of the following:

* Any value of the Raku enum `Bool`.

Not permitted for a **Boolean** is any of the following,
to keep things more correct and simpler:

* Any value of any numeric type such that zero/one represents false/true.

* Any value of some other type that might represent a boolean.

* Any value of some other type such that a Raku operator like `?` or `so`
would coerce it to a `Bool`.

[RETURN](#TOP)

<a name="Integer"></a>

## Integer

An **Integer** artifact is any of the following:

* Any *SYS_Integer*.

A *SYS_Integer* is any of the following:

* Any object of the Raku class `Int`.

* Any object of any of the Raku classes `int`, `uint`, `atomicint`.

* Any object of any of the Raku classes `int32`, `uint32`, `int64`, `uint64`.

Note that `UInt` is a Raku subset of `Int`.

Not permitted for a *SYS_Integer* is any of the following,
to keep things more correct and simpler:

* Any object of any of the Raku classes `byte`, `int8`, `uint8`, `int16`, `uint16`.

* Any object of the Raku class `IntStr` or of any other allomorphic class.

* Any value of some boolean type such that false/true represents zero/one.

* Any value of any character string type such that it represents a
sequence of digits or anything else resembles a numeric literal.

[RETURN](#TOP)

<a name="Rational"></a>

## Rational

A **Rational** artifact is any of the following:

* Any *SYS_Rational*.

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Rational`
and its *SYS_that* is any *SYS_Rational* or any *SYS_Binary* or any *SYS_Integer*.

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Rational`
and its *SYS_that* is
any *SYS_Pair_AA* such that its *SYS_this* and *SYS_that* correspond to
the *numerator* (any *SYS_Integer*) and *denominator* (any *SYS_Integer*
which denotes a nonzero integer) of the new **Rational** respectively.

A *SYS_Rational* is any of the following:

* Any object of the Raku class `Rat`.

* Any object of the Raku class `FatRat` whose denominator is non-zero.

Not permitted for a *SYS_Rational* is any of the following,
to keep things more correct and simpler:

* Any object of the Raku class `FatRat` whose denominator is zero.

* Any object of any Raku class that composes the Raku role `Rational`
besides `Rat` and `FatRat`.

* Any object of the Raku class `RatStr` or of any other allomorphic class.

* Any value of any character string type such that it represents a
sequence of digits or anything else resembles a numeric literal.

[RETURN](#TOP)

<a name="Binary"></a>

## Binary

A **Binary** artifact is any of the following:

* Any *SYS_Binary*.

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Binary`
and its *SYS_that* is any *SYS_Binary* or any *SYS_Integer*.

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Binary`
and its *SYS_that* is
any *SYS_Pair_AA* such that its *SYS_this* and *SYS_that* correspond to
the *significand* (any *SYS_Binary* or any *SYS_Integer*) and *exponent*
(any *SYS_Integer*) of the new **Binary** respectively.

A *SYS_Binary* is any of the following:

* Any object of the Raku class `Num`
that represents a finite number or signed zero;
both signed zeroes are treated as the same plain zero.

* Any object of any of the Raku classes `num`, `num32`, `num64`
that represents a finite number or signed zero;
both signed zeroes are treated as the same plain zero.

Not permitted for a *SYS_Binary* is any of the following,
to keep things more correct and simpler:

* Any object of the Raku class `Num`
that represents an infinity or NaN.

* Any object of any of the Raku classes `num`, `num32`, `num64`
that represents an infinity or NaN.

* Any object of the Raku class `NumStr` or of any other allomorphic class.

* Any value of any character string type such that it represents a
sequence of digits or anything else resembles a numeric literal.

[RETURN](#TOP)

<a name="Decimal"></a>

## Decimal

A **Decimal** artifact is any of the following:

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Decimal`
and its *SYS_that* is any *SYS_Integer*.

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Decimal`
and its *SYS_that* is
any *SYS_Pair_AA* such that its *SYS_this* and *SYS_that* correspond to
the *significand* (*SYS_Integer*) and *exponent*
(any *SYS_Integer*) of the new **Decimal** respectively.

[RETURN](#TOP)

<a name="Bits"></a>

## Bits

A **Bits** artifact is any of the following:

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Bits`
and its *SYS_that* is any *SYS_Blob*
such that every integer is in the set `0..1`.

Not permitted for a **Bits** is any of the following,
to prevent ambiguity and simplify things:

* Any *SYS_Blob*.
This is because that would be interpreted as a **Blob** artifact.

[RETURN](#TOP)

<a name="Blob"></a>

## Blob

A **Blob** artifact is any of the following:

* Any *SYS_Blob*.

A *SYS_Blob* is any of the following:

* Any object of any Raku class that composes the Raku role `Blob`
such that every integer is in the set `0..255`.

Note that the Raku role `Buf` composes the Raku role `Blob` and so objects
of classes that compose the latter also compose the former.

Not permitted for a *SYS_Blob* is any of the following,
to prevent ambiguity and simplify things:

* Any object of the Raku class `List` whose elements are **Integer** artifacts.
This is because that would be interpreted as a **Lot** artifact all of whose
members are any **Integer** artifacts.

[RETURN](#TOP)

<a name="Text---Attribute-Name"></a>

## Text / Attribute Name

A **Text** artifact is any of the following:

* Any *SYS_Text*.

A *SYS_Text* is any of the following:

* Any object of the Raku class `Str` that is *well formed*.

* Any object of the Raku class `Uni` that is *well formed*.

Note that *well formed* means there are no UTF-16 surrogate code points
defined in it that aren't in valid surrogate pairs.

Not permitted for a *SYS_Text* is any of the following,
to keep things more correct and simpler:

* Any object of the Raku class `Str` that is not *well formed*,
if such a thing exists.

* Any object of the Raku class `Uni` that is not *well formed*,
if such a thing exists.

* Any object of any of the Raku classes `IntStr` or `RatStr` or `NumStr`
or of any other allomorphic class.

[RETURN](#TOP)

<a name="Nesting---Attribute-Name-List"></a>

## Nesting / Attribute Name List

A **Nesting** artifact is any of the following:

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Nesting`
and its *SYS_that* is any *SYS_Nesting*.

Not permitted for a **Nesting** is any of the following,
to prevent ambiguity and simplify things:

* Any *SYS_Array_T*.  This is because that would be interpreted as
a **Lot** artifact all of whose members are any **Text** artifacts.

A *SYS_Nesting* is any of the following:

* Any *SYS_Array_T*.

* Any *SYS_Text*.

A *SYS_Array_T* is any of the following:

* Any *SYS_Array_A* such that each of its elements is any *SYS_Text*.

[RETURN](#TOP)

<a name="COLLECTIVE-DATA-TYPE-POSSREPS"></a>

# COLLECTIVE DATA TYPE POSSREPS

[RETURN](#TOP)

<a name="Pair"></a>

## Pair

A **Pair** artifact is any of the following:

* Any *SYS_Pair_AA* such that its *SYS_this* is *this*
(any **Any** artifact except for any of the *SYS_Text* values
`Ignorance`, `Boolean`, `Integer`, `Rational`, `Binary`, `Decimal`, `Bits`,
`Blob`, `Text`, `Nesting`, `Pair`, `Lot_m`, `Lot_mm`, `Kit_a`, `Kit_na`)
and its *SYS_that* is *that* (any **Any** artifact).

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Pair`
and its *SYS_that* is
any *SYS_Pair_AA* such that its *SYS_this* is *this* (any **Any** artifact)
and its *SYS_that* is *that* (any **Any** artifact).

A *SYS_Pair_TA* is any of the following:

* Any *SYS_Pair_AA* such that its *SYS_this* is any *SYS_Text*.

A *SYS_Pair_AA* is any of the following:

* Any object of the Raku class `Pair`
such that its `key` property is *SYS_this* and its `value` property is *SYS_that*.

Not permitted for a *SYS_Pair_AA* is any of the following,
to keep things more correct and simpler:

* Any values or objects of N-ary collection types having exactly 2 elements.

[RETURN](#TOP)

<a name="Lot"></a>

## Lot

A **Lot** artifact is any of the following:

* Any *SYS_Non_Qualified_Lot_M*.

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Lot_m`
and its *SYS_that* is any *SYS_Non_Qualified_Lot_M*.

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Lot_mm`
and its *SYS_that* is
any *SYS_Array_DAA* such that each of its elements in turn is
*multiplied member* whose *SYS_this* is *member* (any **Any** artifact)
and whose *SYS_that* is *multiplicity*
(any **Any** artifact but conceptually a real number);
this format can express every possible **Lot**,
such that an explicit multiplicity is specified for each member as a number
rather than by repeating the member value for each instance.

A *SYS_Non_Qualified_Lot_M* is any of the following:

* Any *SYS_Array_A* such that each of its elements in turn is *member*
(any **Any** artifact) and its corresponding *multiplicity* is 1;
this format can express every possible **Lot**,
such that each distinct member repeats per instance.

A *SYS_Array_DAA* is any of the following:

* Any *SYS_Array_A* such that each of its elements is any *SYS_Pair_AA*.

A *SYS_Array_A* is any of the following:

* Any object of the Raku class `List`.

Note that the Raku classes `Array` and `Slip` are subtypes of `List` and
so their objects can be used anywhere `List` objects can be used.

[RETURN](#TOP)

<a name="Kit"></a>

## Kit

A **Kit** artifact is any of the following:

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Kit_a`
and its *SYS_that* is
any *SYS_Array_A* having at most 32 elements such that each of its elements
in turn is *attribute asset* (any **Any** artifact) and its corresponding
*attribute name* is the ordinal position of that element;
this format can express any **Kit** which has only normalized positional attributes
and which has 0..32 attributes,
so to specify 33 or more attributes, the general format must be used;
this format is more concise than the general format.

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Kit_na`
and its *SYS_that* is any *SYS_Non_Qualified_Kit_NA*.

A *SYS_Non_Qualified_Kit_NA* is any of the following:

* Any *SYS_Array_DAA* such that each of its elements in turn is
*attribute* whose *SYS_this* is *attribute name* (any *SYS_Text*)
and whose *SYS_that* is *attribute asset* (any **Any** artifact);
this format can express every possible **Kit**.

Note that objects of the Raku class `Map` (or of its subclasses such as `Hash`)
are not used to represent collections of pairs because they are
unordered collections, and Raku doesn't provide any ordered analogy.

Note that an object of the Raku class `Capture` is a direct **Kit**/*tuple*
analogy which extends to the fact that a primary purpose of both is to
represent a collection of arguments for a routine.

A *SYS_Positional_Tuple_A* is any of the following:

* Any *SYS_Array_A*.

[RETURN](#TOP)

<a name="AUTHOR"></a>

# AUTHOR

Darren Duncan - darren@DarrenDuncan.net

[RETURN](#TOP)

<a name="LICENSE-AND-COPYRIGHT"></a>

# LICENSE AND COPYRIGHT

This file is part of the formal specification named
**Muldis Object Notation** (**MUON**).

MUON is Copyright © 2002-2023, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of [Overview](Muldis_Object_Notation.md) for details.
