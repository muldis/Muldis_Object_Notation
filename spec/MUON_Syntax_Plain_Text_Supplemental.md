<a name="TOP"></a>

# Muldis Object Notation (MUON) Syntax_Plain_Text Supplemental

This document features supplemental material that used to be part of
[Syntax_Plain_Text](Muldis_Object_Notation_Syntax_Plain_Text.md)
but was removed from there as it was deemed to fit better as part of a
possible superset of the MUON grammar rather than as part of MUON proper.

## CONTENTS

- [Expansion of Possrep Any](#Expansion-of-Possrep-Any)
- [Added Dedicated Format for Calendar Time](#Added-Dedicated-Format-for-Calendar-Time)
- [Added Dedicated Format for Calendar Duration](#Added-Dedicated-Format-for-Calendar-Duration)
- [Added Dedicated Format for Calendar Instant](#Added-Dedicated-Format-for-Calendar-Instant)
- [Added Dedicated Format for Geographic Point](#Added-Dedicated-Format-for-Geographic-Point)
- [Added Dedicated Format for Interval](#Added-Dedicated-Format-for-Interval)
- [More Compact Examples of Interval Set](#More-Compact-Examples-of-Interval-Set)
- [More Compact Examples of Interval Bag](#More-Compact-Examples-of-Interval-Bag)
- [More Compact Examples of Relation](#More-Compact-Examples-of-Relation)
- [Naive Entity Marker](#Naive-Entity-Marker)
- [Signature Declaring Secondary Data Type Possrep Script - Semantics](#Signature-Declaring-Secondary-Data-Type-Possrep-Script---Semantics)
- [Signature Declaring Secondary Data Type Possrep Script - Syntax Abstract](#Signature-Declaring-Secondary-Data-Type-Possrep-Script---Syntax-Abstract)
- [Signature Declaring Secondary Data Type Possrep Script - Syntax Plain Text](#Signature-Declaring-Secondary-Data-Type-Possrep-Script---Syntax-Plain-Text)

[RETURN](#TOP)

<a name="Expansion-of-Possrep-Any"></a>

## Expansion of Possrep Any

Grammar:

```
    token Any
    {
          ...
        | <Calendar_Time>
        | <Calendar_Duration>
        | <Calendar_Instant>
        | <Geographic_Point>
        | <Interval>
    }
```

[RETURN](#TOP)

<a name="Added-Dedicated-Format-for-Calendar-Time"></a>

## Added Dedicated Format for Calendar Time

A **Calendar Time** artifact has the dedicated concrete literal format
described by `<Calendar_Time>`.

Grammar:

```
    token Calendar_Time
    {
        0Lct [<sp>? '@' <sp>? <time_elements>]?
    }

    token time_elements
    {
        [<time_unit> <sp>? <loc_multiplicity>]+ % [<sp>? '|' <sp>?]
    }

    token time_unit
    {
        <[ymdhis]>
    }

    token loc_multiplicity
    {
        <Integer> | <Fraction>
    }
```

Examples:

```
    `No measurement was taken or specified at all.`
    0Lct

    `Either an unspecified period in 1970 or a duration of 1970 years.`
    0Lct@y1970

    `Either a civil calendar date 2015-5-3 or a duration of 2015y+5m+3d.`
    0Lct@y2015|m5|d3

    `Either a military calendar date 1998-300 or a duration of 1998y+300d.`
    0Lct@y1998|d300

    `Either the 6th week of 1776 or a duration of 1776 years + 6 weeks.`
    0Lct@y1776|d42

    `Either the first quarter of 1953 or a duration of 1953.25 years.`
    0Lct@y1953.25

    `Either high noon on an unspecified day or a duration of 12 hours.`
    0Lct@h12|i0|s0

    `Either a fully specified civil date and time or a 6-part duration.`
    0Lct@y1884|m10|d17|h20|i55|s30

    `Either an ancient date and time or a negative duration.`
    0Lct@y-370|m1|d24|h11|i0|s0

    `Either a time on some unspecified day or a duration of seconds.`
    0Lct@s5923.21124603
```

[RETURN](#TOP)

<a name="Added-Dedicated-Format-for-Calendar-Duration"></a>

## Added Dedicated Format for Calendar Duration

A **Calendar Duration** artifact has the dedicated concrete literal format
described by `<Calendar_Duration>`.

Grammar:

```
    token Calendar_Duration
    {
        0Lcd [<sp>? '@' <sp>? <time_elements>]?
    }
```

Examples:

```
    `Addition of 2 years and 3 months.`
    0Lcd@y2|m3|d0|h0|i0|s0

    `Subtraction of 22 hours.`
    0Lcd@y0|m0|d0|h-22|i0|s0
```

[RETURN](#TOP)

<a name="Added-Dedicated-Format-for-Calendar-Instant"></a>

## Added Dedicated Format for Calendar Instant

A **Calendar Instant** artifact has the dedicated concrete literal format
described by `<Calendar_Instant>`.

Grammar:

```
    token Calendar_Instant
    {
        0Lci [<sp>? '@' <sp>? <instant_base>
            [<sp>? '@' <sp>? [<instant_offset> | <instant_zone>]]?
        ]?
    }

    token instant_base
    {
        <time_elements>
    }

    token instant_offset
    {
        <time_elements>
    }

    token instant_zone
    {
        <quoted_text_segment>
    }
```

Examples:

```
    `The Day The Music Died (if paired with Gregorian calendar).`
    0Lci@y1959|m2|d3

    `A time of day when one might have breakfast.`
    0Lci@h7|i30|s0

    `What was now in the Pacific zone (if paired with Gregorian calendar).`
    0Lci@y2018|m9|d3|h20|i51|s17@h-8|i0|s0

    `A time of day in the UTC zone on an unspecified day.`
    0Lci@h9|i25|s0@h0|i0|s0

    `A specific day and time in the Pacific Standard Time zone.`
    0Lci@y2001|m4|d16|h20|i1|s44@"PST"
```

[RETURN](#TOP)

<a name="Added-Dedicated-Format-for-Geographic-Point"></a>

## Added Dedicated Format for Geographic Point

A **Geographic Point** artifact has the dedicated concrete literal format
described by `<Geographic_Point>`.

Grammar:

```
    token Geographic_Point
    {
        0Lgp [<sp>? '@' <sp>? <geo_elements>]?
    }

    token geo_elements
    {
        [<geo_unit> <sp>? <loc_multiplicity>]+ % [<sp>? '|' <sp>?]
    }

    token geo_unit
    {
        <[>^+]>
    }
```

Examples:

```
    `No specified coordinates at all.`
    0Lgp

    `Just an elevation specified.`
    0Lgp@+920

    `Geographic surface coordinates of Googleplex; elevation not specified.`
    0Lgp@>-122.0857017|^37.4218363

    `Same thing.`
    0Lgp@^37.4218363|>-122.0857017

    `Some location with all coordinates specified.`
    0Lgp@>-101|^-70|+1000

    `Another place.`
    0Lgp@>-94.746094|^37.483577
```

[RETURN](#TOP)

<a name="Added-Dedicated-Format-for-Interval"></a>

## Added Dedicated Format for Interval

An **Interval** artifact has the dedicated concrete literal format
described by `<Interval>`.

Grammar:

```
    token Interval
    {
        ['(:' <sp>?] ~ [<sp>? ':)'] <interval_members>
    }

    token interval_members
    {
        <interval_empty> | <interval_single> | <interval_range>
    }

    token interval_empty
    {
        ''
    }

    token interval_single
    {
        <Any>
    }

    token interval_range
    {
          [[<interval_low> <sp>? '<' '='?]? '*'  ['<' '='? <sp>? <interval_high>]?]
        | [ <interval_low> <sp>?            '..'           <sp>? <interval_high>  ]
    }

    token interval_low
    {
        <Any>
    }

    token interval_high
    {
        <Any>
    }
```

Examples:

```
    `Empty interval (zero members).`
    {}

    `Unit interval (one member).`
    (:abc:)

    `Closed interval (probably 10 members, depending on the model used).`
    (:1 <=*<= 10:)

    `Same thing.`
    (:1..10:)

    `Left-closed, right-open interval; every Fraction x in [2.7<=x<9.3].`
    (:2.7 <=*< 9.3:)

    `Left-open, right-closed interval; every Text x ordered in [a<x<=z].`
    (:a <*<= z:)

    `Open interval; time period between Dec 6 and 20 excluding both.`
    (:0Lci@y2002|m12|d6@"UTC" <*< 0Lci@y2002|m12|d20@"UTC":)

    `Left-unbounded, right-closed interval; every Integer x where x <= 3.`
    (:*<= 3:)

    `Left-closed, right-unbounded interval; every Integer x where 29 <= x.`
    (:29 <=*:)

    `Universal interval; unbounded; every value of type system is a member.`
    (:*:)
```

[RETURN](#TOP)

<a name="More-Compact-Examples-of-Interval-Set"></a>

## More Compact Examples of Interval Set

```
    `Empty interval-set (zero members).`
    (Interval_Set:[])

    `Unit interval-set (one member).`
    (Interval_Set:[(:abc:)])

    `Probably 10 members, depending on the model used.`
    (Interval_Set:[(:1<=*<=10:)])

    `Same thing.`
    (Interval_Set:[(:1..10:)])

    `Probably 6 members.`
    (Interval_Set:[(:1..3:),(:6:),(:8..9:)])

    `Every Integer x except for [4..13,22..28]`
    (Interval_Set:[(:*<=3:),(:14..21:),(:29<=*:)])

    `Set of all valid Unicode code points.`
    (Interval_Set:[(:0..0xD7FF:),(:0xE000..0x10FFFF:)])

    `Probably 15 members (no duplicates), depending on the model used.`
    (Interval_Set:[(:1..10:),(:6..15:)])

    `Probably same thing, regardless of data model used.`
    (Interval_Set:[(:1<=*<6:),(:6..10:):2,(:10<*<=15:)])
```

[RETURN](#TOP)

<a name="More-Compact-Examples-of-Interval-Bag"></a>

## More Compact Examples of Interval Bag

```
    `Empty interval-bag (zero members).`
    (Interval_Bag:[])

    `Unit interval-bag (one member).`
    (Interval_Bag:[(:abc:)])

    `Five members (4 duplicates).`
    (Interval_Bag:[(:def:):5])

    `Probably 20 members (5 duplicates), depending on the model used.`
    (Interval_Bag:[(:1<=*<=10:),(:6<=*<=15:)])

    `Same thing.`
    (Interval_Bag:[(:1..10:),(:6..15:)])

    `Probably same thing, regardless of data model used.`
    (Interval_Bag:[(:1<=*<6:),(:6..10:):2,(:10<*<=15:)])
```

[RETURN](#TOP)

<a name="More-Compact-Examples-of-Relation"></a>

## More Compact Examples of Relation

```
    `Some people records.`
    (Relation:[
        {name : "Jane Ives", birth_date : 0Lci@y1971|m11|d06,
            phone_numbers : (Set:["+1.4045552995", "+1.7705557572"])},
        {name : "Layla Miller", birth_date : 0Lci@y1995|m08|d27,
            phone_numbers : (Set:[])},
        {name : "岩倉 玲音", birth_date : 0Lci@y1984|m07|d06,
            phone_numbers : (Set:["+81.9072391679"])},
    ])

    `Same thing.`
    (Relation:(
            {name          , birth_date        , phone_numbers}
        : [
            {"Jane Ives"   , 0Lci@y1971|m11|d06, (Set:["+1.4045552995", "+1.7705557572"])},
            {"Layla Miller", 0Lci@y1995|m08|d27, (Set:[])},
            {"岩倉 玲音", 0Lci@y1984|m07|d06, (Set:["+81.9072391679"])},
        ]
    ))
```

[RETURN](#TOP)

<a name="Naive-Entity-Marker"></a>

## Naive Entity Marker

This document section used to be additional content of the
**DIVIDING SPACE** section of
[Syntax_Plain_Text](Muldis_Object_Notation_Syntax_Plain_Text.md)
but was removed from there when MUON was simplified to exclude this
semi-obsolete optional feature.
An alternative method to accomplish the same goal will be added later.

An *entity marker* is a feature that is optional for a MUON parser or
generator to support.  It is a special case of a `<quoted_sp_comment_str>`,
the character string `` `$$$` ``, and would simply be seen as such by a MUON parser
that didn't specifically know about it.  An *entity marker* is intended
as a trivial annotation for some MUON construct that immediately follows
it.  This is so that naive development tools that know about MUON
specifically but not about any source code defining data models layered
over it can be expressly pointed to the parts of the MUON document that
declare something interesting, such as a package or routine or type
declaration, so that generic MUON tooling can, say, generate a navigation
menu to quickly jump around a document to each entity declaration therein.
The idomatic location for an *entity marker* is immediately before a
**Kit** attribute name, assuming that the corresponding attribute value
is the construct of interest and the attribute name is used as the name to
refer to it with in function menus.

Examples:

```
    (
        `$$$` My_Func : Function*(...),

        `$$$` My_Proc_1 : Procedure*(...),

        `$$$` My_Proc_2 : Procedure*(...),
    )
```

[RETURN](#TOP)

<a name="Signature-Declaring-Secondary-Data-Type-Possrep-Script---Semantics"></a>

## Signature Declaring Secondary Data Type Possrep Script - Semantics

This document section used to be the content of the
**SIGNATURE DECLARING SECONDARY DATA TYPE POSSREPS - Script** section of
[Semantics](Muldis_Object_Notation_Semantics.md)
but was removed from there when MUON was altered to make UTF-8 the only
allowed file text encoding option rather than supporting alternatives,
and its **Script** secondary data type possrep was deleted.

A **Script** value is characterized by the pairing of a *script predicate*
value with a *script subject* value, such that the former describes the latter.

A *script predicate* is a declaration of the primary *script* of (typically)
the *value* as a whole, meaning its character repertoire and/or character
encoding and/or character normalization.  Under the assumption that a
parser might be reading the *value* as binary data or otherwise as
unnormalized character data, declaring the **Script** makes it completely
unambiguous as to what characters it is to be treating the input as.

For a simple example, a **Script** of `ASCII` says every literal source
code character is a 7-bit ASCII character (and representing any non-ASCII
characters is being done with escape sequences), and this is recommended
for any file that doesn't need to be something else. For various legacy
8-bit formats the **Script** can tell us if we're using `Latin1` or
`CP1252` or `EBCDIC` etc.  For Unicode the **Script** would have multiple
parts, such as `Unicode 2.1 UTF-8 canon`, indicating expected repertoire,
and encoding (useful more with ones lacking BOMs); but at the very least it
is useful with normalization; if `compat` is declared then the source code
is folded before it is parsed so possibly distinct literal characters in
the original code are seen as identical character strings by the main
parser, while `canon` would not do this folding.

A parser would possibly scan through the same source code multiple times
filtering by a variety of text encodings until it can read a **Script**
declaring the same encoding that the **Script** is itself written in, and
then from that point it would expect the whole file to be that declared
encoding or it would consider the source code invalid.

There may be multiple **Script**; when this is the case,
it means the *value* conforms to every one of those scripts,
typically because only the common subsets of said were used.

[RETURN](#TOP)

<a name="Signature-Declaring-Secondary-Data-Type-Possrep-Script---Syntax-Abstract"></a>

## Signature Declaring Secondary Data Type Possrep Script - Syntax Abstract

This document section used to be the content of the
**SIGNATURE DECLARING SECONDARY DATA TYPE POSSREPS - Script** section of
[Syntax_Abstract](Muldis_Object_Notation_Syntax_Abstract.md)
but was removed from there when MUON was altered to make UTF-8 the only
allowed file text encoding option rather than supporting alternatives,
and its **Script** secondary data type possrep was deleted.

A **Script** artifact has the predicate `Script`.

Its subject is any of the following:

* Any **Duo** artifact such that its *this* and *that*
are the *script predicate* and *script subject* respectively;
the *script subject* is any **Any** artifact;
the *script predicate* is any **Lot** artifact
that typically consists of 3 **Text** artifacts.

Examples:

```
    (Script:([ASCII]:
        42
    ))

    (Script:([Unicode, 2.1, "UTF-8"]:
        42
    ))

    (Script:([Unicode, 2.1, "UTF-8", canon]:
        42
    ))
```

[RETURN](#TOP)

<a name="Signature-Declaring-Secondary-Data-Type-Possrep-Script---Syntax-Plain-Text"></a>

## Signature Declaring Secondary Data Type Possrep Script - Syntax Plain Text

This document section used to be the content of the
**NORMALIZATION - Script / Character Encoding** section of
[Syntax_Plain_Text](Muldis_Object_Notation_Syntax_Plain_Text.md)
but was removed from there when MUON was altered to make UTF-8 the only
allowed file text encoding option rather than supporting alternatives,
and its **Script** secondary data type possrep was deleted.

Assuming that the MUON parser proper operates logically in terms of the
input *parsing unit* being a Unicode character string (characterized by a
sequence of Unicode *character code points*, each corresponding to an
integer in the set `[0..0xD7FF,0xE000..0x10FFFF]`), a MUON parser that is
actually given an octet string as input (per a raw file) will need to
determine which of possibly many possible encoding formats was used to
encode the character data as octets, and then convert the input as such.

In self-defining terms, the regular MUON parser expects a **Text** value
as input, but a raw file is directly characterized by a **Blob** value,
so a normalization function would need to map from the latter value to the
former, a process typically known as *character decoding*.

It is mandatory for every MUON parser and generator to support the UTF-8
character format associated with the **Unicode** standard version 2.1 and
later; the proper subset 7-bit ASCII character format is also mandatory.
Both the UTF-8 variants with and without the leading Byte Order Mark (BOM)
character must be supported.

It is recommended but not mandatory for a MUON parser or generator to also
support other commonly used character formats, for example UTF-16BE and
UTF-16LE (both with and without a BOM), either legacy or modern.

It is strongly recommended but not mandatory for a MUON parser or generator
to natively accept or return both **Text** and **Blob** values directly.
Typically this means providing 2 parsing or generating functions that
differ only in accepting or returning a **Text** or a **Blob**.
This can make the parsing or generating operations use less memory or time
by avoiding extra intermediate copies or conversions of the data; it should
be quite straightforward to parse or generate MUON octet streams directly.
This also means applications using them don't have to concern themselves as
much with explicit character decoding or encoding, and can simply feed or
output a file or network stream etc.

*The rest of this sub-section about Muldis Content Predicate is quite rough
and will be rewritten at some future time.*

It is strongly recommended but not mandatory for a MUON parser or generator
to support the externally defined standard **Muldis Content Predicate**
(**MCP**) format for source code metadata.  The MCP standard was
co-developed with the MUON standard as a recommended way to make a MUON
*parsing unit* more strongly typed, for example to explicitly declare
what script / character encoding was used in its file / octet string form.
While heuristics (and BOMs) can lead to a strong guess as to what character
encoding a file is, an explicit MCP declaration can make things more certain.

A **Muldis Content Predicate** declaration is expressly supported by
**Muldis Object Notation** in the form of the latter's
**SIGNATURE DECLARING SECONDARY DATA TYPE POSSREPS**,
which are the possreps: **Script**, **Syntax**, **Model**.

If a MUON parser supports scanning a *parsing unit* for a *script
predicate*, then it is mandatory for any scan to look through the lesser of
the first 1000 characters, the first 2000 octets, or the entirety, of the
*parsing unit*, before it gives up on trying to find a *script
predicate*; giving up after that point is recommended.  This
means that any *script predicate* needs to be located near the start of the
*parsing unit* if it has any expectation of being seen.  This requirement
exists to aid performance of a MUON parser by invalidating pathological
cases, so a parser doesn't have to scan a large *parsing unit* just in case
it might have a buried *script predicate* that most likely isn't there at all.
