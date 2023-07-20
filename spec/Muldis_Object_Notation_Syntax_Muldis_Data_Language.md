<a name="TOP"></a>

# NAME

Muldis Object Notation (MUON) - Source code and data interchange format

# VERSION

The fully-qualified name of this document is
`Muldis_Object_Notation https://muldis.com 0.300.0`.

# PART

This artifact is part 7 of 20 of the document
`Muldis_Object_Notation https://muldis.com 0.300.0`;
its part name is `Syntax_Muldis_Data_Language`.

# CONTENTS


[RETURN](#TOP)

<a name="SYNOPSIS"></a>

# SYNOPSIS

```
    (Syntax:([Muldis_Object_Notation_Muldis_Data_Language, "https://muldis.com", "0.300.0"]:
        (Model:([Muldis_Data_Language, "https://muldis.com", "0.300.0"]:
            (Relation:[
                {name : "Jane Ives", birth_date : (Calendar_Instant:{y:1971,m:11,d:6}),
                    phone_numbers : (Set:["+1.4045552995", "+1.7705557572"])},
                {name : "Layla Miller", birth_date : (Calendar_Instant:{y:1995,m:8,d:27}),
                    phone_numbers : (Set:[])},
                {name : "岩倉 玲音", birth_date : (Calendar_Instant:{y:1984,m:7,d:6}),
                    phone_numbers : (Set:["+81.9072391679"])},
            ])
        ))
    ))
```

[RETURN](#TOP)

<a name="DESCRIPTION"></a>

# DESCRIPTION

This document consists of multiple parts; for a directory to all of the
parts, see [Overview](Muldis_Object_Notation.md).

This part of the **Muldis Object Notation** document specifies the
canonical concrete Muldis Data Language (MDL) hosted syntax of MUON,
which expresses a MUON artifact in terms of a native in-memory value or
object of the MDL programming language,
authority `https://muldis.com`, version 0.300.0 (2023) or later,
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

[RETURN](#TOP)

<a name="SIMPLE-PRIMARY-DATA-TYPE-POSSREPS"></a>

# SIMPLE PRIMARY DATA TYPE POSSREPS

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

<a name="COLLECTIVE-PRIMARY-DATA-TYPE-POSSREPS"></a>

# COLLECTIVE PRIMARY DATA TYPE POSSREPS

[RETURN](#TOP)

<a name="Duo"></a>

## Duo

A **Duo** artifact is any of the following:

* Any value of the MDL type `fdn::SC_Duo`.

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

<a name="Article---Labelled-Tuple"></a>

## Article / Labelled Tuple

An **Article** artifact is any of the following:

* Any value of the MDL type `fdn::SC_Article`.

[RETURN](#TOP)

<a name="Excuse"></a>

## Excuse

An **Excuse** artifact is any of the following:

* Any value of the MDL type `fdn::SC_Excuse`.

[RETURN](#TOP)

<a name="ADDITIONAL-SECONDARY-DATA-TYPE-POSSREP-FORMATS"></a>

# ADDITIONAL SECONDARY DATA TYPE POSSREP FORMATS

[RETURN](#TOP)

<a name="Calendar-Time"></a>

## Calendar Time

A **Calendar Time** artifact is additionally any of the following:

* Any value of the MDL type `fdn::Calendar_Time`.

[RETURN](#TOP)

<a name="Calendar-Duration"></a>

## Calendar Duration

A **Calendar Duration** artifact is additionally any of the following:

* Any value of the MDL type `fdn::Calendar_Duration`.

[RETURN](#TOP)

<a name="Calendar-Instant"></a>

## Calendar Instant

A **Calendar Instant** artifact is additionally any of the following:

* Any value of the MDL type `fdn::Calendar_Instant`.

[RETURN](#TOP)

<a name="Geographic-Point"></a>

## Geographic Point

A **Geographic Point** artifact is additionally any of the following:

* Any value of the MDL type `fdn::Geographic_Point`.

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
