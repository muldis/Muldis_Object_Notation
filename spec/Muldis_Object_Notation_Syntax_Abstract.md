# NAME

Muldis Object Notation (MUON) - Source code and data interchange format

# VERSION

The fully-qualified name of this document is
`Muldis_Object_Notation https://muldis.com 0.300.0`.

# PART

This artifact is part 3 of 15 of the document
`Muldis_Object_Notation https://muldis.com 0.300.0`;
its part name is `Syntax_Abstract`.

# SYNOPSIS

```
    (Syntax:({Muldis_Object_Notation_Plain_Text, "https://muldis.com", "0.300.0"}:
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
fundamental abstract syntax of MUON, which expresses a MUON artifact in
terms of a few kinds of simple generic data structures such as integers and
ordered lists.  This abstract syntax is what all concrete MUON syntaxes are
designed to satisfy the requirements of and map with.

# OVERVIEW OF ABSTRACT DATA TYPE POSSREPS

Each valid abstract MUON artifact is an instance of a single abstract MUON
possrep.  Each abstract MUON possrep is of exactly one of these 3 kinds:
*algebraic possrep*, *primary possrep*, *secondary possrep*.

This document considers each abstract MUON *primary possrep* to be
fundamental and to simply exist.  It is manadatory that each concrete MUON
syntax will bootstrap a *primary possrep* in terms of one or more
dedicated concrete literal formats or host language data types.

This document considers each abstract MUON *secondary possrep* to be
non-fundamental and to be defined as a special case of a *primary possrep*.
Each concrete MUON syntax does not have to say anything at all about any
*secondary possrep*, but it may optionally provide for it one or more
dedicated concrete literal formats or host language data types.

This document considers each abstract MUON *algebraic possrep* to be
non-fundamental and to be defined as a union of 0..N *primary possrep*.

See [Semantics](Muldis_Object_Notation_Semantics.md) for further context.

This document part provides illustrative example code in the concrete
[Syntax_Plain_Text](Muldis_Object_Notation_Syntax_Plain_Text.md)
but expressly limits itself to the *primary possrep* literal formats.

# CRITICAL ALGEBRAIC DATA TYPE POSSREPS

## Any / Universal Type Possrep

An **Any** artifact is an artifact that qualifies as any of the other MUON
artifacts, since the **Any** possrep is characterized by the union of all
other possreps.

## None / Empty Type Possrep

A **None** artifact is an artifact that qualifies as none of the other MUON
artifacts, since the **None** possrep is characterized by the intersection
of all other possreps.  That is, there are no **None** artifacts at all,
and this possrep is just mentioned as the logical complement of **Any**.

# FOLDING ALGEBRAIC DATA TYPE POSSREPS

## Fractional

A **Fractional** artifact is an artifact that qualifies as either
any **Fraction** artifact or as any **Integer** artifact.
A context explicitly requiring any **Fractional** artifact implicitly requires
any **Fraction** artifact; when an **Integer** artifact is instead given,
then the proper interpretation is as if a **Fraction** artifact was
actually given whose numeric value was the same as that **Integer**.

## Nesty

A **Nesty** artifact is an artifact that qualifies as either
any **Nesting** artifact or as any **Text** artifact.
A context explicitly requiring any **Nesty** artifact implicitly requires
any **Nesting** artifact; when a **Text** artifact is instead given,
then the proper interpretation is as if a single-element **Nesting** artifact was
actually given whose element was the same as that **Text**.

## Arrayish

A **Arrayish** artifact is an artifact that qualifies as either
any **Array** artifact or as any **Lot** artifact.
A context explicitly requiring any **Arrayish** artifact implicitly requires
any **Array** artifact; when a **Lot** artifact is instead given,
then the proper interpretation is as if a **Array** artifact was
actually given whose subject was that **Lot**.

## Setty

A **Setty** artifact is an artifact that qualifies as either
any **Set** artifact or as any **Lot** artifact.
A context explicitly requiring any **Setty** artifact implicitly requires
any **Set** artifact; when a **Lot** artifact is instead given,
then the proper interpretation is as if a **Set** artifact was
actually given whose subject was that **Lot**.

## Baggy

A **Baggy** artifact is an artifact that qualifies as either
any **Bag** artifact or as any **Lot** artifact.
A context explicitly requiring any **Baggy** artifact implicitly requires
any **Bag** artifact; when a **Lot** artifact is instead given,
then the proper interpretation is as if a **Bag** artifact was
actually given whose subject was that **Lot**.

## Heady

A **Heady** artifact is an artifact that qualifies as either
any **Heading** artifact or as any **Kit** artifact.
A context explicitly requiring any **Heady** artifact implicitly requires
any **Heading** artifact; when a **Kit** artifact is instead given,
then the proper interpretation is as if a **Heading** artifact was
actually given whose subject was that **Kit**.

## Renamey

A **Renamey** artifact is an artifact that qualifies as either
any **Renaming** artifact or as any **Kit** artifact.
A context explicitly requiring any **Renamey** artifact implicitly requires
any **Renaming** artifact; when a **Kit** artifact is instead given,
then the proper interpretation is as if a **Renaming** artifact was
actually given whose subject was that **Kit**.

## Tupley

A **Tupley** artifact is an artifact that qualifies as either
any **Tuple** artifact or as any **Kit** artifact.
A context explicitly requiring any **Tupley** artifact implicitly requires
any **Tuple** artifact; when a **Kit** artifact is instead given,
then the proper interpretation is as if a **Tuple** artifact was
actually given whose subject was that **Kit**.

# SIMPLE PRIMARY DATA TYPE POSSREPS

## Ignorance

An **Ignorance** artifact is a singleton.

Examples:

```
    0iIGNORANCE
```

## Boolean

A **Boolean** artifact is any of the 2 logic boolean values *false* and *true*.

Examples:

```
    0bFALSE

    0bTRUE
```

## Integer

An **Integer** artifact is any generic exact integral number of any magnitude.

Examples:

```
    0

    1

    -3

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

## Fraction

A **Fraction** artifact is any generic exact rational number of any
magnitude and precision.

Examples:

```
    0.0

    1.0

    -4.72

    +4.72

    0/1

    1/1

    5/3

    -472/100

    +472/100

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

## Bits

A **Bits** artifact is an arbitrarily-large ordered sequence of *bits* where each
bit is an integer in the set `0..1`.

Examples:

```
    0bb

    0bb00101110100010

    0bb00101110_100010

    0bo644

    0bxA705E
```

## Blob

A **Blob** artifact is an arbitrarily-large ordered sequence of *octets* where each
octet is an integer in the set `0..255`.

Examples:

```
    0xx

    0xxA705E416

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

## Text / Attribute Name

A **Text** artifact is an arbitrarily-large ordered sequence of **Unicode** standard
*character code points* where each code point is an integer in the set
`{0..0xD7FF,0xE000..0x10FFFF}`.

Examples:

```
    ""

    Ceres

    "サンプル"

    "This isn't not escaped.\n"

    "\{0tx263A,0t65}"

    `One non-ordered quoted Text (or, one named attribute).`
    "sales"

    `Same thing but nonquoted.`
    sales

    `One attribute name with a space in it.`
    "First Name"

    `One ordered nonquoted Text (or, one ordered attribute).`
    0t0

    `Same Text value (or, one ordered attr written in format of a named).`
    "\{0t0}"

    `From a graduate student (in finals week), the following haiku:`
    "study, write, study,\n"
        "do review (each word) if time.\n"
        "close book. sleep? what's that?\n"
```

## Nesting / Attribute Name List

A **Nesting** artifact is an arbitrarily-large ordered sequence of
*attribute names* (each one a **Text**), having at least 1 element.

Examples:

```
    ::person

    person::birth_date

    person::birth_date::year

    the_db::stats::"samples by order"
```

# COLLECTIVE PRIMARY DATA TYPE POSSREPS

## Duo

A **Duo** artifact is an ordered collection having exactly 2 elements
which in order are named *this* (any **Any** artifact)
and *that* (any **Any** artifact).

Examples:

```
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
```

## Lot

A **Lot** artifact is an arbitrarily-large ordered collection of elements
each of which in turn is named *multiplied member* such that each
*multiplied member* is an ordered collection having exactly 2 elements
which in order are named *member* (any **Any** artifact) and *multiplicity*
(any **Any** artifact but conceptually a real number).

Examples:

```
    `Zero members.`
    {}

    `One member.`
    { "The lonely only." }

    `Four members.`
    {
        Clubs  :  5,
        Diamonds,
        Hearts : 10,
        Spades : 20,
    }
```

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
    ()

    `One named attribute.`
    ("First Name": Joy,)

    `One ordered attribute.`
    (53,)

    `Same thing.`
    (0t0: 53,)

    `Same thing.`
    ("\{0t0}": 53,)

    `Three named attributes.`
    (
        login_name : hartmark,
        login_pass : letmein,
        is_special : 0bTRUE,
    )

    `Three ordered attributes.`
    (hello,26,0bTRUE)

    `One of each.`
    (Jay, age: 10)

    `A non-Latin name.`
    ("サンプル": "http://example.com",)
```

## Article / Labelled Tuple

An **Article** artifact is an ordered collection having exactly 2 elements
which in order are named *label* (any **Nesty** artifact)
and *attributes* (any **Kit** artifact).

Examples:

```
    Point*(x : 5, y : 3)

    Float*(
        significand : 45207196,
        radix       : 10,
        exponent    : 37,
    )

    the_db::UTC_Date_Time*(
        year   : 2003,
        month  : 10,
        day    : 26,
        hour   : 1,
        minute : 30,
        second : 0.0,
    )

    Positive_Infinity*()

    Negative_Zero*()
```

## Excuse

An **Excuse** artifact is an ordered collection having exactly 2 elements
which in order are named *label* (any **Nesty** artifact)
and *attributes* (any **Kit** artifact).

Examples:

```
    Input_Field_Wrong!(name : "Your Age")

    Div_By_Zero!()

    No_Such_Attr_Name!()
```

# COMMON QUALITIES OF ABSTRACT SECONDARY DATA TYPE POSSREPS

Every abstract MUON *secondary possrep* has one or more general *qualified*
formats characterized by the pairing of a *predicate* with a *subject*.
There is NOT any abstract MUON secondary possrep that has any alternative
*unqualified* formats characterized by the *subject* on its own; however,
the latter is a common option for concrete MUON possreps.

Every (qualified) abstract MUON artifact is a **Duo** artifact;
its *this* is the *predicate* and its *that* is the *subject*.

Every MUON possrep *predicate* is a **Text** artifact,
and that value is characterized by the name
of the MUON possrep in this document.  Every MUON possrep *predicate*
conforms to the character string pattern `[<[A..Z]><[a..z]>+]+ % _`.

The general case of every MUON possrep *subject* is, loosely speaking, an
**Any** artifact, though strictly speaking, the validity of a *subject* is
constrained to those enumerated by the MUON possreps.

# LESS-COLLECTIVE SECONDARY DATA TYPE POSSREPS

## Calendar Time

A **Calendar Time** artifact has the predicate `Calendar_Time`.

Its subject is any of the following:

* Any **Kit** artifact having any subset of the 6 attributes of the
heading {`y|year`,`m|month`,`d|day`,`h|hour`,`i|minute`,`s|second`} such
that their corresponding attribute assets are {*year*, *month*, *day*,
*hour*, *minute*, *second*}; each of those 6 is any **Fractional** artifact.

Examples:

```
    `No measurement was taken or specified at all.`
    (Calendar_Time:())

    `Either an unspecified period in 1970 or a duration of 1970 years.`
    (Calendar_Time:(y:1970,))

    `Either a civil calendar date 2015-5-3 or a duration of 2015y+5m+3d.`
    (Calendar_Time:(y:2015,m:5,d:3))

    `Either a military calendar date 1998-300 or a duration of 1998y+300d.`
    (Calendar_Time:(y:1998,d:300))

    `Either the 6th week of 1776 or a duration of 1776 years + 6 weeks.`
    (Calendar_Time:(y:1776,d:42))

    `Either the first quarter of 1953 or a duration of 1953.25 years.`
    (Calendar_Time:(y:1953.25,))

    `Either high noon on an unspecified day or a duration of 12 hours.`
    (Calendar_Time:(h:12,i:0,s:0))

    `Either a fully specified civil date and time or a 6-part duration.`
    (Calendar_Time:(y:1884,m:10,d:17,h:20,i:55,s:30))

    `Either an ancient date and time or a negative duration.`
    (Calendar_Time:(y-370,m:1,d:24,h:11,i:0,s:0))

    `Either a time on some unspecified day or a duration of seconds.`
    (Calendar_Time:(s:5923.21124603,))
```

## Calendar Duration

A **Calendar Duration** artifact has the predicate `Calendar_Duration`.

Its subject is any of the following:

* Any **Calendar Time** subject.

Examples:

```
    `Addition of 2 years and 3 months.`
    (Calendar_Duration:(y:2,m:3,d:0,h:0,i:0,s:0))

    `Subtraction of 22 hours.`
    (Calendar_Duration:(y:0,m:0,d:0,h-22,i:0,s:0))
```

## Calendar Instant

A **Calendar Instant** artifact has the predicate `Calendar_Instant`.

Its subject is any of the following:

* Any *instant base*.

* Any **Duo** artifact such that its *this* and *that* respectively are
the *instant base* and *instant offset*.

* Any **Duo** artifact such that its *this* and *that* respectively are
the *instant base* and *instant zone*.

The above components are defined as follows:

* An *instant base* is any **Calendar Time** subject.

* An *instant offset* is any **Calendar Time** subject
such that it is restricted to a subset of {*hour*, *minute*, *second*}.

* An *instant zone* is any **Text** artifact.

Examples:

```
    `The Day The Music Died (if paired with Gregorian calendar).`
    (Calendar_Instant:(y:1959,m:2,d:3))

    `A time of day when one might have breakfast.`
    (Calendar_Instant:(h:7,i:30,s:0))

    `What was now in the Pacific zone (if paired with Gregorian calendar).`
    (Calendar_Instant:((y:2018,m:9,d:3,h:20,i:51,s:17):(h:-8,i:0,s:0)))

    `A time of day in the UTC zone on an unspecified day.`
    (Calendar_Instant:((h:9,i:25,s:0):(h:0,i:0,s:0)))

    `A specific day and time in the Pacific Standard Time zone.`
    (Calendar_Instant:((y:2001,m:4,d:16,h:20,i:1,s:44):"PST"))
```

## Geographic Point

A **Geographic Point** artifact has the predicate `Geographic_Point`.

Its subject is any of the following:

* Any **Kit** artifact having any subset of the 3 attributes of the
heading {`">"|longitude`,`"^"|latitude`,`"+"|elevation`} such that their
corresponding attribute assets are {*longitude*, *latitude*, *elevation*};
each of those 6 is any **Fractional** artifact.

Examples:

```
    `No specified coordinates at all.`
    (Geographic_Point:())

    `Just an elevation specified.`
    (Geographic_Point:("+":920,))

    `Geographic surface coordinates of Googleplex; elevation not specified.`
    (Geographic_Point:(">":-122.0857017,"^":37.4218363))

    `Same thing.`
    (Geographic_Point:("^":37.4218363,">":-122.0857017))

    `Some location with all coordinates specified.`
    (Geographic_Point:(">":-101,"^":-70,"+":1000))

    `Another place.`
    (Geographic_Point:(">":-94.746094,"^":37.483577))
```

# MORE-COLLECTIVE SECONDARY DATA TYPE POSSREPS

## Array

An **Array** artifact has the predicate `Array`.

Its subject is any of the following:

* Any **Lot** artifact such that for every one of its *multiplied members*
LM, that member denotes a sequence of consecutive identical members AM of
the **Array**; LM's *member* denotes the value of each AM and LM's
*multiplicity* is any **Integer** artifact which denotes a non-negative
integer and indicates how many elements that sequence has.

Examples:

```
    `Zero members.`
    (Array:{})

    `One member.`
    (Array:{ "You got it!" })

    `Three members.`
    (Array:{
        Alphonse,
        Edward,
        Winry,
    })

    `Five members (1 duplicate).`
    (Array:{
        57,
        45,
        63,
        61,
        63,
    })

    `32 members (28 duplicates in 2 runs).`
    (Array:{
        "/",
        "*" : 20,
        "+" : 10,
        "-",
    })
```

## Set

A **Set** artifact has the predicate `Set`.

Its subject is any of the following:

* Any **Lot** artifact such that for every one of its *multiplied members*,
that multiplied member's *member* denotes a potential distinct member of
the **Set** and the multiplied member's *multiplicity* is any **Integer**
artifact which denotes a non-negative integer *multiplicity*
(any greater than 1 is treated as 1).

Examples:

```
    `Zero members.`
    (Set:{})

    `One member.`
    (Set:{ "I know this one!" })

    `Four members (no duplicates).`
    (Set:{
        Canada,
        Spain,
        Jordan,
        Jordan,
        Thailand,
    })

    `Three members.`
    (Set:{
        3,
        16,
        85,
    })

    `Two members.`
    (Set:{
        21 : 1,
        62 : 0,
        3 : 1,
        101 : 0,
    })
```

## Bag / Multiset

A **Bag** artifact has the predicate `Bag`.

Its subject is any of the following:

* Any **Lot** artifact such that for every one of its *multiplied members*,
that multiplied member's *member* denotes a potential distinct member of
the **Bag** and the multiplied member's *multiplicity* is any **Integer**
artifact which denotes a non-negative integer *multiplicity*.

Examples:

```
    `Zero members.`
    (Bag:{})

    `One member.`
    (Bag:{ "I hear that!": 1 })

    `1200 members (1197 duplicates).`
    (Bag:{
        Apple  : 500,
        Orange : 300,
        Banana : 400,
    })

    `Six members (2 duplicates).`
    (Bag:{
        Foo : 1,
        Quux : 1,
        Foo : 1,
        Bar : 1,
        Baz : 1,
        Baz : 1,
    })
```

## Mix

A **Mix** artifact has the predicate `Mix`.

Its subject is any of the following:

* Any **Lot** artifact such that for every one of its *multiplied members*,
that multiplied member's *member* denotes a potential distinct member of
the **Mix** and the multiplied member's *multiplicity* is any **Fractional**
artifact which denotes a nonzero possibly fractional *multiplicity*.

Examples:

```
    `Zero members; we measured zero of nothing in particular.`
    (Mix:{})

    `One member; one gram of mass.`
    (Mix:{::Gram: 1.0})

    `29.95 members (28.95 duplicates); the cost of a surgery.`
    (Mix:{::USD: 29.95})

    `9.8 members; acceleration under Earth's gravity.`
    (Mix:{::Meter_Per_Second_Squared: 9.8})

    `0.615 members (fractions of 3 distinct members); recipe.`
    (Mix:{
        ::Butter : 0.22,
        ::Sugar  : 0.1,
        ::Flour  : 0.275,
        ::Sugar  : 0.02,
    })

    `4/3 members (fractions of 3 distinct members); this-mix.`
    (Mix:{
        Sugar: 1/3,
        Spice: 1/4,
        All_Things_Nice: 3/4,
    })

    `-1.5 members; adjustment for recipe.`
    (Mix:{
        Rice: +4.0,
        Beans: -5.7,
        Carrots: +0.2,
    })
```

## Interval

An **Interval** artifact has the predicate `Interval`.

Its subject is any of the following:

* The **Text** artifact empty string value; this designates an *empty interval*.

* Any **Duo** artifact such that its *this* is the **Text** artifact empty
string value and its *that* is any **Any** artifact; this designates a
*unit interval*, and *that* corresponds to its sole member.

* Any **Duo** artifact such that its *this* is any of the 5 **Text**
artifacts {`<=*<=`, `<=*<`, `<*<=`, `<*<`, `..`} and its *that* is any
**Duo** artifact such that its *this* and *that* respectively are each any
**Any** artifact; this designates a *bounded interval*, and the latter
*this* and *that* correspond respectively to the low and high endpoints.

* Any **Duo** artifact such that its *this* is any of the 2 **Text**
artifacts {`<=*`, `<*`} and its *that* is any **Any** artifact; this
designates a *low-bounded, high-unbounded interval*, and *that* corresponds
to the low endpoint.

* Any **Duo** artifact such that its *this* is any of the 2 **Text**
artifacts {`*<=`, `*<`} and its *that* is any **Any** artifact; this
designates a *low-unbounded, high-bounded interval*, and *that* corresponds
to the high endpoint.

* The **Text** artifact `*`;
this designates a *universal interval* or *unbounded interval*.

Examples:

```
    `Empty interval (zero members).`
    (Interval:"")

    `Unit interval (one member).`
    (Interval:("":abc))

    `Closed interval (probably 10 members, depending on the model used).`
    (Interval:("<=*<=":(1:10)))

    `Same thing.`
    (Interval:("..":(1:10)))

    `Left-closed, right-open interval; every Fraction x in [2.7<=x<9.3].`
    (Interval:("<=*<":(2.7:9.3)))

    `Left-open, right-closed interval; every Text x ordered in [a<x<=z].`
    (Interval:("<*<=":(a:z)))

    `Open interval; time period between Dec 6 and 20 excluding both.`
    (Interval:("<*<":(
          (Calendar_Instant:((y:2002,m:12,d: 6):"UTC"))
        : (Calendar_Instant:((y:2002,m:12,d:20):"UTC"))
    )))

    `Left-unbounded, right-closed interval; every Integer x where x <= 3.`
    (Interval:("*<=":3))

    `Left-closed, right-unbounded interval; every Integer x where 29 <= x.`
    (Interval:("<=*":29))

    `Universal interval; unbounded; every value of type system is a member.`
    (Interval:"*")
```

## Interval Set

An **Interval Set** artifact has the predicate `Interval_Set`.

Its subject is any of the following:

* Any **Setty** artifact such that every one of its *members* is an
**Interval** artifact.

Examples:

```
    `Empty interval-set (zero members).`
    (Interval_Set:{})

    `Unit interval-set (one member).`
    (Interval_Set:{(Interval:("":abc))})

    `Probably 10 members, depending on the model used.`
    (Interval_Set:{(Interval:("<=*<=":(1:10)))})

    `Same thing.`
    (Interval_Set:{(Interval:("..":(1:10)))})

    `Probably 6 members.`
    (Interval_Set:{
        (Interval:("..":(1:3))),
        (Interval:(""  :6    )),
        (Interval:("..":(8:9))),
    })

    `Every Integer x except for {4..13,22..28}`
    (Interval_Set:{*<=3,(Interval:("..":(14:21))),29<=*})

    `Set of all valid Unicode code points.`
    (Interval_Set:{
        (Interval:("..":(     0:  0xD7FF))),
        (Interval:("..":(0xE000:0x10FFFF))),
    })

    `Probably 15 members (no duplicates), depending on the model used.`
    (Interval_Set:{(Interval:("..":(1:10))),(Interval:("..":(6:15)))})

    `Probably same thing, regardless of data model used.`
    (Interval_Set:{
        (Interval:("<=*<":( 1: 6)))  ,
        (Interval:(".."  :( 6:10))):2,
        (Interval:("<*<=":(10:15)))  ,
    })
```

## Interval Bag

An **Interval Bag** artifact has the predicate `Interval_Bag`.

Its subject is any of the following:

* Any **Interval Set** subject but that any **Baggy** artifact is used in
place of the specified any **Setty** artifact.

Examples:

```
    `Empty interval-bag (zero members).`
    (Interval_Bag:{})

    `Unit interval-bag (one member).`
    (Interval_Bag:{(Interval:("":abc))})

    `Five members (4 duplicates).`
    (Interval_Bag:{(Interval:("":def)):5})

    `Probably 20 members (5 duplicates), depending on the model used.`
    (Interval_Bag:{(Interval:("<=*<=":(1:10))),(Interval:("<=*<=":(6:15)))})

    `Same thing.`
    (Interval_Bag:{(Interval:("..":(1:10))),(Interval:("..":(6:15)))})

    `Probably same thing, regardless of data model used.`
    (Interval_Bag:{
        (Interval:("<=*<":( 1: 6)))  ,
        (Interval:(".."  :( 6:10))):2,
        (Interval:("<*<=":(10:15)))  ,
    })
```

## Pair

A **Pair** artifact has the predicate `Pair`.

Its subject is any of the following:

* Any **Duo** artifact such that its *this* and *that* define the same
elements of the **Pair**.

Examples:

```
    `Pair of Integer.`
    (Pair:(5: -3))

    `Pair of Text.`
    (Pair:("First Name": Joy))

    `Another Pair.`
    (Pair:(x:y))

    `Same thing.`
    (Pair:(x->y))

    `Same thing.`
    (Pair:(y<-x))
```

## Heading / Attribute Name Set

A **Heading** artifact has the predicate `Heading`.

Its subject is any of the following:

* Any **Kit** artifact such that every one of its attribute assets is a
**Text** artifact, and no 2 attribute asset values are the same value (and
presumably the attribute names are all positional).  The *attribute assets*
of the **Kit** denote the *attribute names* of the **Heading**.

Examples:

```
    `Zero attributes.`
    (Heading:())

    `One named attribute.`
    (Heading:(sales,))

    `Same thing.`
    (Heading:("sales",))

    `One ordered attribute.`
    (Heading:(0t0,))

    `Same thing.`
    (Heading:("\{0t0}",))

    `Three named attributes.`
    (Heading:(region,revenue,qty))

    `Three ordered attributes.`
    (Heading:(0t0,0t1,0t2))

    `One of each.`
    (Heading:(0t1,age))

    `Some attribute names can only appear quoted.`
    (Heading:("Street Address",))

    `A non-Latin name.`
    (Heading:("サンプル",))
```

## Renaming / Attribute Name Map

A **Renaming** artifact has the predicate `Renaming`.

Its subject is any of the following:

* Any **Kit** artifact such that every one of its attribute assets is a
**Text** artifact, and no 2 attribute asset values are the same value; for
each *attribute*, that attribute's name and asset respectively specify the
*name before* and *name after* name of some other attribute being renamed
of some other attributive value.

Examples:

```
    `Zero renamings, a no-op.`
    (Renaming:())

    `Also a no-op.`
    (Renaming:(age->age,))

    `Rename one attribute.`
    (Renaming:(fname->first_name,))

    `Same thing.`
    (Renaming:(first_name:fname,))

    `Swap 2 named attributes.`
    (Renaming:(foo->bar,foo<-bar))

    `Convert ordered names to nonordered.`
    (Renaming:(foo,bar))

    `Same thing.`
    (Renaming:(0t0->foo,0t1->bar))

    `Convert nonordered names to ordered.`
    (Renaming:(0t0<-foo,0t1<-bar))

    `Swap 2 ordered attributes.`
    (Renaming:(0t0->0t1,0t0<-0t1))

    `Same thing.`
    (Renaming:(0t1,0t0))

    `Some attribute names can only appear quoted.`
    (Renaming:("First Name"->"Last Name",))
```

## Tuple / Attribute Set

A **Tuple** artifact has the predicate `Tuple`.

Its subject is any of the following:

* Any **Kit** artifact such that its *attributes* define the same
*attributes* of the **Tuple**.

Examples:

```
    `Zero attributes.`
    (Tuple:())

    `One named attribute.`
    (Tuple:("First Name": Joy,))

    `One ordered attribute.`
    (Tuple:(53,))

    `Three ordered attributes.`
    (Tuple:(hello,26,0bTRUE))

    `One of each.`
    (Tuple:(Jay, age: 10))

    `Two named attributes.`
    (Tuple:(
        name : Michelle,
        age  : 17,
    ))
```

## Tuple Array

A **Tuple Array** artifact has the predicate `Tuple_Array`.

Its subject is any of the following:

* Any **Relation** subject but that any **Arrayish** artifact is used in
place of the specified any **Setty** artifact.

Examples:

```
    `Zero attributes + zero tuples.`
    (Tuple_Array:())

    `Zero attributes + one tuple.`
    (Tuple_Array:{()})

    `Three named attributes + zero tuples.`
    (Tuple_Array:(x,y,z))

    `Three positional attributes + zero tuples.`
    (Tuple_Array:(0t0,0t1,0t2))

    `Two named attributes + three tuples (1 duplicate).`
    (Tuple_Array:{
        (name: Amy     , age: 14),
        (name: Michelle, age: 17),
        (name: Amy     , age: 14),
    })

    `Two positional attributes + two tuples.`
    (Tuple_Array:{
        (Michelle, 17),
        (Amy     , 14),
    })
```

## Relation / Tuple Set

A **Relation** artifact has the predicate `Relation`.

Its subject is any of the following:

* Any **Heady** artifact, which denotes the *heading* of the
**Relation**, and the *body* of the **Relation** has zero tuples.
This is the idiomatic format for an empty (zero-tuple) **Relation**.

* Any **Setty** artifact such that every one of its *members* is a **Tupley**
artifact, and the count of its members is at least 1, and no 2 members have
different *headings*.  The *members* of the **Setty** denote the *body* or
*members* of the **Relation**, and any one *member* also denotes the
*heading* of the **Relation**.  This is the idiomatic format for specifying
a non-empty (at least one tuple) **Relation** where the attribute names
repeat for every tuple.

* Any **Duo** artifact such that its *this* and *that* correspond to the
*heading* and *body* of the new **Relation** respectively, and its *that*
is any **Setty** artifact per the prior bullet point but that it may have
zero members, and its *this* is any **Renamey** artifact such that its set
of *name before* is identical to the set of attribute names in every
*member* of *that*.  This is the idiomatic format for specifying a
**Relation** where the attribute names just appear once and are shared for
every tuple, like in a terse columnar table format; it is expected the
normal use case of this format is that every **Setty** member only has
positional attributes and the **Renaming** is effectively giving them
non-positional names.

Examples:

```
    `Zero attributes + zero tuples.`
    (Relation:())

    `Same thing.`
    (Relation:(():{}))

    `Zero attributes + one tuple.`
    (Relation:{()})

    `Same thing.`
    (Relation:(():{()}))

    `Three named attributes + zero tuples.`
    (Relation:(x,y,z))

    `Three positional attributes + zero tuples.`
    (Relation:(0t0,0t1,0t2))

    `Two named attributes + two tuples.`
    (Relation:{
        (name: Michelle, age: 17),
        (name: Amy     , age: 14),
    })

    `Same thing.`
    (Relation:(
            (name    , age)
        : {
            (Michelle, 17 ),
            (Amy     , 14 ),
        }
    ))

    `Two positional attributes + two tuples.`
    (Relation:{
        (Michelle, 17),
        (Amy     , 14),
    })

    `Some people records.`
    (Relation:{
        (name : "Jane Ives", birth_date : (Calendar_Instant:(y:1971,m:11,d:6)),
            phone_numbers : (Set:{"+1.4045552995", "+1.7705557572"})),
        (name : "Layla Miller", birth_date : (Calendar_Instant:(y:1995,m:8,d:27)),
            phone_numbers : (Set:{})),
        (name : "岩倉 玲音", birth_date : (Calendar_Instant:(y:1984,m:7,d:6)),
            phone_numbers : (Set:{"+81.9072391679"})),
    })

    `Same thing.`
    (Relation:(
            (name          , birth_date                           , phone_numbers)
        : {
            ("Jane Ives"   , (Calendar_Instant:(y:1971,m:11,d:6)), (Set:{"+1.4045552995", "+1.7705557572"})),
            ("Layla Miller", (Calendar_Instant:(y:1995,m:8,d:27)), (Set:{})),
            ("岩倉 玲音", (Calendar_Instant:(y:1984,m:7,d:6)), (Set:{"+81.9072391679"})),
        }
    ))
```

## Tuple Bag

A **Tuple Bag** artifact has the predicate `Tuple_Bag`.

Its subject is any of the following:

* Any **Relation** subject but that any **Baggy** artifact is used in
place of the specified any **Setty** artifact.

Examples:

```
    `Zero attributes + zero tuples.`
    (Tuple_Bag:())

    `Zero attributes + one tuple.`
    (Tuple_Bag:{()})

    `Three named attributes + zero tuples.`
    (Tuple_Bag:(x,y,z))

    `Three positional attributes + zero tuples.`
    (Tuple_Bag:(0t0,0t1,0t2))

    `Two named attributes + six tuples (4 duplicates).`
    (Tuple_Bag:{
        (name: Michelle, age: 17),
        (name: Amy     , age: 14) : 5,
    })

    `Two positional attributes + two tuples.`
    (Tuple_Bag:{
        (Michelle, 17),
        (Amy     , 14),
    })
```

# SIGNATURE DECLARING SECONDARY DATA TYPE POSSREPS

*This whole section is quite rough and will be rewritten at some future time.*

## Syntax

A **Syntax** artifact has the predicate `Syntax`.

Its subject is any of the following:

* Any **Duo** artifact such that its *this* and *that*
are the *syntax predicate* and *syntax subject* respectively;
the *syntax predicate* is any **Arrayish** artifact
that typically consists of 3 **Text** artifacts;
the *syntax subject* is any **Any** artifact.

Examples:

```
    (Syntax:({Muldis_Object_Notation_Plain_Text, "https://muldis.com", "0.300.0"}:
        42
    ))

    (Syntax:({Muldis_Object_Notation_Plain_Text, "https://example.com", "42"}:
        42
    ))
```

## Model

A **Model** artifact has the predicate `Model`.

Its subject is any of the following:

* Any **Duo** artifact such that its *this* and *that*
are the *model predicate* and *model subject* respectively;
the *model predicate* is any **Arrayish** artifact
that typically consists of 3 **Text** artifacts;
the *model subject* is any **Any** artifact.

Examples:

```
    (Model:({Muldis_Data_Language, "https://muldis.com", "0.300.0"}:
        42
    ))

    (Model:({Muldis_Data_Language, "https://example.com", "42"}:
        42
    ))

    (Model:({SQL, "https://postgresql.org", "14.3"}:
        42
    ))

    (Model:({SQL, "https://sqlite.org", "3.38.5"}:
        42
    ))

    (Model:({Perl, "https://perlfoundation.org", "5.36.0"}:
        42
    ))
```

# SOURCE CODE DEFINING SECONDARY DATA TYPE POSSREPS

*None yet.*

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
