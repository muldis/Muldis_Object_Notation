# NAME

Muldis Object Notation (MUON) -
Source code and data interchange format

# VERSION

The fully-qualified name of this document is
`Muldis_Object_Notation http://muldis.com 0.201.0`.

# SYNOPSIS

```
    `Muldis_Content_Predicate
    MCP version http://muldis.com 0.201.0 MCP
    MCP script Unicode 2.1 UTF-8 MCP
    MCP syntax Muldis_Object_Notation http://muldis.com 0.201.0 MCP
    MCP model Muldis_Data_Language http://muldis.com 0.201.0 MCP
    Muldis_Content_Predicate`

    \?%{
        (name : "Jane Ives", birth_date : "1971-11-06",
            phone_numbers : {"+1.4045552995", "+1.7705557572"}),
        (name : "Layla Miller", birth_date : "1995-08-27", phone_numbers : {}),
        (name : "岩倉 玲音", birth_date : "1984-07-06",
            phone_numbers : {"+81.9072391679"}),
    }
```

# DESCRIPTION

This document is the human readable authoritative formal specification named
**Muldis Object Notation** (**MUON**).
The fully-qualified name of this document and specification is
`Muldis_Object_Notation http://muldis.com 0.201.0`.
This is the official/original version by the authority Muldis Data Systems
(`http://muldis.com`), version number `0.201.0`.

**Muldis Object Notation** specifies a semi-lightweight source code and
data interchange format.  It is fairly easy for humans to read and write.
It is fairly easy for machines to parse and generate.  MUON is a plain text
format that is completely language independent but uses conventions that
are familiar to programmers of many other languages.

The prescribed standard filename extension for files featuring a MUON
parsing unit is `.muon`, though as per standard UNIX conventions, such MUON
files can in fact have any filename extension when there is other context
to interpret them with.  Filename extensions are more for the benefit of
the operating system or command shell or users than for a MUON parser or
generator, the latter just cares about the content of the file.

# FEATURES

These sections outline some key features of MUON, including some that are
more unique to it and some reasons for why one might want to use it.

## Data Types

**Muldis Object Notation** is mainly characterized by a set of *data types*
that all *values* represented with MUON syntax are members of.
Each MUON data type corresponds 1:1 with a distinct grammar in this document.

- Logical: Boolean
- Numeric: Integer, Fraction, Decimal
- Stringy: Bits, Blob, Text
- Discrete: Array, Set, Bag
- Continuous: Interval, Interval Set, Interval Bag
- Structural: Tuple
- Relational: Tuple Array, Relation, Tuple Bag
- Symbolic: Unit, Measure
- Generic: Capsule, Excuse, Ignorance
- Source Code: Nesting, Heading, Renaming

This document avoids defining any relationship between these types, and
officially leaves it up to each external data model used with MUON to
define for itself whether any two given types are *conjoined* (have any
values in common) or *disjoint* (have no values in common).  For example,
some external data models may consider **Integer** to be a *subtype* of
**Decimal** (`42` is a member of both) while others may consider the two
types to be disjoint (`42` and `42.0` do not compare as equal).  The sole
exceptions are that the (not listed above) **Any** and **None** types
explicitly are a *supertype* or *subtype* respectively of every other type,
regardless of the data model, for what that's worth.

Each external data model used with MUON is not required to support every
one of the types defined here; however, every *value* that the external
data model supports generating into or parsing from MUON must be losslessly
represented using at least one of the types defined here, and that value
must be losslessly round-trippable using all of those representations.
Note that the **Capsule** type is the idiomatic way for an external data
model to represent "new" types in a consistent way.

## Ease of Use

*TODO.*

## Resiliency

*TODO.*

## Extensibility

*TODO.*

# NORMALIZATION

The grammar comprising most of this document assumes that the MUON *parsing
unit* it takes as input has already been through some basic normalization,
which this section describes.  Said normalization is expected to be
performed by a MUON parser natively as its first step.

## UNIX Shebang Interpreter Directive

[https://en.wikipedia.org/wiki/Shebang_(Unix)](
https://en.wikipedia.org/wiki/Shebang_(Unix))

Since a MUON file may typically define an executable program that could be
directly invoked in the typical manner of a UNIX script, MUON officially
supports the option of a *shebang line* at the start of a *parsing unit*.
The shebang line tells the program loader what interpreter to invoke to run
the MUON file and what other additional arguments it should be given.

Examples:

```
    #!/usr/bin/env muldisre
```

The `#!` is a magic number and the shebang continues until the first
linebreak; the parser should discard that line and then process the rest of
the input according to the regular MUON grammar.

## Script / Character Encoding

Assuming that the MUON parser proper operates logically in terms of the
input *parsing unit* being a Unicode character string (characterized by a
sequence of Unicode *character codepoints*, each corresponding to an
integer in the set {0..0xD7FF,0xE000..0x10FFFF}), a MUON parser that is
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
support other commonly used character formats, particularly UTF-16BE and
UTF-16LE (both with and without a BOM), either legacy or modern.

It is strongly recommended but not mandatory for a MUON parser or generator
to support the externally defined standard **Muldis Content Predicate**
(**MCP**) format for source code metadata.  The MCP standard was
co-developed with the MUON standard as a recommended way to make a MUON
*parsing unit* more strongly typed, in particular to explicitly declare
what script / character encoding was used in its file / octet string form.
While heuristics (and BOMs) can lead to a strong guess as to what character
encoding a file is, an explicit MCP declaration makes things more certain.

A **Muldis Content Predicate** declaration would normally be embedded in a
MUON *dividing space* quoted comment string, so the regular MUON parser
needs no special handling grammar/logic to ignore it (unlike a shebang).

Examples:

```
    `Muldis_Content_Predicate
    MCP version http://muldis.com 0.201.0 MCP
    MCP script Unicode 2.1 UTF-8 MCP
    MCP syntax Muldis_Object_Notation http://muldis.com 0.201.0 MCP
    MCP model Muldis_Data_Language http://muldis.com 0.201.0 MCP
    Muldis_Content_Predicate`
```

# GRAMMAR

The format of the grammar itself seen in this document is proprietary as a
whole and is influenced both by EBNF and Perl 6 rules; it is designed for
human readability and is not meant to be consumed by a parser-generator,
but it should have all the needed details to derive an executable parser.

Grammar:

```
    <MUON> ::=
        <sp>
            <Any>
        <sp>

    <sp> ::=
        [<whitespace> | <quoted_sp_comment_str>]*

    <whitespace> ::=
        [' ' | '\t' | '\n' | '\r']+

    <quoted_sp_comment_str> ::=
        '`' <-[`]>* '`'
```

A `<sp>` represents *dividing space* that may be used to visually format
MUON for readability (with line breaks and line indentation), or to embed
comments, without changing its meaning.  A superset of the MUON grammar
might require *dividing space* to disambiguate the boundaries of
otherwise-consecutive grammar tokens, but plain MUON does not.

## Any / Universal Type

The **Any** type is the *universal type*, which is the maximal data type of
the type system and consists of all values which can possibly exist.
This is represented by `<Any>`.

Grammar:

```
    <Any> ::=
        <opaque> | <collection>

    <opaque> ::=
          <Boolean>
        | <Integer>
        | <Fraction>
        | <Decimal>
        | <Bits>
        | <Blob>
        | <Text>
        | <Ignorance>
        | <Nesting>
        | <Heading>
        | <Renaming>

    <collection> ::=
          <Array>
        | <Set>
        | <Bag>
        | <Interval>
        | <Interval_Set>
        | <Interval_Bag>
        | <Tuple>
        | <Tuple_Array>
        | <Relation>
        | <Tuple_Bag>
        | <Unit>
        | <Measure>
        | <Capsule>
        | <Excuse>
```

An `<Any>` represents a generic value literal that is allowed to be of any
type at all, except where specifically noted otherwise.

An `<opaque>` is an `<Any>` that explicitly has no child `<Any>` nodes; in
conventional terms, one is typically for selecting scalar values, though
many cases are also simple collections.

A `<collection>` is an `<Any>` that explicitly does have child `<Any>`
nodes in the general case; in conventional terms, one is for selecting
values representing collections of other values.

## None / Empty Type

The **None** type is the *empty type*, which is the minimal data type of
the type system and consists of exactly zero values.
This has no representation in the grammar, but is mentioned for parity.

## Boolean

A **Boolean** value, represented by `<Boolean>`, is a general purpose
2-valued logic boolean or *truth value*, or specifically it is one of the 2
values *False* and *True*.

Grammar:

```
    <Boolean> ::=
        ['\\?' <sp>]? [False | True]
```

Examples:

```
    False

    True

    \?False

    \?True
```

## Integer

An **Integer** value, represented by `<Integer>`, is a general purpose
exact integral number of any magnitude, which explicitly does not represent
any kind of thing in particular, neither cardinal nor ordinal nor nominal.
It has no minimum or maximum value.

Grammar:

```
    <Integer> ::=
        <nonquoted_int> | <quoted_int> | <int_with_radix>

    <nonquoted_int> ::=
        ['\\+' <sp>]? <asigned_int>

    <asigned_int> ::=
        <[+-]>? <nonsigned_int>

    <nonsigned_int> ::=
        <[ 0..9 _ ]>+

    <quoted_int> ::=
        '\\+' <sp> '"' <asigned_int> '"' [<sp> '"' <nonsigned_int> '"']*

    <int_with_radix> ::=
        ['\\+' <sp>]? <asigned_int_with_radix>

    <asigned_int_with_radix> ::=
        <[+-]>? <nonsigned_int_with_radix>

    <nonsigned_int_with_radix> ::=
        <ns_int_2> | <ns_int_8> | <ns_int_10> | <ns_int_16>

    <ns_int_2> ::=
        0b <[ 0..1 _ ]>+

    <ns_int_8> ::=
        0o <[ 0..7 _ ]>+

    <ns_int_10> ::=
        0d <[ 0..9 _ ]>+

    <ns_int_16> ::=
        0x <[ 0..9 A..F _ a..f ]>+
```

This grammar supports writing **Integer** literals in any of the numeric
bases {2,8,10,16}, using conventional syntax.  The literal may optionally
contain underscore characters (`_`), which exist just to help with visual
formatting, such as for `10_000_000`.

A quoted `<Integer>` may optionally be split into 1..N quoted segments
where each pair of consecutive segments is separated by dividing space;
this segmenting ability is provided to support code that contains very long
numeric literals while still being well formatted (no extra long lines).

This grammar is subject to the additional rule that the total count of
digit characters (`0..9`) in the `<nonsigned_int>` must be at least 1.

This grammar is subject to the additional rule that the total count of
numeric position characters (`0..9 A..F a..f`) in the
`<nonsigned_int_with_radix>` must be at least 1.

Examples:

```
    0

    1

    -3

    42

    `USA national debt in US dollars close to midnight of 2017 Dec 31.`
    20_597_460_196_915

    \+81

    `Mersenne Prime 2^521-1, 157 digits, discovered 1952 Jan 30.`
    \+"68_64797"
        "66013_06097_14981_90079_90813_93217_26943_53001_43305_40939"
        "44634_59185_54318_33976_56052_12255_96406_61454_55497_72963"
        "11391_48085_80371_21987_99971_66438_12574_02829_11150_57151"

    0d39

    0xDEADBEEF

    0o644

    0b11001001
```

## Fraction

A **Fraction** value, represented by `<Fraction>`, is a general purpose
exact rational number of any magnitude and precision, which explicitly does
not represent any kind of thing in particular, neither cardinal nor ordinal
nor nominal.  It has no minimum or maximum value.

Grammar:

```
    <Fraction> ::=
        <nonquoted_frac> | <quoted_frac>

    <nonquoted_frac> ::=
        <nonquoted_int> '/' <nonsigned_int>

    <quoted_frac> ::=
        '\\+' <sp> '"' <[+-]>? <[ 0..9 _ / ]>+
            '"' [<sp> '"' <[ 0..9 _ / ]>+ '"']*
```

This grammar supports writing **Fraction** literals in numeric base 10
only, as a *numerator* / *denominator* pair of **Integer** whose
*denominator* is positive, using conventional syntax.  MUON does not
require the *numerator* / *denominator* pair to be coprime, but typically a
type system will normalize the pair as such when determining value
identity.  The literal may optionally contain underscore characters (`_`),
which exist just to help with visual formatting, such as for `20_194/17`.

A quoted `<Fraction>` may optionally be split into 1..N quoted segments
where each pair of consecutive segments is separated by dividing space;
this segmenting ability is provided to support code that contains very long
numeric literals while still being well formatted (no extra long lines).

This grammar is subject to the additional rule that the total count of `/`
in the `<quoted_frac>` must be exactly 1.

This grammar is subject to the additional rule that the total count of
digit characters (`0..9`) in the `<quoted_frac>` must be at least 2,
such that the `/` is positioned after at least 1 and before at least 1.

Examples:

```
    0/1

    1/1

    5/3

    -472/100

    15_485_863/32_452_843

    \+355/113

    `Mersenne Primes 2^107-1 divided by 2^127-1.`
    \+"162259276829213363391578010288127"
        "/170141183460469231731687303715884105727"
```

## Decimal

A **Decimal** value, represented by `<Decimal>`, is a general purpose exact
rational number of any magnitude and precision that can be represented as a
terminating decimal number, which explicitly does not represent any kind of
thing in particular, neither cardinal nor ordinal nor nominal.  Note that
every rational number that can be represented as a terminating binary or
octal or hexadecimal number can also be represented as a terminating
decimal number.  It has no minimum or maximum value.

Grammar:

```
    <Decimal> ::=
        <nonquoted_dec> | <quoted_dec>

    <nonquoted_dec> ::=
        <nonquoted_int> '.' <nonsigned_int>

    <quoted_dec> ::=
        '\\+' <sp> '"' <[+-]>? <[ 0..9 _ \. ]>+
            '"' [<sp> '"' <[ 0..9 _ \. ]>+ '"']*
```

This grammar supports writing **Decimal** literals in numeric base 10 only,
using conventional syntax.  The literal may optionally contain underscore
characters (`_`), which exist just to help with visual formatting, such as
for `3.141_59`.

A quoted `<Decimal>` may optionally be split into 1..N quoted segments
where each pair of consecutive segments is separated by dividing space;
this segmenting ability is provided to support code that contains very long
numeric literals while still being well formatted (no extra long lines).

This grammar is subject to the additional rule that the total count of `.`
in the `<quoted_dec>` must be exactly 1.

This grammar is subject to the additional rule that the total count of
digit characters (`0..9`) in the `<quoted_dec>` must be at least 2,
such that the `.` is positioned after at least 1 and before at least 1.

Examples:

```
    0.0

    1.0

    -4.72

    \+29.95

    `First 101 digits of transcendental number π.`
    \+"3.14159_26535_89793_23846_26433_83279_50288_41971_69399_37510"
        "58209_74944_59230_78164_06286_20899_86280_34825_34211_70679"
```

## Bits

A **Bits** value, represented by `<Bits>`, is characterized by an
arbitrarily-long sequence of *bits* where each bit is represented by an
**Integer** in the range 0..1,
which explicitly does not represent any kind of thing in particular.

Grammar:

```
    <Bits> ::=
        '\\~?' <sp> [['"' <[ 0..1 _ ]>* '"'] % <sp>]
```

This grammar supports writing **Bits** literals in numeric base
2 only, using conventional syntax.  The literal may optionally contain
underscore characters (`_`), which exist just to help with visual
formatting.  A `<Bits>` may optionally be split into 1..N segments
where each pair of consecutive segments is separated by dividing space.

Examples:

```
    \~?""

    \~?"00101110100010"
```

## Blob

A **Blob** value, represented by `<Blob>`, is characterized by an
arbitrarily-long sequence of *octets* where each octet is represented by an
**Integer** in the range 0..255,
which explicitly does not represent any kind of thing in particular.

Grammar:

```
    <Blob> ::=
        '\\~+' <sp> [['"' <[ 0..9 A..F _ a..f ]>* '"'] % <sp>]
```

This grammar supports writing **Blob** literals in numeric base
16 only, using conventional syntax.  The literal may optionally contain
underscore characters (`_`), which exist just to help with visual
formatting.  A `<Blob>` may optionally be split into 1..N segments
where each pair of consecutive segments is separated by dividing space.

This grammar is subject to the additional rule that the total count of
hexit characters (`0..9 A..F _ a..f`) in the `<Blob>` excluding `_` must be
a multiple of 2.

Examples:

```
    \~+""

    \~+"A705E416"
```

## Text / Attribute Name

A **Text** value, represented by `<Text>`, is characterized by an
arbitrarily-long sequence of **Unicode** 10.0 standard *character
codepoints*, where each distinct codepoint corresponds to a distinct
integer in the set **{0..0xD7FF,0xE000..0x10FFFF}**,
which explicitly does not represent any kind of thing in particular.

See also [https://unicode.org](https://unicode.org).

A **Text** value has 2 fundamental uses, one being for generic user data,
and the other being the canonical form of a standalone *attribute name*
(see the **Tuple** type) which is an unqualified program identifier.

Note that some programming languages or execution environments support a
"Unicode character string" concept that is less strict than the **Unicode**
standard, and thus allow malformed character strings.  For example, some
may allow isolated/non-paired UTF-16 "surrogate" codepoints corresponding
to integers in the set **{0xD800..0xDFFF}**.  MUON forbids the use of any
such "character strings" using the `<Text>` syntax.  However, such data can
still be conveyed using other means such as MUON's `<Array>+<Integer>`.

Grammar:

```
    <Text> ::=
        <quoted_text> | <codepoint_text>

    <quoted_text> ::=
        ['\\~' <sp>]? <quoted_text_no_pfx>

    <quoted_text_no_pfx> ::=
        [['"' <text_content> '"'] % <sp>]

    <text_content> ::=
        <text_nonescaped_content> | <text_escaped_content>

    <text_nonescaped_content> ::=
        [<restricted_inside_char-[\\]> <restricted_inside_char>*]?

    <text_escaped_content> ::=
        '\\' [<restricted_inside_char-[\\]> | <escaped_char>]*

    <restricted_inside_char> ::=
        <-[ \x<0>..\x<1F> "` \x<80>..\x<9F> ]>*

    <escaped_char> ::=
          '\\q' | '\\g'
        | '\\b'
        | '\\t' | '\\n' | '\\r'
        | ['\\c<' <codepoint> '>']

    <codepoint_text> ::=
        '\\~' <sp> <codepoint>

    <codepoint> ::=
        <nonsigned_int> | <nonsigned_int_with_radix>
```

A `<Text>` may optionally be split into 1..N segments where each pair
of consecutive segments is separated by dividing space.

This grammar is subject to the additional rule that the non-negative integer
denoted by `<codepoint>` must be in the set {0..0xD7FF,0xE000..0x10FFFF}.

The meanings of the simple character escape sequences are:

```
    Esc | Unicode   | Unicode         | Chr | Literal character used
    Seq | Codepoint | Character Name  | Lit | for when not escaped
    ----+-----------+-----------------+-----+------------------------------
    \q  | 0x22   34 | QUOTATION MARK  | "   | delimit Text/opaque literals
    \g  | 0x60   96 | GRAVE ACCENT    | `   | delimit dividing space comments
    \b  | 0x5C   93 | REVERSE SOLIDUS | \   | no special meaning in non-escaped
    \t  | 0x9     9 | CHAR... TAB...  |     | control char horizontal tab
    \n  | 0xA    10 | LINE FEED (LF)  |     | ctrl char line feed / newline
    \r  | 0xD    13 | CARR. RET. (CR) |     | control char carriage return
```

There is just one complex escape sequence, of the format `\c<...>`, that
supports specifying characters in terms of their Unicode codepoint number.
One reason for this feature is to empower more elegant passing of
Unicode-savvy MUON through a communications channel that is more limited,
such as to 7-bit ASCII.

A `<codepoint_text>` is a specialized shorthand for a **Text** of
exactly 1 character whose codepoint number it denotes.

Given that **Text** values or syntax serve double duty for not only regular
user data but also for attribute names of tuples or other kinds of
identifiers, the `<codepoint_text>` variant provides a nicer alternative
for specifying them in latter contexts; it is
purposefully like a regular integer for use in situations where we have
conceptually ordered (rather than conceptually named) attributes.

Examples:

```
    ""

    "Ceres"

    "サンプル"

    "\This isn't not escaped.\n"

    "\\c<0x263A>\c<65>"

    \~"Green"

    `One non-ordered quoted Text (or, one named attribute).`
    "sales"

    `One attribute name with a space in it.`
    "First Name"

    `One ordered nonquoted Text (or, one ordered attribute).`
    \~0

    `Same Text value (or, one ordered attr written in format of a named).`
    "\\c<0>"

    `From a graduate student (in finals week), the following haiku:`
    "\study, write, study,\n"
        "\do review (each word) if time.\n"
        "\close book. sleep? what's that?\n"
```

## Array

An **Array** value, represented by `<Array>`, is a general purpose
arbitrarily-long ordered sequence of any other, *member* values, which
explicitly does not represent any kind of thing in particular, and is
simply the sum of its members.  An **Array** value is dense; iff it has any
members, then its first-ordered member is at ordinal position **0**, and
its last-ordinal-positioned member is at the ordinal position that is one
less than the count of its members.  An **Array** in the general case may
have multiple members that are the same value, and any duplicates may or
may not exist at consecutive ordinal positions.

Grammar:

```
    <Array> ::=
        ['\\~' <sp>]? <ord_member_commalist>

    <ord_member_commalist> ::=
        '[' <sp> <member_commalist> <sp> ']'
```

Examples:

```
    `Zero members.`
    []

    `One member.`
    [ "You got it!" ]

    `Three members.`
    [
        "Alphonse",
        "Edward",
        "Winry",
    ]

    `Five members (1 duplicate).`
    \~[
        57,
        45,
        63,
        61,
        63,
    ]
```

## Set

A **Set** value, represented by `<Set>`, is a general purpose
arbitrarily-large unordered collection of any other, *member* values, which
explicitly does not represent any kind of thing in particular, and is
simply the sum of its members.  A **Set** ensures that no 2 of its members
are the same value.

Grammar:

```
    <Set> ::=
        ['\\?' <sp>]? <nonord_member_commalist>
```

A `<Set>` is subject to the additional rule that, either its
`<member_commalist>` must not have any `<multiplied_member>` elements, or
the `<Set>` must have the `\?` prefix, so that the `<Set>` can be
distinguished from every possible `<Bag>`.

Examples:

```
    `Zero members.`
    {}

    `One member.`
    { "I know this one!" }

    `Four members (no duplicates).`
    {
        "Canada",
        "Spain",
        "Jordan",
        "Jordan",
        "Thailand",
    }

    `Three members.`
    \?{
        3,
        16,
        85,
    }
```

## Bag / Multiset

A **Bag** value, represented by `<Bag>`, is a general purpose
arbitrarily-large unordered collection of any other, *member* values, which
explicitly does not represent any kind of thing in particular, and is
simply the sum of its members.  A **Bag** in the general case may have
multiple members that are the same value.

Grammar:

```
    <Bag> ::=
        ['\\+' <sp>]? <nonord_member_commalist>

    <nonord_member_commalist> ::=
        '{' <sp> <member_commalist> <sp> '}'

    <member_commalist> ::=
        [<single_member> | <multiplied_member> | ''] % [<sp> ',' <sp>]

    <single_member> ::=
        <member>

    <multiplied_member> ::=
        <member> <sp> ':' <sp> <multiplicity>

    <member> ::=
        <Any>

    <multiplicity> ::=
        <nonsigned_int> | <nonsigned_int_with_radix>
```

A `<Bag>` is subject to the additional rule that, either its
`<member_commalist>`  must have at least 1 `<multiplied_member>` element,
or the `<Bag>` must have the `\+` prefix, so that the `<Bag>` can be
distinguished from every possible `<Set>`.  An idiomatic way to represent
an empty **Bag** is to have exactly 1 `<multiplied_member>` whose
`<multiplicity>` is zero.

Examples:

```
    `Zero members.`
    {0:0}

    `One member.`
    { "I hear that!": 1 }

    `1200 members (1197 duplicates).`
    {
        "Apple"  : 500,
        "Orange" : 300,
        "Banana" : 400,
    }

    `Six members (2 duplicates).`
    \+{
        "Foo",
        "Quux",
        "Foo",
        "Bar",
        "Baz",
        "Baz",
    }
```

## Interval

An **Interval** value, represented by `<Interval>`, is a general purpose
arbitrarily-large unordered collection of any other, *member* values, which
explicitly does not represent any kind of thing in particular, and is
simply the sum of its members; the count of members may be either finite or
infinite depending on the external data model or type system in question.

In stark contrast to a **Set** value, whose set of members is characterized
by an enumeration of every member value, an **Interval** value's set of
members is instead characterized by exactly 2 *endpoint* values (or exactly
1 or exactly zero) of some *orderable* type such that every value in the
type system with a defined total order between those 2 endpoints is
considered to be a member value of the **Interval**.  Depending on the
external data model or type system in question, an **Interval** value may
(and typically does) consist of an infinite set of members, in contrast
with a **Set** which can only have a finite set of members.

An *empty interval* has exactly zero members.  A *unit interval* has
exactly 1 member.  A *closed interval* includes both endpoint values in its
membership; an *open interval* excludes both endpoint values; a
*half-closed, half-open interval* includes one and excludes the other.
A *half-unbounded, half-bounded interval* includes all values that are
ordered either before or after the single endpoint; a *universal interval*
or *unbounded interval* includes every value in the type system.

In the general case, for MUON-defined types, only a *bounded interval* over
2 distinct **Integer** (or **Boolean**) endpoints has a finite member
count; whereas, a *bounded interval* over 2 distinct endpoints over any
other type (such as **Fraction** or **Text**) has an infinite member count,
because given any 2 distinct values of most types you can find another
distinct value that is ordered between them.  Also, a non-bounded interval
over **Integer** has an infinite member count in MUON.  An external data
model can only change this by defining its corresponding member data types
to have a finite membership themselves, in contrast to mathematics.

Note that it is up to the external data model to define any total orders
for any member value types, either which one is used implicitly when the
**Interval** has no explicit context to specify one, or how to interpret
that explicit context.  For a common example, there exist a wide variety of
character string collations in common use, and it would require context or
the external data model to declare which to use for **Text** members.
MUON itself simply characterizes an **Interval** *as* its endpoints.

Grammar:

```
    <Interval> ::=
        '\\..' <sp> '{' <sp> <interval_members> <sp> '}'

    <interval_members> ::=
        <interval_empty> | <interval_single> | <interval_range>

    <interval_empty> ::=
        ''

    <interval_single> ::=
        <Any>

    <interval_range> ::=
        <interval_low>? <interval_boundary_kind> <interval_high>?

    <interval_low> ::=
        <Any>

    <interval_high> ::=
        <Any>

    <interval_boundary_kind> ::=
        '..' | '-..' | '..-' | '-..-'
```

Examples:

```
    `Empty interval (zero members).`
    \..{}

    `Unit interval (one member).`
    \..{"abc"}

    `Closed interval (probably 10 members, depending on the model used).`
    \..{1..10}

    `Left-closed, right-open interval; every Decimal x in {2.7<=x<9.3}.`
    \..{2.7..-9.3}

    `Left-open, right-closed interval; every Text x ordered in {"a"<x<="z"}.`
    \..{"a"-.."z"}

    `Open interval; time period between Dec 6 and 20 excluding both.`
    \..{(\UTCInstant:(2002,12,6)) -..- (\UTCInstant:(2002,12,20))}

    `Left-unbounded, right-closed interval; every Integer <= 3.`
    \..{..3}

    `Left-closed, right-unbounded interval; every Integer >= 29.`
    \..{29..}

    `Universal interval; unbounded; every value of type system is a member.`
    \..{..}
```

## Interval Set

An **Interval Set** value, represented by `<Interval_Set>`, is
characterized by a **Set** value such that every member value of the
**Set** is an **Interval**.  An **Interval Set** is alternately
characterized by a single **Interval** that is allowed to have
discontinuities, and is in the typical case characterized by more than 2
*endpoint* values.

When reasoning about an interval in terms of defining a set of values by
endpoints under a total order rather than by enumeration, an **Interval
Set** is the actual best direct analogy to a **Set** because every possible
distinct **Set** value can map to a distinct **Interval Set** value but
only a proper subset of the former can map to an **Interval**.  The
**Interval Set** type is closed under *set union* operations just as
**Set** is, while **Interval** is not.

Unlike with the **Set** type, the **Interval Set** type also has a
meaningful *set absolute complement* operation applicable to it.

Grammar:

```
    <Interval_Set> ::=
        '\\?..' <sp> <nonord_interval_commalist>
```

Examples:

```
    `Empty interval-set (zero members).`
    \?..{}

    `Unit interval-set (one member).`
    \?..{"abc"}

    `Probably 10 members, depending on the model used.`
    \?..{1..10}

    `Probably 6 members.`
    \?..{1..3,6,8..9}

    `Every Integer x except for {4..13,22..28}`
    \?..{..3,14..21,29..}

    `Set of all valid Unicode codepoints.`
    \?..{0..0xD7FF,0xE000..0x10FFFF}

    `Probably 15 members (no duplicates), depending on the model used.`
    \?..{1..10,6..15}

    `Probably same thing, regardless of data model used.`
    \?..{1..-6,6..10:2,10-..15}
```

## Interval Bag

An **Interval Bag** value, represented by `<Interval_Bag>`, is
characterized by a generalization of an **Interval Set** that permits
multiple members to have the same value; an **Interval Bag** is isomorphic
to a **Bag** in the same way that an **Interval Set** is to a **Set**;
every possible distinct **Bag** can map to a distinct **Interval Bag**.

Grammar:

```
    <Interval_Bag> ::=
        '\\+..' <sp> <nonord_interval_commalist>

    <nonord_interval_commalist> ::=
        '{' <sp> <interval_commalist> <sp> '}'

    <interval_commalist> ::=
        [<single_interval> | <multiplied_interval> | ''] % [<sp> ',' <sp>]

    <single_interval> ::=
        <interval_members>

    <multiplied_interval> ::=
        <interval_members> <sp> ':' <sp> <multiplicity>
```

Examples:

```
    `Empty interval-bag (zero members).`
    \+..{}

    `Unit interval-bag (one member).`
    \+..{"abc"}

    `Five members (4 duplicates).`
    \+..{"def":5}

    `Probably 20 members (5 duplicates), depending on the model used.`
    \+..{1..10,6..15}

    `Probably same thing, regardless of data model used.`
    \+..{1..-6,6..10:2,10-..15}
```

## Tuple / Attribute Set

A **Tuple** value, represented by `<Tuple>`, is a general purpose
arbitrarily-large unordered heterogeneous collection of named *attributes*,
such that no 2 attributes have the same *attribute name*, which explicitly
does not represent any kind of thing in particular, and is simply the sum
of its attributes.  An attribute is conceptually a name-asset pair, the
name being used to look up the attribute in a **Tuple**.  An *attribute
name* is an unqualified program identifier and is conceptually a character
string that is not a **Text** value.  In the general case each attribute of
a tuple is of a distinct data type, though multiple attributes often have
the same type.  The set of attribute names of a **Tuple** is called its
*heading*, and the corresponding attribute assets are called its *body*.

With respect to the relational model of data, a *heading* represents a
predicate, for which each *attribute name* is a free variable, and a
**Tuple** as a whole represents a derived proposition, where the
corresponding attribute asset values substitute for the free variables;
however, any actual predicate/etc is defined by the context of a
**Tuple** value and a **Tuple** in isolation explicitly does not
represent any proposition in particular.

The canonical way to represent the concept of a *tuple* that has ordered
attributes is to use integral names; to be specific, the attribute name
consisting of just the character codepoint 0 would mark the first ordered
attribute, the name consisting of just the codepoint 1 would mark the
second, and so on; this can be repeated up to 32 "positional" names whose
names would correspond to non-printing Unicode codepoints and would
alphabetically sort correctly and prior to any normal text-like attribute
names like **name** or **age**; said first 32 would likewise be distinct in
appearance from all regular printable numbers used as attribute names.

Grammar:

```
    <Tuple> ::=
        ['\\%' <sp>]? '(' <sp> <attr_commalist> <sp> ')'

    <attr_commalist> ::=
        [<anon_attr> | <named_attr> | <nested_named_attr> | ''] % [<sp> ',' <sp>]

    <anon_attr> ::=
        <attr_asset>

    <named_attr> ::=
        <attr_name> <sp> ':' <sp> <attr_asset>

    <nested_named_attr> ::=
        <nesting_attr_names> <sp> ':' <sp> <attr_asset>

    <attr_asset> ::=
        <Any>
```

A `<Tuple>` is subject to the additional rule that, iff its
`<attr_commalist>` has exactly 1 `<*_attr>` element, either that element
must have a leading or trailing comma, or the `<Tuple>` must have the `\%`
prefix, so that the `<Tuple>` can be distinguished from every possible
`<Capsule>` (and from a superset grammar's generic grouping parenthesis).

Examples:

```
    `Zero attributes.`
    ()

    `One named attribute.`
    ("First Name": "Joy",)

    `One ordered attribute.`
    (53,)

    `Same thing.`
    (0: 53,)

    `Same thing.`
    ("\\c<0>": 53,)

    `Three named attributes.`
    (
        login_name : "hartmark",
        login_pass : "letmein",
        is_special : True,
    )

    `Three ordered attributes.`
    ("hello",26,True)

    `One of each.`
    ("Jay", age: 10)

    `A non-Latin name.`
    ("サンプル": "http://example.com",)

    `Two named attributes.`
    \%(
        name : "Michelle",
        age  : 17,
    )

    `Four leaf attributes in nested multi-level namespace.`
    (
        name: "John Glenn",
        birth_date::year: 1921,
        comment: "Fly!",
        birth_date::month: 7,
        birth_date::day: 18,
    )

    `Same thing.`
    (
        name: "John Glenn",
        birth_date: (
            year: 1921,
            month: 7,
            day: 18,
        ),
        comment: "Fly!",
    )
```

## Tuple Array

A **Tuple Array** value, represented by `<Tuple_Array>`, is characterized
by the pairing of a **Heading** value with an **Array** value, which define
its *heading* and *body*, respectively.  A **Tuple Array** is isomorphic to
a **Relation** with the sole exception of being based on an **Array**
rather than a **Set**.

Grammar:

```
    <Tuple_Array> ::=
        '\\~%' <sp> [<delim_attr_name_commalist> | <ord_member_commalist>]
```

A `<Tuple_Array>` with an `<ord_member_commalist>` is subject to the
additional rule that its `<member_commalist>` has at least 1 `*_member`
element, and that every such `*_member` element's `<member>` is a
`<Tuple>`; otherwise the `<Tuple_Array>` must have a
`<delim_attr_name_commalist>`.

Examples:

```
    `Zero attributes + zero tuples.`
    \~%()

    `Zero attributes + one tuple.`
    \~%[()]

    `Three named attributes + zero tuples.`
    \~%(x,y,z)

    `Three positional attributes + zero tuples.`
    \~%(0..2)

    `Two named attributes + three tuples (1 duplicate).`
    \~%[
        (name: "Amy"     , age: 14),
        (name: "Michelle", age: 17),
        (name: "Amy"     , age: 14),
    ]

    `Two positional attributes + two tuples.`
    \~%[
        ("Michelle", 17),
        ("Amy"     , 14),
    ]
```

## Relation / Tuple Set

A **Relation** value, represented by `<Relation>`, is characterized
by the pairing of a **Heading** value with a **Set** value, which define
its *heading* and *body*, respectively.  A **Relation** ensures that every
*member* of its *body* is a **Tuple** having the same *heading* (set of
*attribute names*) as its own *heading*.  A **Relation** is alternately
characterized by the pairing of a single set of attribute names with a set
of corresponding attribute assets for each attribute name.

With respect to the relational model of data, a *heading* represents a
predicate, for which each *attribute name* is a free variable, and a
**Relation** as a whole represents a set of derived propositions, where the
corresponding attribute asset values substitute for the free variables;
however, any actual predicate/etc is defined by the context of a
**Relation** value and a **Relation** in isolation explicitly does not
represent any proposition in particular.

Grammar:

```
    <Relation> ::=
        '\\?%' <sp> [<delim_attr_name_commalist> | <nonord_member_commalist>]
```

A `<Relation>` with a `<nonord_member_commalist>` is subject to the
additional rule that its `<member_commalist>` has at least 1 `*_member`
element, and that every such `*_member` element's `<member>` is a
`<Tuple>`; otherwise the `<Relation>` must have a
`<delim_attr_name_commalist>`.

Examples:

```
    `Zero attributes + zero tuples.`
    \?%()

    `Zero attributes + one tuple.`
    \?%{()}

    `Three named attributes + zero tuples.`
    \?%(x,y,z)

    `Three positional attributes + zero tuples.`
    \?%(0..2)

    `Two named attributes + two tuples.`
    \?%{
        (name: "Michelle", age: 17),
        (name: "Amy"     , age: 14),
    }

    `Two positional attributes + two tuples.`
    \?%{
        ("Michelle", 17),
        ("Amy"     , 14),
    }
```

## Tuple Bag

A **Tuple Bag** value, represented by `<Tuple_Bag>`, is characterized
by the pairing of a **Heading** value with a **Bag** value, which define
its *heading* and *body*, respectively.  A **Tuple Bag** is isomorphic to
a **Relation** with the sole exception of being based on a **Bag**
rather than a **Set**.

Grammar:

```
    <Tuple_Bag> ::=
        '\\+%' <sp> [<delim_attr_name_commalist> | <nonord_member_commalist>]
```

A `<Tuple_Bag>` with a `<nonord_member_commalist>` is subject to the
additional rule that its `<member_commalist>` has at least 1 `*_member`
element, and that every such `*_member` element's `<member>` is a
`<Tuple>`; otherwise the `<Tuple_Bag>` must have a
`<delim_attr_name_commalist>`.

Examples:

```
    `Zero attributes + zero tuples.`
    \+%()

    `Zero attributes + one tuple.`
    \+%{()}

    `Three named attributes + zero tuples.`
    \+%(x,y,z)

    `Three positional attributes + zero tuples.`
    \+%(0..2)

    `Two named attributes + six tuples (4 duplicates).`
    \+%{
        (name: "Michelle", age: 17),
        (name: "Amy"     , age: 14) : 5,
    }

    `Two positional attributes + two tuples.`
    \+%{
        ("Michelle", 17),
        ("Amy"     , 14),
    }
```

## Unit

A **Unit** value, represented by `<Unit>`, is a symbol intended to be used
as a *unit of measurement*, which explicitly is agnostic to any externally
defined standards and should be able to represent units from any of them.

*TODO: Reconsider whether Unit should be its own distinct MUON type apart
from Measure versus just having its definition folded into the latter.*

A **Unit** value is characterized by a set of 0..N *unit factors* such that
each *unit factor* is a *unit label* / *unit exponent* pair.  A *unit
label* can be of any type but is idiomatically either a **Nesting** value
or a **Text** value or a singleton **Capsule** value; it represents a basic
named component unit such as `Meter` or `Second` or `Gram`; MUON generally
does not define any of these basic names itself, leaving that to external
data models.  A *unit exponent* is any **Integer** value, typically
positive one.  A **Unit** ensures that no 2 of its *unit factor* have the
same *unit label*.

MUON does not otherwise normalize **Unit** values in any way, leaving that
to external data models.

A **Unit** value is characterized by a mathematical expression consisting
of 0..N factors that are multiplied together where each factor is an
exponentiated named constant.  If there are exactly zero factors then the
expression has the value positive one, the identity value for multiplication.

The **Unit** type is numeric and is closed under multiplication and
division and reciprocal and integer exponentiation, but is not closed under
addition or subtraction (but the **Measure** type supports those too).

The sole **Unit** value with exactly zero *unit factor* is the *identity
unit*; using this as the unit of a measurement is explicitly saying that
all you have is a plain number, and not a number *of* anything.  The
*identity unit* is the identity value for the **Unit** type; multiplying
any **Unit** X with this yields X.

*TODO: Consider if a singleton Capsule is actually the best idiomatic type
for a unit label.*

Grammar:

```
    <Unit> ::=
        <generic_unit> | <simple_unit>

    <generic_unit> ::=
        '\\$$' <sp> '{' <sp> <unit_factor_list> <sp> '}'

    <unit_factor_list> ::=
        [<simple_unit_factor> | <expon_unit_factor>] % [<sp> '*' <sp>]

    <simple_unit_factor> ::=
        <label>

    <expon_unit_factor> ::=
        <label> <sp> '^' <sp> <exponent>

    <exponent> ::=
        <Integer>

    <simple_unit> ::=
        '\\$$' <sp> <nesting_attr_names>
```

A `<simple_unit>` is shorthand for a `<generic_unit>` such that it
represents a **Unit** consisting of exactly 1 *unit factor* where its *unit
exponent* is positive one and its *unit label* is the **Nesting** that
directly corresponds to the `<nesting_attr_names>`.

Examples:

```
    `The identity unit.`
    \$${}

    `Acceleration.`
    \$${\Meter * \Second ^ -2}

    `Mass.`
    \$$Gram

    `Same thing.`
    \$${\Gram}
```

## Measure

A **Measure** value, represented by `<Measure>`, is a measurement of some
quantity or position or other thing that one measures, in terms of numbers
paired with units, which explicitly is agnostic to any externally defined
standards and should be able to represent units from any of them.

MUON provides the **Measure** type as a powerful expressive generic
foundation for for external data models layered over top of MUON to use
with their own concepts of measures and quantities and units.  Examples of
such measurements include temporal (instant and duration to arbitrary
precision or on any calendar), spatial or geospatial (locations or shapes
or volumes), physical phenomina (mass, velocity, acceleration, power), and
currency (US Dollar or Euro etc).  Using this foundation, one can do a lot
of common operations such as adding or multiplying or differencing
measurements using generic code that doesn't know anything specific to any
units and get accurate answers, albeit sometimes in a non-standard format;
one typically would use a unit-savvy normalization step such as to get nice
calendar dates out but that's the domain of the higher level data model.

A **Measure** value is characterized by a set of 0..N *measure terms* such
that each *measure term* is a *measure coefficient* / *measure unit* pair.
A *measure coefficient* is intended to be of any type that is considered a
normal number, such as **Integer** or **Fraction** or **Decimal**, but MUON
permits a value of any type, leaving the data model in use to judge what is
actually a number.  A *measure unit* is any **Unit** value.  A **Measure**
ensures that no 2 of its *measure term* have the same *measure unit*.

A **Measure** value is characterized by a mathematical expression
consisting of 0..N terms that are added together where each term is a
number multiplied by a **Unit**.  If there are exactly zero terms then the
expression has the value zero, the identity value for addition.

The **Measure** type as a whole is numeric and is closed under every
mathematical operator that the set of rational numbers is closed under;
this is conceptually guaranteed to be true if every *measure coefficient*
is a **Fraction** value; for **Integer** it is conceptually not closed
under division and similar operators, but only with respect to the
coefficients, though that can be worked around if rounding division is
employed; all of these details depend on the data model in use.

The sole **Measure** value with exactly zero *measure term* is the
*identity measure*; using this is explicitly saying that you have a zero,
whatever that means to the context in question, such as a zero quantity or
a home position; or, devoid of an external context, it might be more like
explicitly saying you didn't take a measurement in the first place, though
in such circumstances you should be using an **Excuse** instead of a
**Measure**.  The *identity measure* is the identity value for the
**Measure** type; adding any **Measure** X to this yields X.

Grammar:

```
    <Measure> ::=
        <generic_measure> | <simple_measure>

    <generic_measure> ::=
        '\\$' <sp> '{' <sp> <measure_term_list> <sp> '}'

    <measure_term_list> ::=
        [<coefficient> | <unit> | <measure_term_pair>] % [<sp> '+' <sp>]

    <measure_term_pair> ::=
        <coefficient> <sp> '*' <sp> <unit>

    <coefficient> ::=
        <Any>

    <unit> ::=
        <unit_factor_list>

    <simple_measure> ::=
        '\\$' <sp> <nesting_attr_names>
```

A `<simple_measure>` is shorthand for a `<generic_measure>` such that it
represents a **Measure** consisting of exactly 1 *measure term* where its
*measure coefficient* is positive one and its *measure unit* is the
*simple unit* that directly corresponds to the `<nesting_attr_names>`.

Examples:

```
    `The identity measure.`
    \${}

    `Acceleration under Earth's gravity.`
    \${9.8 * \Meter * \Second ^ -2}

    `One gram of mass.`
    \$Gram

    `Same thing.`
    \${\Gram}

    `The Day The Music Died.`
    \${\Gregorian + 1959 * \Year + 2 * \Month + 3 * \Day}

    `The cost of a surgery.`
    \${29.95 * \USD}

    `Somewhere out there.`
    \${-94.746094 * \Longitude + 37.483577 * \Latitude}
```

## Capsule / Labelled Tuple

A **Capsule** value, represented by `<Capsule>`, is characterized by the
pairing of a *label* with a set of 0..N *attributes* where that set is a
**Tuple** value; the label can be of any type but is idiomatically a
**Nesting** value.

The **Capsule** type is the idiomatic way for an external data model to
represent "new" types of a nominal type system in a consistent way.  The
*label* represents a fully-qualified external data type name, and thus a
namespace within all the **Capsule** values, while the *attributes* define
all the components of a value of that external type.  Thus a **Capsule**
corresponds to a generic *object* of an object-oriented language, the
*label* is the *class* of that *object*, and *attributes* are *properties*.

As a primary exception to the above, the large number of *exception* or
*error* types common in some data models / type systems should *not* be
represented using a **Capsule** but rather with the structurally identical
**Excuse** which natively carries that extra semantic.

The idiomatic way to represent a singleton type value is as a **Capsule**
where the *label* is the singleton type name and the *attributes* is the
**Tuple** with zero attributes.

The idiomatic default attribute name for a single-attribute **Capsule** is
`0` (the first conceptually ordered attribute name) when there isn't an
actual meaningful name to give it.

Grammar:

```
    <Capsule> ::=
        <generic_capsule> | <singleton_capsule>

    <generic_capsule> ::=
        ['\\*' <sp>]? <label_attrs_pair>

    <label_attrs_pair> ::=
        '(' <sp> <label> <sp> ':' <sp> <attrs> <sp> ')'

    <label> ::=
        <Any>

    <attrs> ::=
        <Tuple>

    <singleton_capsule> ::=
        '\\*' <sp> <nesting_attr_names>
```

Examples:

```
    (\Point : (x : 5, y : 3))

    (\Float : (
        significand : 45207196,
        radix       : 10,
        exponent    : 37,
    ))

    \*(\the_db::UTCDateTime : (
        year   : 2003,
        month  : 10,
        day    : 26,
        hour   : 1,
        minute : 30,
        second : 0.0,
    ))

    \*Positive_Infinity
```

## Excuse

An **Excuse** value, represented by `<Excuse>`, is an explicitly stated
reason for why, given some particular problem domain, a value is not being
used that is ordinary for that domain.  Alternately, an **Excuse** is
characterized by a **Capsule** that has the added semantic of representing
some kind of error condition, in contrast to an actual **Capsule** which
explicitly does *not* represent an error condition in the general case.

For example, the typical integer division operation is not defined to give
an integer result when the divisor is zero, and so a function for integer
division could be defined to result in an **Excuse** value rather than
throw an exception in that case.  For another example, an **Excuse** value
could be used to declare that the information we are storing about a person
is missing certain details and why those are missing, such as because the
person left the birthdate field blank on their application form.

An **Excuse** is isomorphic to an *exception* but that use of the former is
not meant to terminate execution of code early unlike the latter which is.

The **Excuse** type is the idiomatic way for an external data model to
represent "new" *error* or *exception* types of a nominal type system in a
consistent way.  The counterpart **Capsule** type should *not* be used for
these things, but rather just every other kind of externally-defined type.

Grammar:

```
    <Excuse> ::=
        '\\!' <sp> [<label_attrs_pair> | <nesting_attr_names>]
```

Examples:

```
    \!(\Input_Field_Wrong : (name : "Your Age"))

    \!Div_By_Zero

    \!No_Such_Attr_Name
```

## Ignorance

The singleton **Ignorance** value, represented by `<Ignorance>`, is
characterized by an **Excuse** which simply says that an ordinary value for
any given domain is missing and that there is simply no excuse that has
been given for this; in other words, something has gone wrong without the
slightest hint of an explanation.

This is conceptually the most generic excuse value there is and it can
be used by lazy programmers as a fallback for when they don't have even a
semblance of a better explanation for why an ordinary value is missing.

The **Ignorance** value has its own special syntax in MUON disjoint from
any **Excuse** syntax so that this MUON-defined excuse doesn't step on any
possible name that a particular external data model might use.

When an external data model natively has exactly one generic *null* or
*nil* or *undefined* or *unknown* or similar value or quasi-value,
**Ignorance** is the official way to represent an instance of it in MUON.

When an external data model natively has a concept of 3-valued logic (MUON
itself does not), specifically a concept like such where the multiplicity
of scenarios that may produce a special no-regular-value-is-here marker do
in fact all produce the exact same marker, **Ignorance** is the official
way to represent that marker.  This includes the *null* of any common
dialect of SQL.  Whereas, for external data models that distinguish the
reasons for why a regular value may be missing, **Ignorance** should NOT be
used and instead other more applicable **Excuse** values should instead.

Grammar:

```
    <Ignorance> ::=
        '\\!!' <sp> Ignorance
```

Examples:

```
    \!!Ignorance
```

## Nesting / Attribute Name List

A **Nesting** value, represented by `<Nesting>`, is an arbitrarily-large
nonempty ordered collection of attribute names, intended for referencing an
entity in a multi-level namespace, such as nested **Tuple** may implement.

Grammar:

```
    <Nesting> ::=
        '\\' <sp> <nesting_attr_names>

    <nesting_attr_names> ::=
        <attr_name> % [<sp> '::' <sp>]

    <attr_name> ::=
        <nonord_attr_name> | <ord_attr_name>

    <nonord_attr_name> ::=
        <nonord_nonquoted_attr_name> | <quoted_text_no_pfx>

    <nonord_nonquoted_attr_name> ::=
        <[ A..Z _ a..z ]> <[ 0..9 A..Z _ a..z ]>*

    <ord_attr_name> ::=
        <codepoint>
```

The meaning of `<nonord_nonquoted_attr_name>` is exactly the same as if the
same characters surrounded by quotation marks.

Examples:

```
    \person

    \person::birth_date

    \person::birth_date::year

    \the_db::stats::"samples by order"
```

## Heading / Attribute Name Set

A **Heading** value, represented by `<Heading>`, is an arbitrarily-large
unordered collection of *attribute names*, such that no 2 attribute names
are the same.

Grammar:

```
    <Heading> ::=
        '\\@' <sp> <delim_attr_name_commalist>

    <delim_attr_name_commalist> ::=
        '(' <sp> <attr_name_commalist> <sp> ')'

    <attr_name_commalist> ::=
        [<attr_name> | <ord_attr_name_range> | ''] % [<sp> ',' <sp>]

    <ord_attr_name_range> ::=
        <min_ord_attr> <sp> '..' <sp> <max_ord_attr>

    <min_ord_attr> ::=
        <ord_attr_name>

    <max_ord_attr> ::=
        <ord_attr_name>
```

An `<ord_attr_name_range>` is subject to the additional rule that its
integral `<min_ord_attr>` value must be less than or equal to its integral
`<max_ord_attr>` value.

Examples:

```
    `Zero attributes.`
    \@()

    `One named attribute.`
    \@(sales)

    `Same thing.`
    \@("sales")

    `One ordered attribute.`
    \@(0)

    `Same thing.`
    \@("\\c<0>")

    `Three named attributes.`
    \@(region,revenue,qty)

    `Three ordered attributes.`
    \@(0..2)

    `One of each.`
    \@(1,age)

    `Some attribute names can only appear quoted.`
    \@("Street Address")

    `A non-Latin name.`
    \@("サンプル")
```

## Attribute Renaming Specification

A **Renaming** value, represented by `<Renaming>`, is an arbitrarily-large
unordered collection of attribute renaming specifications.

Grammar:

```
    <Renaming> ::=
        '\\@:' <sp> <delim_renaming_commalist>

    <delim_renaming_commalist> ::=
        '(' <sp> <renaming_commalist> <sp> ')'

    <renaming_commalist> ::=
        [<anon_attr_rename> | <named_attr_rename> | ''] % [<sp> ',' <sp>]

    <anon_attr_rename> ::=
          ['->' <sp> <attr_name_after>]
        | [<attr_name_after> <sp> '<-']
        | [<attr_name_before> <sp> '->']
        | ['<-' <sp> <attr_name_before>]

    <named_attr_rename> ::=
          [<attr_name_before> <sp> '->' <sp> <attr_name_after>]
        | [<attr_name_after> <sp> '<-' <sp> <attr_name_before>]

    <attr_name_before> ::=
        <attr_name>

    <attr_name_after> ::=
        <attr_name>
```

Each attribute renaming specification is a pair of attribute names marked
with a `->` or a `<-` element; the associated `<attr_name_before>` and
`<attr_name_after>` indicate the name that an attribute has *before* and
*after* the renaming operation, respectively.  Iff the renaming
specification is an `<anon_attr_rename>` then either the *before* or
*after* name is an ordered attribute name corresponding to the ordinal
position of the renaming specification element in the
`<renaming_commalist>`, starting at zero.

A `<renaming_commalist>` is subject to the additional rule that no 2
`<attr_name_before>` may be the same attribute name and that no 2
`<attr_name_after>` may be the same attribute name.

Examples:

```
    `Zero renamings, a no-op.`
    \@:()

    `Also a no-op.`
    \@:(age->age)

    `Rename one attribute.`
    \@:(fname->first_name)

    `Same thing.`
    \@:(first_name<-fname)

    `Swap 2 named attributes.`
    \@:(foo->bar,foo<-bar)

    `Convert ordered names to nonordered.`
    \@:(->foo,->bar)

    `Same thing.`
    \@:(0->foo,1->bar)

    `Convert nonordered names to ordered.`
    \@:(<-foo,<-bar)

    `Same thing.`
    \@:(0<-foo,1<-bar)

    `Swap 2 ordered attributes.`
    \@:(0->1,0<-1)

    `Same thing.`
    \@:(->1,->0)

    `Some attribute names can only appear quoted.`
    \@:("First Name"->"Last Name")
```

# SYNTACTIC MNEMONICS

The syntax of Muldis Object Notation is designed around a variety of
mnemonics that bring it some self-similarity and an association between
syntax and semantics so that it is easier to read and write data and code
in it.  Some of these mnemonics are more about self-similarity and others
are more about shared traits with other languages.

The following table enumerates and explains the syntactic character
mnemonics that Muldis Object Notation itself has specific knowledge of and
ascribes specific meanings to; where multiple characters are shown together
that means they are used in pairs.

```
    Chars | Generic Meaning        | Specific Use Cases
    ------+------------------------+---------------------------------------
    ""    | stringy data and names | * delimit quoted opaque regular literals
          |                        | * delimit all Bits/Blob/Text literals
          |                        | * delimit quoted Integer/Fraction/Decimal literals
          |                        | * delimit quoted code identifiers/names
    ------+------------------------+---------------------------------------
    ``    | stringy comments       | * delimit expendable dividing space comments
    ------+------------------------+---------------------------------------
    \     | special contexts       | * indicates special contexts where
          |                        |   typical meanings may not apply
          |                        | * first char inside a quoted string
          |                        |   to indicate it has escaped characters
          |                        | * prefix for each escaped char in quoted string
          |                        | * L0 of prefix for literals/selectors
          |                        |   to disambiguate that they are lits/sels
    ------+------------------------+---------------------------------------
    []    | ordered collections    | * delimit homogeneous ordered collections
          |                        |   of members, concept ordinal+asset pairs
          |                        | * delimit Array selectors
          |                        | * delimit nonempty-Tuple-Array selectors
    ------+------------------------+---------------------------------------
    {}    | nonordered collections | * delimit homogeneous nonordered collections
          |                        |   of members, concept asset+cardinal pairs
          |                        | * delimit Set/Bag selectors
          |                        | * delimit Interval-Set/Interval-Bag selectors
          |                        | * delimit nonempty-Relation/Tuple-Bag sels
    ------+------------------------+---------------------------------------
    ()    | aordered collections   | * delimit heterogeneous aordered collections
          |                        |   of attributes, concept nominal+asset pairs
          |                        | * delimit Tuple/Capsule/Excuse selectors
          |                        | * delimit Heading literals
          |                        | * delimit empty-Tuple-Array/Relation/Tuple-Bag lits
    ------+------------------------+---------------------------------------
    :     | pairings               | * indicates a pairing context
          |                        | * separates the 2 parts of a pair
          |                        | * optional pair separator in Array/Set/Bag sels
          |                        | * optional pair separator in Tuple/Excuse sels
          |                        | * optional pair separator in ne-TA/Rel/TB sels
          |                        | * label/attributes separator in Capsule sel
          |                        | * disambiguate Bag sel from Set sel
          |                        | * L2 of prefix for Renaming literals
    ------+------------------------+---------------------------------------
    ,     | list builders          | * separates collection elements
          |                        | * separate members in Array/Set/Bag sels
          |                        | * separate members in nonempty-TA/Rel/TB sels
          |                        | * separate attributes in Tuple/Excuse sels
          |                        | * separate attributes in Heading lits
          |                        | * disambiguate unary named Tuple sels from Capsule sels
    ------+------------------------+---------------------------------------
    ?     | qualifications/is?/so  | * indicates a qualifying/yes-or-no context
          |                        | * L1 of optional prefix for Boolean literals
          |                        | * L2 of prefix for Bits literals
          |                        | * L1 of optional prefix for Set selectors
          |                        | * L1 of prefix for Interval-Set selectors
          |                        | * L1 of prefix for Relation lits/sels
    ------+------------------------+---------------------------------------
    +     | quantifications/count  | * indicates a quantifying/count context
          |                        | * L1 of optional prefix for Integer/Fraction/Decimal literals
          |                        | * L2 of prefix for Blob literals
          |                        | * L1 of optional prefix for Bag selectors
          |                        | * L1 of prefix for Interval-Bag selectors
          |                        | * L1 of prefix for Tuple-Bag lits/sels
          | addition               | * separate terms in Measure selectors
    ------+------------------------+---------------------------------------
    ~     | sequences/stitching    | * indicates a sequencing context
          |                        | * L1 of prefix for Bits/Blob literals
          |                        | * L1 of optional prefix for Text literals
          |                        | * L1 of optional prefix for Array selectors
          |                        | * L1 of prefix for Tuple-Array lits/sels
    ------+------------------------+---------------------------------------
    ..    | intervals/ranges       | * L1 of prefix for Interval selectors
          |                        | * L2 of prefix for Interval-Set/Interval-Bag selectors
          |                        | * pair separator in Interval/Ivl-Set/Ivl-Bag selectors
    ------+------------------------+---------------------------------------
    %     | tuples/heterogeneous   | * indicates that tuples are featured
          |                        | * L1 of optional prefix for Tuple selectors
          |                        | * L2 of prefix for Tuple-Array/Relation/Tuple-Bag lits/sels
    ------+------------------------+---------------------------------------
    $     | measures               | * indicates that units or measures are featured
          |                        | * L1 of prefix for Unit/Measure selectors
    ------+------------------------+---------------------------------------
    *     | generics               | * indicates a generic type context
          |                        | * L1 of optional prefix for Capsule selectors
          | multiplication         | * separate factors in Unit/Measure selectors
    ------+------------------------+---------------------------------------
    !     | excuses/but/not        | * indicates that excuses are featured
          |                        | * L1 of prefix for Excuse literals/selectors
    ------+------------------------+---------------------------------------
    @     | locators/at/headings   | * indicates identifiers/names are featured
          |                        | * L1 of prefix for Heading literals
          |                        | * L1 of prefix for Renaming literals
    ------+------------------------+---------------------------------------
    -     | subtraction            | * indicates negative-Integer/Fraction/Decimal literal
          |                        | * indicates open endpoint in Interval selectors
    ------+------------------------+---------------------------------------
    /     | division               | * disambiguate Fraction lit from Integer/Decimal lit
    ------+------------------------+---------------------------------------
    .     | radix point            | * disambiguate Decimal lit from Integer/Fraction lit
    ------+------------------------+---------------------------------------
    ^     | exponentiation         | * label/exponent separator in Unit/Measure selectors
    ------+------------------------+---------------------------------------
    digit | number                 | * first char 0..9 in bareword indicates is a number
    ------+------------------------+---------------------------------------
    alpha | identifier             | * first char a..z/etc in bareword indicates is identifier
    ------+------------------------+---------------------------------------
    0b    | base-2                 | * indicates base-2/binary notation
          |                        | * prefix for Integer in base-2
    ------+------------------------+---------------------------------------
    0o    | base-8                 | * indicates base-8/octal notation
          |                        | * prefix for Integer in base-8
    ------+------------------------+---------------------------------------
    0d    | base-10                | * indicates base-10/decimal notation
          |                        | * optional prefix for Integer in base-10
    ------+------------------------+---------------------------------------
    0x    | base-16                | * indicates base-16/hexadecimal notation
          |                        | * prefix for Integer in base-16
    ------+------------------------+---------------------------------------

    When combining symbols in a \XY prefix (L0+L1+L2) to represent both
    collection type and element type, the X and Y always indicate the
    collection and element type respectively; the mnemonic is "X of Y", for
    example, \?% says "set of tuple", or \~? says "string of boolean".
```

Some of the above mnemonics also carry additional meanings in a wider
**Muldis Data Language** context, but those are not described here.

# VERSIONING

Every version of this specification document is expected to declare its own
fully-qualified name, or *identity*, so that it can easily be referred to
and be distinguished from every other version that does or might exist.

The expected fully-qualified name of every version of this specification
document, as either declared in said document or as referenced by other
documents or by source code, has 3 main parts: *document base name*,
*authority*, and *version number*.

The *document base name* is the character string `Muldis_Object_Notation`.

An *authority* is some nonempty character string whose value uniquely
identifies the authority or author of the versioned entity.  Generally
speaking, the community at large should self-regulate authority identifier
strings so they are reasonable formats and so each prospective
authority/author has one of their own that everyone recognizes as theirs.
Note that an authority/author doesn't have to be an individual person; it
could be some corporate entity instead.

Examples of recommended *authority* naming schemes include a qualified
base HTTP url belonging to the authority (example `http://muldis.com`) or
a qualified user identifier at some well-known asset repository
(example `http://github.com/muldis` or `cpan:DUNCAND`).

For all official/original works by Muldis Data Systems, Inc., the
*authority* has always been `http://muldis.com` and is expected to remain
so during the foreseeable future.

If someone else wants to *embrace and extend* this specification document,
then they must use their own (not `http://muldis.com`) base authority
identifier, to prevent ambiguity, assist quality control, and give due credit.

In this context, *embrace and extend* means for someone to do any of the
following:

- Releasing a modified version of this current document or any
component thereof where the original of the modified version was released
by someone else (the original typically being the official release), as
opposed to just releasing a delta document that references the current one
as a foundation.  This applies both for unofficial modifications and for
official modifications following a change of who is the official maintainer.

- Releasing a delta document for a version of this current document or
any component thereof where the referenced original is released by someone
else, and where the delta either makes significant incompatible changes.

A *version number* is an ordered sequence of 1 or more integers.  A
*version number* is used to distinguish between all of the versions of a
named entity that have a common *authority*, per each kind of versioned
entity; version numbers typically indicate the release order of these
related versions and how easily users can substitute one version for
another.  The actual intended meaning of any given *version number*
regarding for example substitutability is officially dependant on each
*authority* and no implicit assumptions should be made that 2 *version
number* with different *authority* are comparable in any meaningful way,
aside from case-by-case where a particular *authority* declares they use a
scheme compatible with another.  The only thing this document requires is that
every distinct version of an entity has a distinct fully-qualified name.

For each official/original work by Muldis Data Systems related to this
specification document and released after 2016 April 1, except where
otherwise stated, it uses *semantic versioning* for each *version number*,
as described below.  Others are encouraged to follow the same format, but
are not required to.  For all intents and purposes, every *version number*
of an official Muldis work is intended to conform to the external public
standard **Semantic Versioning 2.0.0** as published at
[https://semver.org](https://semver.org), but it is re-explained below for
clarity or in case the external document disappears.

A *version number* for authority `http://muldis.com` is an ordered sequence
of integers, the order of these being from most significant to least, with
3 positions [MAJOR,MINOR,PATCH] and further ones possible.  The version
sequence may have have as few as 1 most significant position.  Any omitted
trailing position is treated as if it were zero.  Each of
{MAJOR,MINOR,PATCH} must be a non-negative integer. MAJOR is always (except
when it is zero) incremented when a change is made which breaks
backwards-compatibility for functioning uses, such as when removing a
feature; it may optionally be incremented at other times, such as for
marketing purposes.  Otherwise, MINOR is always incremented when a change
is made that breaks forwards-compatibility for functioning uses, such as
when adding a feature; it may optionally be incremented at other times,
such as for when a large internals change is made.  Otherwise, PATCH must
be incremented when making any kind or size of change at all, as long as it
doesn't break compatibility; typically this is bug-fixes or performance
improvements or some documentation changes or any test suite changes.  For
fixes to bugs or security holes which users may have come to rely on in
conceptually functioning uses, they should be treated like API changes.
When MAJOR is zero, MINOR is incremented for any kind of breaking change.
There is no requirement that successive versions have adjacent integers,
but they must be increases.

Strictly speaking a *version number* reflects intention of the authority's
release and not necessarily its actuality.  If PATCH is incremented but the
release unknowingly had a breaking change, then once this is discovered
another release should be made which increments PATCH again and undoes that
breaking change, in order to safeguard upgrading users from surprises; an
additional release can be made which instead increments MAJOR or MINOR with
the breaking change if that change was actually desired.

*Currently this document does not specify matters such as how to indicate
maturity, for example production vs pre-production/beta/etc, so explicit
markers of such can either be omitted or be based on other standards.
However, a major version of zero should be considered either pre-production
or that the authority expects frequent upcoming backwards-incompatible changes.*

See also [http://design.perl6.org/S11.html#Versioning](
http://design.perl6.org/S11.html#Versioning) which was the primary
influence for the versioning scheme described above.

# SEE ALSO

*TODO.*

# AUTHOR

Darren Duncan - darren@DarrenDuncan.net

# LICENSE AND COPYRIGHT

This file is part of the formal specification named
**Muldis Object Notation** (**MUON**).

MUON is Copyright © 2002-2017, Muldis Data Systems, Inc.

[http://www.muldis.com/](http://www.muldis.com/)

MUON is free documentation for software;
you can redistribute it and/or modify it under the terms of the Artistic
License version 2 (AL2) as published by the Perl Foundation
([http://www.perlfoundation.org/](http://www.perlfoundation.org/)).
You should have received copies of the AL2 as part of the
MUON distribution, in the file
[LICENSE/artistic-2_0.txt](../LICENSE/artistic-2_0.txt); if not, see
[http://www.perlfoundation.org/attachment/legal/artistic-2_0.txt](
http://www.perlfoundation.org/attachment/legal/artistic-2_0.txt).

Any versions of MUON that you modify and distribute must carry prominent
notices stating that you changed the files and the date of any changes, in
addition to preserving this original copyright notice and other credits.

While it is by no means required, the copyright holder of MUON would
appreciate being informed any time you create a modified version of Muldis
D that you are willing to distribute, because that is a practical way of
suggesting improvements to the standard version.

# TRADEMARK POLICY

**MULDIS** and **MULDIS MULTIVERSE OF DISCOURSE** are trademarks of Muldis
Data Systems, Inc. ([http://www.muldis.com/](http://www.muldis.com/)).
The trademarks apply to computer database software and related services.
See [http://www.muldis.com/trademark_policy.html](
http://www.muldis.com/trademark_policy.html) for the full written details
of Muldis Data Systems' trademark policy.

# ACKNOWLEDGEMENTS

*None yet.*

# FORUMS

*TODO.*
