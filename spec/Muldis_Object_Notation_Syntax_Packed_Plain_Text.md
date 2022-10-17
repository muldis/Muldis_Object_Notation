# NAME

Muldis Object Notation (MUON) - Source code and data interchange format

# VERSION

The fully-qualified name of this document is
`Muldis_Object_Notation https://muldis.com 0.300.0`.

# PART

This artifact is part 5 of 19 of the document
`Muldis_Object_Notation https://muldis.com 0.300.0`;
its part name is `Syntax_Packed_Plain_Text`.

# SYNOPSIS

*TODO.*

# DESCRIPTION

This document consists of multiple parts; for a directory to all of the
parts, see [Overview](Muldis_Object_Notation.md).

This part of the **Muldis Object Notation** document specifies the
canonical concrete packed plain text syntax of MUON,
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

The prescribed standard *syntax predicate* of a **Syntax** signature for a
MUON Packed Plain Text artifact is `Muldis_Object_Notation_Packed_Plain_Text`.

The prescribed standard filename extension for files featuring a MUON Packed Plain
Text parsing unit is `.muonppt`, though as per standard UNIX conventions,
such MUON files can in fact have any filename extension when there is other
context to interpret them with.  Filename extensions are more for the
benefit of the operating system or command shell or users than for a MUON
parser or generator, the latter just cares about the content of the file.

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

It is mandatory for every MUON parser to support recognition of an optional
*shebang line* and to handle it gracefully, such that it is not an error
for a *parsing unit* to either have or not have one, and any otherwise
valid MUON following one is handled properly.

## Script / Character Encoding

The MUON parser proper operates logically in terms of the input *parsing
unit* being an octet string (characterized by a sequence of
octets, each corresponding to an integer in the
set `[0..0xFF]`).  In self-defining terms, the MUON
parser proper expects a **Blob** value as input.

For the purpose of illustration, however, the grammar of this document part
treats the input *parsing unit* as if it were an ISO Latin-1 character
string; or to be specific, any octets `[0x20..0x7E]` which correspond to
printable ASCII characters or SPACE in the ISO Latin-1 encoding will appear
as the same character literals in the grammar, while the other octets
`[0..0x1F,0x7F..0xFF]` will be expressed as those integers.

Note that in any artifact examples, the format `\NN` is used to represent
octets that don't correspond to printable ASCII characters or SPACE; the
`NN` is a padded base-16 notation integer between `00` and `FF`; all other
appearances of `\` are followed by a letter and represent themselves.

## Aggregate Self-Synchronization Mark

It is mandatory for every MUON parser to recognize the simple aggregation
of multiple mutually independent *parsing unit* into a *parsing unit
aggregate* such that each pair of consecutive components is separated by an
*aggregate self-synchronization mark* (*assm*), which is this literal text:

```
    `Muldis_Object_Notation_Sync_Mark`
```

See the corresponding section of the MUON Syntax Plain Text documentation
for rationale, which will not be repeated here.

Examples:

*TODO.*

# COMMON QUALITIES OF THE GRAMMAR

The syntax and intended interpretation of the grammar itself seen in this
document part should match that of the user-defined grammars feature of the
Raku language, which is described by
<https://docs.raku.org/language/grammars>.

Any references like `<foo>` in either the grammar itself or in the written
documentation specifically refer to the corresponding grammar token `foo`.

See also the bundled actual Raku module
[hosts/Raku/lib/Muldis/Reference/Object_Notation_Packed_Plain_Text.rakumod](
../hosts/Raku/lib/Muldis/Reference/Object_Notation_Packed_Plain_Text.rakumod)
which has an executable copy of the grammar.

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

# DIVIDING SPACE

Grammar:

```
    token sp
    {
        '`' ~ '`' <[ \x[0]..\x[FF] ] - [`]>*
    }
```

A `<sp>` represents *dividing space* that may be used to embed extra octet
sequences in MUON parsing units that are expendable and don't change its
meaning, such as for use as padding or limited formatting or comments.

# CRITICAL ALGEBRAIC DATA TYPE POSSREPS

## Any / Universal Type Possrep

An **Any** artifact has the dedicated concrete literal format
described by `<Any>`.

Grammar:

```
    token Any
    {
        <simple_primary> | <collective_primary>
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
        TODO
    }
```

Examples:

*TODO.*

## Boolean

A **Boolean** artifact has the dedicated concrete literal format
described by `<Boolean>`.

Grammar:

```
    token Boolean
    {
        TODO
    }
```

Examples:

*TODO.*

## Integer

An **Integer** artifact has the dedicated concrete literal format
described by `<Integer>`.

Grammar:

```
    token Integer
    {
        TODO
    }
```

Examples:

*TODO.*

## Fraction

A **Fraction** artifact has the dedicated concrete literal format
described by `<Fraction>`.

Grammar:

```
    token Fraction
    {
        TODO
    }
```

Examples:

*TODO.*

## Bits

A **Bits** artifact has the dedicated concrete literal format
described by `<Bits>`.

Grammar:

```
    token Bits
    {
        TODO
    }
```

Examples:

*TODO.*

## Blob

A **Blob** artifact has the dedicated concrete literal format
described by `<Blob>`.

Grammar:

```
    token Blob
    {
        TODO
    }
```

Examples:

*TODO.*

## Text / Attribute Name

A **Text** artifact has the dedicated concrete literal format
described by `<Text>`.

Grammar:

```
    token Text
    {
        TODO
    }
```

Examples:

*TODO.*

## Nesting / Attribute Name List

A **Nesting** artifact has the dedicated concrete literal format
described by `<Nesting>`.

Grammar:

```
    token Nesting
    {
        TODO
    }
```

Examples:

*TODO.*

# COLLECTIVE PRIMARY DATA TYPE POSSREPS

## Duo

A **Duo** artifact has the dedicated concrete literal format
described by `<Duo>`.

Grammar:

```
    token Duo
    {
        TODO
    }
```

Examples:

*TODO.*

## Lot

A **Lot** artifact has the dedicated concrete literal format
described by `<Lot>`.

Grammar:

```
    token Lot
    {
        TODO
    }
```

Examples:

*TODO.*

## Kit

A **Kit** artifact has the dedicated concrete literal format
described by `<Kit>`.

Grammar:

```
    token Kit
    {
        TODO
    }
```

Examples:

*TODO.*

## Article / Labelled Tuple

A **Article** artifact has the dedicated concrete literal format
described by `<Article>`.

Grammar:

```
    token Article
    {
        TODO
    }
```

Examples:

*TODO.*

## Excuse

A **Excuse** artifact has the dedicated concrete literal format
described by `<Excuse>`.

Grammar:

```
    token Excuse
    {
        TODO
    }
```

Examples:

*TODO.*

# GLOSSARY OF OCTETS

The following table enumerates the 256 octets in ascending numerical order
and their intended interpretations within MUON Packed Plain Text artifacts
usually in the context of their being the first octet of an artifact.

```
    PPT | PPT | Plain Text  | Meaning
    Oct | Chr | Literal     |
    ----+-----+-------------+----------------------------------------------
    00  |     | 0t0         | Text artifact or first "positional" Tuple/etc attribute name
    01  |     | 0t1         | Text artifact or second "positional" Tuple/etc attribute name
    ...
    1F  |     | 0t31        | Text artifact or 32nd "positional" Tuple/etc attribute name
    ----+-----+-------------+----------------------------------------------
    20  |     |             | (unassigned)
    ----+-----+-------------+----------------------------------------------
    21  | !   | 0bFALSE     | Boolean artifact false
    22  | "   |             | delimit quoted octet string
    23  | #   |             | (unassigned)
    24  | $   |             | (unassigned)
    25  | %   |             | (unassigned)
    26  | &   |             | (unassigned)
    27  | '   |             | (unassigned)
    28  | (   |             | delimit-start 2-ary/4-ary collection element list (Fraction/Duo/Article/Excuse)
    29  | )   |             | delimit-end 2-ary/4-ary collection element list (Fraction/Duo/Article/Excuse)
    2A  | *   |             | (unassigned)
    2B  | +   |             | Integer artifact prefix general case positive number
    2C  | ,   |             | separates N-ary collection list elements (Nesting/Lot/Kit)
    2D  | -   |             | Integer artifact prefix general case negative number
    2E  | .   | -1          | Integer artifact negative one
    2F  | /   |             | Fraction artifact prefix general case [numerator,denominator] pair
    ----+-----+-------------+----------------------------------------------
    30  | 0   | 0           | Integer artifact zero
    31  | 1   | 1           | Integer artifact positive one or Lot member multiplicity one
    ...
    39  | 9   | 9           | Integer artifact positive nine or Lot member multiplicity nine
    ----+-----+-------------+----------------------------------------------
    3A  | :   |             | separate the 2 parts of a pair in a Duo/Lot/Kit/Article/Excuse
    3B  | ;   |             | (unassigned)
    3C  | <   | -1.0        | Fraction artifact negative one
    3D  | =   | 0.0         | Fraction artifact zero
    3E  | >   | 1.0         | Fraction artifact positive one
    3F  | ?   | 0bTRUE      | Boolean artifact true
    40  | @   |             | (unassigned)
    ----+-----+-------------+----------------------------------------------
    41  | A   |             | Article artifact prefix general case
    42  | B   |             | Blob artifact prefix general case quoted string with N octets
    43  | C   |             | (unassigned)
    44  | D   |             | Duo artifact prefix general case
    45  | E   |             | Excuse artifact prefix general case
    46  | F   |             | (unassigned)
    47  | G   |             | (unassigned)
    48  | H   |             | (unassigned)
    49  | I   |             | (unassigned)
    4A  | J   |             | (unassigned)
    4B  | K   |             | Kit artifact prefix general case with N attributes
    4C  | L   |             | Lot artifact prefix general case with N members
    4D  | M   |             | (unassigned)
    4E  | N   |             | Nesting artifact prefix general case with N elements
    4F  | O   |             | (unassigned)
    50  | P   |             | (unassigned)
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
    5B  | [   |             | delimit-start N-ary collection element list (Nesting/Lot/Kit)
    5C  | \   |             | escape sequence prefix within quoted octet string
    5D  | ]   |             | delimit-end N-ary collection element list (Nesting/Lot/Kit)
    5E  | ^   |             | Fraction artifact prefix general case [numerator,denominator,radix,exponent] 4-tuple
    5F  | _   | 0iIGNORANCE | Ignorance artifact singleton
    60  | `   |             | delimit Self-Synchronization Mark or expendable padding/comments
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
    6B  | k   | ()          | Kit artifact with zero attributes
    6C  | l   | []          | Lot artifact with zero members
    6D  | m   |             | Lot artifact prefix special case with exactly 1 member (implicit multiplicity of 1)
    6E  | n   |             | Nesting artifact prefix special case with exactly 1 element
    6F  | o   |             | Blob artifact prefix special case string with exactly 1 octet element
    70  | p   |             | (unassigned)
    71  | q   |             | (unassigned)
    72  | r   |             | (unassigned)
    73  | s   | 0bb         | Bits artifact empty string
    74  | t   | ""          | Text artifact empty string
    ----+-----+-------------+----------------------------------------------
    75  | u   |             | Text artifact prefix special case UTF-8 string with exactly 1 octet / 1 ASCII character
    76  | v   |             | Text artifact prefix special case UTF-8 string with exactly 2 octets
    77  | w   |             | Text artifact prefix special case UTF-8 string with exactly 3 octets
    78  | x   |             | Text artifact prefix special case UTF-8 string with exactly 4 octets / 1 non-BMP Unicode character
    79  | y   |             | Text artifact prefix special case UTF-8 string with exactly 5 octets
    7A  | z   |             | Text artifact prefix special case UTF-8 string with exactly 6 octets
    ----+-----+-------------+----------------------------------------------
    7B  | {   |             | (unassigned)
    7C  | |   |             | (unassigned)
    7D  | }   |             | (unassigned)
    7E  | ~   |             | (unassigned)
    ----+-----+-------------+----------------------------------------------
    7F  |     |             | (unassigned)
    ----+-----+-------------+----------------------------------------------
    80  |     |             | (unassigned)
    ...
    FF  |     |             | (unassigned)
    ----+-----+-------------+----------------------------------------------
```

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
