<a name="TOP"></a>

# NAME

Muldis Object Notation (MUON) - Source code and data interchange format

# VERSION

The fully-qualified name of this document is
`Muldis_Object_Notation https://muldis.com 0.400.0`.

# PART

This artifact is part 5 of 22 of the document
`Muldis_Object_Notation https://muldis.com 0.400.0`;
its part name is `Syntax_Abstract`.

# CONTENTS

- [DESCRIPTION](#DESCRIPTION)
- [OVERVIEW OF ABSTRACT DATA TYPE POSSREPS](#OVERVIEW-OF-ABSTRACT-DATA-TYPE-POSSREPS)
- [ALGEBRAIC DATA TYPE POSSREPS](#ALGEBRAIC-DATA-TYPE-POSSREPS)
    - [Any / Universal Type Possrep](#Any---Universal-Type-Possrep)
    - [None / Empty Type Possrep](#None---Empty-Type-Possrep)
- [SIMPLE DATA TYPE POSSREPS](#SIMPLE-DATA-TYPE-POSSREPS)
    - [Ignorance](#Ignorance)
    - [Boolean](#Boolean)
    - [Integer](#Integer)
    - [Rational](#Rational)
    - [Binary](#Binary)
    - [Decimal](#Decimal)
    - [Bits](#Bits)
    - [Blob](#Blob)
    - [Text](#Text)
    - [Name](#Name)
    - [Nesting / Attribute Name List](#Nesting---Attribute-Name-List)
- [COLLECTIVE DATA TYPE POSSREPS](#COLLECTIVE-DATA-TYPE-POSSREPS)
    - [Pair](#Pair)
    - [Lot](#Lot)
    - [Kit](#Kit)
- [AUTHOR](#AUTHOR)
- [LICENSE AND COPYRIGHT](#LICENSE-AND-COPYRIGHT)

[RETURN](#TOP)

<a name="DESCRIPTION"></a>

# DESCRIPTION

This document consists of multiple parts; for a directory to all of the
parts, see [Overview](Muldis_Object_Notation.md).

This part of the **Muldis Object Notation** document specifies the
fundamental abstract syntax of MUON, which expresses a MUON artifact in
terms of a few kinds of simple generic data structures such as integers and
ordered lists.  This abstract syntax is what all concrete MUON syntaxes are
designed to satisfy the requirements of and map with.

[RETURN](#TOP)

<a name="OVERVIEW-OF-ABSTRACT-DATA-TYPE-POSSREPS"></a>

# OVERVIEW OF ABSTRACT DATA TYPE POSSREPS

Each valid abstract MUON artifact is an instance of a single abstract MUON
possrep.  Each abstract MUON possrep is of exactly one of these 2 kinds:
*algebraic possrep*, *non-algebraic possrep*.

This document considers each abstract MUON *non-algebraic possrep* to be
fundamental and to simply exist.  It is manadatory that each concrete MUON
syntax will bootstrap a *non-algebraic possrep* in terms of one or more
dedicated concrete literal formats or host language data types.

This document considers each abstract MUON *algebraic possrep* to be
non-fundamental and to be defined as a union of 0..N *non-algebraic possrep*.

See [Semantics](Muldis_Object_Notation_Semantics.md) for further context.

See [Syntax_Plain_Text](Muldis_Object_Notation_Syntax_Plain_Text.md)
for illustrative example code in that satisfying concrete format.

[RETURN](#TOP)

<a name="ALGEBRAIC-DATA-TYPE-POSSREPS"></a>

# ALGEBRAIC DATA TYPE POSSREPS

[RETURN](#TOP)

<a name="Any---Universal-Type-Possrep"></a>

## Any / Universal Type Possrep

An **Any** artifact is an artifact that qualifies as any of the other MUON
artifacts, since the **Any** possrep is characterized by the union of all
other possreps.

[RETURN](#TOP)

<a name="None---Empty-Type-Possrep"></a>

## None / Empty Type Possrep

A **None** artifact is an artifact that qualifies as none of the other MUON
artifacts, since the **None** possrep is characterized by the intersection
of all other possreps.  That is, there are no **None** artifacts at all,
and this possrep is just mentioned as the logical complement of **Any**.

[RETURN](#TOP)

<a name="SIMPLE-DATA-TYPE-POSSREPS"></a>

# SIMPLE DATA TYPE POSSREPS

[RETURN](#TOP)

<a name="Ignorance"></a>

## Ignorance

An **Ignorance** artifact is a singleton.

[RETURN](#TOP)

<a name="Boolean"></a>

## Boolean

A **Boolean** artifact is any of the 2 logic boolean values *false* and *true*.

[RETURN](#TOP)

<a name="Integer"></a>

## Integer

An **Integer** artifact is any generic exact integral number of any magnitude.

[RETURN](#TOP)

<a name="Rational"></a>

## Rational

A **Rational** artifact is any generic exact rational number
of any magnitude and precision.

[RETURN](#TOP)

<a name="Binary"></a>

## Binary

A **Binary** artifact is any generic exact rational number,
which is a binary fraction, of any magnitude and precision.

[RETURN](#TOP)

<a name="Decimal"></a>

## Decimal

A **Decimal** artifact is any generic exact rational number,
which is a decimal fraction, of any magnitude and precision.

[RETURN](#TOP)

<a name="Bits"></a>

## Bits

A **Bits** artifact is an arbitrarily-large ordered sequence of *bits* where each
bit is an integer in the set `0..1`.

[RETURN](#TOP)

<a name="Blob"></a>

## Blob

A **Blob** artifact is an arbitrarily-large ordered sequence of *octets* where each
octet is an integer in the set `0..255`.

[RETURN](#TOP)

<a name="Text"></a>

## Text

A **Text** artifact is an arbitrarily-large ordered sequence of **Unicode** standard
*character code points* where each code point is an integer in the set
`[0..0xD7FF,0xE000..0x10FFFF]`.

[RETURN](#TOP)

<a name="Name"></a>

## Name

A **Name** artifact is a standalone *attribute name*
which is an nonqualified program identifier.

[RETURN](#TOP)

<a name="Nesting---Attribute-Name-List"></a>

## Nesting / Attribute Name List

A **Nesting** artifact is an arbitrarily-large ordered sequence of
*attribute names* (each one a **Text**), having at least 1 element.

[RETURN](#TOP)

<a name="COLLECTIVE-DATA-TYPE-POSSREPS"></a>

# COLLECTIVE DATA TYPE POSSREPS

[RETURN](#TOP)

<a name="Pair"></a>

## Pair

A **Pair** artifact is an ordered collection having exactly 2 elements
which in order are named *this* (any **Any** artifact)
and *that* (any **Any** artifact).

[RETURN](#TOP)

<a name="Lot"></a>

## Lot

A **Lot** artifact is an arbitrarily-large ordered collection of elements
each of which in turn is named *multiplied member* such that each
*multiplied member* is an ordered collection having exactly 2 elements
which in order are named *member* (any **Any** artifact) and *multiplicity*
(any **Any** artifact but conceptually a real number).

[RETURN](#TOP)

<a name="Kit"></a>

## Kit

A **Kit** artifact is an arbitrarily-large ordered collection of elements
each of which in turn is named *attribute* such that each
*attribute* is an ordered collection having exactly 2 elements
which in order are named *attribute name* (any **Text** artifact)
and *attribute asset* (any **Any** artifact),
such that no 2 attributes have the same *attribute name*.

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
