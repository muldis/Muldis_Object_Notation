<a name="TOP"></a>

# NAME

Muldis Object Notation (MUON) - Source code and data interchange format

# VERSION

The fully-qualified name of this document is
`Muldis_Object_Notation https://muldis.com 0.400.0`.

# PART

This artifact is part 9 of 22 of the document
`Muldis_Object_Notation https://muldis.com 0.400.0`;
its part name is `Syntax_Muldis_Data_Language`.

# CONTENTS

- [SYNOPSIS](#SYNOPSIS)
- [DESCRIPTION](#DESCRIPTION)
- [SIMPLE DATA TYPE POSSREPS](#SIMPLE-DATA-TYPE-POSSREPS)
    - [Ignorance](#Ignorance)
    - [Boolean](#Boolean)
    - [Integer](#Integer)
    - [Fraction](#Fraction)
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

*No example provided as it would be identical to the MUON Plain Text (strict) version,
except that the `Muldis_Object_Notation_Syntax` would say `Muldis_Data_Language`.*

[RETURN](#TOP)

<a name="DESCRIPTION"></a>

# DESCRIPTION

This document consists of multiple parts; for a directory to all of the
parts, see [Overview](Muldis_Object_Notation.md).

This part of the **Muldis Object Notation** document specifies the
canonical concrete Muldis Data Language (MDL) hosted syntax of MUON,
which expresses a MUON artifact in terms of a native in-memory value or
object of the MDL programming language,
authority `https://muldis.com`, version 0.400.0 (2023) or later,
as a non-cyclic data structure composed only using system-defined types.

The MUON `Syntax_Muldis_Data_Language` is derived from and maps with the MUON
[Syntax_Abstract](Muldis_Object_Notation_Syntax_Abstract.md); see that plus
[Semantics](Muldis_Object_Notation_Semantics.md) for further context.

The MUON MDL hosted format is semi-lightweight and designed to support
interchange of source code and data between any 2 environments that do have
a common working memory and run the MDL programming language, such as
because they collectively are part of a single instance of a Muldis Data
Engine.  One typical use case is a MDL library generic API that
accepts or returns structured data using a well-defined protocol such that
the library and its users require no common dependencies besides MDL
standard library classes.  Another typical use case is the bridge format of
a MDL library for generating or parsing MUON `Syntax_Plain_Text`.
The format is fairly easy for humans to read and write in terms of plain
MDL source code.  It is fairly easy for machines to parse and generate.

The prescribed standard *syntax base name* of a *syntax-qualified artifact*
for a MUON MDL hosted artifact is `Muldis_Data_Language`.

See also <https://github.com/muldis/Muldis_Data_Language>.

[RETURN](#TOP)

<a name="SIMPLE-DATA-TYPE-POSSREPS"></a>

# SIMPLE DATA TYPE POSSREPS

[RETURN](#TOP)

<a name="Ignorance"></a>

## Ignorance

An **Ignorance** artifact is any of the following:

* The only value of the MDL singleton type `fdn::Ignorance`.

[RETURN](#TOP)

<a name="Boolean"></a>

## Boolean

A **Boolean** artifact is any of the following:

* Any value of the MDL type `fdn::Boolean`.

[RETURN](#TOP)

<a name="Integer"></a>

## Integer

An **Integer** artifact is any of the following:

* Any value of the MDL type `fdn::Integer`.

[RETURN](#TOP)

<a name="Fraction"></a>

## Fraction

A **Fraction** artifact is any of the following:

* Any value of the MDL type `fdn::Fraction`.

[RETURN](#TOP)

<a name="Bits"></a>

## Bits

A **Bits** artifact is any of the following:

* Any value of the MDL type `fdn::Bits`.

[RETURN](#TOP)

<a name="Blob"></a>

## Blob

A **Blob** artifact is any of the following:

* Any value of the MDL type `fdn::Blob`.

[RETURN](#TOP)

<a name="Text---Attribute-Name"></a>

## Text / Attribute Name

A **Text** artifact is any of the following:

* Any value of the MDL type `fdn::Text`.

[RETURN](#TOP)

<a name="Nesting---Attribute-Name-List"></a>

## Nesting / Attribute Name List

A **Nesting** artifact is any of the following:

* Any value of the MDL type `fdn::Nesting`.

[RETURN](#TOP)

<a name="COLLECTIVE-DATA-TYPE-POSSREPS"></a>

# COLLECTIVE DATA TYPE POSSREPS

[RETURN](#TOP)

<a name="Pair"></a>

## Pair

A **Pair** artifact is any of the following:

* Any value of the MDL type `fdn::SC_Pair`.

[RETURN](#TOP)

<a name="Lot"></a>

## Lot

A **Lot** artifact is any of the following:

* Any value of the MDL type `fdn::SC_Lot`.

[RETURN](#TOP)

<a name="Kit"></a>

## Kit

A **Kit** artifact is any of the following:

* Any value of the MDL type `fdn::SC_Kit`.

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
