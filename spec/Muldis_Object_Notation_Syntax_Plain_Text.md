# NAME

Muldis Object Notation (MUON) - Source code and data interchange format

# VERSION

The fully-qualified name of this document is
`Muldis_Object_Notation https://muldis.com 0.300.0`.

# PART

This artifact is part 4 of 9 of the document
`Muldis_Object_Notation https://muldis.com 0.300.0`;
its part name is `Syntax_Plain_Text`.

# SYNOPSIS

```
    (Script:(
        {Unicode, 2.1, "UTF-8"},
        (Syntax:(
            {Muldis_Object_Notation, "https://muldis.com", {0,300,0}},
            (Model:(
                {Muldis_Data_Language, "https://muldis.com", {0,300,0}},
                (Relation:{
                    (name : "Jane Ives", birth_date : (Calendar_Instant:(y:1971,m:11,d:06)),
                        phone_numbers : (Set:{"+1.4045552995", "+1.7705557572"})),
                    (name : "Layla Miller", birth_date : (Calendar_Instant:(y:1995,m:08,d:27)),
                        phone_numbers : (Set:{})),
                    (name : "岩倉 玲音", birth_date : (Calendar_Instant:(y:1984,m:07,d:06)),
                        phone_numbers : (Set:{"+81.9072391679"})),
                }),
            )),
        )),
    ))
```

# DESCRIPTION

This document consists of multiple parts; for a directory to all of the
parts, see [Overview](Muldis_Object_Notation.md).

This part of the **Muldis Object Notation** document specifies the
canonical concrete plain text syntax of MUON,
which expresses a MUON artifact in terms of a Unicode character string
conforming to a well-defined pattern,
which can exist as a raw file in a filesystem or be exchanged over a
network or exist in memory of any program as a character string value.

The MUON `Syntax_Plain_Text` is derived from and maps with the MUON
[Syntax_Abstract](Muldis_Object_Notation_Syntax_Abstract.md); see that plus
[Semantics](Muldis_Object_Notation_Semantics.md) for further context.

The MUON canonical plain text format is semi-lightweight and designed to
support interchange of source code and data between any 2 environments that
do not have a common working memory, such as because they are distinct
machine processes written in different programming languages, or because
they are on distinct machines, or because they are mediated by a network or
disk file.  The format is fairly easy for humans to read and write.  It is
fairly easy for machines to parse and generate.  The MUON plain text format
that is completely language independent but uses conventions that are
familiar to programmers of many other languages.

The prescribed standard filename extension for files featuring a MUON
parsing unit is `.muon`, though as per standard UNIX conventions, such MUON
files can in fact have any filename extension when there is other context
to interpret them with.  Filename extensions are more for the benefit of
the operating system or command shell or users than for a MUON parser or
generator, the latter just cares about the content of the file.

# NORMALIZATION

The grammar comprising most of this document assumes that the MUON *parsing
unit* it takes as input has already been through some basic normalization,
which this section describes.  Said normalization is expected to be
performed by a MUON parser natively as its first step.

## UNIX Shebang Interpreter Directive

<https://en.wikipedia.org/wiki/Shebang_(Unix)>

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
sequence of Unicode *character code points*, each corresponding to an
integer in the set `{0..0xD7FF,0xE000..0x10FFFF}`), a MUON parser that is
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
*parsing unit* more strongly typed, in particular to explicitly declare
what script / character encoding was used in its file / octet string form.
While heuristics (and BOMs) can lead to a strong guess as to what character
encoding a file is, an explicit MCP declaration makes things more certain.

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

# COMMON QUALITIES OF THE GRAMMAR

The syntax and intended interpretation of the grammar itself seen in this
document should match that of the user-defined grammars feature of the Raku
language, which is described by
<https://docs.raku.org/language/grammars>.

Any references like `<foo>` in either the grammar itself or in the written
documentation specifically refer to the corresponding grammar token `foo`.

See also the bundled actual Raku module
[hosts/Raku/lib/Muldis/Reference/Object_Notation.rakumod](
../hosts/Raku/lib/Muldis/Reference/Object_Notation.rakumod)
which has an executable copy of the grammar.

# PARSING UNIT

A MUON *parsing unit* is represented in the grammar by `<MUON>`.

Grammar:

```
    token MUON
    {
        <sp>? ~ <sp>? <Any>
    }
```

# DIVIDING SPACE

Grammar:

```
    token sp
    {
        [<whitespace_char> | <quoted_sp_comment_str>]+
    }

    token whitespace_char
    {
        <[ \t \n \r \x[20] ]>
    }

    token quoted_sp_comment_str
    {
        '`' ~ '`' <-[`]>*
    }
```

A `<sp>` represents *dividing space* that may be used to visually format
MUON for readability (with line breaks and line indentation), or to embed
comments, without changing its meaning.  A superset of the MUON grammar
might require *dividing space* to disambiguate the boundaries of
otherwise-consecutive grammar tokens, but plain MUON does not.

A special feature of MUON is that any unrestrained-length literal or
identifier may be split into multiple segments
separated by dividing space.  This segmenting ability is provided to
support code that contains very long numeric or stringy literals while
still being well formatted (no extra long lines).
See the grammar sections for `<Integer>`, `<Fraction>`, `<Bits>`, `<Blob>`,
`<Text>` for more details on how this specifically applies to them.

*The rest of this sub-section about "entity marker" is obsolete and will be
updated with an alternative method to accomplish the same goal.*

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

# CRITICAL ALGEBRAIC DATA TYPE POSSREPS

## Any / Universal Type Possrep

An **Any** artifact has the dedicated concrete literal format
described by `<Any>`.

Grammar:

```
    token Any
    {
        <generic_group> | <simple_primary> | <collective_primary>
    }

    token generic_group
    {
        ['(' <sp>?] ~ [<sp>? ')'] <Any>
    }

    token simple_primary
    {
          <Ignorance>
        | <Boolean>
        | <Integer>
        | <Fraction>
        | <Bits>
        | <Blob>
        | <Text>
        | <Nesting>
    }

    token collective_primary
    {
          <Duo>
        | <Lot>
        | <Kit>
        | <Article>
        | <Excuse>
    }
```

A `<generic_group>` is an optional syntactic construct to force a
particular parsing precedence or otherwise help illustrate an existing one;
it is not actually needed by MUON itself but can assist a superset grammar.

## None / Empty Type Possrep

A **None** artifact doesn't exist, but is mentioned for parity.

# SIMPLE PRIMARY DATA TYPE POSSREPS

## Ignorance

An **Ignorance** artifact has the dedicated concrete literal format
described by `<Ignorance>`.

Grammar:

```
    token Ignorance
    {
        0iIGNORANCE
    }
```

Examples:

```
    0iIGNORANCE
```

## Boolean

A **Boolean** artifact has the dedicated concrete literal format
described by `<Boolean>`.

Grammar:

```
    token Boolean
    {
        0b [FALSE | TRUE]
    }
```

Examples:

```
    0bFALSE

    0bTRUE
```

## Integer

An **Integer** artifact has the dedicated concrete literal format
described by `<Integer>`.

Grammar:

```
    token Integer
    {
        <[+-]>? <sp>? <Integer_nonsigned>
    }

    token Integer_nonsigned
    {
          [ 0b <sp>?   [0 | [   1            [[_ | <sp>]? <[ 0..1      ]>+]*]]]
        | [ 0o <sp>?   [0 | [<[ 1..7      ]> [[_ | <sp>]? <[ 0..7      ]>+]*]]]
        | [[0d <sp>?]? [0 | [<[ 1..9      ]> [[_ | <sp>]? <[ 0..9      ]>+]*]]]
        | [ 0x <sp>?   [0 | [<[ 1..9 A..F ]> [[_ | <sp>]? <[ 0..9 A..F ]>+]*]]]
    }
```

This grammar supports writing **Integer** literals in any of the numeric
bases `{2,8,10,16}`, using conventional syntax.  The literal may
optionally contain underscore characters (`_`), which exist just to help
with visual formatting, such as for `10_000_000`.

This grammar explicitly forbids leading zeros in the main body of non-zero
**Integer** literals as a precaution against subtle security flaws or
other bugs resulting from users copying literals with leading zeros between
MUON and some other language/format that differ in whether or not they
consider a leading zero to signify octal/base-8 notation.

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

A **Fraction** artifact has the dedicated concrete literal format
described by `<Fraction>`.

Grammar:

```
    token Fraction
    {
        <significand> [<sp>? '*' <sp>? <radix> <sp>? '^' <sp>? <exponent>]?
    }

    token significand
    {
        <radix_point_sig> | <num_den_sig>
    }

    token radix_point_sig
    {
        <[+-]>? <sp>? <nonsigned_radix_point_sig>
    }

    token nonsigned_radix_point_sig
    {
          [
            0b <sp>?
            [0 | [1 [[_ | <sp>]? <[ 0..1 ]>+]*]]
            [_ | <sp>]? '.'
            [[_ | <sp>]? <[ 0..1 ]>+]+
          ]
        | [
            0o <sp>?
            [0 | [<[ 1..7 ]> [[_ | <sp>]? <[ 0..7 ]>+]*]]
            [_ | <sp>]? '.'
            [[_ | <sp>]? <[ 0..7 ]>+]+
          ]
        | [
            [0d <sp>?]?
            [0 | [<[ 1..9 ]> [[_ | <sp>]? <[ 0..9 ]>+]*]]
            [_ | <sp>]? '.'
            [[_ | <sp>]? <[ 0..9 ]>+]+
          ]
        | [
            0x <sp>?
            [0 | [<[ 1..9 A..F ]> [[_ | <sp>]? <[ 0..9 A..F ]>+]*]]
            [_ | <sp>]? '.'
            [[_ | <sp>]? <[ 0..9 A..F ]>+]+
          ]
    }

    token num_den_sig
    {
        <numerator> <sp>? '/' <sp>? <denominator>
    }

    token numerator
    {
        <Integer>
    }

    token denominator
    {
        <Integer_nonsigned>
    }

    token radix
    {
        <Integer_nonsigned>
    }

    token exponent
    {
        <Integer>
    }
```

This grammar supports writing **Fraction** literals in any of the numeric
bases `{2,8,10,16}`, using conventional syntax.  The literal may
optionally contain underscore characters (`_`), which exist just to help
with visual formatting, such as for `20_194/17` or `3.141_59`.

This grammar explicitly forbids leading zeros in the main body of non-zero
**Fraction** literals as a precaution against subtle security flaws or
other bugs resulting from users copying literals with leading zeros between
MUON and some other language/format that differ in whether or not they
consider a leading zero to signify octal/base-8 notation.

The general form of a **Fraction** literal is `n/d*r^e` such that
`{n,d,r,e}` are each integers and the literal represents the rational
number that results from evaluating the mathematical expression using the
following implicit order of operations, `(n/d)*(r^e)` such that `/` means
divide, `*` means multiply, and `^` means exponentiate.

While the wider general format `n/d*r^e` can represent every rational
number, as can just the `n/d` portion by itself, the alternate but typical
format `x.x` can only represent a proper subset of the rational numbers,
that subset being every rational number that can be represented as a
terminating decimal number.  Note that every rational number that can be
represented as a terminating binary or octal or hexadecimal number can also
be represented as a terminating decimal number.

Note that in order to keep the grammar simpler or more predictable, each
**Fraction** component `{n,d,r,e}` must have its numeric base specified
individually, and so any component without a {`0b`,`0o`,`0x`} prefix will
be interpreted as base 10.  This keeps behaviour consistent with a parser
that sees a **Fraction** literal but interprets it as multiple **Integer**
literals separated by symbolic infix operators, evaluation order aside.
Also per normal expectations, literals in the format `x.x` only specify the
base at most once in total, *not* separately for the part after the `.`.

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

A **Bits** artifact has the dedicated concrete literal format
described by `<Bits>`.

Grammar:

```
    token Bits
    {
          [ 0bb <sp>? [<[ 0..1      ]>+]* % [_ | <sp>]]
        | [ 0bo <sp>? [<[ 0..7      ]>+]* % [_ | <sp>]]
        | [ 0bx <sp>? [<[ 0..9 A..F ]>+]* % [_ | <sp>]]
    }
```

This grammar supports writing **Bits** literals in any of the numeric
bases `{2,8,16}`, using semi-conventional syntax.  The literal may
optionally contain underscore characters (`_`), which exist just to help
with visual formatting, such as for `0bb00101110_100010`.

Examples:

```
    0bb

    0bb00101110100010

    0bb00101110_100010

    0bo644

    0bxA705E
```

## Blob

A **Blob** artifact has the dedicated concrete literal format
described by `<Blob>`.

Grammar:

```
    token Blob
    {
          [ 0xb <sp>? [[<[ 0..1      ]> ** 8]+]* % [_ | <sp>]]
        | [ 0xx <sp>? [[<[ 0..9 A..F ]> ** 2]+]* % [_ | <sp>]]
        | [ 0xy <sp>? [[<[ A..Z a..z 0..9 + / = ]> ** 4]+]* % [_ | <sp>]]
    }
```

This grammar supports writing **Blob** literals in any of the numeric
bases `{2,16,64}`, using semi-conventional syntax.  The literal may
optionally contain underscore characters (`_`), which exist just to help
with visual formatting, such as for `0xxA705_E416`.

A `<Blob>` is subject to the additional rule that any `=` characters may
only appear at the very end of it.

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

A **Text** artifact has the dedicated concrete literal format
described by `<Text>`.

Grammar:

```
    token Text
    {
        <quoted_text> | <nonquoted_alphanumeric_text> | <code_point_text>
    }

    token quoted_text
    {
        <quoted_text_segment>+ % <sp>?
    }

    token quoted_text_segment
    {
        '"' ~ '"' [<restricted_inside_char> | <escaped_char>]*
    }

    token restricted_inside_char
    {
        <-[ \x[0]..\x[1F] "` \x[7F] \x[80]..\x[9F] ]>
    }

    token escaped_char
    {
        '\\' [<[qgbtnr]> | ['<' ~ '>' <code_point_text>]]
    }

    token nonquoted_alphanumeric_text
    {
        <[ A..Z _ a..z ]> <[ 0..9 A..Z _ a..z ]>*
    }

    token code_point_text
    {
          [0tb  [0 | [   1            <[ 0..1      ]>+]]]
        | [0to  [0 | [<[ 1..7      ]> <[ 0..7      ]>+]]]
        | [0td? [0 | [<[ 1..9      ]> <[ 0..9      ]>+]]]
        | [0tx  [0 | [<[ 1..9 A..F ]> <[ 0..9 A..F ]>+]]]
    }
```

The meaning of `<nonquoted_alphanumeric_text>` is exactly the same as if
the same characters were surrounded by quotation marks.

This grammar explicitly forbids leading zeros in the main body of non-zero
`<code_point_text>` for consistency with **Integer** literals.

A `<code_point_text>` is subject to the additional rule that the
non-negative integer it denotes must be in the set
`{0..0xD7FF,0xE000..0x10FFFF}`.

The meanings of the simple character escape sequences are:

```
    Esc | Unicode    | Unicode         | Chr | Literal character used
    Seq | Code Point | Character Name  | Lit | for when not escaped
    ----+------------+-----------------+-----+-----------------------------
    \q  | 0x22    34 | QUOTATION MARK  | "   | delimit Text/opaque literals
    \g  | 0x60    96 | GRAVE ACCENT    | `   | delimit dividing space comments
    \b  | 0x5C    93 | REVERSE SOLIDUS | \   | no special meaning in non-escaped
    \t  | 0x9      9 | CHAR... TAB...  |     | control char horizontal tab
    \n  | 0xA     10 | LINE FEED (LF)  |     | ctrl char line feed / newline
    \r  | 0xD     13 | CARR. RET. (CR) |     | control char carriage return
```

There is just one complex escape sequence, of the format `\<...>`, that
supports specifying characters in terms of their Unicode code point number.
One reason for this feature is to empower more elegant passing of
Unicode-savvy MUON through a communications channel that is more limited,
such as to 7-bit ASCII.

A `<code_point_text>` is a specialized shorthand for a **Text** of
exactly 1 character whose code point number it denotes.

Given that **Text** values or syntax serve double duty for not only regular
user data but also for attribute names of tuples or other kinds of
identifiers, the `<code_point_text>` variant provides a nicer alternative
for specifying them in latter contexts; it is purposefully like a regular
integer for use in situations where we have conceptually ordered (rather
than conceptually named) attributes.

Examples:

```
    ""

    Ceres

    "サンプル"

    "This isn't not escaped.\n"

    "\<0tx263A>\<0t65>"

    `One non-ordered quoted Text (or, one named attribute).`
    "sales"

    `Same thing but nonquoted.`
    sales

    `One attribute name with a space in it.`
    "First Name"

    `One ordered nonquoted Text (or, one ordered attribute).`
    0t0

    `Same Text value (or, one ordered attr written in format of a named).`
    "\<0t0>"

    `From a graduate student (in finals week), the following haiku:`
    "study, write, study,\n"
        "do review (each word) if time.\n"
        "close book. sleep? what's that?\n"
```

## Nesting / Attribute Name List

A **Nesting** artifact has the dedicated concrete literal format
described by `<Nesting>`.

Grammar:

```
    token Nesting
    {
        <nesting_unary> | <nesting_nary>
    }

    token nesting_unary
    {
        ['::' <sp>? <Text>]
    }

    token nesting_nary
    {
        ['::' <sp>?]?
        [<Text> ** 2..* % [<sp>? '::' <sp>?]]
    }
```

Examples:

```
    ::person

    person::birth_date

    person::birth_date::year

    the_db::stats::"samples by order"
```

# COLLECTIVE PRIMARY DATA TYPE POSSREPS

## Duo

A **Duo** artifact has the dedicated concrete literal format
described by `<Duo>`.

Grammar:

```
    token Duo
    {
        ['(' <sp>?] ~ [<sp>? ')'] <this_and_that>
    }

    token this_and_that
    {
          [<this> <sp>? [':'|'->'] <sp>? <that>]
        | [<that> <sp>?      '<-'  <sp>? <this>]
    }

    token this
    {
        <Any>
    }

    token that
    {
        <Any>
    }
```

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

A **Lot** artifact has the dedicated concrete literal format
described by `<Lot>`.

Grammar:

```
    token Lot
    {
        ['{' <sp>?] ~ [<sp>? '}']
            [',' <sp>?]?
            [[<this> | <this_and_that>]* % [<sp>? ',' <sp>?]]
            [<sp>? ',']?
    }
```

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

## Kit / Multi-Level Tuple

A **Kit** artifact has the dedicated concrete literal format
described by `<Kit>`.

Grammar:

```
    token Kit
    {
        ['(' <sp>?] ~ [<sp>? ')'] <kit_ml_attrs>
    }

    token kit_ml_attrs
    {
        <kit_nullary> | <kit_unary> | <kit_nary>
    }

    token kit_nullary
    {
        ''
    }

    token kit_unary
    {
          [          <kit_ml_attr> <sp>? ',']
        | [',' <sp>? <kit_ml_attr> <sp>? ',']
        | [',' <sp>? <kit_ml_attr>          ]
    }

    token kit_nary
    {
        [',' <sp>?]?
        [<kit_ml_attr> ** 2..* % [<sp>? ',' <sp>?]]
        [<sp>? ',']?
    }

    token kit_ml_attr
    {
        [<ml_attr_name> <sp>? ':' <sp>?]? <ml_attr_asset>
    }

    token ml_attr_name
    {
        <Nesting> | <Text>
    }

    token ml_attr_asset
    {
        <Any>
    }
```

The meaning of a `<kit_ml_attr>` consisting of only an `<ml_attr_asset>` is
exactly the same as if the former also had an `<ml_attr_name>` of the form
`0tN` such that `N` is the zero-based ordinal position of the
`<kit_ml_attr>` in the `<kit_ml_attrs>` among all sibling such
`<kit_ml_attr>`.  These *attribute name* are determined without regard to
any explicit *attribute name* that a `<kit_ml_attrs>` may contain, and it is
invalid for any explicit names to duplicate any implicit or explicit names.

Examples:

```
    `Zero attributes.`
    ()

    `One named attribute.`
    ("First Name": Joy,)

    `Same thing.`
    (::"First Name": Joy,)

    `One ordered attribute.`
    (53,)

    `Same thing.`
    (0t0: 53,)

    `Same thing.`
    ("\<0t0>": 53,)

    `Same thing.`
    (::0t0: 53,)

    `Three named attributes.`
    (
        login_name : hartmark,
        login_pass : letmein,
        is_special : 0bTRUE,
    )

    `Same thing.`
    (
        ::login_name : hartmark,
        ::login_pass : letmein,
        ::is_special : 0bTRUE,
    )

    `Three ordered attributes.`
    (hello,26,0bTRUE)

    `One of each.`
    (Jay, age: 10)

    `A non-Latin name.`
    ("サンプル": "http://example.com",)

    `Five leaf attributes in nested multi-level namespace.`
    (
        name: "John Glenn",
        birth_date::year: 1921,
        comment: "Fly!",
        birth_date::month: 7,
        birth_date::day: 18,
    )
```

## Article / Labelled Tuple

A **Article** artifact has the dedicated concrete literal format
described by `<Article>`.

Grammar:

```
    token Article
    {
        <label> <sp>? '*' <sp>? <attrs>
    }

    token label
    {
        <Nesting> | <Text>
    }

    token attrs
    {
        <Kit>
    }
```

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

A **Excuse** artifact has the dedicated concrete literal format
described by `<Excuse>`.

Grammar:

```
    token Excuse
    {
        <label> <sp>? '!' <sp>? <attrs>
    }
```

Examples:

```
    Input_Field_Wrong!(name : "Your Age")

    Div_By_Zero!()

    No_Such_Attr_Name!()
```

# RESERVED UNUSED SYNTAX

Muldis Object Notation reserves the use of certain syntaxes for various
reasons.  In some cases it doesn't use those syntaxes now but wants to
prevent other superset grammars of MUON from defining their own meanings,
regardless of whether MUON might use them in the future itself.  In other
cases it doesn't use those syntaxes expressly in order to empower superset
grammars to define their own meanings.

## Possrep Heuristics

The following table indicates the basic heuristics for how each primary
possrep is recognized within a valid Muldis Object Notation artifact:

```
    Possrep/partial | Possrep Instead Identified By
    ----------------+---------------------------------------------
    Ignorance       | prefix 0i followed by IGNORANCE
    Boolean         | prefix 0b followed by FALSE or TRUE
    Integer         | optional prefix +|-
                    |     and leading 0..9 without any ./*^
                    |     and no prefix 0[i|t] or 0b[F|T] or 0[b|x][a..z]
    Fraction        | optional prefix +|-
                    |     and leading 0..9 with at least 1 of ./*^
                    |     and no prefix 0xy
    Bits            | prefix 0bb or 0bo or 0bx
    Blob            | prefix 0xb or 0xx or 0xy
    Text            | only "" or "..." or prefix [A..Z _ a..z] or prefix 0t
    Nesting         | leading ::, or :: between 2 of, what otherwise is Text
    Duo             | (...:...) or (...->...) or (...<-...) without any comma
    Lot             | only {} or {...}
    Kit             | only () or (...) with >= 1 comma
    Article         | * between a Nesting|Text and a Kit in that order
    Excuse          | ! between a Nesting|Text and a Kit in that order
```

## Features Reserved For Superset Grammars

Muldis Object Notation is designed around a minimized set of *syntactic
namespaces* in order to leave as much useful syntax as possible for
superset grammars, such as ones defining a more full featured programming
language, a co-developed example being **Muldis Data Language**.

MUON doesn't use any generic-context alphanumeric barewords to mean
anything besides simple literal values of enumerated or numeric or stringy
types.  It has no alpha keywords or reserved words.

MUON *always* defines enumerated literals or numeric literals or
non-character string literals to begin with a digit, in some cases with the
sole exception of a `-` or `+` symbol.  It *always* defines character
string literals to start with a simple letter or underscore, or that
literal is double-quoted, with the sole exception of `0tN` literals.

MUON doesn't use any generic-context symbolic barewords, but if it did then
it would group them into a single namespace defined by a leading `\` which
frees up all other possible symbol sequences to be defined by the superset;
as it isn't typical for any languages to use a `\` for their symbolic
operator names, the languages can be natural.

While MUON also has some free `.+-*/^`, those only appear adjacent to
numeric barewords and are considered part of those numeric literals, and so
shouldn't interfere with a superset using those for regular operators.

Likewise, any uses of `:` or `->` or `<-` or `,` are only used by MUON
within various kinds of bracketing pairs and a superset should be able to
also use them.

MUON does not use the single-quote string delimiter character `'` for
anything, and leaves it reserved for a superset to use as it sees fit.

MUON does not use the square bracket collection delimiters `[` and `]` for
anything, and leaves them reserved for a superset to use as it sees fit.

MUON does not use the semicolon `;` for anything, so a superset grammar can
use it for things like separating statements and thus disambiguating its
own uses of bracketing characters to define statement or expression groups.

## Features Shared With Superset Grammars

MUON declares that all alpha barewords are **Text** literals,
meaning any bareword like `foo` is interpreted as if it were `"foo"`.
This syntactic feature is intended to make the common cases of **Nesting**
or attribute names or similar more pleasant to manually write or read.
There are intentionally no special edge cases that could cause confusion or
bugs; for example `FALSE` is a **Text**, not a **Boolean**; to get the
latter you must prefix `0b` for a leading digit.

MUON assumes that a superset grammar may wish to override that general
interpretation such as to be reserved words or refer to infix or prefix etc
operator or routine invocations or to refer to variable names or whatever;
in that case, any contexts that could be interpreted either as a **Text**
literal or as something else will be interpreted as the latter, and one can
use the quoted form of **Text** to force that meaning.

# SYNTACTIC MNEMONICS

The syntax of Muldis Object Notation is designed around a variety of
mnemonics that bring it some self-similarity and an association between
syntax and semantics so that it is easier to read and write data and code
in it.  Some of these mnemonics are more about self-similarity and others
are more about shared traits with other languages.

The following table enumerates and explains the syntactic character
mnemonics that Muldis Object Notation itself has specific knowledge of and
ascribes specific meanings to; where multiple characters are shown together
that means they are used either in pairs or as contiguous sequences.

```
    Chars | Generic Meaning        | Specific Use Cases
    ------+------------------------+---------------------------------------
    ``    | stringy comments       | * delimit expendable dividing space comments
    ------+------------------------+---------------------------------------
    ""    | stringy data and names | * delimit all quoted-Text/identifier literals
    ------+------------------------+---------------------------------------
    \     | escaped characters     | * prefix for each escaped char in quoted string
    ------+------------------------+---------------------------------------
    ()    | attribute collections  | * delimit heterogeneous aordered collections
          |                        |   of attributes, concept nominal+asset pairs
          |                        | * delimit Duo/Kit selectors
          | generic grouping       | * optional delimiters around Any to force a parsing precedence
    ------+------------------------+---------------------------------------
    {}    | discrete collections   | * delimit homogeneous discrete collections
          |                        |   of members, concept asset+cardinal pairs
          |                        | * delimit Lot selectors
    ------+------------------------+---------------------------------------
    :     | pairings               | * indicates a pairing context
    ->    |                        | * separates the 2 parts of a pair
    <-    |                        | * this/that separator in Duo sels
          |                        | * optional attr name/asset separator in Kit sels
          |                        | * disambiguate Duo sels from generic_group
    ------+------------------------+---------------------------------------
    ,     | list builders          | * separates collection elements
          |                        | * separate attributes in Kit sels
          |                        | * disambiguate unary named Kit sels from Duo sels and generic_group
          |                        | * separate members in Lot sels
    ------+------------------------+---------------------------------------
    ::    | nestings               | * prefix or separate elements of a Nesting literal
          |                        | * disambiguate Nesting from Text
    ------+------------------------+---------------------------------------
    *     | generics/whatever      | * indicates a generic type context
          | articles               | * separates the 2 parts of an Article selector
          | multiplication         | * significand/radix separator in Fraction literals
    ------+------------------------+---------------------------------------
    !     | excuses                | * separates the 2 parts of an Excuse selector
    ------+------------------------+---------------------------------------
    +     | addition               | * optional indicates positive-Integer/Fraction literal
    ------+------------------------+---------------------------------------
    -     | subtraction            | * indicates negative-Integer/Fraction literal
    ------+------------------------+---------------------------------------
    .     | radix point            | * disambiguate Fraction lit from Integer lit
    ------+------------------------+---------------------------------------
    /     | fractions/measures     | * indicates a fractional quantifying/count context
          | division               | * disambiguate Fraction lit from Integer lit
          |                        | * numerator/denominator separator in Fraction literals
    ------+------------------------+---------------------------------------
    ^     | exponentiation         | * radix/exponent separator in Fraction literals
    ------+------------------------+---------------------------------------
    $     | identifiers/names      | * a triple of this indicates an entity marker
    ------+------------------------+---------------------------------------
    digit | number/enumeration     | * first char 0..9 in bareword indicates is number/code-point/Bits/Blob/enumeration
    ------+------------------------+---------------------------------------
    alpha | identifier             | * first char a..z/etc in bareword indicates is Text/identifier
    ------+------------------------+---------------------------------------
    0i    | ignorance              | * prefix for Ignorance literal
    ------+------------------------+---------------------------------------
    0b    | boolean                | * prefix for Boolean literal
          | base-2                 | * indicates base-2/binary notation
          |                        | * prefix for Integer or Fraction-part in base-2
          | bit string             | * prefix for Bits literals; 0bb/0bo/0bx means in base-2/8/16
    ------+------------------------+---------------------------------------
    0o    | base-8                 | * indicates base-8/octal notation
          |                        | * prefix for Integer or Fraction-part in base-8
    ------+------------------------+---------------------------------------
    0d    | base-10                | * indicates base-10/decimal notation
          |                        | * optional prefix for Integer or Fraction-part in base-10
    ------+------------------------+---------------------------------------
    0x    | base-16                | * indicates base-16/hexadecimal notation
          |                        | * prefix for Integer or Fraction-part in base-16
          | octet string           | * prefix for Blob literals; 0xb/0xx/0xy means in base-2/16/64
    ------+------------------------+---------------------------------------
    0t    | character code point   | * indicates a Unicode character code point
          |                        | * prefix for code-point-Text lit; 0tb/0to/0td/0tx means in base-2/8/10/16
    ------+------------------------+---------------------------------------
```

Some of the above mnemonics also carry additional meanings in a wider
**Muldis Data Language** context, but those are not described here.

# NESTING PRECEDENCE RULES

Muldis Object Notation is explicitly designed to avoid parsing complexities
around operator precedence that are typical with programming languages.

Primarily this is due to user-defined entities such as operators having no
impact at all on how a MUON artifact is parsed.  The parsing rules are
static and parsing can be done with no knowledge of anything user-defined.

Secondarily this is due to the static MUON syntax having a small count of
basic rules so understanding how to parse it shouldn't take much effort.
The rest of this document section enumerates or gives examples of those,
generally arranged from tightest precedence at the top to loosest at the bottom.

## Quoted Strings

MUON has 2 kinds of quoted strings which have strict precedence relative to
each other and above everything else.

A `<quoted_sp_comment_str>`, that is, a pair of grave accents `` ` `` with
a run of any other characters between them, has the highest precedence of
the whole MUON grammar, and a valid MUON artifact will only have zero or an
exact positive multiple of 2 of grave accent characters.  A MUON parser
would logically isolate all `<quoted_sp_comment_str>` as their own tokens
first, and then the entire remainder of the grammar would apply as if each
of those tokens was simply not present in the original artifact and any
characters immediately before/after it were instead adjacent.
(A superset grammar might wish to instead treat the remainder of the
grammar as if the before/after were instead separated by a single space
character, if that is necessary to properly parse the superset.)

A `<quoted_text>`, that is, a pair of quotation marks `"` with a run of any
other (except grave accent) characters between them, has the second highest
precedence of the whole MUON grammar, and a valid MUON artifact will only
have zero or an exact positive multiple of 2 of quotation mark characters
outside of a `<quoted_sp_comment_str>`.  A MUON parser would logically
isolate all `<quoted_text>` as their own tokens second, and then the
remainder of the grammar would apply outside of those tokens.

## Symbolic Delimiters/Separators/Indicators

Anywhere outside of a quoted string that these specific symbolic sequences
appear, each one is its own indivisible token that is not part of any
bareword or (except for the case of `*`) numeric-format literal;
when any of these sequences overlap, longest token always wins:

```
    (
    )
    {
    }
    :
    ->
    <-
    ,
    ::
    *
    !
```

## Barewords and Numeric-Format Literals

MUON has a handful of possreps or components of possreps that are either
contiguous alphanumeric barewords or semi-contiguous alphanumeric barewords
with a small set of possible embedded symbolic characters as well as
optional *dividing space*.  Notwithstanding anything declared in prior
document sub-sections, any bareword or numeric-format literal or quoted
string literal will always be interpreted with the longest possible match.
That is, any place where one could possibly interpret that there are
multiple terms in a row, if it is valid to interpret the second term as a
continuation of the first one, then it will be taken as a continuation.

For example, an unquoted `29 56 14 09` will be interpreted as a single
integer of 8 digits, or as part of something larger depending on what
precedes it, but interrupting with something like a comma as in
`29 56, 14 09` would instead be two integers of 4 digits.

For example, an unquoted `- 29 / 14 * 2 ^ - 6` will be interpreted as a
single fraction value and not 4 integers separated by operators.

It is expected that any programming languages whose grammar is a superset
of MUON's will also keep this precedence over any actual prefix/infix/etc
operators they may have, which in some case may require `<generic_group>`
parenthesis to disambiguate that they want those operator calls instead.

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
