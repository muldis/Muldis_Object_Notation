<a name="TOP"></a>

# NAME

Muldis Object Notation (MUON) - Source code and data interchange format

# VERSION

The fully-qualified name of this document is
`Muldis_Object_Notation https://muldis.com 0.300.0`.

# PART

This artifact is part 6 of 21 of the document
`Muldis_Object_Notation https://muldis.com 0.300.0`;
its part name is `Syntax_Plain_Text_Lax`.

# CONTENTS

- [SYNOPSIS](#SYNOPSIS)
- [DESCRIPTION](#DESCRIPTION)
- [COMMON QUALITIES OF THE GRAMMAR](#COMMON-QUALITIES-OF-THE-GRAMMAR)
- [PARSING UNIT](#PARSING-UNIT)
- [DIVIDING SPACE](#DIVIDING-SPACE)
- [CRITICAL ALGEBRAIC DATA TYPE POSSREPS](#CRITICAL-ALGEBRAIC-DATA-TYPE-POSSREPS)
    - [Any / Universal Type Possrep](#Any---Universal-Type-Possrep)
    - [None / Empty Type Possrep](#None---Empty-Type-Possrep)
- [SIMPLE PRIMARY DATA TYPE POSSREPS](#SIMPLE-PRIMARY-DATA-TYPE-POSSREPS)
    - [Ignorance](#Ignorance)
    - [Boolean](#Boolean)
    - [Integer](#Integer)
    - [Fraction](#Fraction)
    - [Bits](#Bits)
    - [Blob](#Blob)
    - [Text / Attribute Name](#Text---Attribute-Name)
    - [Nesting / Attribute Name List](#Nesting---Attribute-Name-List)
- [COLLECTIVE PRIMARY DATA TYPE POSSREPS](#COLLECTIVE-PRIMARY-DATA-TYPE-POSSREPS)
    - [Duo](#Duo)
    - [Lot](#Lot)
    - [Kit](#Kit)
    - [Article / Labelled Tuple](#Article---Labelled-Tuple)
    - [Excuse](#Excuse)
- [EXTENSIONS OVER SYNTAX PLAIN TEXT](#EXTENSIONS-OVER-SYNTAX-PLAIN-TEXT)
    - [JSON - JavaScript Object Notation](#JSON---JavaScript-Object-Notation)
    - [Pair Separator Equals-Greater-Than](#Pair-Separator-Equals-Greater-Than)
- [SEE ALSO](#SEE-ALSO)
- [AUTHOR](#AUTHOR)
- [LICENSE AND COPYRIGHT](#LICENSE-AND-COPYRIGHT)
- [TRADEMARK POLICY](#TRADEMARK-POLICY)
- [ACKNOWLEDGEMENTS](#ACKNOWLEDGEMENTS)

[RETURN](#TOP)

<a name="SYNOPSIS"></a>

# SYNOPSIS

*No example provided as it would be identical to the MUON Plain Text (strict) version.*

[RETURN](#TOP)

<a name="DESCRIPTION"></a>

# DESCRIPTION

This document consists of multiple parts; for a directory to all of the
parts, see [Overview](Muldis_Object_Notation.md).

This part of the **Muldis Object Notation** document specifies the
canonical concrete plain text lax syntax of MUON,
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
compatibility is provided as a secondary syntax rather than being part of
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

The prescribed standard *syntax predicate* of a **Syntax** signature for a
MUON Plain Text Lax artifact is `Muldis_Object_Notation_Plain_Text_Lax`.

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
[hosts/Raku/lib/Muldis/Reference/Object_Notation_Plain_Text_Lax.rakumod](
../hosts/Raku/lib/Muldis/Reference/Object_Notation_Plain_Text_Lax.rakumod)
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

<a name="CRITICAL-ALGEBRAIC-DATA-TYPE-POSSREPS"></a>

# CRITICAL ALGEBRAIC DATA TYPE POSSREPS

[RETURN](#TOP)

<a name="Any---Universal-Type-Possrep"></a>

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

*This part of the grammar has no differences from the MUON Plain Text (strict) version.*

[RETURN](#TOP)

<a name="None---Empty-Type-Possrep"></a>

## None / Empty Type Possrep

A **None** artifact doesn't exist, but is mentioned for parity.

[RETURN](#TOP)

<a name="SIMPLE-PRIMARY-DATA-TYPE-POSSREPS"></a>

# SIMPLE PRIMARY DATA TYPE POSSREPS

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

<a name="Fraction"></a>

## Fraction

A **Fraction** artifact has the dedicated concrete literal format
described by `<Fraction>`.

Grammar:

```
    token Fraction
    {
        <Fraction_but_alpha_sci_notation> | <Fraction_alpha_sci_notation>
    }

    token Fraction_but_alpha_sci_notation
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

    token Fraction_alpha_sci_notation
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
        <-[ \x[0]..\x[1F] " \\ \x[7F] \x[80]..\x[9F] ]>
    }

    token escaped_char_simple
    {
        '\\' <[ " / \\ abtnvfreqkg ]>
    }

    token escaped_char_cpt_seq
    {
        '\\' ['[' ~ ']' [<code_point_text>* % ',']]
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
        <!before [null | false | true] <wb>>
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

The meanings of the additional simple character escape sequences are:

```
    Esc | Unicode    | Unicode         | Chr | Literal character used
    Seq | Code Point | Character Name  | Lit | for when not escaped
    ----+------------+-----------------+-----+-----------------------------
    \"  | 0x22    34 | QUOTATION MARK  | "   | delimit Text/opaque literals
    \/  | 0x2F    47 | SOLIDUS         | /   | Fraction literals
    \\  | 0x5C    93 | REVERSE SOLIDUS | \   | not used
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
        ['::' <sp>? <Text>]
    }

    token nesting_nary
    {
        ['::' <sp>?]?
        [<Text> ** 2..* % [<sp>? '::' <sp>?]]
    }
```

*This part of the grammar has no differences from the MUON Plain Text (strict) version.*

[RETURN](#TOP)

<a name="COLLECTIVE-PRIMARY-DATA-TYPE-POSSREPS"></a>

# COLLECTIVE PRIMARY DATA TYPE POSSREPS

[RETURN](#TOP)

<a name="Duo"></a>

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
          [<this> <sp>? [':'|'->'|'=>'] <sp>? <that>]
        | [<that> <sp>?      '<-'       <sp>? <this>]
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

*This part of the grammar has no differences from the MUON Plain Text (strict) version.*

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
            [',' <sp>?]?
            [<multiplied_member>* % [<sp>? ',' <sp>?]]
            [<sp>? ',']?
    }

    token multiplied_member
    {
          [<member>       <sp>? [':'|'->'|'=>'] <sp>? <multiplicity>]
        | [<multiplicity> <sp>?      '<-'       <sp>? <member>      ]
        | <member>
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

*This part of the grammar has no differences from the MUON Plain Text (strict) version.*

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
            [',' <sp>?]?
            [<kit_attr>* % [<sp>? ',' <sp>?]]
            [<sp>? ',']?
    }

    token kit_attr
    {
          [<attr_name>  <sp>? [':'|'->'|'=>'] <sp>? <attr_asset>]
        | [<attr_asset> <sp>?      '<-'       <sp>? <attr_name> ]
        | <attr_asset>
    }

    token attr_name
    {
        <Text>
    }

    token attr_asset
    {
        <Any>
    }
```

*This part of the grammar has no differences from the MUON Plain Text (strict) version.*

[RETURN](#TOP)

<a name="Article---Labelled-Tuple"></a>

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

*This part of the grammar has no differences from the MUON Plain Text (strict) version.*

[RETURN](#TOP)

<a name="Excuse"></a>

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

*This part of the grammar has no differences from the MUON Plain Text (strict) version.*

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

For **Fraction**:

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

For **Duo** and **Lot** and **Kit**:

- Added `=>` as an alternative pair separator syntax for `:` and `->`.

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
