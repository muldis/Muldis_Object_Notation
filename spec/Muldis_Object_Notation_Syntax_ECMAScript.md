<a name="TOP"></a>

# NAME

Muldis Object Notation (MUON) - Source code and data interchange format

# VERSION

The fully-qualified name of this document is
`Muldis_Object_Notation https://muldis.com 0.400.0`.

# PART

This artifact is part 17 of 22 of the document
`Muldis_Object_Notation https://muldis.com 0.400.0`;
its part name is `Syntax_ECMAScript`.

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
    ["Muldis_Object_Notation_Syntax",[["Lot_m",["ECMAScript", "https://muldis.com", "0.400.0"]],
        ["Muldis_Object_Notation_Model",[["Lot_m",["Muldis_Data_Language", "https://muldis.com", "0.400.0"]],
            ["Relation",["Lot_m",[
                ["Kit_na",[
                    ["name", "Jane Ives"],
                    ["birth_date", ["Calendar_Instant",
                        ["Kit_na",[["y",1971],["m",11],["d",6]]]]],
                    ["phone_numbers", ["Set",["Lot_m",["+1.4045552995", "+1.7705557572"]]]]
                ]],
                ["Kit_na",[
                    ["name", "Layla Miller"],
                    ["birth_date", ["Calendar_Instant",
                        ["Kit_na",[["y",1995],["m",8],["d",27]]]]],
                    ["phone_numbers", ["Set",["Lot_m",[]]]]
                ]],
                ["Kit_na",[
                    ["name", "岩倉 玲音"],
                    ["birth_date", ["Calendar_Instant",
                        ["Kit_na",[["y",1984],["m",7],["d",6]]]]],
                    ["phone_numbers", ["Set",["Lot_m",["+81.9072391679"]]]]
                ]]
            ]]]
        ]]
    ]]
```

[RETURN](#TOP)

<a name="DESCRIPTION"></a>

# DESCRIPTION

This document consists of multiple parts; for a directory to all of the
parts, see [Overview](Muldis_Object_Notation.md).

This part of the **Muldis Object Notation** document specifies the
canonical concrete ECMAScript hosted syntax of MUON,
which expresses a MUON artifact in terms of a native in-memory value or
object of the ECMAScript programming language,
version 14 (2023; or 11, 2020) or later,
as a non-cyclic data structure composed only using system-defined types.

The MUON `Syntax_ECMAScript` is derived from and maps with the MUON
[Syntax_Abstract](Muldis_Object_Notation_Syntax_Abstract.md); see that plus
[Semantics](Muldis_Object_Notation_Semantics.md) for further context.

The MUON ECMAScript hosted format is semi-lightweight and designed to support
interchange of source code and data between any 2 environments that do have
a common working memory and run the ECMAScript programming language, such as
because they collectively are part of a single process of an ECMAScript virtual
machine.  One typical use case is an ECMAScript library generic API that
accepts or returns structured data using a well-defined protocol such that
the library and its users require no common dependencies besides ECMAScript
standard library classes.  Another typical use case is the bridge format of
an ECMAScript library for generating or parsing MUON `Syntax_Plain_Text`.
The format is fairly easy for humans to read and write in terms of plain
ECMAScript source code.  It is fairly easy for machines to parse and generate.

The prescribed standard *syntax base name* of a *syntax-qualified artifact*
for a MUON ECMAScript hosted artifact is `ECMAScript`.

See also <https://ecma-international.org/publications-and-standards/standards/ecma-262>.

Note that a few details in this document part may not be specific to
ECMAScript per se but instead to JavaScript (or TypeScript).
To be specific, the type system duality of unboxed and unboxed versions
of the same primitives might not be in ECMAScript itself.
For examples, `boolean` plus `Boolean` and `string` plus `String`.
More tweaking will likely need to be done regarding these things.

[RETURN](#TOP)

<a name="SIMPLE-DATA-TYPE-POSSREPS"></a>

# SIMPLE DATA TYPE POSSREPS

[RETURN](#TOP)

<a name="Ignorance"></a>

## Ignorance

An **Ignorance** artifact is any of the following:

* The only value of the ECMAScript singleton type `null`.

Not permitted for an **Ignorance** is any of the following,
to keep things more correct and simpler:

* The only value of the ECMAScript singleton type `undefined`.

[RETURN](#TOP)

<a name="Boolean"></a>

## Boolean

A **Boolean** artifact is any of the following:

* Any value of any of the ECMAScript types `boolean`, `Boolean`.

Not permitted for a **Boolean** is any of the following,
to keep things more correct and simpler:

* Any value of any numeric type such that zero/one represents false/true.

* Any value of some other type that might represent a boolean.

[RETURN](#TOP)

<a name="Integer"></a>

## Integer

An **Integer** artifact is any of the following:

* Any *SYS_Integer*.

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Integer`
and its *SYS_that* is any *SYS_Integer*.

Not permitted for an **Integer** is any of the following,
to keep things more correct and simpler:

* Any value of any character string type such that it represents a
sequence of digits or anything else resembles a numeric literal.
This is because that would be interpreted as a **Text** artifact.

A *SYS_Integer* is any of the following:

* Any *SYS_Binary* that represents a whole number.

* Any value of any of the ECMAScript types `bigint`, `BigInt`.

Not permitted for a *SYS_Integer* is any of the following,
to keep things more correct and simpler:

* Any *SYS_Binary* that doesn't represent a whole number.

Note that the types `bigint`, `BigInt` are only part of ECMAScript starting
with version 11 (2020), so that represents the minimum required to support
MUON for the general case of unlimited size numbers.

[RETURN](#TOP)

<a name="Rational"></a>

## Rational

A **Rational** artifact is any of the following:

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Rational`
and its *SYS_that* is any *SYS_Binary* or any *SYS_Integer*.

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Rational`
and its *SYS_that* is
any *SYS_Pair_AA* such that its *SYS_this* and *SYS_that* correspond to
the *numerator* (any *SYS_Integer*) and *denominator* (any *SYS_Integer*
which denotes a nonzero integer) of the new **Rational** respectively.

[RETURN](#TOP)

<a name="Binary"></a>

## Binary

A **Binary** artifact is any of the following:

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Binary`
and its *SYS_that* is any *SYS_Binary* or any *SYS_Integer*.

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Binary`
and its *SYS_that* is
any *SYS_Pair_AA* such that its *SYS_this* and *SYS_that* correspond to
the *significand* (any *SYS_Binary* or any *SYS_Integer*) and *exponent*
(any *SYS_Integer*) of the new **Binary** respectively.

Not permitted for a **Binary** is any of the following,
to keep things more correct and simpler:

* Any *SYS_Binary*.
This is because that would often be interpreted as an **Integer** artifact.

* Any value of any character string type such that it represents a
sequence of digits or anything else resembles a numeric literal.
This is because that would typically be interpreted as a **Text** artifact.

A *SYS_Binary* is any of the following:

* Any value of any of the ECMAScript types `number`, `Number`
that represents a finite number or signed zero;
both signed zeroes are treated as the same plain zero.

Not permitted for a *SYS_Binary* is any of the following,
to keep things more correct and simpler:

* Any value of any of the ECMAScript types `number`, `Number`
that represents an infinity or NaN;
note that ECMAScript has exactly 3 of these special values in total,
which have the literals `-Infinity`, `+Infinity` (or `Infinity`), `NaN`.

[RETURN](#TOP)

<a name="Decimal"></a>

## Decimal

A **Decimal** artifact is any of the following:

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Decimal`
and its *SYS_that* is any *SYS_Integer*.

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Decimal`
and its *SYS_that* is
any *SYS_Pair_AA* such that its *SYS_this* and *SYS_that* correspond to
the *significand* (any *SYS_Integer*) and *exponent*
(any *SYS_Integer*) of the new **Decimal** respectively.

[RETURN](#TOP)

<a name="Bits"></a>

## Bits

A **Bits** artifact is any of the following:

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Bits`
and its *SYS_that* is any *SYS_String*
such that every element is in the set `0..1`.

[RETURN](#TOP)

<a name="Blob"></a>

## Blob

A **Blob** artifact is any of the following:

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Blob`
and its *SYS_that* is any *SYS_String*
such that every element is in the set `0..255`.

Not permitted for a **Blob** is any of the following,
to prevent ambiguity and simplify things:

* Any *SYS_String*.
This is because that would be interpreted as a **Text** artifact if not invalid.

[RETURN](#TOP)

<a name="Text---Attribute-Name"></a>

## Text / Attribute Name

A **Text** artifact is any of the following:

* Any *SYS_Text*.

A *SYS_Text* is any of the following:

* Any *SYS_String* that is *well formed UTF-16*.

Not permitted for a *SYS_Text* is any of the following,
to keep things more correct and simpler:

* Any *SYS_String* that is not *well formed UTF-16*.

Note that *well formed UTF-16* means all integer sequences are valid Unicode
UTF-16 and there are no UTF-16 surrogate code points defined in it that
aren't in valid surrogate pairs.

A *SYS_String* is any of the following:

* Any value of any of the ECMAScript types `string`, `String`.

[RETURN](#TOP)

<a name="Nesting---Attribute-Name-List"></a>

## Nesting / Attribute Name List

A **Nesting** artifact is any of the following:

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Nesting`
and its *SYS_that* is any *SYS_Nesting*.

Not permitted for a **Nesting** is any of the following,
to prevent ambiguity and simplify things:

* Any *SYS_Array_T*.  This is because that would be interpreted as
a **Pair** artifact all of whose members are any **Text** artifacts,
or as something invalid.

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

* Any *SYS_Array_A* having exactly 2 elements
such that its first element is *SYS_this* and its second element is *SYS_that*.

[RETURN](#TOP)

<a name="Lot"></a>

## Lot

A **Lot** artifact is any of the following:

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

* Any value of the ECMAScript type `Array`.

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

Note that values of the ECMAScript type `Map`
are not used to represent collections of pairs because the ECMAScript
language standard does not guarantee that they preserve the insertion order
of elements, even if the defacto standard implementations all do so.

[RETURN](#TOP)

<a name="AUTHOR"></a>

# AUTHOR

Darren Duncan - darren@DarrenDuncan.net

[RETURN](#TOP)

<a name="LICENSE-AND-COPYRIGHT"></a>

# LICENSE AND COPYRIGHT

This file is part of the formal specification named
**Muldis Object Notation** (**MUON**).

MUON is Copyright © 2002-2024, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of [Overview](Muldis_Object_Notation.md) for details.
