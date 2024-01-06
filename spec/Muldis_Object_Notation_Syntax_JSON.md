<a name="TOP"></a>

# NAME

Muldis Object Notation (MUON) - Source code and data interchange format

# VERSION

The fully-qualified name of this document is
`Muldis_Object_Notation https://muldis.com 0.400.0`.

# PART

This artifact is part 21 of 22 of the document
`Muldis_Object_Notation https://muldis.com 0.400.0`;
its part name is `Syntax_JSON`.

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
    ["Muldis_Object_Notation_Syntax",[["Lot_m",["JSON", "https://muldis.com", "0.400.0"]],
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
canonical concrete JavaScript Object Notation (JSON) hosted syntax of MUON,
which expresses a MUON artifact in terms of a well-formed JSON document,
which can exist as a raw file in a filesystem or be exchanged over a
network or exist in memory of any program as a character string value.

The MUON `Syntax_JSON` is derived from and maps with the MUON
[Syntax_Abstract](Muldis_Object_Notation_Syntax_Abstract.md); see that plus
[Semantics](Muldis_Object_Notation_Semantics.md) for further context.

The MUON JSON hosted format is semi-lightweight and designed to
support interchange of source code and data between any 2 environments that
do not have a common working memory, such as because they are distinct
machine processes written in different programming languages, or because
they are on distinct machines, or because they are mediated by a network or
disk file.  The format is fairly easy for humans to read and write.  It is
fairly easy for machines to parse and generate.

The MUON `Syntax_JSON` supports, as an option, a subset of the MUON
[Syntax_Plain_Text](Muldis_Object_Notation_Syntax_Plain_Text.md)
concrete literal formats, embedded within JSON `string` values.
This is particularly important for the lossless conveyance of **Integer**
artifacts of larger magnitudes or derivatives since JSON `number`
representations of such may not be supported by some JSON implementations.
This is also useful for conveyence of
**Rational** and **Binary** and **Decimal** and **Bits** and **Blob**
artifacts as it opens up more compact options than are otherwise available.

The prescribed standard *syntax base name* of a *syntax-qualified artifact*
for a MUON JSON hosted artifact is `JSON`.

See also <https://json.org>.

[RETURN](#TOP)

<a name="SIMPLE-DATA-TYPE-POSSREPS"></a>

# SIMPLE DATA TYPE POSSREPS

[RETURN](#TOP)

<a name="Ignorance"></a>

## Ignorance

An **Ignorance** artifact is any of the following:

* The special JSON `null` value.

[RETURN](#TOP)

<a name="Boolean"></a>

## Boolean

A **Boolean** artifact is any of the following:

* The special JSON `false` and `true` values.

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
and its *SYS_that* is any *SYS_or_embedded_Integer*.

Not permitted for an **Integer** is any of the following,
to keep things more correct and simpler:

* Any value of any character string type such that it represents a
sequence of digits or anything else resembles a numeric literal.
This is because that would be interpreted as a **Text** artifact.

A *SYS_Integer* is any of the following:

* Any *SYS_Rational* that represents a whole number.

Not permitted for a *SYS_Integer* is any of the following,
to keep things more correct and simpler:

* Any *SYS_Rational* that doesn't represent a whole number.

A *SYS_or_embedded_Integer* is any of the following:

* Any *SYS_Integer*.

* Any *embedded_MUON_PT_Integer*.

An *embedded_MUON_PT_Integer* is any of the following:

* Any *embedded_MUON_PT_parsing_unit* that denotes any **Integer** artifact.

An *embedded_MUON_PT_parsing_unit* is any of the following:

* Any *SYS_Text* that can be successfully interpreted as a
`Muldis_Object_Notation_Plain_Text` parsing unit consisting of a single
**Integer** or **Rational** or **Binary** or **Decimal**
or **Bits** or **Blob** artifact.

[RETURN](#TOP)

<a name="Rational"></a>

## Rational

A **Rational** artifact is any of the following:

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Rational`
and its *SYS_that* is any *SYS_Rational*
or any *embedded_MUON_PT_Rational* or any *embedded_MUON_PT_Binary*
or any *embedded_MUON_PT_Decimal* or any *SYS_or_embedded_Integer*.

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Rational`
and its *SYS_that* is
any *SYS_Pair_AA* such that its *SYS_this* and *SYS_that* correspond to
the *numerator* (any *SYS_or_embedded_Integer*)
and *denominator* (any *SYS_or_embedded_Integer*
which denotes a nonzero integer) of the new **Rational** respectively.

Not permitted for a **Rational** is any of the following,
to keep things more correct and simpler:

* Any *SYS_Rational*.
This is because that would often be interpreted as an **Integer** artifact.

* Any value of any character string type such that it represents a
sequence of digits or anything else resembles a numeric literal.
This is because that would typically be interpreted as a **Text** artifact.

A *SYS_Rational* is any of the following:

* Any value of the JSON type `number`
that represents a finite number or signed zero;
both signed zeroes are treated as the same plain zero.

Not permitted for a *SYS_Rational* is any of the following,
to keep things more correct and simpler:

* Any value of the JSON type `number`
that represents an infinity or NaN.

An *embedded_MUON_PT_Rational* is any of the following:

* Any *embedded_MUON_PT_parsing_unit* that denotes any **Rational** artifact.

[RETURN](#TOP)

<a name="Binary"></a>

## Binary

A **Binary** artifact is any of the following:

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Binary`
and its *SYS_that* is any *SYS_Rational*
or any *embedded_MUON_PT_Binary* or any *SYS_or_embedded_Integer*.

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Binary`
and its *SYS_that* is
any *SYS_Pair_AA* such that its *SYS_this* and *SYS_that* correspond to
the *significand* (any *SYS_or_embedded_Integer*) and *exponent*
(any *SYS_or_embedded_Integer*) of the new **Binary** respectively.

An *embedded_MUON_PT_Binary* is any of the following:

* Any *embedded_MUON_PT_parsing_unit* that denotes any **Binary** artifact.

[RETURN](#TOP)

<a name="Decimal"></a>

## Decimal

A **Decimal** artifact is any of the following:

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Decimal`
and its *SYS_that* is any *SYS_Rational*
or any *embedded_MUON_PT_Decimal* or any *SYS_or_embedded_Integer*.

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Decimal`
and its *SYS_that* is
any *SYS_Pair_AA* such that its *SYS_this* and *SYS_that* correspond to
the *significand* (any *SYS_or_embedded_Integer*) and *exponent*
(any *SYS_or_embedded_Integer*) of the new **Decimal** respectively.

An *embedded_MUON_PT_Decimal* is any of the following:

* Any *embedded_MUON_PT_parsing_unit* that denotes any **Decimal** artifact.

[RETURN](#TOP)

<a name="Bits"></a>

## Bits

A **Bits** artifact is any of the following:

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Bits`
and its *SYS_that* is any *SYS_Non_Qualified_Bits*.

A *SYS_Non_Qualified_Bits* is any of the following:

* Any *SYS_Array_A* such that every element is any *SYS_Integer* in `0..1`.

* Any *embedded_MUON_PT_Bits*.

An *embedded_MUON_PT_Bits* is any of the following:

* Any *embedded_MUON_PT_parsing_unit* that denotes any **Bits** artifact.

[RETURN](#TOP)

<a name="Blob"></a>

## Blob

A **Blob** artifact is any of the following:

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Blob`
and its *SYS_that* is any *SYS_Non_Qualified_Blob*.

A *SYS_Non_Qualified_Blob* is any of the following:

* Any *SYS_Array_A* such that every element is any *SYS_Integer* in `0..255`.

* Any *embedded_MUON_PT_Blob*.

An *embedded_MUON_PT_Blob* is any of the following:

* Any *embedded_MUON_PT_parsing_unit* that denotes any **Blob** artifact.

[RETURN](#TOP)

<a name="Text---Attribute-Name"></a>

## Text / Attribute Name

A **Text** artifact is any of the following:

* Any *SYS_Text*.

A *SYS_Text* is any of the following:

* Any value of the JSON type `string` that is *well formed UTF-8*.

Note that *well formed UTF-8* means all octet sequences are valid Unicode UTF-8
and there are no UTF-16 surrogate code points
defined in it that aren't in valid surrogate pairs.

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

* Any value of the JSON type `array`.

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

Note that JSON `object` values
are not used to represent collections of pairs because they are
unordered collections, and JSON doesn't provide any ordered analogy.

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
