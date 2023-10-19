<a name="TOP"></a>

# NAME

Muldis Object Notation (MUON) - Source code and data interchange format

# VERSION

The fully-qualified name of this document is
`Muldis_Object_Notation https://muldis.com 0.300.0`.

# PART

This artifact is part 4 of 21 of the document
`Muldis_Object_Notation https://muldis.com 0.300.0`;
its part name is `Syntax_Abstract`.

# CONTENTS

- [SYNOPSIS](#SYNOPSIS)
- [DESCRIPTION](#DESCRIPTION)
- [OVERVIEW OF ABSTRACT DATA TYPE POSSREPS](#OVERVIEW-OF-ABSTRACT-DATA-TYPE-POSSREPS)
- [ALGEBRAIC DATA TYPE POSSREPS](#ALGEBRAIC-DATA-TYPE-POSSREPS)
    - [Any / Universal Type Possrep](#Any---Universal-Type-Possrep)
    - [None / Empty Type Possrep](#None---Empty-Type-Possrep)
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
    - [Duo](#Duo)
    - [Lot](#Lot)
    - [Kit](#Kit)
- [SEE ALSO](#SEE-ALSO)
- [AUTHOR](#AUTHOR)
- [LICENSE AND COPYRIGHT](#LICENSE-AND-COPYRIGHT)
- [TRADEMARK POLICY](#TRADEMARK-POLICY)
- [ACKNOWLEDGEMENTS](#ACKNOWLEDGEMENTS)

[RETURN](#TOP)

<a name="SYNOPSIS"></a>

# SYNOPSIS

```
    (Syntax:([Muldis_Object_Notation_Plain_Text, "https://muldis.com", "0.300.0"]:
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

This document part provides illustrative example code in the concrete
[Syntax_Plain_Text](Muldis_Object_Notation_Syntax_Plain_Text.md).

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

Examples:

```
    0iIGNORANCE
```

[RETURN](#TOP)

<a name="Boolean"></a>

## Boolean

A **Boolean** artifact is any of the 2 logic boolean values *false* and *true*.

Examples:

```
    0bFALSE

    0bTRUE
```

[RETURN](#TOP)

<a name="Integer"></a>

## Integer

An **Integer** artifact is any generic exact integral number of any magnitude.

Examples:

```
    0

    1

    -1

    +42

    `USA national debt in US dollars close to midnight of 2017 Dec 31.`
    20_597_460_196_915

    `Mersenne Prime 2^521-1, 157 digits, discovered 1952 Jan 30.`
    68_64797
        66013_06097_14981_90079_90813_93217_26943_53001_43305_40939
        44634_59185_54318_33976_56052_12255_96406_61454_55497_72963
        11391_48085_80371_21987_99971_66438_12574_02829_11150_57151

    `Base 10.`
    0d39

    `Base 16.`
    0xDEADBEEF

    `Base 8.`
    0o644

    `Base 2.`
    0b11001001
```

[RETURN](#TOP)

<a name="Fraction"></a>

## Fraction

A **Fraction** artifact is any generic exact rational number of any
magnitude and precision.

Examples:

```
    0.0

    0/1

    0/1*2^0

    0/1*10^0

    1.0

    1/1

    1/1*2^0

    -1.0

    -1/1

    -1/1*2^0

    5/3

    5/1*3^-1

    -4.72

    -472/100

    -472/1*10^-2

    15_485_863/32_452_843

    `First 101 digits of transcendental number π.`
    3.14159_26535_89793_23846_26433_83279_50288_41971_69399_37510
        58209_74944_59230_78164_06286_20899_86280_34825_34211_70679

    `Mersenne Primes 2^107-1 divided by 2^127-1.`
    162259276829213363391578010288127
        /170141183460469231731687303715884105727

    `Base 10.`
    4.5207196*10^37

    `Base 16.`
    0xDEADBEEF.FACE

    `Base 8.`
    -0o35/0o3

    `Base 2.`
    0b1.1

    `Base 2.`
    0b1.011101101*0b10^-0b11011
```

[RETURN](#TOP)

<a name="Bits"></a>

## Bits

A **Bits** artifact is an arbitrarily-large ordered sequence of *bits* where each
bit is an integer in the set `0..1`.

Examples:

```
    0bb

    0bb0

    0bb1

    0bb00101110_100010

    0bo644

    0bxA705E
```

[RETURN](#TOP)

<a name="Blob"></a>

## Blob

A **Blob** artifact is an arbitrarily-large ordered sequence of *octets* where each
octet is an integer in the set `0..255`.

Examples:

```
    0xx

    0xx0

    0xx1

    0xxA705_E416

    0xb00101110_10001011

    `A quote from Thomas Hobbes' "Leviathan", as UTF-8 text encoded in Base64.`
    0xy
        TWFuIGlzIGRpc3Rpbmd1aXNoZWQsIG5vdCBvbmx5IGJ5IGhpcyByZWFzb24sIGJ1dCBieSB0aGlz
        IHNpbmd1bGFyIHBhc3Npb24gZnJvbSBvdGhlciBhbmltYWxzLCB3aGljaCBpcyBhIGx1c3Qgb2Yg
        dGhlIG1pbmQsIHRoYXQgYnkgYSBwZXJzZXZlcmFuY2Ugb2YgZGVsaWdodCBpbiB0aGUgY29udGlu
        dWVkIGFuZCBpbmRlZmF0aWdhYmxlIGdlbmVyYXRpb24gb2Yga25vd2xlZGdlLCBleGNlZWRzIHRo
        ZSBzaG9ydCB2ZWhlbWVuY2Ugb2YgYW55IGNhcm5hbCBwbGVhc3VyZS4=
```

[RETURN](#TOP)

<a name="Text---Attribute-Name"></a>

## Text / Attribute Name

A **Text** artifact is an arbitrarily-large ordered sequence of **Unicode** standard
*character code points* where each code point is an integer in the set
`[0..0xD7FF,0xE000..0x10FFFF]`.

Examples:

```
    ""

    `One ordered nonquoted Text (or, the first ordered attribute).`
    0t0

    `Same Text value (or, one ordered attr written in format of a named).`
    "\(0t0)"

    `Another ordered nonquoted Text (or, the second ordered attribute).`
    0t1

    Ceres

    "⨝"

    "サンプル"

    "This isn't not escaped.\n"

    `Two characters specified in terms of Unicode code-point numbers.`
    "\(0tx263A)\(0t65)"

    `Same thing.`
    "\u263A\u0041"

    `One non-ordered quoted Text (or, one named attribute).`
    "sales"

    `Same thing but nonquoted.`
    sales

    `One attribute name with a space in it.`
    "First Name"

    `From a graduate student (in finals week), the following haiku:`
    "study, write, study,\n"
        "do review (each word) if time.\n"
        "close book. sleep? what's that?\n"
```

[RETURN](#TOP)

<a name="Nesting---Attribute-Name-List"></a>

## Nesting / Attribute Name List

A **Nesting** artifact is an arbitrarily-large ordered sequence of
*attribute names* (each one a **Text**), having at least 1 element.

Examples:

```
    ::""

    ::0t0

    ::person

    person::birth_date

    person::birth_date::year

    the_db::stats::"samples by order"
```

[RETURN](#TOP)

<a name="COLLECTIVE-DATA-TYPE-POSSREPS"></a>

# COLLECTIVE DATA TYPE POSSREPS

[RETURN](#TOP)

<a name="Duo"></a>

## Duo

A **Duo** artifact is an ordered collection having exactly 2 elements
which in order are named *this* (any **Any** artifact)
and *that* (any **Any** artifact).

Examples:

```
    `Duo of Ignorance.`
    (0iIGNORANCE: 0iIGNORANCE)

    `Duo of Integer.`
    (5: -3)

    `Duo of Text.`
    ("First Name": Joy)

    `Another Duo.`
    (x:y)

    `Same thing.`
    (x->y)

    `Same thing.`
    (y<-x)

    `A singleton higher-level data type possrep artifact.`
    (Arguments: 0iIGNORANCE)

    `Same thing in shorthand.`
    (Arguments:)
```

[RETURN](#TOP)

<a name="Lot"></a>

## Lot

A **Lot** artifact is an arbitrarily-large ordered collection of elements
each of which in turn is named *multiplied member* such that each
*multiplied member* is an ordered collection having exactly 2 elements
which in order are named *member* (any **Any** artifact) and *multiplicity*
(any **Any** artifact but conceptually a real number).

Examples:

```
    `Zero members.`
    []

    `One member.`
    [ "The lonely only." ]

    `Four members.`
    [
        Clubs  :  5,
        Diamonds,
        Hearts : 10,
        Spades : 20,
    ]
```

[RETURN](#TOP)

<a name="Kit"></a>

## Kit

A **Kit** artifact is an arbitrarily-large ordered collection of elements
each of which in turn is named *attribute* such that each
*attribute* is an ordered collection having exactly 2 elements
which in order are named *attribute name* (any **Text** artifact)
and *attribute asset* (any **Any** artifact),
such that no 2 attributes have the same *attribute name*.

Examples:

```
    `Zero attributes.`
    {}

    `One named attribute.`
    {"First Name": Joy}

    `One ordered attribute.`
    {53}

    `Same thing.`
    {0t0: 53}

    `Same thing.`
    {"\(0t0)": 53}

    `Three named attributes.`
    {
        login_name : hartmark,
        login_pass : letmein,
        is_special : 0bTRUE,
    }

    `Three ordered attributes.`
    {hello,26,0bTRUE}

    `One of each.`
    {Jay, age: 10}

    `A non-Latin name.`
    {"サンプル": "https://example.com"}
```

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
