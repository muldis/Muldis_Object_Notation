<a name="TOP"></a>

# NAME

Muldis Object Notation (MUON) - Source code and data interchange format

# VERSION

The fully-qualified name of this document is
`Muldis_Object_Notation https://muldis.com 0.300.0`.

# PART

This artifact is part 19 of 20 of the document
`Muldis_Object_Notation https://muldis.com 0.300.0`;
its part name is `Syntax_JSON`.

# CONTENTS

- [SYNOPSIS](#SYNOPSIS)
- [DESCRIPTION](#DESCRIPTION)
- [SIMPLE PRIMARY DATA TYPE POSSREPS](#SIMPLE-PRIMARY-DATA-TYPE-POSSREPS)
    - [Ignorance](#Ignorance)
    - [Boolean](#Boolean)
    - [Integer](#Integer)
    - [Fraction](#Fraction)
    - [Bits](#Bits)
    - [Blob](#Blob)
    - [Text / Attribute Name](#Text---Attribute-Name)
    - [Nesting / Attribute Name List](#Nesting---Attribute-Name-List)
- [COLLECTIVE PRIMARY DATA TYPE POSSREPS](#COLLECTIVE-PRIMARY-DATA-TYPE-POSSREPS)
    - [Duo](#Duo)
    - [Lot](#Lot)
    - [Kit](#Kit)
    - [Article / Labelled Tuple](#Article---Labelled-Tuple)
    - [Excuse](#Excuse)
- [SEE ALSO](#SEE-ALSO)
- [AUTHOR](#AUTHOR)
- [LICENSE AND COPYRIGHT](#LICENSE-AND-COPYRIGHT)
- [TRADEMARK POLICY](#TRADEMARK-POLICY)
- [ACKNOWLEDGEMENTS](#ACKNOWLEDGEMENTS)

[RETURN](#TOP)

<a name="SYNOPSIS"></a>

# SYNOPSIS

```
    ["Syntax",[["Lot",["Muldis_Object_Notation_JSON", "https://muldis.com", "0.300.0"]],
        ["Model",[["Lot",["Muldis_Data_Language", "https://muldis.com", "0.300.0"]],
            ["Relation",["Lot",[
                ["Kit",["named",[
                    ["name", "Jane Ives"],
                    ["birth_date", ["Calendar_Instant",
                        ["Kit",["named",[["y",1971],["m",11],["d",6]]]]]],
                    ["phone_numbers", ["Set",["Lot",["+1.4045552995", "+1.7705557572"]]]]
                ]]],
                ["Kit",["named",[
                    ["name", "Layla Miller"],
                    ["birth_date", ["Calendar_Instant",
                        ["Kit",["named",[["y",1995],["m",8],["d",27]]]]]],
                    ["phone_numbers", ["Set",["Lot",[]]]]
                ]]],
                ["Kit",["named",[
                    ["name", "岩倉 玲音"],
                    ["birth_date", ["Calendar_Instant",
                        ["Kit",["named",[["y",1984],["m",7],["d",6]]]]]],
                    ["phone_numbers", ["Set",["Lot",["+81.9072391679"]]]]
                ]]]
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

The MUON JSON-hosted format is semi-lightweight and designed to
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
This is also useful for conveyence of **Fraction** and **Bits** and **Blob**
artifacts as it opens up more compact options than are otherwise available.

The prescribed standard *syntax predicate* of a **Syntax** signature for a
MUON JSON-hosted artifact is `Muldis_Object_Notation_JSON`.

See also <https://json.org>.

[RETURN](#TOP)

<a name="SIMPLE-PRIMARY-DATA-TYPE-POSSREPS"></a>

# SIMPLE PRIMARY DATA TYPE POSSREPS

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

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `Integer`
and its *SYS_that* is any *SYS_or_embedded_Integer*.

Not permitted for an **Integer** is any of the following,
to keep things more correct and simpler:

* Any value of any character string type such that it represents a
sequence of digits or anything else resembles a numeric literal.
This is because that would be interpreted as a **Text** artifact.

A *SYS_Integer* is any of the following:

* Any *SYS_Fraction* that represents a whole number.

Not permitted for a *SYS_Integer* is any of the following,
to keep things more correct and simpler:

* Any *SYS_Fraction* that doesn't represent a whole number.

A *SYS_or_embedded_Integer* is any of the following:

* Any *SYS_Integer*.

* Any *embedded_MUON_PT_Integer*.

An *embedded_MUON_PT_Integer* is any of the following:

* Any *embedded_MUON_PT_parsing_unit* that denotes any **Integer** artifact.

An *embedded_MUON_PT_parsing_unit* is any of the following:

* Any *SYS_Text* that can be successfully interpreted as a
`Muldis_Object_Notation_Plain_Text` parsing unit consisting of a single
**Integer** or **Fraction** or **Bits** or **Blob** artifact.

[RETURN](#TOP)

<a name="Fraction"></a>

## Fraction

A **Fraction** artifact is any of the following:

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `Fraction`
and its *SYS_that* is any *SYS_Non_Qualified_Fraction*.

Not permitted for a **Fraction** is any of the following,
to keep things more correct and simpler:

* Any *SYS_Fraction*.
This is because that would often be interpreted as an **Integer** artifact.

* Any value of any character string type such that it represents a
sequence of digits or anything else resembles a numeric literal.
This is because that would typically be interpreted as a **Text** artifact.

A *SYS_Non_Qualified_Fraction* is any of the following:

* Any *embedded_MUON_PT_Fraction*.

* Any *significand*.

* Any *SYS_Ordered_Tuple_A* having exactly 1 element which
is the *significand*.

* Any *SYS_Ordered_Tuple_A* having exactly 2 elements which in
ascending order are the *numerator* and *denominator*.

* Any *SYS_Ordered_Tuple_A* having exactly 3 elements which in
ascending order are the *significand*, *radix*, and *exponent*.

* Any *SYS_Ordered_Tuple_A* having exactly 4 elements which in
ascending order are the *numerator*, *denominator*, *radix*, and *exponent*.

A *significand* is any *SYS_Fraction* or any *SYS_or_embedded_Integer*.

A *numerator* is any *SYS_or_embedded_Integer*.

A *denominator* is any *SYS_or_embedded_Integer* which denotes a nonzero integer.

A *radix* is any *SYS_or_embedded_Integer* which denotes an integer that is at least 2.

An *exponent* is any *SYS_or_embedded_Integer*.

A *SYS_Fraction* is any of the following:

* Any value of the JSON type `number`
that represents a finite number or signed zero;
both signed zeroes are treated as the same plain zero.

Not permitted for a *SYS_Fraction* is any of the following,
to keep things more correct and simpler:

* Any value of the JSON type `number`
that represents an infinity or NaN.

An *embedded_MUON_PT_Fraction* is any of the following:

* Any *embedded_MUON_PT_parsing_unit* that denotes any **Fraction** artifact.

[RETURN](#TOP)

<a name="Bits"></a>

## Bits

A **Bits** artifact is any of the following:

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `Bits`
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

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `Blob`
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

* Any value of the JSON type `string` that is *well formed*.

Note that *well formed* means all octet sequences are valid Unicode UTF-8
and there are no UTF-16 surrogate code points
defined in it that aren't in valid surrogate pairs.

[RETURN](#TOP)

<a name="Nesting---Attribute-Name-List"></a>

## Nesting / Attribute Name List

A **Nesting** artifact is any of the following:

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `Nesting`
and its *SYS_that* is any *SYS_Nesting*.

Not permitted for a **Nesting** is any of the following,
to prevent ambiguity and simplify things:

* Any *SYS_Array_T*.  This is because that would be interpreted as
a **Duo** artifact all of whose members are any **Text** artifacts,
or as something invalid.

A *SYS_Nesting* is any of the following:

* Any *SYS_Array_T*.

* Any *SYS_Text*.

A *SYS_Array_T* is any of the following:

* Any *SYS_Array_A* such that each of its elements is any *SYS_Text*.

[RETURN](#TOP)

<a name="COLLECTIVE-PRIMARY-DATA-TYPE-POSSREPS"></a>

# COLLECTIVE PRIMARY DATA TYPE POSSREPS

[RETURN](#TOP)

<a name="Duo"></a>

## Duo

A **Duo** artifact is any of the following:

* Any *SYS_Duo_AA* such that its *SYS_this* is *this*
(any **Any** artifact except for any *Primary_Possrep_Name*
and except for the *SYS_Text* values `multiplied` and `named`)
and its *SYS_that* is *that* (any **Any** artifact).

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `Duo`
and its *SYS_that* is
any *SYS_Duo_AA* such that its *SYS_this* is *this* (any **Any** artifact)
and its *SYS_that* is *that* (any **Any** artifact).

A *SYS_Duo_TA* is any of the following:

* Any *SYS_Duo_AA* such that its *SYS_this* is any *SYS_Text*.

A *SYS_Duo_AA* is any of the following:

* Any *SYS_Ordered_Tuple_A* having exactly 2 elements
such that its first element is *SYS_this* and its second element is *SYS_that*.

[RETURN](#TOP)

<a name="Lot"></a>

## Lot

A **Lot** artifact is any of the following:

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `Lot`
and its *SYS_that* is any *SYS_Non_Qualified_Lot*.

A *SYS_Non_Qualified_Lot* is any of the following:

* Any *SYS_Non_Qualified_Array_Lot*.

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `multiplied`
and its *SYS_that* is
any *SYS_Array_DAA* such that each of its elements in turn is
*multiplied member* whose *SYS_this* is *member* (any **Any** artifact)
and whose *SYS_that* is *multiplicity*
(any **Any** artifact but conceptually a real number);
this format can express every possible **Lot**,
such that an explicit multiplicity is specified for each member as a number
rather than by repeating the member value for each instance.

A *SYS_Non_Qualified_Array_Lot* is any of the following:

* Any *SYS_Array_A* such that each of its elements in turn is *member*
(any **Any** artifact) and its corresponding *multiplicity* is 1;
this format can express every possible **Lot**,
such that each distinct member repeats per instance.

A *SYS_Array_DAA* is any of the following:

* Any *SYS_Array_A* such that each of its elements is any *SYS_Duo_AA*.

A *SYS_Array_A* is any of the following:

* Any value of the JSON type `array`.

[RETURN](#TOP)

<a name="Kit"></a>

## Kit

A **Kit** artifact is any of the following:

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `Kit`
and its *SYS_that* is any *SYS_Non_Qualified_Kit*.

A *SYS_Non_Qualified_Kit* is any of the following:

* Any *SYS_Array_A* such that each of its elements
in turn is *attribute asset* (any **Any** artifact) and its corresponding
*attribute name* is the ordinal position of that element;
this format can express any **Kit** which has only normalized ordered attributes;
this format is more concise than the general format.

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `named`
and its *SYS_that* is any *SYS_Non_Qualified_Named_Kit*.

A *SYS_Non_Qualified_Named_Kit* is any of the following:

* Any *SYS_Array_DAA* such that each of its elements in turn is
*attribute* whose *SYS_this* is *attribute name* (any *SYS_Text*)
and whose *SYS_that* is *attribute asset* (any **Any** artifact);
this format can express every possible **Kit**.

Note that JSON `object` values
are not used to represent collections of pairs because they are
unordered collections, and JSON doesn't provide any ordered analogy.

A *SYS_Ordered_Tuple_A* is any of the following:

* Any *SYS_Array_A*.

[RETURN](#TOP)

<a name="Article---Labelled-Tuple"></a>

## Article / Labelled Tuple

An **Article** artifact is any of the following:

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `Article`
and its *SYS_that* is any *SYS_Duo_AA* such that
its *SYS_this* is *label* (any *SYS_Nesting*) and
its *SYS_that* is *attributes* (any *SYS_Non_Qualified_Named_Kit*).

[RETURN](#TOP)

<a name="Excuse"></a>

## Excuse

An **Excuse** artifact is any of the following:

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `Excuse`
and its *SYS_that* is any *SYS_Duo_AA* such that
its *SYS_this* is *label* (any *SYS_Nesting*) and
its *SYS_that* is *attributes* (any *SYS_Non_Qualified_Named_Kit*).

[RETURN](#TOP)

<a name="SEE-ALSO"></a>

# SEE ALSO

*TODO.*

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

[RETURN](#TOP)

<a name="TRADEMARK-POLICY"></a>

# TRADEMARK POLICY

The TRADEMARK POLICY in [Overview](Muldis_Object_Notation.md) applies to this file too.

[RETURN](#TOP)

<a name="ACKNOWLEDGEMENTS"></a>

# ACKNOWLEDGEMENTS

The ACKNOWLEDGEMENTS in [Overview](Muldis_Object_Notation.md) apply to this file too.
