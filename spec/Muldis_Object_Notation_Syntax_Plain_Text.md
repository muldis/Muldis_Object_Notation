<a name="TOP"></a>

# NAME

Muldis Object Notation (MUON) - Source code and data interchange format

# VERSION

The fully-qualified name of this document is
`Muldis_Object_Notation https://muldis.com 0.400.0`.

# PART

This artifact is part 6 of 22 of the document
`Muldis_Object_Notation https://muldis.com 0.400.0`;
its part name is `Syntax_Plain_Text`.

# CONTENTS

- [SYNOPSIS](#SYNOPSIS)
- [DESCRIPTION](#DESCRIPTION)
- [NORMALIZATION](#NORMALIZATION)
    - [UNIX Shebang Interpreter Directive](#UNIX-Shebang-Interpreter-Directive)
    - [Script / Character Encoding](#Script---Character-Encoding)
- [COMMON QUALITIES OF THE GRAMMAR](#COMMON-QUALITIES-OF-THE-GRAMMAR)
- [PARSING UNIT](#PARSING-UNIT)
- [DIVIDING SPACE](#DIVIDING-SPACE)
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
    - [Text / Attribute Name](#Text---Attribute-Name)
    - [Nesting / Attribute Name List](#Nesting---Attribute-Name-List)
- [COLLECTIVE DATA TYPE POSSREPS](#COLLECTIVE-DATA-TYPE-POSSREPS)
    - [Pair](#Pair)
    - [Lot](#Lot)
    - [Kit](#Kit)
- [RESERVED UNUSED SYNTAX](#RESERVED-UNUSED-SYNTAX)
    - [Possrep Heuristics](#Possrep-Heuristics)
    - [Features Reserved For Superset Grammars](#Features-Reserved-For-Superset-Grammars)
- [SYNTACTIC MNEMONICS](#SYNTACTIC-MNEMONICS)
- [NESTING PRECEDENCE RULES](#NESTING-PRECEDENCE-RULES)
    - [Quoted Strings](#Quoted-Strings)
    - [Symbolic Delimiters/Separators/Indicators](#Symbolic-Delimiters-Separators-Indicators)
    - [Barewords and Numeric-Format Literals](#Barewords-and-Numeric-Format-Literals)
- [AUTHOR](#AUTHOR)
- [LICENSE AND COPYRIGHT](#LICENSE-AND-COPYRIGHT)

[RETURN](#TOP)

<a name="SYNOPSIS"></a>

# SYNOPSIS

Common "named relation" format with attribute names repeating per tuple.

```
    (:Muldis_Object_Notation_Syntax : (["Plain_Text", "https://muldis.com", "0.400.0"]:
        (:Muldis_Object_Notation_Model : (["Muldis_Data_Language", "https://muldis.com", "0.400.0"]:
            (:Relation : [
                {name : "Jane Ives", birth_date : (:Calendar_Instant : {y:1971,m:11,d:6}),
                    phone_numbers : (:Set : ["+1.4045552995", "+1.7705557572"])},
                {name : "Layla Miller", birth_date : (:Calendar_Instant : {y:1995,m:8,d:27}),
                    phone_numbers : (:Set : [])},
                {name : "岩倉 玲音", birth_date : (:Calendar_Instant : {y:1984,m:7,d:6}),
                    phone_numbers : (:Set : ["+81.9072391679"])},
            ])
        ))
    ))
```

Alternate "positional relation" format with attribute names declared
once between all tuples.

```
    (:Muldis_Object_Notation_Syntax : (["Plain_Text", "https://muldis.com", "0.400.0"]:
        (:Muldis_Object_Notation_Model : (["Muldis_Data_Language", "https://muldis.com", "0.400.0"]:
            (:Relation : (
                    {:name, :birth_date, :phone_numbers}
                : [
                    {"Jane Ives", (:Calendar_Instant : {y:1971,m:11,d:6}),
                        (:Set : ["+1.4045552995", "+1.7705557572"])},
                    {"Layla Miller", (:Calendar_Instant : {y:1995,m:8,d:27}),
                        (:Set : [])},
                    {"岩倉 玲音", (:Calendar_Instant : {y:1984,m:7,d:6}),
                        (:Set : ["+81.9072391679"])},
                ]
            ))
        ))
    ))
```

[RETURN](#TOP)

<a name="DESCRIPTION"></a>

# DESCRIPTION

This document consists of multiple parts; for a directory to all of the
parts, see [Overview](Muldis_Object_Notation.md).

This part of the **Muldis Object Notation** document specifies the
canonical concrete nonhosted plain text (strict) syntax of MUON,
which expresses a MUON artifact in terms of a Unicode character string
conforming to a well-defined pattern,
which can exist as a raw file in a filesystem or be exchanged over a
network or exist in memory of any program as a character string value.

The MUON `Syntax_Plain_Text` is derived from and maps with the MUON
[Syntax_Abstract](Muldis_Object_Notation_Syntax_Abstract.md); see that plus
[Semantics](Muldis_Object_Notation_Semantics.md) for further context.

The MUON canonical plain text (strict) format is semi-lightweight and designed to
support interchange of source code and data between any 2 environments that
do not have a common working memory, such as because they are distinct
machine processes written in different programming languages, or because
they are on distinct machines, or because they are mediated by a network or
disk file.  The format is fairly easy for humans to read and write.  It is
fairly easy for machines to parse and generate.  The MUON plain text format
is completely language independent but uses conventions that are
familiar to programmers of many other languages.

Note that the less-strict human-focused MUON
[Syntax_Plain_Text_Lax](Muldis_Object_Notation_Syntax_Plain_Text_Lax.md)
exists as an alternative to the MUON `Syntax_Plain_Text`.

Note that the machine-focused MUON
[Syntax_Packed_Plain_Text](Muldis_Object_Notation_Syntax_Packed_Plain_Text.md)
exists as an alternative to the MUON `Syntax_Plain_Text`.

The prescribed standard *syntax base name* of a *syntax-qualified artifact*
for a MUON Plain Text artifact is `Plain_Text`.

The prescribed standard filename extension for files featuring a MUON Plain
Text parsing unit is `.muon`, though as per standard UNIX conventions,
such MUON files can in fact have any filename extension when there is other
context to interpret them with.  Filename extensions are more for the
benefit of the operating system or command shell or users than for a MUON
parser or generator, the latter just cares about the content of the file.

[RETURN](#TOP)

<a name="NORMALIZATION"></a>

# NORMALIZATION

The grammar comprising most of this document assumes that the MUON *parsing
unit* it takes as input has already been through some basic normalization,
which this section describes.  Said normalization is expected to be
performed by a MUON parser natively as its first step.

[RETURN](#TOP)

<a name="UNIX-Shebang-Interpreter-Directive"></a>

## UNIX Shebang Interpreter Directive

<https://en.wikipedia.org/wiki/Shebang_(Unix)>

Since a MUON file may typically define an executable program that could be
directly invoked in the typical manner of a UNIX script, MUON officially
supports the option of a *shebang line* at the start of a *parsing unit*.
The shebang line tells the program loader what interpreter to invoke to run
the MUON file and what other additional arguments it should be given.

Examples:

```
    #!/usr/bin/env muldisder
```

The `#!` is a magic number and the shebang continues until the first
linebreak; the parser should discard that line and then process the rest of
the input according to the regular MUON grammar.

It is mandatory for every MUON parser to support recognition of an optional
*shebang line* and to handle it gracefully, such that it is not an error
for a *parsing unit* to either have or not have one, and any otherwise
valid MUON following one is handled properly.

[RETURN](#TOP)

<a name="Script---Character-Encoding"></a>

## Script / Character Encoding

The MUON parser proper operates logically in terms of the input *parsing
unit* being a Unicode character string (characterized by a sequence of
Unicode *character code points*, each corresponding to an integer in the
set `[0..0xD7FF,0xE000..0x10FFFF]`).  In self-defining terms, the MUON
parser proper expects a **Text** value as input.

Actual MUON parser input, however, is given as an octet string (per a raw
file), which represents the character data in some encoding format.  In
self-describing terms, the actual input or raw file is directly
characterized by a **Blob** value, so a normalization function would need
to map from the latter value to the former, a process typically known as
*character decoding*.

It is mandatory for every MUON parser and generator to support the UTF-8
character format associated with the **Unicode** standard version 2.1 and
later; the proper subset 7-bit ASCII character format is also mandatory.
Both the UTF-8 variants with and without the leading Byte Order Mark (BOM)
character must be supported.

It is mandatory for MUON that takes the form of an octet string or **Blob**
value to be encoded as well-formed UTF-8 (or ASCII), with or without a BOM.
No other character encoding formats are allowed for well-formed MUON.

It is mandatory for every MUON parser and generator to preserve the
original Unicode character code points, and to *not* perform any automatic
transformation to any Unicode Normal Forms (such as NFD, NFC, NFKD, NFKC).
If users wish to have any such normalization performed, they must perform
it explicitly as a separate operation from the MUON parsing.

It is mandatory for every MUON parser to reject input, and for every MUON
generator to not produce output, that has character code points
corresponding to integers outside the set `[0..0xD7FF,0xE000..0x10FFFF]`.

However, as an exception to the prior rules, every MUON parser must instead
automatically normalize/correct situations with input where logical Unicode
non-BMP code points are represented by a well-formed ordered pair of
Unicode surrogate code points corresponding to integers in the set
`[0xD800..0xDFFF]`, replacing each pair with the appropriate non-BMP single
code point.  But any surrogate code points that aren't part of such a pair
are still an error and must be rejected.  And every MUON generator still
must not output any Unicode surrogate code points even within such a pair.

It is mandatory for every MUON parser to *not* automatically replace
non-well-formed characters or octets with the Unicode Replacement Character
`0xFFFD`, and they must instead reject that input.
If users wish to have any such substitutions performed, they must perform
it explicitly as a separate operation from the MUON parsing.
However, a MUON parser is allowed to support optional user-configuration
where users can specify how such substitutions are performed, which then is
the behavior instead of rejecting the input.  However, in the absense of
users providing this optional configuration, rejection must be the default.

While MUON conceivably could be represented using a wide-variety of
character encodings, for example variants of UTF-16 or Latin1, the
rationale for forbidding these is mainly to help keep MUON parser/generator
implementations simpler, and because MUON became officially finalized
during a time period where UTF-8 already is widely supported and any first
implementations of a MUON parser/generator should have no excuse in not
supporting UTF-8.

This means that a MUON parser does not need to have logic to detect which
of several character encodings are in use in order to pick one for correct
interpretation of the *parsing unit*, and instead it only has to try
treating the input as UTF-8 and fail if it isn't.  This likewise means that
the MUON specification document doesn't need to define special syntax for
explicit declarations of what character encoding is in use to help parsers.

Strictly speaking the door is not closed for a future version of the MUON
specification to support character encoding declarations, or for a future
MUON parser to natively support other character encoding formats, but in
the foreseeable future, forbidding this is best for simplicity.

[RETURN](#TOP)

<a name="COMMON-QUALITIES-OF-THE-GRAMMAR"></a>

# COMMON QUALITIES OF THE GRAMMAR

The syntax and intended interpretation of the grammar itself seen in this
document part should match that of the user-defined grammars feature of the
Raku language, which is described by
<https://docs.raku.org/language/grammars>.

Any references like `<foo>` in either the grammar itself or in the written
documentation specifically refer to the corresponding grammar token `foo`.

See also the bundled actual Raku module
[grammars/Raku/lib/Muldis/Object_Notation_Grammar_Reference/Plain_Text.rakumod](
../grammars/Raku/lib/Muldis/Object_Notation_Grammar_Reference/Plain_Text.rakumod)
which has an executable copy of the grammar.

[RETURN](#TOP)

<a name="PARSING-UNIT"></a>

# PARSING UNIT

A MUON *parsing unit* is represented in the grammar by
`<Muldis_Object_Notation_Plain_Text>`.

Grammar:

```
    token Muldis_Object_Notation_Plain_Text
    {
        <sp>? ~ <sp>? <Any>
    }
```

[RETURN](#TOP)

<a name="DIVIDING-SPACE"></a>

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
        '`'
        <!before Muldis_Object_Notation_Sync_Mark '`'>
        <-[`]>*
        '`'
        <!before Muldis_Object_Notation_Sync_Mark '`'>
    }
```

A `<sp>` represents *dividing space* that may be used to visually format
MUON for readability (with line breaks and line indentation), or to embed
comments, without changing its meaning.  A superset of the MUON grammar
might require *dividing space* to disambiguate the boundaries of
otherwise-consecutive grammar tokens, but plain MUON does not.

As a special case, a MUON *parsing unit* is expressly forbidden from
containing anywhere the exact character string
`` `Muldis_Object_Notation_Sync_Mark` `` (but the ASCII alphanumeric string
`Muldis_Object_Notation_Sync_Mark` without bounding `` ` `` is ok).
This is because that string is reserved for use as a MUON *aggregate
self-synchronization mark* (*assm*) that marks any boundary of a *parsing
unit* within a *parsing unit aggregate*, a boundary which a *parsing unit*
by definition would never cross over, and therefore can not contain.

A special feature of MUON is that any unrestrained-length literal or
identifier may be split into multiple segments
separated by dividing space.  This segmenting ability is provided to
support code that contains very long numeric or stringy literals while
still being well formatted (no extra long lines).
See the grammar sections for `<Integer>`, `<Rational>`, `<Bits>`, `<Blob>`,
`<Text>` for more details on how this specifically applies to them.

[RETURN](#TOP)

<a name="ALGEBRAIC-DATA-TYPE-POSSREPS"></a>

# ALGEBRAIC DATA TYPE POSSREPS

[RETURN](#TOP)

<a name="Any---Universal-Type-Possrep"></a>

## Any / Universal Type Possrep

An **Any** artifact has the dedicated concrete literal format
described by `<Any>`.

Grammar:

```
    token Any
    {
          <Ignorance>
        | <Boolean>
        | <Integer>
        | <Rational>
        | <Binary>
        | <Decimal>
        | <Bits>
        | <Blob>
        | <Text>
        | <Nesting>
        | <Pair>
        | <Lot>
        | <Kit>
    }
```

[RETURN](#TOP)

<a name="None---Empty-Type-Possrep"></a>

## None / Empty Type Possrep

A **None** artifact doesn't exist, but is mentioned for parity.

[RETURN](#TOP)

<a name="SIMPLE-DATA-TYPE-POSSREPS"></a>

# SIMPLE DATA TYPE POSSREPS

[RETURN](#TOP)

<a name="Ignorance"></a>

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

[RETURN](#TOP)

<a name="Boolean"></a>

## Boolean

A **Boolean** artifact has the dedicated concrete literal format
described by `<Boolean>`.

Grammar:

```
    token Boolean
    {
        0bFALSE | 0bTRUE
    }
```

Examples:

```
    0bFALSE

    0bTRUE
```

[RETURN](#TOP)

<a name="Integer"></a>

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
bases `[2,8,10,16]`, using conventional syntax.  The literal may
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

<a name="Rational"></a>

## Rational

A **Rational** artifact has the dedicated concrete literal format
described by `<Rational>`.

Grammar:

```
    token Rational
    {
        <Rational_with_radix_point> | <Rational_with_num_den>
    }

    token Rational_with_radix_point
    {
        <[+-]>? <sp>? <Rational_with_radix_point_nonsigned>
    }

    token Rational_with_radix_point_nonsigned
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

    token Rational_with_num_den
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
```

This grammar supports writing **Rational** literals in any of the numeric
bases `[2,8,10,16]`, using conventional syntax.  The literal may
optionally contain underscore characters (`_`), which exist just to help
with visual formatting, such as for `20_194/17` or `3.141_59`.

This grammar explicitly forbids leading zeros in the main body of non-zero
**Rational** literals for the same reason as with **Integer** literals.

The general form of a **Rational** literal is `numerator/denominator` such
that `[numerator,denominator]` are each integers and the literal represents
the rational number that results from evaluating the mathematical
expression `numerator/denominator`, such that `/` means divide.

While the general format `numerator/denominator` can represent
every rational number, the alternate but typical
format `x.x` can only represent a proper subset of the rational numbers,
that subset being every rational number that can be represented as a
terminating decimal number.  Note that every rational number that can be
represented as a terminating binary or octal or hexadecimal number can also
be represented as a terminating decimal number.

Note that in order to keep the grammar simpler or more predictable, each
**Rational** component `[numerator,denominator]` must have its numeric base
specified individually; any component without a [`0b`,`0o`,`0x`] prefix will
be interpreted as base 10.  This keeps behaviour consistent with a parser
that sees a **Rational** literal but interprets it as multiple **Integer**
literals separated by symbolic infix operators, evaluation order aside.
Also per normal expectations, literals in the format `x.x` only specify the
base at most once in total, *not* separately for the part after the `.`.

Examples:

```
    0.0

    0/1

    1.0

    1/1

    -1.0

    -1/1

    5/3

    -4.72

    -472/100

    15_485_863/32_452_843

    `First 101 digits of transcendental number π.`
    3.14159_26535_89793_23846_26433_83279_50288_41971_69399_37510
        58209_74944_59230_78164_06286_20899_86280_34825_34211_70679

    `Mersenne Primes 2^107-1 divided by 2^127-1.`
    162259276829213363391578010288127
        /170141183460469231731687303715884105727

    `Base 16.`
    0xDEADBEEF.FACE

    `Base 8.`
    -0o35/0o3

    `Base 2.`
    0b1.1
```

[RETURN](#TOP)

<a name="Binary"></a>

## Binary

A **Binary** artifact has the dedicated concrete literal format
described by `<Binary>`.

Grammar:

```
    token Binary
    {
        <significand> <sp>? '*' <sp>? <radix_two> <sp>? '^' <sp>? <exponent>
    }

    token significand
    {
        <Rational_with_radix_point> | <Integer>
    }

    token radix_two
    {
        2
    }

    token exponent
    {
        <Integer>
    }
```

This grammar supports writing **Binary** literals in any of the numeric
bases `[2,8,10,16]`, using conventional syntax.  The literal may
optionally contain underscore characters (`_`), which exist just to help
with visual formatting, such as for `0b1.0111_0110_1*2^-0b1_1011`.

This grammar explicitly forbids leading zeros in the main body of non-zero
**Binary** literals for the same reason as with **Integer** literals.

The general form of a **Binary** literal is `significand*2^exponent` such
that `[significand,exponent]` are each integers and the literal represents
the rational number that results from evaluating the mathematical
expression `significand*(2^exponent)`, such that `*` means multiply
and `^` means exponentiate.

Note that in order to keep the grammar simpler or more predictable, each
**Binary** component `[significand,exponent]` must have its numeric base
specified individually; any component without a [`0b`,`0o`,`0x`] prefix will
be interpreted as base 10.  This keeps behaviour consistent with a parser
that sees a **Binary** literal but interprets it as multiple **Integer**
literals separated by symbolic infix operators, evaluation order aside.
Also per normal expectations, significands in the format `x.x` only specify
the base at most once in total, *not* separately for the part after the `.`.

A `<Binary>` with a `<significand>` that is a `<Rational_with_radix_point>`
is subject to the additional rule that the integer it denotes must be an
exact multiple of any power of two.  While this is always the case when
that significand has a [`0b`,`0o`,`0x`] prefix, it can easily not be the
case when that significand has either no prefix or a `0d` prefix.

Examples:

```
    0.0*2^0

    0*2^0

    1.0*2^0

    1*2^0

    -1.0*2^0

    -1*2^0

    1*2^1

    1*2^-1

    0xDEADBEEF*2^0x0

    0xD.EADBEEF*2^0x38

    0b1.011101101*2^-0b11011
```

[RETURN](#TOP)

<a name="Decimal"></a>

## Decimal

A **Decimal** artifact has the dedicated concrete literal format
described by `<Decimal>`.

Grammar:

```
    token Decimal
    {
        <significand> <sp>? '*' <sp>? <radix_ten> <sp>? '^' <sp>? <exponent>
    }

    token radix_ten
    {
        10
    }
```

This grammar supports writing **Decimal** literals in any of the numeric
bases `[2,8,10,16]`, using conventional syntax.  The literal may
optionally contain underscore characters (`_`), which exist just to help
with visual formatting, such as for `4.520_719_6*10^37`.

This grammar explicitly forbids leading zeros in the main body of non-zero
**Decimal** literals for the same reason as with **Integer** literals.

The general form of a **Decimal** literal is `significand*10^exponent` such
that `[significand,exponent]` are each integers and the literal represents
the rational number that results from evaluating the mathematical
expression `significand*(10^exponent)`, such that `*` means multiply
and `^` means exponentiate.

Note that in order to keep the grammar simpler or more predictable, each
**Decimal** component `[significand,exponent]` must have its numeric base
specified individually; any component without a [`0b`,`0o`,`0x`] prefix will
be interpreted as base 10.  This keeps behaviour consistent with a parser
that sees a **Decimal** literal but interprets it as multiple **Integer**
literals separated by symbolic infix operators, evaluation order aside.
Also per normal expectations, significands in the format `x.x` only specify
the base at most once in total, *not* separately for the part after the `.`.

Examples:

```
    0.0*10^0

    0*10^0

    1.0*10^0

    1*10^0

    -1.0*10^0

    -1*10^0

    1*10^1

    1*10^-1

    -4.72*10^0

    -472*10^-2

    4.5207196*10^37

    45207196*10^30
```

[RETURN](#TOP)

<a name="Bits"></a>

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
bases `[2,8,16]`, using semi-conventional syntax.  The literal may
optionally contain underscore characters (`_`), which exist just to help
with visual formatting, such as for `0bb00101110_100010`.

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
bases `[2,16,64]`, using semi-conventional syntax.  The literal may
optionally contain underscore characters (`_`), which exist just to help
with visual formatting, such as for `0xxA705_E416`.

A `<Blob>` is subject to the additional rule that any `=` characters may
only appear at the very end of it.

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

A **Text** artifact has the dedicated concrete literal format
described by `<Text>`.

Grammar:

```
    token Text
    {
        <quoted_text> | <nonquoted_alphanumeric_text> | <code_point_text>
    }

    token Text_nonqualified
    {
        <quoted_text> | <nonquoted_alphanumeric_char_seq> | <code_point>
    }

    token quoted_text
    {
        <quoted_text_segment>+ % <sp>?
    }

    token quoted_text_segment
    {
        '"' ~ '"' <aescaped_char>*
    }

    token aescaped_char
    {
          <restricted_nonescaped_char>
        | <escaped_char_simple>
        | <escaped_char_cpt_seq>
        | <escaped_char_utf32_cpt_seq>
        | <escaped_char_utf16_cpt_seq>
    }

    token restricted_nonescaped_char
    {
        <-[ \x[0]..\x[1F] " \\ ` \x[7F] \x[80]..\x[9F] ]>
    }

    token escaped_char_simple
    {
        '\\' <[abtnvfreqkg]>
    }

    token escaped_char_cpt_seq
    {
        '\\' ['(' ~ ')' <code_point>]
    }

    token escaped_char_utf32_cpt_seq
    {
        '\\' U00 [<[ 0..9 A..F a..f ]> ** 6]
    }

    token escaped_char_utf16_cpt_seq
    {
        '\\' u [<[ 0..9 A..F a..f ]> ** 4]
    }

    token nonquoted_alphanumeric_text
    {
        ':' <sp>? <nonquoted_alphanumeric_char_seq>
    }

    token nonquoted_alphanumeric_char_seq
    {
        <[ A..Z _ a..z ]> <[ 0..9 A..Z _ a..z ]>*
    }

    token code_point_text
    {
        ':' <sp>? <code_point>
    }

    token code_point
    {
          [0b    [0 | [   1            <[ 0..1      ]> ** 0..20]]]
        | [0o    [0 | [<[ 1..7      ]> <[ 0..7      ]> ** 0..6 ]]]
        | [[0d]? [0 | [<[ 1..9      ]> <[ 0..9      ]> ** 0..6 ]]]
        | [0x    [0 | [<[ 1..9 A..F ]> <[ 0..9 A..F ]> ** 0..5 ]]]
    }
```

The meaning of `<nonquoted_alphanumeric_char_seq>` is exactly the same as if
the same characters were surrounded by quotation marks.

This grammar explicitly forbids leading zeros in the main body of non-zero
`<code_point>` for consistency with **Integer** literals.

A `<code_point>` is subject to the additional rule that the
non-negative integer it denotes must be in the set
`[0..0xD7FF,0xE000..0x10FFFF]`.

An `<escaped_char_utf32_cpt_seq>` is subject to the additional rule that
the integer it denotes must be in the set `[0..0xD7FF,0xE000..0x10FFFF]`.

A `<quoted_text_segment>` is subject to the additional rule that if it has
any `<escaped_char_utf16_cpt_seq>` then it must denote *well formed UTF-16*
as further described below.

The meanings of the simple character escape sequences are:

```
    Esc | Unicode    | Unicode         | Chr | Literal character used
    Seq | Code Point | Character Name  | Lit | for when not escaped
    ----+------------+-----------------+-----+-----------------------------
    \a  | 0x7      7 | BELL            |     | not used
    \b  | 0x8      8 | BACKSPACE       |     | not used
    \t  | 0x9      9 | CHAR... TAB...  |     | dividing space horizontal tab
    \n  | 0xA     10 | LINE FEED (LF)  |     | dividing space line feed / newline
    \v  | 0xB     11 | LINE TABULATION |     | not used
    \f  | 0xC     12 | FORM FEED (FF)  |     | not used
    \r  | 0xD     13 | CARR. RET. (CR) |     | dividing space carriage return
    \e  | 0x1B    27 | ESCAPE          |     | not used
    \q  | 0x22    34 | QUOTATION MARK  | "   | delimit quoted-Text/identifier literals
    \k  | 0x5C    93 | REVERSE SOLIDUS | \   | not used
    \g  | 0x60    96 | GRAVE ACCENT    | `   | delimit dividing space comments
```

There are 3 complex escape sequences that support specifying characters in
terms of their Unicode code point number.  One benefit of these is to
empower more elegant passing of Unicode-savvy MUON through a communications
channel that is more limited, such as to 7-bit ASCII.

An `<escaped_char_cpt_seq>` is the MUON-specific standard format, `\(...)`,
that is the most consistent with the rest of MUON and supports writing
a code point number in any of the numeric bases 2/8/10/16.

An `<escaped_char_utf32_cpt_seq>` is an alternate format, `\U00HHHHHH`
which denotes an unsigned 32-bit integer; it supports writing a code point
number in base-16 only, but using both upper-case and lower-case letters.
This format exists to match a support common in other programming languages.

An `<escaped_char_utf16_cpt_seq>` is an alternate format, `\uHHHH` which
denotes an unsigned 16-bit integer, which supports specifying characters in
terms of UTF-16.  For a Unicode BMP code point, that is a single `\uHHHH`
integer in the non-surrogate set `[0..0xD7FF,0xE000..0xFFFF]`.  For a
Unicode non-BMP code point, that is an ordered pair of `\uHHHH` integer in
the surrogate set `[0xD800..0xDFFF]`, which looks like `\uHHHH\uHHHH` such
that the pair is also *well formed UTF-16*.  It is forbidden for a
`<quoted_text_segment>` to contain any `\uHHHH` of the surrogate set that
isn't so paired.  This format supports writing a code point number in
base-16 only, but using both upper-case and lower-case letters.
This format exists to match a support common in other programming languages.

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

    `One positional nonquoted Text (or, the first positional attribute).`
    :0

    `Same Text value (or, one positional attr written in format of a named).`
    "\(0)"

    `Another positional nonquoted Text (or, the second positional attribute).`
    :1

    "Ceres"

    "⨝"

    "サンプル"

    "This isn't not escaped.\n"

    `Two characters specified in terms of Unicode code-point numbers.`
    "\(0x263A)\(65)"

    `Same thing.`
    "\u263A\u0041"

    `One non-positional quoted Text (or, one named attribute).`
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
        ['::' <sp>? <Text_nonqualified>]
    }

    token nesting_nary
    {
        ['::' <sp>?]?
        [<Text_nonqualified> ** 2..* % [<sp>? '::' <sp>?]]
    }
```

Examples:

```
    ::""

    ::0

    ::person

    person::birth_date

    person::birth_date::year

    the_db::stats::"samples by order"
```

[RETURN](#TOP)

<a name="COLLECTIVE-DATA-TYPE-POSSREPS"></a>

# COLLECTIVE DATA TYPE POSSREPS

[RETURN](#TOP)

<a name="Pair"></a>

## Pair

A **Pair** artifact has the dedicated concrete literal format
described by `<Pair>`.

Grammar:

```
    token Pair
    {
        ['(' <sp>?] ~ [<sp>? ')'] <this_and_that>
    }

    token this_and_that
    {
        <this> <sp>? [':'|'->'] <sp>? <that>
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
    `Pair of Ignorance.`
    (0iIGNORANCE: 0iIGNORANCE)

    `Pair of Integer.`
    (5: -3)

    `Pair of Text.`
    ("First Name": "Joy")

    `Another Pair.`
    ("x":"y")

    `Same thing.`
    ("x"->"y")

    `Higher-level Article type.`
    (:Article : (::Point : {x : 5, y : 3}))

    `Higher-level Article type.`
    (:Article : (::Float : {
        significand : 45207196,
        radix       : 10,
        exponent    : 37,
    }))

    `Higher-level Article type.`
    (:Article : (the_db::UTC_Date_Time : {
        year   : 2003,
        month  : 10,
        day    : 26,
        hour   : 1,
        minute : 30,
        second : 0.0,
    }))

    `Higher-level Article type.`
    (:Article : (::Positive_Infinity : {}))

    `Higher-level Article type.`
    (:Article : (::Negative_Zero : {}))

    `Higher-level Excuse type.`
    (:Excuse : (::Input_Field_Wrong : {name : "Your Age"}))

    `Higher-level Excuse type.`
    (:Excuse : (::Div_By_Zero : {}))

    `Higher-level Excuse type.`
    (:Excuse : (::No_Such_Attr_Name : {}))

    `Higher-level Calendar_Duration type: Addition of 2 years and 3 months.`
    (:Calendar_Duration : {y:2,m:3,d:0,h:0,i:0,s:0})

    `Higher-level Calendar_Duration type: Subtraction of 22 hours.`
    (:Calendar_Duration : {y:0,m:0,d:0,h-22,i:0,s:0})

    `Higher-level Calendar_Instant type: The Day The Music Died (if paired with Gregorian calendar).`
    (:Calendar_Instant : {y:1959,m:2,d:3})

    `Higher-level Calendar_Instant type: A time of day when one might have breakfast.`
    (:Calendar_Instant : {h:7,i:30,s:0})

    `Higher-level Calendar_Instant type: What was now in the Pacific zone (if paired with Gregorian calendar).`
    (:Calendar_Instant : ({y:2018,m:9,d:3,h:20,i:51,s:17}:{h:-8,i:0,s:0}))

    `Higher-level Calendar_Instant type: A time of day in the UTC zone on an unspecified day.`
    (:Calendar_Instant : ({h:9,i:25,s:0}:{h:0,i:0,s:0}))

    `Higher-level Calendar_Instant type: A specific day and time in the Pacific Standard Time zone.`
    (:Calendar_Instant : ({y:2001,m:4,d:16,h:20,i:1,s:44}:"PST"))
```

[RETURN](#TOP)

<a name="Lot"></a>

## Lot

A **Lot** artifact has the dedicated concrete literal format
described by `<Lot>`.

Grammar:

```
    token Lot
    {
        ['[' <sp>?] ~ [<sp>? ']']
            [
                [',' <sp>?]?
                [<multiplied_member>+ % [<sp>? ',' <sp>?]]
                [<sp>? ',']?
            ]?
    }

    token multiplied_member
    {
        [<member> <sp>? [':'|'->'] <sp>? <multiplicity>] | <member>
    }

    token member
    {
        <Any>
    }

    token multiplicity
    {
        <Any>
    }
```

The meaning of a `<multiplied_member>` consisting of only a `<member>` is
exactly the same as if the former also had a `<multiplicity>` of 1.

Examples:

```
    `Zero members.`
    []

    `One member.`
    [ "The lonely only." ]

    `Four members.`
    [
        "Clubs"  :  5,
        "Diamonds",
        "Hearts" : 10,
        "Spades" : 20,
    ]

    `Higher-level Array type: Three members.`
    (:Array : [
        "Alphonse",
        "Edward",
        "Winry",
    ])

    `Higher-level Array type: 32 members (28 duplicates in 2 runs).`
    (:Array : [
        "/",
        "*" : 20,
        "+" : 10,
        "-",
    ])

    `Higher-level Set type: Four members (no duplicates).`
    (:Set : [
        "Canada",
        "Spain",
        "Jordan",
        "Jordan",
        "Thailand",
    ])

    `Higher-level Bag type: Zero members.`
    (:Bag : [])

    `Higher-level Bag type: One member.`
    (:Bag : [ "I hear that!": 1 ])

    `Higher-level Bag type: 1200 members (1197 duplicates).`
    (:Bag : [
        "Apple"  : 500,
        "Orange" : 300,
        "Banana" : 400,
    ])

    `Higher-level Bag type: Six members (2 duplicates).`
    (:Bag : [
        "Foo" : 1,
        "Quux" : 1,
        "Foo" : 1,
        "Bar" : 1,
        "Baz" : 1,
        "Baz" : 1,
    ])

    `Higher-level Mix type: Zero members; we measured zero of nothing in particular.`
    (:Mix : [])

    `Higher-level Mix type: One member; one gram of mass.`
    (:Mix : [::Gram: 1.0])

    `Higher-level Mix type: 29.95 members (28.95 duplicates); the cost of a surgery.`
    (:Mix : [::USD: 29.95])

    `Higher-level Mix type: 9.8 members; acceleration under Earth's gravity.`
    (:Mix : [::Meter_Per_Second_Squared: 9.8])

    `Higher-level Mix type: 0.615 members (fractions of 3 distinct members); recipe.`
    (:Mix : [
        ::Butter : 0.22,
        ::Sugar  : 0.1,
        ::Flour  : 0.275,
        ::Sugar  : 0.02,
    ])

    `Higher-level Mix type: 4/3 members (fractions of 3 distinct members); this-mix.`
    (:Mix : [
        Sugar: 1/3,
        Spice: 1/4,
        All_Things_Nice: 3/4,
    ])

    `Higher-level Mix type: -1.5 members; adjustment for recipe.`
    (:Mix : [
        Rice: +4.0,
        Beans: -5.7,
        Carrots: +0.2,
    ])
```

[RETURN](#TOP)

<a name="Kit"></a>

## Kit

A **Kit** artifact has the dedicated concrete literal format
described by `<Kit>`.

Grammar:

```
    token Kit
    {
        ['{' <sp>?] ~ [<sp>? '}']
            [
                [',' <sp>?]?
                [
                      [
                        [<kit_attr_a> ** 1..32 % [<sp>? ',' <sp>?]?]
                        [<sp>? ',' <sp>? <kit_attr_na>+ % [<sp>? ',' <sp>?]]?
                      ]
                    | [<kit_attr_na>+ % [<sp>? ',' <sp>?]]
                ]
                [<sp>? ',']?
            ]?
    }

    token kit_attr_na
    {
        <attr_name> <sp>? [':'|'->'] <sp>? <attr_asset>
    }

    token kit_attr_a
    {
        <attr_asset>
    }

    token attr_name
    {
        <Text_nonqualified>
    }

    token attr_asset
    {
        <Any>
    }
```

The meaning of a `<kit_attr_a>` (consisting of only an `<attr_asset>`) is
exactly the same as if the former also had an `<attr_name>` of the form
`N` such that `N` is the zero-based ordinal position of the
`<kit_attr_a>` in the `<kit_attrs>` among all sibling such `<kit_attr_a>`.
These *attribute name* are determined without regard to the explicit
*attribute name* of any `<kit_attr_na>` that a `<kit_attrs>` may contain,
and it is invalid for any explicit names to duplicate any implicit or
explicit names.

Examples:

```
    `Zero attributes.`
    {}

    `One named attribute.`
    {"First Name": "Joy"}

    `One positional attribute.`
    {53}

    `Same thing.`
    {0: 53}

    `Same thing.`
    {"\(0)": 53}

    `Three named attributes.`
    {
        login_name : "hartmark",
        login_pass : "letmein",
        is_special : 0bTRUE,
    }

    `Three positional attributes.`
    {"hello",26,0bTRUE}

    `One of each.`
    {"Jay", age: 10}

    `A non-Latin name.`
    {"サンプル": "https://example.com"}

    `Higher-level Renaming type: Rename one attribute.`
    (:Renaming : {fname->:first_name})

    `Higher-level Renaming type: Same thing.`
    (:Renaming : {fname : :first_name})

    `Higher-level Renaming type: Swap 2 named attributes.`
    (:Renaming : {foo->:bar,bar->:foo})

    `Higher-level Renaming type: Convert positional names to nonpositional.`
    (:Renaming : {:foo,:bar})

    `Higher-level Renaming type: Same thing.`
    (:Renaming : {0->:foo,1->:bar})

    `Higher-level Renaming type: Convert nonpositional names to positional.`
    (:Renaming : {foo->:0,bar->:1})

    `Higher-level Renaming type: Swap 2 positional attributes.`
    (:Renaming : {0->:1,1->:0})

    `Higher-level Renaming type: Same thing.`
    (:Renaming : {:1,:0})

    `Higher-level Tuple type: Two named attributes.`
    (:Tuple : {
        name : "Michelle",
        age  : 17,
    })

    `Higher-level Tuple type: Same thing.`
    (:Tuple : (
          {"name     , "age}
        : {"Michelle", 17  }
    ))

    `Higher-level Relation type: Zero attributes + zero tuples.`
    (:Relation : {})

    `Higher-level Relation type: Same thing.`
    (:Relation : ({}:[]))

    `Higher-level Relation type: Zero attributes + one tuple.`
    (:Relation : [{}])

    `Higher-level Relation type: Same thing.`
    (:Relation : ({}:[{}]))

    `Higher-level Relation type: Three named attributes + zero tuples.`
    (:Relation : {:x,:y,:z})

    `Higher-level Relation type: Three positional attributes + zero tuples.`
    (:Relation : {:0,:1,:2})

    `Higher-level Relation type: Two named attributes + two tuples.`
    (:Relation : [
        {name: "Michelle", age: 17},
        {name: "Amy"     , age: 14},
    ])

    `Higher-level Relation type: Same thing.`
    (:Relation : (
            {:name     , :age}
        : [
            {"Michelle", 17  },
            {"Amy"     , 14  },
        ]
    ))

    `Higher-level Relation type: Two positional attributes + two tuples.`
    (:Relation : [
        {"Michelle", 17},
        {"Amy"     , 14},
    ])

    `Higher-level Relation type: Some people records.`
    (:Relation : [
        {name : "Jane Ives", birth_date : (:Calendar_Instant : {y:1971,m:11,d:6}),
            phone_numbers : (:Set : ["+1.4045552995", "+1.7705557572"])},
        {name : "Layla Miller", birth_date : (:Calendar_Instant : {y:1995,m:8,d:27}),
            phone_numbers : (:Set : [])},
        {name : "岩倉 玲音", birth_date : (:Calendar_Instant : {y:1984,m:7,d:6}),
            phone_numbers : (:Set : ["+81.9072391679"])},
    ])

    `Higher-level Relation type: Same thing.`
    (:Relation : (
            {:name         , :birth_date                            , :phone_numbers}
        : [
            {"Jane Ives"   , (:Calendar_Instant : {y:1971,m:11,d:6}), (:Set : ["+1.4045552995", "+1.7705557572"])},
            {"Layla Miller", (:Calendar_Instant : {y:1995,m:8,d:27}), (:Set : [])},
            {"岩倉 玲音", (:Calendar_Instant : {y:1984,m:7,d:6}), (:Set : ["+81.9072391679"])},
        ]
    ))
```

[RETURN](#TOP)

<a name="RESERVED-UNUSED-SYNTAX"></a>

# RESERVED UNUSED SYNTAX

Muldis Object Notation reserves the use of certain syntaxes for various
reasons.  In some cases it doesn't use those syntaxes now but wants to
prevent other superset grammars of MUON from defining their own meanings,
regardless of whether MUON might use them in the future itself.  In other
cases it doesn't use those syntaxes expressly in order to empower superset
grammars to define their own meanings.

[RETURN](#TOP)

<a name="Possrep-Heuristics"></a>

## Possrep Heuristics

The following table indicates the basic heuristics for how each
possrep is recognized within a valid Muldis Object Notation artifact:

```
    Possrep/partial | Possrep Instead Identified By
    ----------------+---------------------------------------------
    Ignorance       | prefix 0i followed by IGNORANCE
    Boolean         | prefix 0b followed by FALSE or TRUE
    Integer         | optional prefix +|- and leading 0..9
                    |     and without any ./*^
                    |     and no prefix 0[i|t] or 0b[F|T] or 0[b|x][a..z]
    Rational        | optional prefix +|- and leading 0..9
                    |     and with . but no * or ^
                    |         or with / but no prefix 0xy
    Binary          | optional prefix +|- and leading 0..9 and with *2^
    Decimal         | optional prefix +|- and leading 0..9 and with *10^
    Bits            | prefix 0bb or 0bo or 0bx
    Blob            | prefix 0xb or 0xx or 0xy
    Text            | only "" or "..." or prefix : but no prefix ::
    Nesting         | prefix ::, or :: between 2 of,
                    |     what otherwise is Text sans prefix :
    Pair            | (...)
    Lot             | only [] or [...]
    Kit             | only {} or {...}
```

[RETURN](#TOP)

<a name="Features-Reserved-For-Superset-Grammars"></a>

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
sole exception of a `-` or `+` symbol.

MUON *always* defines character string literals to either be double-quoted
or to begin with a `:` or to begin with or contain a `::`.

MUON leaves all generic-context alphanumeric barewords, that start with a
simple letter or underscore, free for a superset grammar to use.
MUON only uses such barewords either combined with a `:` or `::`
or within bracketing pairs.

MUON doesn't use any generic-context symbolic barewords, but if it did then
it would group them into a single namespace defined by a leading `\` which
frees up all other possible symbol sequences to be defined by the superset;
as it isn't typical for any languages to use a `\` for their symbolic
operator names, the languages can be natural.

While MUON also has some free `.+-*/^`, those only appear adjacent to
numeric barewords and are considered part of those numeric literals, and so
shouldn't interfere with a superset using those for regular operators.

Likewise, any uses of `->` or `,` are only used by MUON within various
kinds of bracketing pairs and a superset should be able to also use them.

MUON has some free `:` and `::` but both only appear in identifier literals
but that `:` also otherwise only appears within bracketing pairs;
a superset should be able to use them in non-conflicting generic scenarios.

MUON does not use the single-quote string delimiter character `'` for
anything, and leaves it reserved for a superset to use as it sees fit.

MUON does not use the semicolon `;` for anything, so a superset grammar can
use it for things like separating statements and thus disambiguating its
own uses of bracketing characters to define statement or expression groups.

MUON does not use parenthesis pairs `(` and `)`,
except with a colon/etc (`:`/`->`)
between them as a `Pair` syntax, so parenthesis pairs without the colon/etc
are available for a superset grammar to use for generic grouping purposes
to force a particular parsing precedence with infix operators and such.

[RETURN](#TOP)

<a name="SYNTACTIC-MNEMONICS"></a>

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
    ()    | pair collections       | * delimit Pair selectors
    ------+------------------------+---------------------------------------
    []    | discrete collections   | * delimit homogeneous discrete collections
          |                        |   of members, concept asset+cardinal pairs
          |                        | * delimit Lot selectors
    ------+------------------------+---------------------------------------
    {}    | attribute collections  | * delimit heterogeneous aordered collections
          |                        |   of attributes, concept nominal+asset pairs
          |                        | * delimit Kit selectors
    ------+------------------------+---------------------------------------
    :     | pairings               | * indicates a pairing context
    ->    |                        | * separates the 2 parts of a pair
          |                        | * this/that separator in Pair sels
          |                        | * optional m-m member/multiplicity sep in Lot sels
          |                        | * optional attr name/asset separator in Kit sels
    :     | identifiers            | * prefix of a Text literal in non-quoted formats
          |                        | * disambiguate Text from Nesting
    ------+------------------------+---------------------------------------
    ,     | list builders          | * separates collection elements
          |                        | * separate multiplied-members in Lot sels
          |                        | * separate attributes in Kit sels
    ------+------------------------+---------------------------------------
    ::    | nestings               | * prefix or separate elements of a Nesting literal
          |                        | * disambiguate Nesting from Text
    ------+------------------------+---------------------------------------
    *     | generics/whatever      | * indicates a generic type context
          | multiplication         | * significand/radix separator in Binary/Decimal literals
          |                        | * disambiguate Binary/Decimal lit from Integer/Rational lit
    ------+------------------------+---------------------------------------
    +     | addition               | * optional indicates positive-Integer/Rational literal
    ------+------------------------+---------------------------------------
    -     | subtraction            | * indicates negative-Integer/Rational literal
    ------+------------------------+---------------------------------------
    .     | radix point            | * disambiguate Rational lit from Integer lit
    ------+------------------------+---------------------------------------
    /     | rationals/measures     | * indicates a fractional quantifying/count context
          | division               | * disambiguate Rational lit from Integer lit
          |                        | * numerator/denominator separator in Rational literals
    ------+------------------------+---------------------------------------
    ^     | exponentiation         | * radix/exponent separator in Binary/Decimal literals
          |                        | * disambiguate Binary/Decimal lit from Integer/Rational lit
    ------+------------------------+---------------------------------------
    digit | number/enumeration     | * first char 0..9 in bareword indicates is number/code-point/Bits/Blob/enumeration
    ------+------------------------+---------------------------------------
    0i    | ignorance              | * prefix for Ignorance literal
    ------+------------------------+---------------------------------------
    0b    | boolean                | * prefix for Boolean literal
          | base-2                 | * indicates base-2/binary notation
          |                        | * prefix for Integer or Rational-part in base-2
          | bit string             | * prefix for Bits literals; 0bb/0bo/0bx means in base-2/8/16
    ------+------------------------+---------------------------------------
    0o    | base-8                 | * indicates base-8/octal notation
          |                        | * prefix for Integer or Rational-part in base-8
    ------+------------------------+---------------------------------------
    0d    | base-10                | * indicates base-10/decimal notation
          |                        | * optional prefix for Integer or Rational-part in base-10
    ------+------------------------+---------------------------------------
    0x    | base-16                | * indicates base-16/hexadecimal notation
          |                        | * prefix for Integer or Rational-part in base-16
          | octet string           | * prefix for Blob literals; 0xb/0xx/0xy means in base-2/16/64
    ------+------------------------+---------------------------------------
```

Some of the above mnemonics also carry additional meanings in a wider
**Muldis Data Language** context, but those are not described here.

[RETURN](#TOP)

<a name="NESTING-PRECEDENCE-RULES"></a>

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

[RETURN](#TOP)

<a name="Quoted-Strings"></a>

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

[RETURN](#TOP)

<a name="Symbolic-Delimiters-Separators-Indicators"></a>

## Symbolic Delimiters/Separators/Indicators

Anywhere outside of a quoted string that these specific symbolic sequences
appear, each one is its own indivisible token that is not part of any
bareword or numeric-format literal;
when any of these sequences overlap, longest token always wins:

```
    (
    )
    [
    ]
    {
    }
    :
    ->
    ,
    ::
```

The symbolic sequence `:` is special and has either of 2 different possible
meanings, which are indicating a **Text** literal as well as being a pair
separator within a bracketed pair.  The design of MUON should preclude any
ambiguous situations where it isn't clear which of these meanings a `:` has.

[RETURN](#TOP)

<a name="Barewords-and-Numeric-Format-Literals"></a>

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

For example, an unquoted `- 29 * 10 ^ - 6` will be interpreted as a
single `Decimal` value and not 3 integers separated by operators.

It is expected that any programming languages whose grammar is a superset
of MUON's will also keep this precedence over any actual prefix/infix/etc
operators they may have, which in some cases may require the superset
grammar to have some kind of additional syntax, perhaps a pair of
parenthesis without a colon between them, to disambiguate that they want
those operator calls instead.

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
