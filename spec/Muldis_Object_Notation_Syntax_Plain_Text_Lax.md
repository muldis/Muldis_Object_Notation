<a name="TOP"></a>

# NAME

Muldis Object Notation (MUON) - Source code and data interchange format

# VERSION

The fully-qualified name of this document is
`Muldis_Object_Notation https://muldis.com 0.400.0`.

# PART

This artifact is part 7 of 22 of the document
`Muldis_Object_Notation https://muldis.com 0.400.0`;
its part name is `Syntax_Plain_Text_Lax`.

# CONTENTS

- [SYNOPSIS](#SYNOPSIS)
- [DESCRIPTION](#DESCRIPTION)
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
- [EXTENSIONS OVER SYNTAX PLAIN TEXT](#EXTENSIONS-OVER-SYNTAX-PLAIN-TEXT)
    - [JSON - JavaScript Object Notation](#JSON---JavaScript-Object-Notation)
    - [Pair Separator Equals-Greater-Than](#Pair-Separator-Equals-Greater-Than)
    - [Pair Separator Comma](#Pair-Separator-Comma)
    - [String Delimiter Single-Quote](#String-Delimiter-Single-Quote)
- [AUTHOR](#AUTHOR)
- [LICENSE AND COPYRIGHT](#LICENSE-AND-COPYRIGHT)

[RETURN](#TOP)

<a name="SYNOPSIS"></a>

# SYNOPSIS

*No example provided as it would be identical to the MUON Plain Text (strict) version,
except that the `Muldis_Object_Notation_Syntax` would say `Plain_Text_Lax`.*

[RETURN](#TOP)

<a name="DESCRIPTION"></a>

# DESCRIPTION

This document consists of multiple parts; for a directory to all of the
parts, see [Overview](Muldis_Object_Notation.md).

This part of the **Muldis Object Notation** document specifies the
canonical concrete nonhosted plain text lax syntax of MUON,
which expresses a MUON artifact in terms of a Unicode character string
conforming to a well-defined pattern,
which can exist as a raw file in a filesystem or be exchanged over a
network or exist in memory of any program as a character string value.

The MUON `Syntax_Plain_Text_Lax` is derived from and maps with the MUON
[Syntax_Abstract](Muldis_Object_Notation_Syntax_Abstract.md); see that plus
[Semantics](Muldis_Object_Notation_Semantics.md) for further context.

The MUON canonical plain text lax format is semi-lightweight and designed to
support interchange of source code and data between any 2 environments that
do not have a common working memory, such as because they are distinct
machine processes written in different programming languages, or because
they are on distinct machines, or because they are mediated by a network or
disk file.

The MUON `Syntax_Plain_Text_Lax` exists as an alternative to the MUON
[Syntax_Plain_Text](Muldis_Object_Notation_Syntax_Plain_Text.md).

The MUON Plain Text Lax format is strictly a proper superset of the MUON
Plain Text (strict) format.  The former extends the latter with additional
allowed formats for some possreps, formats that are illegal syntax in
Plain Text (strict) but have defined meanings in Plain Text lax.

The main rationale for MUON `Syntax_Plain_Text_Lax` to exist is that MUON
`Syntax_Plain_Text` incorporates a large fraction, but not 100%, of the
syntax of other comparable data formats and languages, in particular
JavaScript Object Notation (JSON), with whom it intentionally has a very
similar name.  This more lax syntax exists to provide all of the remaining
syntax options of JSON so users are empowered that every valid JSON
artifact can also be parsed as a valid MUON artifact with essentially the
same meaning, rather than the 2 languages being incompatible despite their
overlapping features being mostly syntax compatible.  This full
compatibility is provided as an additional syntax rather than being part of
the most fundamental Plain Text (strict) format so that the latter can be
more pure and not constrained by third-party decision-makers.  The Lax
syntax also incorporates several non-conflicting formats from a variety of
other programming languages.

The intended benefit is that it would be much easier with this Lax syntax
to copy-paste value literals from other formats and languages into MUON
artifacts and have them just work, without needing manual adjustments.

So MUON `Syntax_Plain_Text_Lax` is strictly a proper superset of *both*
MUON `Syntax_Plain_Text` *and* JSON, so every artifact of the latter 2
should parse as an artifact of the first, but not every artifact of the
first would parse as an artifact of either of the latter 2.

Note that while some versions of the JSON spec allow more file encoding
options, MUON Plain Text Lax maintains the MUON Plain Text (strict)
restriction to UTF-8 as the only allowed option, which is also in keeping
with other versions of the JSON spec as well as many JSON implementations.

The prescribed standard *syntax base name* of a *syntax-qualified artifact*
for a MUON Plain Text Lax artifact is `Plain_Text_Lax`.

The prescribed standard filename extension for files featuring a MUON Plain
Text Lax parsing unit is `.muonlax`, though as per standard UNIX conventions,
such MUON files can in fact have any filename extension when there is other
context to interpret them with.  Filename extensions are more for the
benefit of the operating system or command shell or users than for a MUON
parser or generator, the latter just cares about the content of the file.

The MUON Plain Text Lax syntax specification is mostly structured as a
delta of the MUON Plain Text (strict) syntax specification, so most aspects
that do not differ between the two are not repeated in the current part.
However the current part *does* repeat the entire common grammar.

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
[grammars/Raku/lib/Muldis/Object_Notation_Grammar_Reference/Plain_Text_Lax.rakumod](
../grammars/Raku/lib/Muldis/Object_Notation_Grammar_Reference/Plain_Text_Lax.rakumod)
which has an executable copy of the grammar.

[RETURN](#TOP)

<a name="PARSING-UNIT"></a>

# PARSING UNIT

A MUON *parsing unit* is represented in the grammar by
`<Muldis_Object_Notation_Plain_Text_Lax>`.

Grammar:

```
    token Muldis_Object_Notation_Plain_Text_Lax
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

*This part of the grammar has no differences from the MUON Plain Text (strict) version.*

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

*This part of the grammar has no differences from the MUON Plain Text (strict) version.*

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
        0iIGNORANCE | null
    }
```

Additional Examples:

```
    null
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
        0bFALSE | 0bTRUE | false | true
    }
```

Additional Examples:

```
    false

    true
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

*This part of the grammar has no differences from the MUON Plain Text (strict) version.*

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

*This part of the grammar has no differences from the MUON Plain Text (strict) version.*

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

*This part of the grammar has no differences from the MUON Plain Text (strict) version.*

[RETURN](#TOP)

<a name="Decimal"></a>

## Decimal

A **Decimal** artifact has the dedicated concrete literal format
described by `<Decimal>`.

Grammar:

```
    token Decimal
    {
        <Decimal_but_alpha_sci_notation> | <Decimal_alpha_sci_notation>
    }

    token Decimal_but_alpha_sci_notation
    {
        <significand> <sp>? '*' <sp>? <radix_ten> <sp>? '^' <sp>? <exponent>
    }

    token radix_ten
    {
        10
    }

    token Decimal_alpha_sci_notation
    {
        <[+-]>? <sp>? [0 | [<[ 1..9 ]> [[_ | <sp>]? <[ 0..9 ]>+]*]]
        [[_ | <sp>]? '.' [[_ | <sp>]? <[ 0..9 ]>+]+]?
        [_ | <sp>]? <[eE]>
        [_ | <sp>]? <[+-]>? [[_ | <sp>]? <[ 0..9 ]>+]+
    }
```

Additional Examples:

```
    -472e-2

    4.5207196e37
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

*This part of the grammar has no differences from the MUON Plain Text (strict) version.*

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

*This part of the grammar has no differences from the MUON Plain Text (strict) version.*

[RETURN](#TOP)

<a name="Text"></a>

## Text

A **Text** artifact has the dedicated concrete literal format
described by `<Text>`.

Grammar:

```
    token Text
    {
        <quoted_char_seq>
    }

    token quoted_char_seq
    {
        <quoted_char_seq_segment>+ % <sp>?
    }

    token quoted_char_seq_segment
    {
          ['"'  ~ '"'  [<aescaped_char> | '\'']*]
        | ['\'' ~ '\'' [<aescaped_char> | '"' ]*]
    }

    token aescaped_char
    {
          <restricted_nonescaped_char>
        | <escaped_char_simple>
        | <escaped_char_code_point>
        | <escaped_char_utf32_code_point>
        | <escaped_char_utf16_code_point>
    }

    token restricted_nonescaped_char
    {
        <-[ \x[0]..\x[1F] " ' \\ \x[7F] \x[80]..\x[9F] ]>
    }

    token escaped_char_simple
    {
        '\\' <[ " ' / \\ ` abtnvfreqkg ]>
    }

    token escaped_char_code_point
    {
        '\\' ['(' ~ ')' <code_point>]
    }

    token code_point
    {
          [0b    [0 | [   1            <[ 0..1      ]> ** 0..20]]]
        | [0o    [0 | [<[ 1..7      ]> <[ 0..7      ]> ** 0..6 ]]]
        | [[0d]? [0 | [<[ 1..9      ]> <[ 0..9      ]> ** 0..6 ]]]
        | [0x    [0 | [<[ 1..9 A..F ]> <[ 0..9 A..F ]> ** 0..5 ]]]
    }

    token escaped_char_utf32_code_point
    {
        '\\' U00 [<[ 0..9 A..F a..f ]> ** 6]
    }

    token escaped_char_utf16_code_point
    {
        '\\' u [<[ 0..9 A..F a..f ]> ** 4]
    }
```

The meanings of the additional simple character escape sequences are:

```
    Esc | Unicode    | Unicode         | Chr | Literal character used
    Seq | Code Point | Character Name  | Lit | for when not escaped
    ----+------------+-----------------+-----+-----------------------------
    \"  | 0x22    34 | QUOTATION MARK  | "   | delimit quoted-Text/identifier literals
    \'  | 0x27    39 | APOSTROPHE      | '   | delimit quoted-Text/identifier literals
    \/  | 0x2F    47 | SOLIDUS         | /   | Rational literals
    \\  | 0x5C    93 | REVERSE SOLIDUS | \   | not used
    \`  | 0x60    96 | GRAVE ACCENT    | `   | delimit dividing space comments
```

Additional Examples:

```
    'Differently quoted text.'
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
        ':' <sp>? <Name_nonqualified>
    }

    token Name_nonqualified
    {
        <quoted_char_seq> | <nonquoted_alphanumeric_char_seq> | <code_point>
    }

    token nonquoted_alphanumeric_char_seq
    {
        <[ A..Z _ a..z ]> <[ 0..9 A..Z _ a..z ]>*
    }
```

*This part of the grammar has no differences from the MUON Plain Text (strict) version.*

[RETURN](#TOP)

<a name="Nesting---Attribute-Name-List"></a>

## Nesting / Attribute Name List

A **Nesting** artifact has the dedicated concrete literal format
described by `<Nesting>`.

Grammar:

```
    token Nesting
    {
        '::' <sp>? [<Name_nonqualified>+ % [<sp>? '::' <sp>?]]
    }
```

*This part of the grammar has no differences from the MUON Plain Text (strict) version.*

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
        <this> <sp>? [':'|'->'|'=>'|','] <sp>? <that>
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

Additional Examples:

```
    (:x=>:y)

    (:x,:y)
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
        [<member> <sp>? [':'|'->'|'=>'] <sp>? <multiplicity>] | <member>
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

Additional Examples:

```
    [
        "Clubs"  =>  5,
        "Diamonds",
        "Hearts" => 10,
        "Spades" => 20,
    ]
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
        <attr_name> <sp>? [':'|'->'|'=>'] <sp>? <attr_asset>
    }

    token kit_attr_a
    {
        <attr_asset>
    }

    token attr_name
    {
        <Name_nonqualified>
    }

    token attr_asset
    {
        <Any>
    }
```

Additional Examples:

```
    {
        login_name => "hartmark",
        login_pass => "letmein",
        is_special => 0bTRUE,
    }
```

[RETURN](#TOP)

<a name="EXTENSIONS-OVER-SYNTAX-PLAIN-TEXT"></a>

# EXTENSIONS OVER SYNTAX PLAIN TEXT

The following sub-sections outline extensions that MUON Plain Text Lax
makes over MUON Plain Text (strict) that are specific to compatibility with
individual other formats and languages.

[RETURN](#TOP)

<a name="JSON---JavaScript-Object-Notation"></a>

## JSON - JavaScript Object Notation

Following are the extensions made by MUON Plain Text Lax which collectively
close the gap for full compatibility with JSON.

For **Ignorance**:

- Added `null` as an alternate syntax for `0iIGNORANCE`.

For **Boolean**:

- Added `false` and `true` as alternate syntaxes respectively for `0bFALSE`
and `0bTRUE`.

For **Decimal**:

- Added the scientific notation format like `4.5207196e37` as an alternate
syntax for the format like `4.5207196*10^37`.

For **Text**:

- Allowed the grave accent / backtick character `` ` `` to appear literally
in a quoted string literal, where it was otherwise forbidden such that one
could only specify it with `\g` before.
- Added the simple character escape sequences: `\"`, `\/`, `\\`.
Otherwise the first and last could only be specified with `\q` and `\k`
respectively.  The `/` didn't have an escape as it may appear literally.

[RETURN](#TOP)

<a name="Pair-Separator-Equals-Greater-Than"></a>

## Pair Separator Equals-Greater-Than

Following are extensions made by MUON Plain Text Lax which collectively
increase the level of compatibility with: Raku, Perl, PHP, maybe others.

For **Pair** and **Lot** and **Kit**:

- Added `=>` as an alternative pair separator syntax for `:` and `->`.

[RETURN](#TOP)

<a name="Pair-Separator-Comma"></a>

## Pair Separator Comma

Following are extensions made by MUON Plain Text Lax which collectively
increase the level of compatibility with: C#, Python, maybe others.

For **Pair**:

- Added `,` as an alternative pair separator syntax for `:` and `->`.

[RETURN](#TOP)

<a name="String-Delimiter-Single-Quote"></a>

## String Delimiter Single-Quote

Following are extensions made by MUON Plain Text Lax which collectively
increase the level of compatibility with any formats and languages that
delimit strings with single-quotes, either instead of or as an alternative
to double-quotes.

For **Text** and **Nesting** and **Kit**:

- Added `'` as an alternative delimiter for `"` for any quoted string.

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
