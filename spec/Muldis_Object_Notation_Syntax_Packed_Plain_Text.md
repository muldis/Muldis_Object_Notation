<a name="TOP"></a>

# NAME

Muldis Object Notation (MUON) - Source code and data interchange format

# VERSION

The fully-qualified name of this document is
`Muldis_Object_Notation https://muldis.com 0.400.0`.

# PART

This artifact is part 8 of 22 of the document
`Muldis_Object_Notation https://muldis.com 0.400.0`;
its part name is `Syntax_Packed_Plain_Text`.

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
    - [Text](#Text)
    - [Name](#Name)
    - [Nesting / Attribute Name List](#Nesting---Attribute-Name-List)
- [COLLECTIVE DATA TYPE POSSREPS](#COLLECTIVE-DATA-TYPE-POSSREPS)
    - [Pair](#Pair)
    - [Lot](#Lot)
    - [Kit](#Kit)
- [GLOSSARY OF OCTETS](#GLOSSARY-OF-OCTETS)
- [AUTHOR](#AUTHOR)
- [LICENSE AND COPYRIGHT](#LICENSE-AND-COPYRIGHT)

[RETURN](#TOP)

<a name="SYNOPSIS"></a>

# SYNOPSIS

Common "named relation" format with attribute names repeating per tuple.

```
    P N"Muldis_Object_Notation_Syntax" P M[T"Packed_Plain_Text" T"https://muldis.com" T"0.400.0"]
        P N"Muldis_Object_Notation_Model" P M[T"Muldis_Data_Language" T"https://muldis.com" T"0.400.0"]
            P N"Relation" M[
                K[xname T"Jane Ives"
                    N"birth_date" P N"Calendar_Instant" K[uy e\07\B3 um q ud 6]
                    N"phone_numbers" P wSet M[T"+1.4045552995" T"+1.7705557572"]]
                K[xname T"Layla Miller"
                    N"birth_date" P N"Calendar_Instant" K[uy e\07\CB um 8 ud c\1B]
                    N"phone_numbers" P wSet l]
                K[xname T"\E5\B2\A9\E5\80\89 \E7\8E\B2\E9\9F\B3"
                    N"birth_date" P N"Calendar_Instant" K[uy e\07\C0 um 7 ud 6]
                    N"phone_numbers" P wSet M[T"+81.9072391679"]]
            ]
```

Alternate "positional relation" format with attribute names declared
once between all tuples.

```
    P N"Muldis_Object_Notation_Syntax" P M[T"Packed_Plain_Text" T"https://muldis.com" T"0.400.0"]
        P N"Muldis_Object_Notation_Model" P M[T"Muldis_Data_Language" T"https://muldis.com" T"0.400.0"]
            P N"Relation" P
                    J[xname N"birth_date" N"phone_numbers"]
                M[
                    J[T"Jane Ives"
                        P N"Calendar_Instant" K[uy e\07\B3 um q ud 6]
                        P wSet M[T"+1.4045552995" T"+1.7705557572"]]
                    J[T"Layla Miller"
                        P N"Calendar_Instant" K[uy e\07\CB um 8 ud c\1B]
                        P wSet l]
                    J[T"\E5\B2\A9\E5\80\89 \E7\8E\B2\E9\9F\B3"
                        P N"Calendar_Instant" K[uy e\07\C0 um 7 ud 6]
                        P wSet M[T"+81.9072391679"]]
                ]
```

[RETURN](#TOP)

<a name="DESCRIPTION"></a>

# DESCRIPTION

This document consists of multiple parts; for a directory to all of the
parts, see [Overview](Muldis_Object_Notation.md).

This part of the **Muldis Object Notation** document specifies the
canonical concrete nonhosted packed plain text syntax of MUON,
which expresses a MUON artifact in terms of an octet string
conforming to a well-defined pattern,
which can exist as a raw file in a filesystem or be exchanged over a
network or exist in memory of any program as an octet string value.

The MUON `Syntax_Packed_Plain_Text` is derived from and maps with the MUON
[Syntax_Abstract](Muldis_Object_Notation_Syntax_Abstract.md); see that plus
[Semantics](Muldis_Object_Notation_Semantics.md) for further context.

The MUON canonical packed plain text format is semi-lightweight and designed to
support interchange of source code and data between any 2 environments that
do not have a common working memory, such as because they are distinct
machine processes written in different programming languages, or because
they are on distinct machines, or because they are mediated by a network or
disk file.  The format is fairly easy for machines to parse and generate.
It is *not* intended for humans to easily read and write but has aids for that.

The MUON `Syntax_Packed_Plain_Text` exists as an alternative to the MUON
[Syntax_Plain_Text](Muldis_Object_Notation_Syntax_Plain_Text.md)
under the theory that the former may be more performant for machines to
parse and generate, or may occupy fewer resources (network bandwidth,
working memory, disk space) than the latter.

The MUON Packed Plain Text format is fundamentally the same as the MUON
Plain Text format, both in what it can represent and how it represents
those things, but that it has certain key differences.  These differences
allow MUON artifacts to be represented much more compactly, using
considerably fewer octets, with the trade-off that many of those octets
don't correspond to ASCII printable characters, or to different ones.
Some design choices are such that Packed Plain Text is at least partially
human readable or writeable, but on the whole it isn't intended for that.

The prescribed standard *syntax base name* of a *syntax-qualified artifact*
for a MUON Packed Plain Text artifact is `Packed_Plain_Text`.

The prescribed standard filename extension for files featuring a MUON Packed Plain
Text parsing unit is `.muonppt`, though as per standard UNIX conventions,
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
unit* being an octet string (characterized by a sequence of
octets, each corresponding to an integer in the
set `[0..0xFF]`).  In self-defining terms, the MUON
parser proper expects a **Blob** value as input.

For the purpose of illustration, however, the grammar of this document part
treats the input *parsing unit* as if it were an ISO Latin-1 character
string; or to be specific, any octets `[0x20..0x7E]` which correspond to
printable ASCII characters or SPACE in the ISO Latin-1 encoding will
typically appear as the same character literals in the grammar, while the
other octets `[0..0x1F,0x7F..0xFF]` will be expressed as those integers.

Note that in any artifact examples, the format `\HH` is used to represent
octets that don't correspond to printable ASCII characters or SPACE; the
`HH` is a padded base-16 notation integer between `00` and `FF`; all other
appearances of `\` are followed by a letter and represent themselves.
Note that the use of `\HH` format may also be used in examples even where
not required, as sometimes using it consistently actually aids readability.

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
[grammars/Raku/lib/Muldis/Object_Notation_Grammar_Reference/Packed_Plain_Text.rakumod](
../grammars/Raku/lib/Muldis/Object_Notation_Grammar_Reference/Packed_Plain_Text.rakumod)
which has an executable copy of the grammar.

[RETURN](#TOP)

<a name="PARSING-UNIT"></a>

# PARSING UNIT

A MUON *parsing unit* is represented in the grammar by
`<Muldis_Object_Notation_Packed_Plain_Text>`.

Grammar:

```
    token Muldis_Object_Notation_Packed_Plain_Text
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
        <[ \x[0]..\x[FF] ] - [`]>*
        '`'
        <!before Muldis_Object_Notation_Sync_Mark '`'>
    }
```

A `<sp>` represents *dividing space* that may be used to visually format
MUON for readability (with line breaks and line indentation), such as that
makes sense in a binary format, or to pad it, or to embed extra octet
sequences such as ASCII comments, without changing its meaning.

As a special case, a MUON *parsing unit* is expressly forbidden from
containing anywhere the exact octet string
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
        | <Name>
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
        _
    }
```

An **Ignorance** artifact unconditionally uses just 1 octet.

Its single octet corresponds to the ASCII/UTF-8 *LOW LINE* character `_`
which visually resembles a blank space without being actual whitespace.

Examples:

```
    `Ignorance singleton (1 octet).`
    _
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
        <Boolean_false> | <Boolean_true>
    }

    token Boolean_false
    {
        '!'
    }

    token Boolean_true
    {
        '?'
    }
```

A **Boolean** artifact unconditionally uses just 1 octet.

Its single octet for *false* corresponds to the ASCII/UTF-8 *EXCLAMATION MARK*
character `!` which has a common mnemonic of logical "not".

Its single octet for *true* corresponds to the ASCII/UTF-8 *QUESTION MARK*
character `?` which has a common mnemonic of logical "so".

Examples:

```
    `Boolean false (1 octet).`
    !

    `Boolean true (1 octet).`
    ?
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
          <Integer_nonsigned>
        | <Integer_negative_one>
        | <Integer_unlimited_negative>
        | <Integer_limited_signed_1_octet>
        | <Integer_limited_signed_2_octets>
        | <Integer_limited_signed_4_octets>
        | <Integer_limited_signed_8_octets>
    }

    token Integer_nonsigned
    {
          <Integer_zero>
        | <Integer_positive_one_thru_nine>
        | <Integer_positive_ten>
        | <Integer_positive_eleven>
        | <Integer_positive_twelve>
        | <Integer_positive_one_hundred>
        | <Integer_positive_one_thousand>
        | <Integer_unlimited_positive>
        | <Integer_limited_nonsigned_1_octet>
        | <Integer_limited_nonsigned_2_octets>
        | <Integer_limited_nonsigned_4_octets>
        | <Integer_limited_nonsigned_8_octets>
    }

    token Integer_zero
    {
        0
    }

    token Integer_positive_one_thru_nine
    {
        <Integer_positive_one_thru_eight> | 9
    }

    token Integer_positive_one_thru_eight
    {
        <[ 1..8 ]>
    }

    token Integer_positive_ten
    {
        '$'
    }

    token Integer_positive_eleven
    {
        q
    }

    token Integer_positive_twelve
    {
        r
    }

    token Integer_positive_one_hundred
    {
        '%'
    }

    token Integer_positive_one_thousand
    {
        '&'
    }

    token Integer_negative_one
    {
        '#'
    }

    token Integer_unlimited_positive
    {
        '+' <sp>? <quoted_octet_seq>
    }

    token Integer_unlimited_negative
    {
        '-' <sp>? <quoted_octet_seq>
    }

    token Integer_limited_nonsigned_1_octet
    {
        c <aescaped_octet>
    }

    token Integer_limited_signed_1_octet
    {
        d <aescaped_octet>
    }

    token Integer_limited_nonsigned_2_octets
    {
        e <aescaped_octet> ** 2
    }

    token Integer_limited_signed_2_octets
    {
        f <aescaped_octet> ** 2
    }

    token Integer_limited_nonsigned_4_octets
    {
        g <aescaped_octet> ** 4
    }

    token Integer_limited_signed_4_octets
    {
        h <aescaped_octet> ** 4
    }

    token Integer_limited_nonsigned_8_octets
    {
        i <aescaped_octet> ** 8
    }

    token Integer_limited_signed_8_octets
    {
        j <aescaped_octet> ** 8
    }
```

An **Integer** artifact uses just 1 octet to canonically represent the most
commonly used integers `[-1,0,1]` as well as `[2..12,100,1000]`.  There are also
other formats for each of these integers, but they all take more octets.

The single canonical octet for each of `[0..9]` corresponds to the
ASCII/UTF-8 *DIGIT ZERO* thru *DIGIT NINE* characters `0` thru `9` so it
is visually represented by its corresponding numeric base 10 literal,
which is also identical to its canonical MUON Plain Text representation.

Its single canonical octet for `10` corresponds to the ASCII/UTF-8
*DOLLAR SIGN* character `$`.

Its single canonical octet for [`11`,`12`] corresponds to the ASCII/UTF-8
*LATIN SMALL LETTER [Q,R]* character [`q`,`r`].

Its single canonical octet for `100` corresponds to the ASCII/UTF-8
*PERCENT SIGN* character `%` which has a common mnemonic for percentages
which are rationals with a denominator of 100.

Its single canonical octet for `1000` corresponds to the ASCII/UTF-8
*AMPERSAND SIGN* character `&`.

Its single canonical octet for `-1` corresponds to the ASCII/UTF-8
*NUMBER SIGN* character `#`.

An **Integer** artifact uses 3..N octets to represent the general case of
any integer as a single sign-denoting octet followed by an unlimited length
big-endian ordered nonsigned integer literal in the numeric base 256, so
the octets `[\00..\FF]` represent `[0..255]` in each position respectively.
The octet for negative and positive sign respectively corresponds to the
ASCII/UTF-8 *HYPHEN-MINUS* and *PLUS SIGN* characters `-` and `+` so it
is visually represented as is typical in math.
The nonsigned integer literal consists of 2 delimiter octets plus 0..N base
256 positions.
Each delimiter octet corresponds to the ASCII/UTF-8 *QUOTATION MARK*
character `"` which has a common mnemonic for string quoting.
Most position octets represent themselves, but a few of the possible 256
values are instead represented by escape sequences of 2 different octets
each, so no delimiter octets appear literally in the string they delimit.
A position string allows leading zero valued octets.
An empty position string is logically equivalent to a string consisting of
exactly one zero valued octet.

An **Integer** artifact uses [2..4,3..7,5..13,9..25] octets respectively to
represent any commonly used integer as a single length-denoting octet
followed by a limited length big-endian ordered nonsigned or signed integer
literal in the numeric base 256.
The integer literal consists of [1,2,4,8] base positions and no delimiters.
All position octets are as per the unlimited length integer formats.
The octet for a big-endian nonsigned [1,2,4,8] octet integer
corresponds to the ASCII/UTF-8 *LATIN SMALL LETTER [C,E,G,I]* character
[`c`,`e`,`g`,`i`].
The octet for a big-endian two's complement signed [1,2,4,8] octet integer
corresponds to the ASCII/UTF-8 *LATIN SMALL LETTER [D,F,H,J]* character
[`d`,`f`,`h`,`j`].

Note that making special cases of single-octet representations for 100 and
1000 is rationalized by their frequent use in decimalised currencies, where
hundredths denominations are very common and thousanths are also used;
this efficiency mainly is for the benefit of **Rational** artifacts.

Examples:

```
    `Zero (1 octet).`
    0

    `Same thing (3 octets).`
    +""

    `Same thing (4 octets).`
    +"\00"

    `Same thing (3 octets).`
    -""

    `Same thing (2 octets).`
    c\00

    `Positive one (1 octet).`
    1

    `Same thing (4 octets).`
    +"\01"

    `Same thing (2 octets).`
    c\01

    `Positive three (1 octet).`
    3

    `Same thing (4 octets).`
    +"\03"

    `Same thing (2 octets).`
    c\03

    `Positive ten (1 octet).`
    $

    `Same thing (4 octets).`
    +"\0A"

    `Same thing (2 octets).`
    c\0A

    `Positive eleven (1 octet).`
    q

    `Same thing (4 octets).`
    +"\0B"

    `Same thing (2 octets).`
    c\0B

    `Positive twelve (1 octet).`
    r

    `Same thing (4 octets).`
    +"\0C"

    `Same thing (2 octets).`
    c\0C

    `Positive one-hundred (1 octet).`
    %

    `Same thing (4 octets).`
    +"\64"

    `Same thing (2 octets).`
    c\64

    `Positive one-thousand (1 octet).`
    &

    `Same thing (5 octets).`
    +"\03\E8"

    `Same thing (3 octets).`
    e\03\E8

    `Negative one (1 octet).`
    #

    `Same thing (4 octets).`
    -"\01"

    `Same thing (2 octets).`
    d\FF

    `Negative three (4 octets).`
    -"\03"

    `Same thing (2 octets).`
    d\FD

    `Positive forty-two (4 octets).`
    +"\2A"

    `Same thing (2 octets).`
    c\2A

    `USA national debt in US dollars close to midnight of 2017 Dec 31`
    `(9 octets); also known as 20_597_460_196_915.`
    +"\12\BB\B8\4C\5E\33"

    `Same thing (9 octets).`
    i\00\00\12\BB\B8\4C\5E\33

    `Dead Beef (5 octets); also known as 0xDEADBEEF.`
    g\DE\AD\BE\EF
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
          <Rational_negative_one>
        | <Rational_zero>
        | <Rational_positive_one>
        | <Rational_with_num_den>
    }

    token Rational_negative_one
    {
        '<'
    }

    token Rational_zero
    {
        '='
    }

    token Rational_positive_one
    {
       '>'
    }

    token Rational_with_num_den
    {
        '/' <sp>? <numerator> <sp>? <denominator>
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

A **Rational** artifact uses just 1 octet to canonically represent the most
commonly used rationals `[-1.0,0.0,1.0]`.  There are also
other formats for each of these rationals, but they all take more octets.

Its single canonical octet for `0.0` corresponds to the ASCII/UTF-8
*EQUALS SIGN* character `=`.

Its single canonical octet for `1.0` corresponds to the ASCII/UTF-8
*GREATER-THAN SIGN* character `>`.

Its single canonical octet for `-1.0` corresponds to the ASCII/UTF-8
*LESS-THAN SIGN* character `<`.

A **Rational** artifact uses 3..N octets to represent the general case of
any rational as a pair-denoting octet, which corresponds to the
ASCII/UTF-8 *SOLIDUS* character `/` which has a common mnemonic
of numeric division or rationals/fractions, followed by 2 **Integer**
artifacts which represent in order a numerator and denominator.

A **Rational** artifact uses 5..N octets to represent the general case of
any rational as a 4-tuple-denoting octet, which corresponds to the
ASCII/UTF-8 *CIRCUMFLEX ACCENT* character `^` which has a common mnemonic
of numeric exponentiation, followed by 4 **Integer** artifacts which
represent in order a numerator, denominator, radix, and exponent.

Examples:

```
    `Zero (1 octet).`
    =

    `Same thing (3 octets); also known as 0/1.`
    /01

    `Same thing (5 octets); also known as 0/1.`
    /c\00c\01

    `Same thing (9 octets); also known as 0/1.`
    /+"\00"+"\01"

    `Positive one (1 octet).`
    >

    `Same thing (3 octets); also known as 1/1.`
    /11

    `Negative one (1 octet).`
    <

    `Same thing (3 octets); also known as -1/1.`
    /#1

    `Positive five-thirds (3 octets); also known as 5/3.`
    /53

    `Ten (3 octets); also known as 10/1.`
    /$1

    `One tenth (3 octets); also known as 1/10.`
    /1$

    `One hundred (3 octets); also known as 100/1.`
    /%1

    `One hundredth (3 octets); also known as 1/100.`
    /1%

    `One thousand (3 octets); also known as 1000/1.`
    /&1

    `One thousandth (3 octets); also known as 1/1000.`
    /1&

    `Negative 472-hundredths (7 octets); also known as -472/100.`
    /-"\01\D8"%

    `Same thing (5 octets); also known as -472/100.`
    /f\FE\28%

    `Same thing (6 octets); also known as -472/100.`
    /f\FE\28c\64

    `Same thing (7 octets); also known as -472/100.`
    /f\FE\28e\00\64

    `The rational 15_485_863/32_452_843 (11 octets).`
    /g\00\EC\4B\A7g\01\EF\30\EB

    `Dead Beef Face (15 octets); also known as 0xDEADBEEF.FACE.`
    /i\00\00\DE\AD\BE\EF\FA\CEg\00\01\00\00
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
          <Binary_negative_one>
        | <Binary_zero>
        | <Binary_positive_one>
        | <Binary_with_sig_exp>
    }

    token Binary_negative_one
    {
        '{'
    }

    token Binary_zero
    {
        '|'
    }

    token Binary_positive_one
    {
       '}'
    }

    token Binary_with_sig_exp
    {
        '~' <sp>? <significand> <sp>? <exponent>
    }

    token significand
    {
        <Integer>
    }

    token exponent
    {
        <Integer>
    }
```

A **Binary** artifact uses just 1 octet to canonically represent the most
commonly used rationals `[-1*2^0,0*2^0,1*2^0]`.  There are also
other formats for each of these rationals, but they all take more octets.

Its single canonical octet for `-1*2^0` corresponds to the ASCII/UTF-8
*LEFT CURLY BRACKET* character `{`.

Its single canonical octet for `0*2^0` corresponds to the ASCII/UTF-8
*VERTICAL LINE* character `|`.

Its single canonical octet for `1*2^0` corresponds to the ASCII/UTF-8
*RIGHT CURLY BRACKET* character `}`.

A **Binary** artifact uses 3..N octets to represent the general case of
any binary fraction as a pair-denoting octet, which corresponds to the
ASCII/UTF-8 *TILDE* character `~`, followed by 2 **Integer** artifacts which
represent in order a significand and exponent.

Examples:

```
    `Zero (1 octet).`
    |

    `Same thing (3 octets); also known as 0*2^0.`
    ~00

    `Same thing (5 octets); also known as 0*2^0.`
    ~c\00c\00

    `Same thing (9 octets); also known as 0*2^0.`
    ~+"\00"+"\00"

    `Positive one (1 octet).`
    }

    `Same thing (3 octets); also known as 1*2^0.`
    ~10

    `Negative one (1 octet).`
    {

    `Same thing (3 octets); also known as -1*2^0.`
    ~#0

    `Two (3 octets); also known as 1*2^1.`
    ~11

    `One half (3 octets); also known as 1*2^-1.`
    ~1#

    `Dead Beef (7 octets); also known as 0xDEADBEEF*2^0x0.`
    ~i\DE\AD\BE\EF0

    `The rational 0b1.011101101*2^-0b11011 (6 octets);`
    `also known as 0b1011101101*2^-0b100100.`
    ~e\02\EDd\DC
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
          <Decimal_negative_one>
        | <Decimal_zero>
        | <Decimal_positive_one>
        | <Decimal_with_sig_exp>
    }

    token Decimal_negative_one
    {
        '('
    }

    token Decimal_zero
    {
        '*'
    }

    token Decimal_positive_one
    {
       ')'
    }

    token Decimal_with_sig_exp
    {
        '^' <sp>? <significand> <sp>? <exponent>
    }
```

A **Decimal** artifact uses just 1 octet to canonically represent the most
commonly used rationals `[-1*10^0,0*10^0,1*10^0]`.  There are also
other formats for each of these rationals, but they all take more octets.

Its single canonical octet for `-1*10^0` corresponds to the ASCII/UTF-8
*LEFT PARENTHESIS* character `(`.

Its single canonical octet for `0*10^0` corresponds to the ASCII/UTF-8
*ASTERISK* character `*`.

Its single canonical octet for `1*10^0` corresponds to the ASCII/UTF-8
*RIGHT PARENTHESIS* character `)`.

A **Decimal** artifact uses 3..N octets to represent the general case of
any decimal fraction as a pair-denoting octet, which corresponds to the
ASCII/UTF-8 *CIRCUMFLEX ACCENT* character `^` which has a common mnemonic
of numeric exponentiation, followed by 2 **Integer** artifacts which
represent in order a significand and exponent.

Examples:

```
    `Zero (1 octet).`
    *

    `Same thing (3 octets); also known as 0*10^0.`
    ^00

    `Same thing (5 octets); also known as 0*10^0.`
    ^c\00c\00

    `Same thing (9 octets); also known as 0*10^0.`
    ^+"\00"+"\00"

    `Positive one (1 octet).`
    )

    `Same thing (3 octets); also known as 1*10^0.`
    ^10

    `Negative one (1 octet).`
    (

    `Same thing (3 octets); also known as -1*10^0.`
    ^#0

    `Ten (3 octets); also known as 1*10^1.`
    ^11

    `One tenth (3 octets); also known as 1*10^-1.`
    ^1#

    `Negative 472-hundredths (10 octets); also known as -472*10^-2.`
    ^-"\01\D8"-"\02"

    `Same thing (6 octets); also known as -472*10^-2.`
    ^f\FE\28d\FE

    `The rational 4.5207196*10^37 (8 octets); also known as 45207196*10^30.`
    ^g\02\B1\CE\9Cc\1E
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
        <Bits_zero> | <Bits_unlimited> | <Bits_limited_1_octet>
    }

    token Bits_zero
    {
        s
    }

    token Bits_unlimited
    {
        S <sp>? <significant_final_octet_bits_count> <sp>? <quoted_octet_seq>
    }

    token Bits_limited_1_octet
    {
        p <significant_final_octet_bits_count> <aescaped_octet>
    }

    token significant_final_octet_bits_count
    {
        <Integer_positive_one_thru_eight>
    }
```

A **Bits** artifact uses just 1 octet to canonically represent the empty
bit string.  This single canonical octet corresponds to the ASCII/UTF-8
*LATIN SMALL LETTER S* character `s` so it is visually represented by the
*smaller* version of the last letter of the possrep name `Bits`.  There
is also another format for this, but it takes more octets.

A **Bits** artifact uses 4..N octets to represent the general case of any
bit string as a single format-denoting octet, which corresponds to the
ASCII/UTF-8 *LATIN CAPITAL LETTER S* character `S` so it is visually
represented by the *larger* version of the last letter of the possrep name
`Bits`, followed by a length-denoting octet, followed by an unlimited
length bit string literal.
The bit string literal consists of 2 delimiter octets plus 0..N bit-defining octets.
Each delimiter octet corresponds to the ASCII/UTF-8 *QUOTATION MARK*
character `"` which has a common mnemonic for string quoting.
Every bit-defining octet except the very last one represents a sequence of
exactly 8 bits, while that last one instead represents a sequence of 1..8
bits, because in the general case the count of bits in a bit string isn't
an exact multiple of 8, and so only the highest order N bits of the last
octet are considered to define bits of the artifact, while the others
aren't.  The number of significant bits N in the last octet are declared by
the length-denoting octet, which must be an integer in 1..8 in the
canonical most compact form for such integers, meaning they take the form
of the ASCII/UTF-8 *DIGIT ZERO* thru *DIGIT EIGHT* characters.
All non-significant bits in the final octet must be zero valued, so that
octet sequences that are logically the same are also physically the same.
The artifact in this format representing the empty bit string must have the
integer 8 as its length-denoting octet.
Most bit-defining octets represent themselves, but a few of the possible 256
values are instead represented by escape sequences of 2 different octets
each, so no delimiter octets appear literally in the string they delimit.

A **Bits** artifact uses 3..5 octets to represent any 1..8-bit bit string
as a single format-denoting octet, which corresponds to the ASCII/UTF-8
*LATIN SMALL LETTER P* character `p`, followed by a length-denoting octet,
followed by a single bit-defining octet, where the latter usually
represents itself except in a few special cases where it is escaped.

Examples:

```
    `Empty bit string (1 octet); also known as 0bb.`
    s

    `Same thing (4 octets).`
    S8""

    `One zero bit (3 octets); also known as 0bb0.`
    p1\00

    `Same thing (5 octets).`
    S1"\00"

    `One one bit (3 octets); also known as 0bb1.`
    p1\80

    `Same thing (5 octets).`
    S1"\80"

    `The 14-bit string 0bb00101110_100010 (6 octets).`
    S6"\2E\88"

    `The 9-bit string 0bo644 (6 octets).`
    S1"\D2\00"

    `The 20-bit string 0bxA705E (7 octets).`
    S4"\A7\05\E0"
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
        <Blob_zero> | <Blob_unlimited> | <Blob_limited_1_octet>
    }

    token Blob_zero
    {
        b
    }

    token Blob_unlimited
    {
        B <sp>? <quoted_octet_seq>
    }

    token Blob_limited_1_octet
    {
        o <aescaped_octet>
    }

    token quoted_octet_seq
    {
          [['[' <sp>?] ~ [<sp>? ']'] <quoted_octet_seq_segment>+ % <sp>?]
        | <quoted_octet_seq_segment>
    }

    token quoted_octet_seq_segment
    {
        '"' ~ '"' <aescaped_octet>*
    }

    token aescaped_octet
    {
          <restricted_nonescaped_octet>
        | <escaped_octet_simple>
        | <restricted_escaped_octet_base_16_pair>
    }

    token restricted_nonescaped_octet
    {
        <[ \x[0]..\x[FF] ] - [ \t \n \r " \\ ` ]>
    }

    token escaped_octet_simple
    {
        '\\' <[tnrqkg]>
    }

    token restricted_escaped_octet_base_16_pair
    {
        '\\'
        <!before [09|0A|0D|22|5C|60]>
        <[ 0..9 A..F ]> ** 2
    }
```

A **Blob** artifact uses just 1 octet to canonically represent the empty
octet string.  This single canonical octet corresponds to the ASCII/UTF-8
*LATIN SMALL LETTER B* character `b` so it is visually represented by the
*smaller* version of the first letter of the possrep name `Blob`.  There
is also another format for this, but it takes more octets.

A **Blob** artifact uses 3..N octets to represent the general case of any
octet string as a single format-denoting octet, which corresponds to the
ASCII/UTF-8 *LATIN CAPITAL LETTER B* character `B` so it is visually
represented by the *larger* version of the first letter of the possrep name
`Blob`, followed by an unlimited length octet string literal.
The octet string literal consists of 2 delimiter octets plus 0..N octet literals.
Each delimiter octet corresponds to the ASCII/UTF-8 *QUOTATION MARK*
character `"` which has a common mnemonic for string quoting.
Most literal octets represent themselves, but a few of the possible 256
values are instead represented by escape sequences of 2 different octets
each, so no delimiter octets appear literally in the string they delimit.

A **Blob** artifact uses 2..4 octets to represent any single-octet octet
string as a single format-denoting octet, which corresponds to the
ASCII/UTF-8 *LATIN SMALL LETTER O* character `o` so it is visually
represented by the *smaller* version of the first letter of the word
`octet`, followed by a single octet literal, where the latter usually
represents itself except in a few special cases where it is escaped.

The meanings of the simple octet escape sequences, which apply to all possreps, are:

```
    Esc | Unicode    | Unicode         | Chr | Literal character used
    Seq | Code Point | Character Name  | Lit | for when not escaped
    ----+------------+-----------------+-----+-----------------------------
    \t  | 0x9      9 | CHAR... TAB...  |     | dividing space horizontal tab
    \n  | 0xA     10 | LINE FEED (LF)  |     | dividing space line feed / newline
    \r  | 0xD     13 | CARR. RET. (CR) |     | dividing space carriage return
    \q  | 0x22    34 | QUOTATION MARK  | "   | delimit quoted octet string
    \k  | 0x5C    93 | REVERSE SOLIDUS | \   | not used
    \g  | 0x60    96 | GRAVE ACCENT    | `   | delimit dividing space comments
```

There is just one complex escape sequence, of the format `\HH` such that
the `HH` is a padded base-16 notation integer between `00` and `FF`.
It is the exact same 250 octets that are allowed to exist literally in a
quoted octet string and that are allowed to be represented by the `\HH`
format; the complimentary 6 octets are only allowed to be represented by
the simple one-letter format.

The primary reason that the `\HH` option exists is to support documentation
examples of MUON artifacts that are both easy for humans to read as
documentation, because some octets correspond to otherwise nonprintable
ASCII characters, and likewise don't get corrupted when passed through
binary-unsafe text channels, while still being valid binary MUON data as
is, without having to be pre-processed into the actual octets to be treated
as the binary MUON.

However, it is expected that normal use cases for the binary MUON will use
the actual octets and not `\HH` because in general that is necessary to
reap a key benefit of using binary MUON over text MUON, its compactness.

Examples:

```
    `Empty octet string (1 octet); also known as 0xx.`
    b

    `Same thing (3 octets).`
    B""

    `One zero octet (2 octets); also known as 0xx0.`
    o\00

    `Same thing (4 octets).`
    B"\00"

    `One one octet (2 octets); also known as 0xx1.`
    o\01

    `Same thing (4 octets).`
    B"\01"

    `The 1-octet string 0xx22 (3 octets).`
    o\q

    `Same thing (5 octets).`
    B"\q"

    `The 1-octet string 0xx60 (3 octets).`
    o\g

    `The 1-octet string 0xx5C (3 octets).`
    o\k

    `The 4-octet string 0xxA705_E416 (7 octets).`
    B"\A7\05\E4\16"

    `The 2-octet string 0xb00101110_10001011 (7 octets).`
    B"\2E\8B"
```

[RETURN](#TOP)

<a name="Text"></a>

## Text

A **Text** artifact has the dedicated concrete literal format
described by `<Text>`.

Grammar:

```
    token Text
    {
        <Text_zero> | <Text_unlimited>
    }

    token Text_zero
    {
        t
    }

    token Text_unlimited
    {
        T <sp>? <quoted_octet_seq>
    }
```

A **Text** artifact uses just 1 octet to canonically represent the empty
character string.  This single canonical octet corresponds to the ASCII/UTF-8
*LATIN SMALL LETTER T* character `t` so it is visually represented by the
*smaller* version of the first letter of the possrep name `Text`.
There is also another format for this, but it takes more octets.

A **Text** artifact uses 3..N octets to represent the general case of any
character string as a single format-denoting octet, which corresponds to the
ASCII/UTF-8 *LATIN CAPITAL LETTER T* character `T` so it is visually
represented by the *larger* version of the first letter of the possrep name
`Text`, followed by an unlimited length character string literal.
The character string literal consists of 2 delimiter octets plus 0..N character literals.
Each delimiter octet corresponds to the ASCII/UTF-8 *QUOTATION MARK*
character `"` which has a common mnemonic for string quoting.
Each character literal consists of 1..4 UTF-8 octet literals.
Most UTF-8 octet defining octets represent themselves, but a few of the possible 256
values are instead represented by escape sequences of 2 different octets
each, so no delimiter octets appear literally in the string they delimit.

Examples:

```
    `Empty character UTF-8 string (1 octet); also known as "".`
    t

    `Same thing (3 octets).`
    T""

    `The 5-character UTF-8 string "Ceres" (8 octets).`
    T"Ceres"

    `The 1-character UTF-8 string "⨝" (6 octets).`
    T"\E2\A8\9D"

    `The 4-character UTF-8 string "サンプル" (15 octets).`
    T"\E3\82\B5\E3\83\B3\E3\83\97\E3\83\AB"

    `A 24 character UTF-8 string (27 octets).`
    T"This isn't not escaped.\0A"

    `The 2-character UTF-8 string "\(0x263A)\(65)" (7 octets).`
    T"\E2\98\BA\41"
```

[RETURN](#TOP)

<a name="Name"></a>

## Name

A **Name** artifact has the dedicated concrete literal format
described by `<Name>`.

Grammar:

```
    token Name
    {
          <Name_zero>
        | <Name_positional_attr_name_zero_thru_thirty_one>
        | <Name_unlimited>
        | <Name_limited_1_octet>
        | <Name_limited_2_octets>
        | <Name_limited_3_octets>
        | <Name_limited_4_octets>
        | <Name_limited_5_octets>
        | <Name_limited_6_octets>
    }

    token Name_zero
    {
        n
    }

    token Name_positional_attr_name_zero_thru_thirty_one
    {
        <[ \x[0]..\x[1F] ] - [ \t\n\r ] + [ ,;: ]>
    }

    token Name_unlimited
    {
        N <sp>? <quoted_octet_seq>
    }

    token Name_limited_1_octet
    {
        u <aescaped_octet>
    }

    token Name_limited_2_octets
    {
        v <aescaped_octet> ** 2
    }

    token Name_limited_3_octets
    {
        w <aescaped_octet> ** 3
    }

    token Name_limited_4_octets
    {
        x <aescaped_octet> ** 4
    }

    token Name_limited_5_octets
    {
        y <aescaped_octet> ** 5
    }

    token Name_limited_6_octets
    {
        z <aescaped_octet> ** 6
    }
```

A **Name** artifact uses just 1 octet to canonically represent the empty
character string.  This single canonical octet corresponds to the ASCII/UTF-8
*LATIN SMALL LETTER N* character `n` so it is visually represented by the
*smaller* version of the first letter of the possrep name `Name`.
There is also another format for this, but it takes more octets.

A **Name** artifact uses just 1 octet to canonically represent the first 32
"positional" **Kit** attribute names.
The single canonical octet for each of `[:0..:8,:11..:12,:14..:31]`
corresponds to each of the ASCII/UTF-8 code points
`[0x0..0x8,0xB..0xC,0xE..0x1F]` respectively, so each one is represented by
itself in UTF-8 format with no extra metadata octets.
The single canonical octet for each of `[:9,:10,:13]` corresponds to
each of the ASCII/UTF-8 code points `[0x2C,0x3B,0x3A]` respectively, meaning
the [*COMMA*, *SEMICOLON*, *COLON*] characters [`,`,`;`,`:`] respectively.
There are also other formats for each of these character strings,
but they all take more octets.

A **Name** artifact uses 3..N octets to represent the general case of any
character string as a single format-denoting octet, which corresponds to the
ASCII/UTF-8 *LATIN CAPITAL LETTER N* character `N` so it is visually
represented by the *larger* version of the first letter of the possrep name
`Name`, followed by an unlimited length character string literal.
The character string literal consists of 2 delimiter octets plus 0..N character literals.
Each delimiter octet corresponds to the ASCII/UTF-8 *QUOTATION MARK*
character `"` which has a common mnemonic for string quoting.
Each character literal consists of 1..4 UTF-8 octet literals.
Most UTF-8 octet defining octets represent themselves, but a few of the possible 256
values are instead represented by escape sequences of 2 different octets
each, so no delimiter octets appear literally in the string they delimit.

A **Name** artifact uses [2..4,3..7,4..10,5..13,6..16,7..19] octets
respectively to represent any shorter character string as a single
length-denoting octet followed by a limited length character string literal.
The character string literal consists of [1,2,3,4,5,6] UTF-8 octets and no delimiters.
All UTF-8 octets are as per the unlimited length character string format.
The octet for a character string consisting of [1,2,3,4,5,6] UTF-8 octets
corresponds to the ASCII/UTF-8 *LATIN SMALL LETTER [U,V,W,X,Y,Z]* character
[`u`,`v`,`w`,`x`,`y`,`z`].

Examples:

```
    `Empty character UTF-8 string (1 octet); also known as "".`
    n

    `Same thing (3 octets).`
    N""

    `The 1-character UTF-8 string :0 or "\(0)" (1 octet);`
    `also known as the first positional attribute name.`
    \00

    `Same thing (2 octets).`
    u\00

    `Same thing (4 octets).`
    N"\00"

    `The 1-character UTF-8 string :1 or "\(1)" (1 octet);`
    `also known as the second positional attribute name.`
    \01

    `Same thing (2 octets).`
    u\01

    `Same thing (4 octets).`
    N"\01"

    `The 4-character UTF-8 string "age" (4 octets).`
    wage

    `Same thing (6 octets).`
    N"age"

    `A 10-character UTF-8 string (13 octets).`
    N"First Name"
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
        E <sp>? [['[' <sp>?] ~ [<sp>? ']'] <Name>+ % <sp>?]
    }
```

A **Nesting** artifact uses 4..N octets to represent the general case of any
attribute name sequence as a single format-denoting octet, which corresponds to the
ASCII/UTF-8 *LATIN CAPITAL LETTER E* character `E` so it is visually
represented by the *larger* version of the second letter of the possrep name
`Nesting`, followed by an unlimited length attribute name sequence literal.
The attribute name sequence literal consists of 2 delimiter octets plus 1..N element.
The leading delimiter octet corresponds to the ASCII/UTF-8 *LEFT SQUARE BRACKET*
character `[` which has a common mnemonic for delimiting an ordered list.
The trailing delimiter octet corresponds to the ASCII/UTF-8 *RIGHT SQUARE BRACKET*
character `]` which has a common mnemonic for delimiting an ordered list.
Each element is any **Name** artifact.

Examples:

```
    `The Nesting with exactly 1 element that is the empty character UTF-8`
    `string (4 octets); also known as ::"".`
    E[n]

    `The Nesting with exactly 1 element that is the first positional`
    `attribute name (4 octets); also known as ::0.`
    E[\00]

    `The Nesting with exactly 1 element that is the 6-charater UTF-8`
    `string "person" (10 octets); also known as ::person.`
    E[zperson]

    `The 2-element Nesting ::person::birth_date (23 octets).`
    E[zpersonN"birth_date"]

    `The 3-element Nesting ::person::birth_date::year (28 octets).`
    E[zpersonN"birth_date"xyear]

    `The 3-element Nesting ::the_db::stats::"samples by order" (35 octets).`
    E[zthe_dbystatsN"samples by order"]
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
        P <sp>? <this_and_that>
    }

    token this_and_that
    {
        <this> <sp>? <that>
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

A **Pair** artifact uses 3..N octets to represent the general case of
any pair as a single format-denoting octet, which corresponds to the
ASCII/UTF-8 *LATIN CAPITAL LETTER P* character `P` so it is visually
represented by the *larger* version of the first letter of the possrep name
`Pair`, followed by typically-any 2 **Any** artifacts which
represent in order the pair's *this* and *that*.

Examples:

```
    `Pair of Ignorance (3 octets); also known as (0iIGNORANCE: 0iIGNORANCE).`
    P__

    `Pair of Integer (4 octets); also known as (5: -3).`
    P5d\FD

    `Pair of Name+Text (20 octets); also known as (:"First Name" : "Joy").`
    PN"First Name"T"Joy"

    `Another Pair (5 octets); also known as (:x : :y).`
    Puxuy
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
          <Lot_zero>
        | <Lot_unlimited>
        | <Lot_unlimited_nonmultiplied>
        | <Lot_limited_1_member>
    }

    token Lot_zero
    {
        l
    }

    token Lot_unlimited
    {
        L <sp>? [['[' <sp>?] ~ [<sp>? ']'] <multiplied_member>* % <sp>?]
    }

    token Lot_unlimited_nonmultiplied
    {
        M <sp>? [['[' <sp>?] ~ [<sp>? ']'] <member>* % <sp>?]
    }

    token Lot_limited_1_member
    {
        m <member>
    }

    token multiplied_member
    {
        <member> <sp>? <multiplicity>
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

Examples:

*TODO.*

[RETURN](#TOP)

<a name="Kit"></a>

## Kit

A **Kit** artifact has the dedicated concrete literal format
described by `<Kit>`.

Grammar:

```
    token Kit
    {
          <Kit_zero>
        | <Kit_unlimited>
        | <Kit_limited_positional>
        | <Kit_limited_1_attr>
    }

    token Kit_zero
    {
        k
    }

    token Kit_unlimited
    {
        K <sp>? [['[' <sp>?] ~ [<sp>? ']'] <kit_attr_na>* % <sp>?]
    }

    token Kit_limited_positional
    {
        J <sp>? [['[' <sp>?] ~ [<sp>? ']'] <kit_attr_a> ** 0..32 % <sp>?]
    }

    token Kit_limited_1_attr
    {
        a <kit_attr>
    }

    token kit_attr_na
    {
        <attr_name> <sp>? <attr_asset>
    }

    token kit_attr_a
    {
        <attr_asset>
    }

    token attr_name
    {
        <Name>
    }

    token attr_asset
    {
        <Any>
    }
```

Examples:

*TODO.*

[RETURN](#TOP)

<a name="GLOSSARY-OF-OCTETS"></a>

# GLOSSARY OF OCTETS

The following table enumerates the 256 octets in ascending numerical order
and their intended interpretations within MUON Packed Plain Text artifacts
usually in the context of their being the first octet of an artifact.

```
    PPT | PPT | Plain Text  | Meaning
    Oct | Chr | Literal     |
    ----+-----+-------------+----------------------------------------------
    00  |     | :0          | Name artifact or 1st "positional" Kit attribute name
    01  |     | :1          | Name artifact or 2nd "positional" Kit attribute name
    ...
    08  |     | :8          | Name artifact or 9th "positional" Kit attribute name
    09  |     |             | dividing space for visual formatting with CHARACTER TABULATION
    0A  |     |             | dividing space for visual formatting with LINE FEED (LF)
    0B  |     | :11         | Name artifact or 12th "positional" Kit attribute name
    0C  |     | :12         | Name artifact or 13th "positional" Kit attribute name
    0D  |     |             | dividing space for visual formatting with CARRIAGE RETURN (CR)
    0E  |     | :14         | Name artifact or 15th "positional" Kit attribute name
    ...
    1F  |     | :31         | Name artifact or 32nd "positional" Kit attribute name
    ----+-----+-------------+----------------------------------------------
    20  |     |             | dividing space for visual formatting with SPACE
    ----+-----+-------------+----------------------------------------------
    21  | !   | 0bFALSE     | Boolean artifact false
    22  | "   |             | delimit quoted octet string
    23  | #   | -1          | Integer artifact negative one
    24  | $   | 10          | Integer artifact positive ten or Lot member multiplicity ten
    25  | %   | 100         | Integer artifact positive one-hundred or Lot member multiplicity one-hundred
    26  | &   | 1000        | Integer artifact positive one-thousand or Lot member multiplicity one-thousand
    27  | '   |             | (unassigned)
    28  | (   |             | Decimal artifact negative one
    29  | )   |             | Decimal artifact positive one
    2A  | *   |             | Decimal artifact zero
    2B  | +   |             | Integer artifact prefix general case positive number or Lot member multiplicity
    2C  | ,   | :9          | Name artifact or 10th "positional" Kit attribute name
    2D  | -   |             | Integer artifact prefix general case negative number
    2E  | .   |             | (unassigned)
    2F  | /   |             | Rational artifact prefix general case [numerator,denominator] pair
    ----+-----+-------------+----------------------------------------------
    30  | 0   | 0           | Integer artifact zero
    31  | 1   | 1           | Integer artifact positive one or Lot member multiplicity one
    ...
    39  | 9   | 9           | Integer artifact positive nine or Lot member multiplicity nine
    ----+-----+-------------+----------------------------------------------
    3A  | :   | :13         | Name artifact or 14th "positional" Kit attribute name
    3B  | ;   | :10         | Name artifact or 11th "positional" Kit attribute name
    3C  | <   | -1.0        | Rational artifact negative one
    3D  | =   | 0.0         | Rational artifact zero
    3E  | >   | 1.0         | Rational artifact positive one
    3F  | ?   | 0bTRUE      | Boolean artifact true
    40  | @   |             | (unassigned)
    ----+-----+-------------+----------------------------------------------
    41  | A   |             | (unassigned)
    42  | B   |             | Blob artifact prefix general case quoted string with N octets
    43  | C   |             | (unassigned)
    44  | D   |             | (unassigned)
    45  | E   |             | Nesting artifact prefix general case with N elements
    46  | F   |             | (unassigned)
    47  | G   |             | (unassigned)
    48  | H   |             | (unassigned)
    49  | I   |             | (unassigned)
    4A  | J   |             | Kit artifact prefix special case with N positional attributes
    4B  | K   |             | Kit artifact prefix general case with N attributes
    4C  | L   |             | Lot artifact prefix general case with N members
    4D  | M   |             | Lot artifact prefix special case with N non-multiplied members
    4E  | N   |             | Name artifact prefix general case quoted UTF-8 string with N octets / N characters
    4F  | O   |             | (unassigned)
    50  | P   |             | Pair artifact prefix general case
    51  | Q   |             | (unassigned)
    52  | R   |             | (unassigned)
    53  | S   |             | Bits artifact prefix general case quoted string with N octets / N bits
    54  | T   |             | Text artifact prefix general case quoted UTF-8 string with N octets / N characters
    55  | U   |             | (unassigned)
    56  | V   |             | (unassigned)
    57  | W   |             | (unassigned)
    58  | X   |             | (unassigned)
    59  | Y   |             | (unassigned)
    5A  | Z   |             | (unassigned)
    ----+-----+-------------+----------------------------------------------
    5B  | [   |             | delimit-start N-ary collection element list (Nesting/Lot/Kit) or multi-segment quoted octet string
    5C  | \   |             | escape sequence prefix within quoted octet string
    5D  | ]   |             | delimit-end N-ary collection element list (Nesting/Lot/Kit) or multi-segment quoted octet string
    5E  | ^   |             | Decimal artifact prefix general case [significand,exponent] pair
    5F  | _   | 0iIGNORANCE | Ignorance artifact singleton
    60  | `   |             | delimit dividing space for embedding arbitrary octet strings or ASCII comments
    ----+-----+-------------+----------------------------------------------
    61  | a   |             | Kit artifact prefix special case with exactly 1 attribute
    62  | b   | 0xx         | Blob artifact empty string
    ----+-----+-------------+----------------------------------------------
    63  | c   |             | Integer artifact prefix fixed width big-endian nonsigned 1 octet
    64  | d   |             | Integer artifact prefix fixed width big-endian two's complement signed 1 octet
    65  | e   |             | Integer artifact prefix fixed width big-endian nonsigned 2 octets
    66  | f   |             | Integer artifact prefix fixed width big-endian two's complement signed 2 octets
    67  | g   |             | Integer artifact prefix fixed width big-endian nonsigned 4 octets
    68  | h   |             | Integer artifact prefix fixed width big-endian two's complement signed 4 octets
    69  | i   |             | Integer artifact prefix fixed width big-endian nonsigned 8 octets
    6A  | j   |             | Integer artifact prefix fixed width big-endian two's complement signed 8 octets
    ----+-----+-------------+----------------------------------------------
    6B  | k   | {}          | Kit artifact with zero attributes
    6C  | l   | []          | Lot artifact with zero members
    6D  | m   |             | Lot artifact prefix special case with exactly 1 member (implicit multiplicity of 1)
    6E  | n   | :""         | Name artifact empty string
    6F  | o   |             | Blob artifact prefix special case string with exactly 1 octet element
    70  | p   |             | Bits artifact prefix special case string with exactly 1..8 bit elements
    71  | q   | 11          | Integer artifact positive eleven or Lot member multiplicity eleven
    72  | r   | 12          | Integer artifact positive twelve or Lot member multiplicity twelve
    73  | s   | 0bb         | Bits artifact empty string
    74  | t   | ""          | Text artifact empty string
    ----+-----+-------------+----------------------------------------------
    75  | u   |             | Name artifact prefix special case UTF-8 string with exactly 1 octet / 1 ASCII character
    76  | v   |             | Name artifact prefix special case UTF-8 string with exactly 2 octets
    77  | w   |             | Name artifact prefix special case UTF-8 string with exactly 3 octets
    78  | x   |             | Name artifact prefix special case UTF-8 string with exactly 4 octets / 1 non-BMP Unicode character
    79  | y   |             | Name artifact prefix special case UTF-8 string with exactly 5 octets
    7A  | z   |             | Name artifact prefix special case UTF-8 string with exactly 6 octets
    ----+-----+-------------+----------------------------------------------
    7B  | {   |             | Binary artifact negative one
    7C  | |   |             | Binary artifact zero
    7D  | }   |             | Binary artifact positive one
    7E  | ~   |             | Binary artifact prefix general case [significand,exponent] pair
    ----+-----+-------------+----------------------------------------------
    7F  |     |             | (unassigned)
    ----+-----+-------------+----------------------------------------------
    80  |     |             | reserved for users to declare reusable Any artifact factor
    ...
    FF  |     |             | reserved for users to declare reusable Any artifact factor
    ----+-----+-------------+----------------------------------------------
```

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
