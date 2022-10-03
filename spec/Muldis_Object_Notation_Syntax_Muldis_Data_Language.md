# NAME

Muldis Object Notation (MUON) - Source code and data interchange format

# VERSION

The fully-qualified name of this document is
`Muldis_Object_Notation https://muldis.com 0.300.0`.

# PART

This artifact is part 6 of 19 of the document
`Muldis_Object_Notation https://muldis.com 0.300.0`;
its part name is `Syntax_Muldis_Data_Language`.

# SYNOPSIS

```
    (Syntax:({Muldis_Object_Notation_Muldis_Data_Language, "https://muldis.com", "0.300.0"}:
        (Model:({Muldis_Data_Language, "https://muldis.com", "0.300.0"}:
            (Relation:{
                (name : "Jane Ives", birth_date : (Calendar_Instant:(y:1971,m:11,d:6)),
                    phone_numbers : (Set:{"+1.4045552995", "+1.7705557572"})),
                (name : "Layla Miller", birth_date : (Calendar_Instant:(y:1995,m:8,d:27)),
                    phone_numbers : (Set:{})),
                (name : "岩倉 玲音", birth_date : (Calendar_Instant:(y:1984,m:7,d:6)),
                    phone_numbers : (Set:{"+81.9072391679"})),
            })
        ))
    ))
```

# DESCRIPTION

This document consists of multiple parts; for a directory to all of the
parts, see [Overview](Muldis_Object_Notation.md).

This part of the **Muldis Object Notation** document specifies the
canonical concrete Muldis Data Language (MDL) hosted syntax of MUON,
which expresses a MUON artifact in terms of a native in-memory value or
object of the MDL programming language,
authority `https://muldis.com`, version 0.300.0 (2022) or later,
as a non-cyclic data structure composed only using system-defined types.

The MUON `Syntax_Muldis_Data_Language` is derived from and maps with the MUON
[Syntax_Abstract](Muldis_Object_Notation_Syntax_Abstract.md); see that plus
[Semantics](Muldis_Object_Notation_Semantics.md) for further context.

The MUON MDL-hosted format is semi-lightweight and designed to support
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

The prescribed standard *syntax predicate* of a **Syntax** signature for a
MUON MDL-hosted artifact is `Muldis_Object_Notation_Muldis_Data_Language`.

See also <https://github.com/muldis/Muldis_Data_Language>.

# SIMPLE PRIMARY DATA TYPE POSSREPS

## Ignorance

An **Ignorance** artifact is any of the following:

* The only value of the MDL singleton type `fdn::Ignorance`.

## Boolean

A **Boolean** artifact is any of the following:

* Any value of the MDL type `fdn::Boolean`.

## Integer

An **Integer** artifact is any of the following:

* Any value of the MDL type `fdn::Integer`.

## Fraction

A **Fraction** artifact is any of the following:

* Any value of the MDL type `fdn::Fraction`.

## Bits

A **Bits** artifact is any of the following:

* Any value of the MDL type `fdn::Bits`.

## Blob

A **Blob** artifact is any of the following:

* Any value of the MDL type `fdn::Blob`.

## Text / Attribute Name

A **Text** artifact is any of the following:

* Any value of the MDL type `fdn::Text`.

## Nesting / Attribute Name List

A **Nesting** artifact is any of the following:

* Any value of the MDL type `fdn::Nesting`.

# COLLECTIVE PRIMARY DATA TYPE POSSREPS

## Duo

A **Duo** artifact is any of the following:

* Any value of the MDL type `fdn::SC_Duo`.

## Lot

A **Lot** artifact is any of the following:

* Any value of the MDL type `fdn::SC_Lot`.

## Kit

A **Kit** artifact is any of the following:

* Any value of the MDL type `fdn::SC_Kit`.

## Article / Labelled Tuple

An **Article** artifact is any of the following:

* Any value of the MDL type `fdn::SC_Article`.

## Excuse

An **Excuse** artifact is any of the following:

* Any value of the MDL type `fdn::SC_Excuse`.

# ADDITIONAL SECONDARY DATA TYPE POSSREP FORMATS

## Calendar Time

A **Calendar Time** artifact is additionally any of the following:

* Any value of the MDL type `fdn::Calendar_Time`.

## Calendar Duration

A **Calendar Duration** artifact is additionally any of the following:

* Any value of the MDL type `fdn::Calendar_Duration`.

## Calendar Instant

A **Calendar Instant** artifact is additionally any of the following:

* Any value of the MDL type `fdn::Calendar_Instant`.

## Geographic Point

A **Geographic Point** artifact is additionally any of the following:

* Any value of the MDL type `fdn::Geographic_Point`.

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
