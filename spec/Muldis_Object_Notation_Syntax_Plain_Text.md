# NAME

Muldis Object Notation (MUON) -
Source code and data interchange format

# VERSION

The fully-qualified name of this document is
`Muldis_Object_Notation http://muldis.com 0.300.0`.

# PART

This artifact is part 3 of 3 of the document
`Muldis_Object_Notation http://muldis.com 0.300.0`;
its part name is `Syntax_Plain_Text`.

# SYNOPSIS

```
    `Muldis_Content_Predicate
    MCP version http://muldis.com 0.300.0 MCP
    MCP script Unicode 2.1 UTF-8 MCP
    MCP syntax Muldis_Object_Notation http://muldis.com 0.300.0 MCP
    MCP model Muldis_Data_Language http://muldis.com 0.300.0 MCP
    Muldis_Content_Predicate`

    \?%{
        (name : "Jane Ives", birth_date : \@(1971,11,06,,,),
            phone_numbers : {"+1.4045552995", "+1.7705557572"}),
        (name : "Layla Miller", birth_date : \@(1995,08,27,,,), phone_numbers : {}),
        (name : "岩倉 玲音", birth_date : \@(1984,07,06,,,),
            phone_numbers : {"+81.9072391679"}),
    }
```

# DESCRIPTION

This document consists of multiple parts; for a directory to all of the
parts, see [Overview](Muldis_Object_Notation.md).

This part of the **Muldis Object Notation** document specifies the
canonical plain text syntax of MUON which all other MUON syntaxes are
derived from and map with.

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

# DATA TYPE POSSREPS

**Muldis Object Notation** is mainly characterized by a set of *data type
possreps* or *possreps* (*possible representations*) that all *values*
represented with MUON syntax are characterized by.
Each MUON possrep corresponds 1:1 with a distinct grammar in each MUON syntax.

- Logical: Boolean
- Numeric: Integer, Fraction
- Stringy: Bits, Blob, Text
- Discrete: Array, Set, Bag, Mix
- Continuous: Interval, Interval Set, Interval Bag
- Structural: Tuple
- Relational: Tuple Array, Relation, Tuple Bag
- Locational: Calendar Time, Calendar Duration, Calendar Instant, Geographic Point
- Generic: Article, Excuse, Ignorance
- Source Code: Nesting, Heading, Renaming

See the DATA TYPE POSSREPS of [Semantics](
Muldis_Object_Notation_Semantics.md) for details and the intended
interpretation of each possrep, to provide valuable context for the grammar
and examples in the current part that isn't being repeated here.

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
sequence of Unicode *character code points*, each corresponding to an
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
to natively accept or return both **Text** and **Blob** values directly.
Typically this means providing 2 parsing or generating functions that
differ only in accepting or returning a **Text** or a **Blob**.
This can make the parsing or generating operations use less memory or time
by avoiding extra intermediate copies or conversions of the data; it should
be quite straightforward to parse or generate MUON octet streams directly.
This also means applications using them don't have to concern themselves as
much with explicit character decoding or encoding, and can simply feed or
output a file or network stream etc.

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

If a MUON parser supports scanning a *parsing unit* for a MCP *parsing unit
predicate*, then it is mandatory for any scan to look through the lesser of
the first 1000 characters, the first 2000 octets, or the entirety, of the
*parsing unit*, before it gives up on trying to find a *parsing unit
predicate*; giving up after that point is recommended.  To be specific,
only the entire first `Muldis_Content_Predicate` token needs to be found in
that scan area, and the rest of the *predicate* may extend past it.  This
means that any *predicate* needs to be located near the start of the
*parsing unit* if it has any expectation of being seen.  This requirement
exists to aid performance of a MUON parser by invalidating pathological
cases, so a parser doesn't have to scan a large *parsing unit* just in case
it might have a buried *predicate* that most likely isn't there at all.

Examples:

```
    `Muldis_Content_Predicate
    MCP version http://muldis.com 0.300.0 MCP
    MCP script Unicode 2.1 UTF-8 MCP
    MCP syntax Muldis_Object_Notation http://muldis.com 0.300.0 MCP
    MCP model Muldis_Data_Language http://muldis.com 0.300.0 MCP
    Muldis_Content_Predicate`
```

# GRAMMAR

The syntax and intended interpretation of the grammar itself seen in this
document should match that of the user-defined grammars feature of the Perl
6 (Raku) language, which is described by
[https://docs.perl6.org/language/grammars](
https://docs.perl6.org/language/grammars).

Any references like `<foo>` in either the grammar itself or in the written
documentation specifically refer to the corresponding grammar token `foo`.

See also the bundled actual Perl 6 module
[hosts/Perl6/lib/Muldis/Reference/Object_Notation.pm6](
../hosts/Perl6/lib/Muldis/Reference/Object_Notation.pm6)
which has an executable copy of the grammar.

Grammar:

```
    token MUON
    {
        <sp>?
            <Any>
        <sp>?
    }

    token sp
    {
        [<ws> | <quoted_sp_comment_str> | <entity_marker>]+
    }

    token ws
    {
        <[ \t \n \r \x[20] ]>+
    }

    token quoted_sp_comment_str
    {
        '`' <-[`]>* '`'
    }

    token entity_marker
    {
        '`\$\$\$`'
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

An `<entity_marker>` is a feature that is optional for a MUON parser or
generator to support.  It is syntactically a proper subset of a
`<quoted_sp_comment_str>` and would simply be seen as such by a MUON parser
that didn't specifically know about it.  An `<entity_marker>` is intended
as a trivial annotation for some MUON construct that immediately follows
it.  This is so that naive development tools that know about MUON
specifically but not about any source code defining data models layered
over it can be expressly pointed to the parts of the MUON document that
declare something interesting, such as a package or routine or type
declaration, so that generic MUON tooling can, say, generate a navigation
menu to quickly jump around a document to each entity declaration therein.
The idomatic location for an `<entity_marker>` is immediately before a
**Tuple** attribute name, assuming that the corresponding attribute value
is the construct of interest and the attribute name is used as the name to
refer to it with in function menus.

Examples:

```
    (
        `$$$` My_Func : (\Function : ...),

        `$$$` My_Proc_1 : (\Procedure : ...),

        `$$$` My_Proc_2 : (\Procedure : ...),
    )
```

## Any / Universal Type Possrep

The **Any** possrep is represented by `<Any>`.

Grammar:

```
    token Any
    {
        <opaque> | <collection>
    }

    token opaque
    {
          <Boolean>
        | <Integer>
        | <Fraction>
        | <Bits>
        | <Blob>
        | <Text>
        | <Calendar_Time>
        | <Calendar_Duration>
        | <Calendar_Instant>
        | <Geographic_Point>
        | <Ignorance>
        | <Nesting>
        | <Heading>
        | <Renaming>
    }

    token collection
    {
          <Array>
        | <Set>
        | <Bag>
        | <Mix>
        | <Interval>
        | <Interval_Set>
        | <Interval_Bag>
        | <Tuple>
        | <Tuple_Array>
        | <Relation>
        | <Tuple_Bag>
        | <Article>
        | <Excuse>
    }
```

An `<Any>` represents a generic value literal that is allowed to be of any
possrep at all, except where specifically noted otherwise.

An `<opaque>` is an `<Any>` that explicitly has no child `<Any>` nodes; in
conventional terms, one is typically for selecting scalar values, though
many cases are also simple collections.

A `<collection>` is an `<Any>` that explicitly does have child `<Any>`
nodes in the general case; in conventional terms, one is for selecting
values representing collections of other values.

## None / Empty Type Possrep

The **None** possrep
has no representation in the grammar, but is mentioned for parity.

## Boolean

A **Boolean** value is represented by `<Boolean>`.

Grammar:

```
    token Boolean
    {
        False | True
    }
```

Examples:

```
    False

    True
```

## Integer

An **Integer** value is represented by `<Integer>`.

Grammar:

```
    token Integer
    {
        <[+-]>? <ws>? <nonsigned_int>
    }

    token nonsigned_int
    {
          [ 0b <ws>?   <[ 0..1           ]>+ % [_ | <ws>]]
        | [ 0o <ws>?   <[ 0..7           ]>+ % [_ | <ws>]]
        | [[0d <ws>?]? <[ 0..9           ]>+ % [_ | <ws>]]
        | [ 0x <ws>?   <[ 0..9 A..F a..f ]>+ % [_ | <ws>]]
    }

    token compact_nonsigned_int
    {
          [ 0b   <[ 0..1           ]>+ % _]
        | [ 0o   <[ 0..7           ]>+ % _]
        | [[0d]? <[ 0..9           ]>+ % _]
        | [ 0x   <[ 0..9 A..F a..f ]>+ % _]
    }
```

This grammar supports writing **Integer** literals in any of the numeric
bases {2,8,10,16}, using conventional syntax.  The literal may optionally
contain underscore characters (`_`), which exist just to help with visual
formatting, such as for `10_000_000`.

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

    0d39

    0xDEADBEEF

    0o644

    0b11001001
```

## Fraction

A **Fraction** value is represented by `<Fraction>`.

Grammar:

```
    token Fraction
    {
        <significand> [<ws>? '*' <ws>? <radix> <ws>? '^' <ws>? <exponent>]?
    }

    token significand
    {
        <radix_point_sig> | <num_den_sig>
    }

    token radix_point_sig
    {
        <[+-]>? <ws>? <nonsigned_radix_point_sig>
    }

    token nonsigned_radix_point_sig
    {
          [ 0b <ws>?   [<[ 0..1           ]>+ % [_ | <ws>]] ** 2 % [<ws>? '.' <ws>?]]
        | [ 0o <ws>?   [<[ 0..7           ]>+ % [_ | <ws>]] ** 2 % [<ws>? '.' <ws>?]]
        | [[0d <ws>?]? [<[ 0..9           ]>+ % [_ | <ws>]] ** 2 % [<ws>? '.' <ws>?]]
        | [ 0x <ws>?   [<[ 0..9 A..F a..f ]>+ % [_ | <ws>]] ** 2 % [<ws>? '.' <ws>?]]
    }

    token num_den_sig
    {
        <numerator> <ws>? '/' <ws>? <denominator>
    }

    token numerator
    {
        <Integer>
    }

    token denominator
    {
        <nonsigned_int>
    }

    token radix
    {
        <nonsigned_int>
    }

    token exponent
    {
        <Integer>
    }
```

This grammar supports writing **Fraction** literals in any of the numeric
bases {2,8,10,16}, using conventional syntax.  The literal may optionally
contain underscore characters (`_`), which exist just to help with visual
formatting, such as for `20_194/17` or `3.141_59`.

The general form of a **Fraction** literal is `N/D*R^E` such that {N,D,R,E}
are each integers and the literal represents the rational number that
results from evaluating the mathematical expression using the following
implicit order of operations, `(N/D)*(R^E)` such that `/` means divide, `*`
means multiply, and `^` means exponentiate.

MUON does not require the numerator/denominator pair to be coprime, but
typically a type system will normalize the pair as such when determining
value identity.  Similarly, MUON does not require any other kind of
normalization between the components of a **Fraction** literal.

While the wider general format `N/D*R^E` can represent every rational
number, as can just the `N/D` portion by itself, the alternate but typical
format `X.X` can only represent a proper subset of the rational numbers,
that subset being every rational number that can be represented as a
terminating decimal number.  Note that every rational number that can be
represented as a terminating binary or octal or hexadecimal number can also
be represented as a terminating decimal number.

Note that in order to keep the grammar simpler or more predictable, each
**Fraction** component {N,D,R,E} must have its numeric base specified
individually, and so any component without a {`0b`,`0o`,`0x`} prefix will
be interpreted as base 10.  This keeps behaviour consistent with a parser
that sees a **Fraction** literal but interprets it as multiple **Integer**
literals separated by symbolic infix operators, evaluation order aside.
Also per normal expectations, literals in the format `X.X` only specify the
base at most once in total, *not* separately for the part after the `.`.

This grammar is subject to the additional rule that the integer denoted by
`<denominator>` must be nonzero.

This grammar is subject to the additional rule that the integer denoted by
`<radix>` must be at least 2.

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

    4.5207196*10^37

    0xDEADBEEF.FACE

    -0o35/0o3

    0b1.1

    0b1.011101101*0b10^-0b11011
```

## Bits

A **Bits** value is represented by `<Bits>`.

Grammar:

```
    token Bits
    {
        '\\~?' <ws>? [['"' <[ 0..1 _ ]>* '"']+ % <ws>]
    }
```

This grammar supports writing **Bits** literals in numeric base
2 only, using conventional syntax.  The literal may optionally contain
underscore characters (`_`), which exist just to help with visual
formatting.

Examples:

```
    \~?""

    \~?"00101110100010"

    \~?"00101110_100010"
```

## Blob

A **Blob** value is represented by `<Blob>`.

Grammar:

```
    token Blob
    {
        '\\~+' <ws>? [['"' [<[ 0..9 A..F a..f ]> ** 2 | _]* '"']+ % <ws>]
    }
```

This grammar supports writing **Blob** literals in numeric base
16 only, using conventional syntax.  The literal may optionally contain
underscore characters (`_`), which exist just to help with visual
formatting.

Examples:

```
    \~+""

    \~+"A705E416"

    \~+"A705_E416"
```

## Text / Attribute Name

A **Text** value is represented by `<Text>`.

Grammar:

```
    token Text
    {
        <quoted_text> | <code_point_text>
    }

    token quoted_text
    {
        ['"' <text_content> '"']+ % <ws>
    }

    token text_content
    {
        <text_nonescaped_content> | <text_escaped_content>
    }

    token text_nonescaped_content
    {
        [[<restricted_inside_char> & <-[\\]>] <restricted_inside_char>*]?
    }

    token text_escaped_content
    {
        '\\' [[<restricted_inside_char> & <-[\\]>] | <escaped_char>]*
    }

    token restricted_inside_char
    {
        <-[ \x[0]..\x[1F] "` \x[80]..\x[9F] ]>*
    }

    token escaped_char
    {
          '\\q' | '\\g'
        | '\\b'
        | '\\t' | '\\n' | '\\r'
        | ['\\c<' <code_point> '>']
    }

    token code_point_text
    {
        '\\~' <code_point>
    }

    token code_point
    {
        <compact_nonsigned_int>
    }
```

A `<Text>` may optionally be split into 1..N segments where each pair
of consecutive segments is separated by dividing space.
However the exact semantics of this for `<Text>` are different than for
other quotation-mark-delimited possreps; mainly it is that the optional
leading `\` is specified separately per segment and it only affects that
segment; also, individual character escape sequences may not cross segments.

This grammar is subject to the additional rule that the non-negative integer
denoted by `<code_point>` must be in the set {0..0xD7FF,0xE000..0x10FFFF}.

The meanings of the simple character escape sequences are:

```
    Esc | Unicode    | Unicode         | Chr | Literal character used
    Seq | Code Point | Character Name  | Lit | for when not escaped
    ----+------------+-----------------+-----+------------------------------
    \q  | 0x22    34 | QUOTATION MARK  | "   | delimit Text/opaque literals
    \g  | 0x60    96 | GRAVE ACCENT    | `   | delimit dividing space comments
    \b  | 0x5C    93 | REVERSE SOLIDUS | \   | no special meaning in non-escaped
    \t  | 0x9      9 | CHAR... TAB...  |     | control char horizontal tab
    \n  | 0xA     10 | LINE FEED (LF)  |     | ctrl char line feed / newline
    \r  | 0xD     13 | CARR. RET. (CR) |     | control char carriage return
```

There is just one complex escape sequence, of the format `\c<...>`, that
supports specifying characters in terms of their Unicode code point number.
One reason for this feature is to empower more elegant passing of
Unicode-savvy MUON through a communications channel that is more limited,
such as to 7-bit ASCII.

A `<code_point_text>` is a specialized shorthand for a **Text** of
exactly 1 character whose code point number it denotes.

Given that **Text** values or syntax serve double duty for not only regular
user data but also for attribute names of tuples or other kinds of
identifiers, the `<code_point_text>` variant provides a nicer alternative
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

An **Array** value is represented by `<Array>`.

Grammar:

```
    token Array
    {
        <ord_member_commalist>
    }

    token ord_member_commalist
    {
        '[' <sp>? <member_commalist> <sp>? ']'
    }
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
    [
        57,
        45,
        63,
        61,
        63,
    ]
```

## Set

A **Set** value is represented by `<Set>`.

Grammar:

```
    token Set
    {
        <nonord_member_commalist>
    }
```

A `<Set>` is subject to the additional rule that its
`<member_commalist>` must not have any `<multiplied_member>` elements
so that the `<Set>` can be
distinguished from every possible `<Bag>` and `<Mix>`.

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
    {
        3,
        16,
        85,
    }
```

## Bag / Multiset

A **Bag** value is represented by `<Bag>`.

Grammar:

```
    token Bag
    {
        <nonord_member_commalist>
    }

    token nonord_member_commalist
    {
        '{' <sp>? <member_commalist> <sp>? '}'
    }

    token member_commalist
    {
        [<single_member> | <multiplied_member> | '']+ % [<sp>? ',' <sp>?]
    }

    token single_member
    {
        <member>
    }

    token multiplied_member
    {
        <member> <sp>? ':' <sp>? <multiplicity>
    }

    token member
    {
        <Any>
    }

    token multiplicity
    {
        <compact_nonsigned_int>
    }
```

A `<Bag>` is subject to the additional rule that its
`<member_commalist>` must have at least 1 `<multiplied_member>` element
so that the `<Bag>` can be
distinguished from every possible `<Set>` and `<Mix>`.  An idiomatic way to
represent an empty **Bag** is to have exactly 1 `<multiplied_member>` whose
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
    {
        "Foo",
        "Quux" : 1,
        "Foo",
        "Bar",
        "Baz",
        "Baz",
    }
```

## Mix

A **Mix** value is represented by `<Mix>`.

Grammar:

```
    token Mix
    {
        <mix_nonord_member_commalist>
    }

    token mix_nonord_member_commalist
    {
        '{' <sp>? <mix_member_commalist> <sp>? '}'
    }

    token mix_member_commalist
    {
        [<mix_single_member> | <mix_multiplied_member> | '']+ % [<sp>? ',' <sp>?]
    }

    token mix_single_member
    {
        <member>
    }

    token mix_multiplied_member
    {
        <member> <sp>? ':' <sp>? <mix_multiplicity>
    }

    token mix_multiplicity
    {
        <Fraction> | <Integer>
    }
```

A `<Mix>` is subject to the additional rule that its
`<mix_member_commalist>` must have at least 1 `<mix_multiplied_member>`
element whose `<mix_multiplicity>` is an `<Fraction>`
so that the `<Mix>` can be distinguished from
every possible `<Set>` and `<Bag>`.  An idiomatic way to represent an empty
**Mix** is to have exactly 1 `<mix_multiplied_member>` whose
`<mix_multiplicity>` is zero.

Examples:

```
    `Zero members; we measured zero of nothing in particular.`
    {0:0.0}

    `One member; one gram of mass.`
    {\Gram: 1.0}

    `29.95 members (28.95 duplicates); the cost of a surgery.`
    {\USD: 29.95}

    `9.8 members; acceleration under Earth's gravity.`
    {\Meter_Per_Second_Squared: 9.8}

    `0.615 members (fractions of 3 distinct members); recipe.`
    {
        \Butter : 0.22,
        \Sugar  : 0.1,
        \Flour  : 0.275,
        \Sugar  : 0.02,
    }

    `4/3 members (fractions of 3 distinct members); this-mix.`
    {
        "Sugar": 1/3,
        "Spice": 1/4,
        "All_Things_Nice": 3/4,
    }

    `-1.5 members; adjustment for recipe.`
    {
        "Rice": +4.0,
        "Beans": -5.7,
        "Carrots": +0.2,
    }
```

## Interval

An **Interval** value is represented by `<Interval>`.

Grammar:

```
    token Interval
    {
        '\\..' <ws>? '{' <sp>? <interval_members> <sp>? '}'
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
        <interval_low>? <interval_boundary_kind> <interval_high>?
    }

    token interval_low
    {
        <Any>
    }

    token interval_high
    {
        <Any>
    }

    token interval_boundary_kind
    {
        '..' | '-..' | '..-' | '-..-'
    }
```

Examples:

```
    `Empty interval (zero members).`
    \..{}

    `Unit interval (one member).`
    \..{"abc"}

    `Closed interval (probably 10 members, depending on the model used).`
    \..{1..10}

    `Left-closed, right-open interval; every Fraction x in {2.7<=x<9.3}.`
    \..{2.7..-9.3}

    `Left-open, right-closed interval; every Text x ordered in {"a"<x<="z"}.`
    \..{"a"-.."z"}

    `Open interval; time period between Dec 6 and 20 excluding both.`
    \..{\@(2002,12,6,,,@"UTC") -..- \@(2002,12,20,,,@"UTC")}

    `Left-unbounded, right-closed interval; every Integer <= 3.`
    \..{..3}

    `Left-closed, right-unbounded interval; every Integer >= 29.`
    \..{29..}

    `Universal interval; unbounded; every value of type system is a member.`
    \..{..}
```

## Interval Set

An **Interval Set** value is represented by `<Interval_Set>`.

Grammar:

```
    token Interval_Set
    {
        '\\?..' <ws>? <nonord_interval_commalist>
    }
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

    `Set of all valid Unicode code points.`
    \?..{0..0xD7FF,0xE000..0x10FFFF}

    `Probably 15 members (no duplicates), depending on the model used.`
    \?..{1..10,6..15}

    `Probably same thing, regardless of data model used.`
    \?..{1..-6,6..10:2,10-..15}
```

## Interval Bag

An **Interval Bag** value is represented by `<Interval_Bag>`.

Grammar:

```
    token Interval_Bag
    {
        '\\+..' <ws>? <nonord_interval_commalist>
    }

    token nonord_interval_commalist
    {
        '{' <sp>? <interval_commalist> <sp>? '}'
    }

    token interval_commalist
    {
        [<single_interval> | <multiplied_interval> | '']+ % [<sp>? ',' <sp>?]
    }

    token single_interval
    {
        <interval_members>
    }

    token multiplied_interval
    {
        <interval_members> <sp>? ':' <sp>? <multiplicity>
    }
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

A **Tuple** value is represented by `<Tuple>`.

Grammar:

```
    token Tuple
    {
        '(' <sp>? <attr_commalist> <sp>? ')'
    }

    token attr_commalist
    {
        [<anon_attr> | <named_attr> | <nested_named_attr> | '']+ % [<sp>? ',' <sp>?]
    }

    token anon_attr
    {
        <attr_asset>
    }

    token named_attr
    {
        <attr_name> <sp>? ':' <sp>? <attr_asset>
    }

    token nested_named_attr
    {
        <nesting_attr_names> <sp>? ':' <sp>? <attr_asset>
    }

    token attr_asset
    {
        <Any>
    }
```

A `<Tuple>` is subject to the additional rule that, iff its
`<attr_commalist>` has exactly 1 `<*_attr>` element, that element
must have a leading or trailing comma,
so that the `<Tuple>` can be distinguished from every possible
`<Article>` (and from a superset grammar's generic grouping parenthesis).

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
    (
        name : "Michelle",
        age  : 17,
    )

    `Five leaf attributes in nested multi-level namespace.`
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

A **Tuple Array** value is represented by `<Tuple_Array>`.

Grammar:

```
    token Tuple_Array
    {
        '\\~%' <ws>? [<heading_attr_names> | <ord_member_commalist>]
    }
```

A `<Tuple_Array>` with an `<ord_member_commalist>` is subject to the
additional rule that its `<member_commalist>` has at least 1 `*_member`
element, and that every such `*_member` element's `<member>` is a
`<Tuple>`; otherwise the `<Tuple_Array>` must have a
`<heading_attr_names>`.

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

A **Relation** value is represented by `<Relation>`.

Grammar:

```
    token Relation
    {
        '\\?%' <ws>? [<heading_attr_names> | <nonord_member_commalist>]
    }
```

A `<Relation>` with a `<nonord_member_commalist>` is subject to the
additional rule that its `<member_commalist>` has at least 1 `*_member`
element, and that every such `*_member` element's `<member>` is a
`<Tuple>`; otherwise the `<Relation>` must have a
`<heading_attr_names>`.

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

    `Some people records.`
    \?%{
        (name : "Jane Ives", birth_date : \@(1971,11,06,,,),
            phone_numbers : {"+1.4045552995", "+1.7705557572"}),
        (name : "Layla Miller", birth_date : \@(1995,08,27,,,), phone_numbers : {}),
        (name : "岩倉 玲音", birth_date : \@(1984,07,06,,,),
            phone_numbers : {"+81.9072391679"}),
    }
```

## Tuple Bag

A **Tuple Bag** value is represented by `<Tuple_Bag>`.

Grammar:

```
    token Tuple_Bag
    {
        '\\+%' <ws>? [<heading_attr_names> | <nonord_member_commalist>]
    }
```

A `<Tuple_Bag>` with a `<nonord_member_commalist>` is subject to the
additional rule that its `<member_commalist>` has at least 1 `*_member`
element, and that every such `*_member` element's `<member>` is a
`<Tuple>`; otherwise the `<Tuple_Bag>` must have a
`<heading_attr_names>`.

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

## Calendar Time

A **Calendar Time** value is represented by `<Calendar_Time>`.

Grammar:

```
    token Calendar_Time
    {
        '\\@%' <ws>? '(' <ws>? <time_ymdhms> <ws>? ')'
    }

    token time_ymdhms
    {
        <time_ymd> <ws>? ',' <ws>? <time_hms>
    }

    token time_ymd
    {
        <year>? <ws>? ',' <ws>? <month>? <ws>? ',' <ws>? <day>?
    }

    token time_hms
    {
        <hour>? <ws>? ',' <ws>? <minute>? <ws>? ',' <ws>? <second>?
    }

    token year
    {
        <loc_multiplicity>
    }

    token month
    {
        <loc_multiplicity>
    }

    token day
    {
        <loc_multiplicity>
    }

    token hour
    {
        <loc_multiplicity>
    }

    token minute
    {
        <loc_multiplicity>
    }

    token second
    {
        <loc_multiplicity>
    }

    token loc_multiplicity
    {
        <Integer> | <Fraction>
    }
```

Examples:

```
    `No measurement was taken or specified at all.`
    \@%(,,,,,)

    `Either an unspecified period in 1970 or a duration of 1970 years.`
    \@%(1970,,,,,)

    `Either a civil calendar date 2015-5-3 or a duration of 2015y+5m+3d.`
    \@%(2015,5,3,,,)

    `Either a military calendar date 1998-300 or a duration of 1998y+300d.`
    \@%(1998,,300,,,)

    `Either the 6th week of 1776 or a duration of 1776 years + 6 weeks.`
    \@%(1776,,42,,,)

    `Either the first quarter of 1953 or a duration of 1953.25 years.`
    \@%(1953.25,,,,,)

    `Either high noon on an unspecified day or a duration of 12 hours.`
    \@%(,,,12,0,0)

    `Either a fully specified civil date and time or a 6-part duration.`
    \@%(1884,10,17,20,55,30)

    `Either an ancient date and time or a negative duration.`
    \@%(-370,1,24,11,0,0)

    `Either a time on some unspecified day or a duration of seconds.`
    \@%(,,,,,5923.21124603)
```

## Calendar Duration

A **Calendar Duration** value is represented by `<Calendar_Duration>`.

Grammar:

```
    token Calendar_Duration
    {
        '\\@+' <ws>? '(' <ws>? <time_ymdhms> <ws>? ')'
    }
```

Examples:

```
    `Addition of 2 years and 3 months.`
    \@+(2,3,0,0,0,0)

    `Subtraction of 22 hours.`
    \@+(0,0,0,-22,0,0)
```

## Calendar Instant

A **Calendar Instant** value is represented by `<Calendar_Instant>`.

Grammar:

```
    token Calendar_Instant
    {
        '\\@' <ws>?
        '(' <ws>?
            <instant_base> [<ws>? '@' <ws>? [<instant_offset> | <instant_zone>]]?
        <ws>? ')'
    }

    token instant_base
    {
        <time_ymdhms>
    }

    token instant_offset
    {
        <time_hms>
    }

    token instant_zone
    {
        <quoted_text>
    }
```

Examples:

```
    `The Day The Music Died (if paired with Gregorian calendar).`
    \@(1959,2,3,,,)

    `A time of day when one might have breakfast.`
    \@(,,,7,30,0)

    `What was now in the Pacific zone (if paired with Gregorian calendar).`
    \@(2018,9,3,20,51,17@-8,0,0)

    `A time of day in the UTC zone on an unspecified day.`
    \@(,,,9,25,0@0,0,0)

    `A specific day and time in the Pacific Standard Time zone.`
    \@(2001,4,16,20,1,44@"PST")
```

## Geographic Point

A **Geographic Point** value is represented by `<Geographic_Point>`.

Grammar:

```
    token Geographic_Point
    {
        '\\@@' <ws>?
        '(' <ws>?
            [[<longitude> | <latitude> | <elevation>]* % [<ws>? ',' <ws>?]]
        <ws>? ')'
    }

    token longitude
    {
        '>' <ws>? <loc_multiplicity>
    }

    token latitude
    {
        '^' <ws>? <loc_multiplicity>
    }

    token elevation
    {
        '+' <ws>? <loc_multiplicity>
    }
```

Examples:

```
    `No specified coordinates at all.`
    \@@()

    `Just an elevation specified.`
    \@@(+ 920)

    `Geographic surface coordinates of Googleplex; elevation not specified.`
    \@@(> -122.0857017, ^ 37.4218363)

    `Same thing.`
    \@@(^ 37.4218363, > -122.0857017)

    `Some location with all coordinates specified.`
    \@@(> -101, ^ -70, + 1000)

    `Another place.`
    \@@(> -94.746094, ^ 37.483577)
```

## Article / Labelled Tuple

An **Article** value is represented by `<Article>`.

Grammar:

```
    token Article
    {
        <generic_article> | <singleton_article>
    }

    token generic_article
    {
        <label_attrs_pair>
    }

    token label_attrs_pair
    {
        '(' <sp>? <label> <sp>? ':' <sp>? <attrs> <sp>? ')'
    }

    token label
    {
        <Any>
    }

    token attrs
    {
        <Tuple>
    }

    token singleton_article
    {
        '\\*' <ws>? <nesting_attr_names>
    }
```

Examples:

```
    (\Point : (x : 5, y : 3))

    (\Float : (
        significand : 45207196,
        radix       : 10,
        exponent    : 37,
    ))

    (\the_db::UTCDateTime : (
        year   : 2003,
        month  : 10,
        day    : 26,
        hour   : 1,
        minute : 30,
        second : 0.0,
    ))

    \*Positive_Infinity

    \*Negative_Zero
```

## Excuse

An **Excuse** value is represented by `<Excuse>`.

Grammar:

```
    token Excuse
    {
        <generic_excuse> | <singleton_excuse>
    }

    token generic_excuse
    {
        '\\!' <ws>? <label_attrs_pair>
    }

    token singleton_excuse
    {
        '\\!' <ws>? <nesting_attr_names>
    }
```

Examples:

```
    \!(\Input_Field_Wrong : (name : "Your Age"))

    \!Div_By_Zero

    \!No_Such_Attr_Name
```

## Ignorance

The singleton **Ignorance** value is represented by `<Ignorance>`.

Grammar:

```
    token Ignorance
    {
        '\\!!' <ws>? Ignorance
    }
```

Examples:

```
    \!!Ignorance
```

## Nesting / Attribute Name List

A **Nesting** value is represented by `<Nesting>`.

Grammar:

```
    token Nesting
    {
        '\\' <ws>? <nesting_attr_names>
    }

    token nesting_attr_names
    {
        <attr_name>+ % [<ws>? '::' <ws>?]
    }

    token attr_name
    {
        <nonord_attr_name> | <ord_attr_name>
    }

    token nonord_attr_name
    {
        <nonord_nonquoted_attr_name> | <quoted_text>
    }

    token nonord_nonquoted_attr_name
    {
        <[ A..Z _ a..z ]> <[ 0..9 A..Z _ a..z ]>*
    }

    token ord_attr_name
    {
        <code_point>
    }
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

A **Heading** value is represented by `<Heading>`.

Grammar:

```
    token Heading
    {
        '\\\$' <ws>? <heading_attr_names>
    }

    token heading_attr_names
    {
        '(' <sp>?
            [',' <sp>?]?
            [[<attr_name> | <ord_attr_name_range>]* % [<sp>? ',' <sp>?]]
            [<sp>? ',']?
        <sp>? ')'
    }

    token ord_attr_name_range
    {
        <ord_attr_name_low> <sp>? '..' <sp>? <ord_attr_name_high>
    }

    token ord_attr_name_low
    {
        <ord_attr_name>
    }

    token ord_attr_name_high
    {
        <ord_attr_name>
    }
```

An `<ord_attr_name_range>` is subject to the additional rule that its
integral `<ord_attr_name_low>` value must be less than or equal to its
integral `<ord_attr_name_high>` value.

Examples:

```
    `Zero attributes.`
    \$()

    `One named attribute.`
    \$(sales)

    `Same thing.`
    \$("sales")

    `One ordered attribute.`
    \$(0)

    `Same thing.`
    \$("\\c<0>")

    `Three named attributes.`
    \$(region,revenue,qty)

    `Three ordered attributes.`
    \$(0..2)

    `One of each.`
    \$(1,age)

    `Some attribute names can only appear quoted.`
    \$("Street Address")

    `A non-Latin name.`
    \$("サンプル")
```

## Renaming / Attribute Name Map

A **Renaming** value is represented by `<Renaming>`.

Grammar:

```
    token Renaming
    {
        '\\\$:' <ws>?
        '(' <sp>?
            [',' <sp>?]?
            [[<anon_attr_rename> | <named_attr_rename>]* % [<sp>? ',' <sp>?]]
            [<sp>? ',']?
        <sp>? ')'
    }

    token anon_attr_rename
    {
          ['->' <sp>? <attr_name_after>]
        | [<attr_name_after> <sp>? '<-']
        | [<attr_name_before> <sp>? '->']
        | ['<-' <sp>? <attr_name_before>]
    }

    token named_attr_rename
    {
          [<attr_name_before> <sp>? '->' <sp>? <attr_name_after>]
        | [<attr_name_after> <sp>? '<-' <sp>? <attr_name_before>]
    }

    token attr_name_before
    {
        <attr_name>
    }

    token attr_name_after
    {
        <attr_name>
    }
```

Each attribute renaming specification is a pair of attribute names marked
with a `->` or a `<-` element; the associated `<attr_name_before>` and
`<attr_name_after>` indicate the name that an attribute has *before* and
*after* the renaming operation, respectively.  Iff the renaming
specification is an `<anon_attr_rename>` then either the *before* or
*after* name is an ordered attribute name corresponding to the ordinal
position of the renaming specification element in the
`<Renaming>`, starting at zero.

A `<Renaming>` is subject to the additional rule that no 2
`<attr_name_before>` may be the same attribute name and that no 2
`<attr_name_after>` may be the same attribute name.

Examples:

```
    `Zero renamings, a no-op.`
    \$:()

    `Also a no-op.`
    \$:(age->age)

    `Rename one attribute.`
    \$:(fname->first_name)

    `Same thing.`
    \$:(first_name<-fname)

    `Swap 2 named attributes.`
    \$:(foo->bar,foo<-bar)

    `Convert ordered names to nonordered.`
    \$:(->foo,->bar)

    `Same thing.`
    \$:(0->foo,1->bar)

    `Convert nonordered names to ordered.`
    \$:(<-foo,<-bar)

    `Same thing.`
    \$:(0<-foo,1<-bar)

    `Swap 2 ordered attributes.`
    \$:(0->1,0<-1)

    `Same thing.`
    \$:(->1,->0)

    `Some attribute names can only appear quoted.`
    \$:("First Name"->"Last Name")
```

# RESERVED UNUSED SYNTAX

Muldis Object Notation reserves the use of certain syntaxes for various
reasons.  In some cases it doesn't use those syntaxes now but wants to
prevent other superset grammars of MUON from defining their own meanings,
regardless of whether MUON might use them in the future itself.  In other
cases it doesn't use those syntaxes expressly in order to empower superset
grammars to define their own meanings.

# Conceptual Possrep Prefixes

Muldis Object Notation is designed around the concept that every possrep
has its own pure symbolic prefix of the form `\foo` where `foo` is a
sequence of zero or more ASCII symbolic characters.  Some possreps actually
use this prefix, and other possreps actually eschew using it because doing
so makes actually writing or reading MUON more pleasant.

The following table enumerates those symbolic prefixes that are *not*
actually used, and so are called *conceptual prefixes*:

```
    Prefix | Possrep/partial | Possrep Instead Identified By
    -------+-----------------+-----------------------------------------------------
    \?     | Boolean         | bareword literal False or True
    \?     | Set             | {} or {...} without any colon
    \+     | Integer         | 0..9 without any ./*^
    \+     | Bag             | {...} with >= 1 colon followed by an Integer
    \/     | Fraction        | 0..9 with at least 1 of ./*^
    \/     | Mix             | {...} with >= 1 colon followed by a Fraction
    \~     | quoted-Text     | "" or "..."
    \~     | Array           | [] or [...]
    \%     | Tuple           | () or (...) with >= 1 comma
    \*     | generic-Article | (...:...) without any comma
```

A few more symbolic prefixes are currently not used but would be used if
particular possreps were added to MUON later.  If **Interval Mix** or
**Tuple Mix** are added, then `\/..{}` and `\/%()` plus `\/%{}`
respectively are reserved for them.

# Features For Superset Grammars

Muldis Object Notation is designed around a minimized set of *syntactic
namespaces* in order to leave as much useful syntax as possible for
superset grammars, such as ones defining a more full featured programming
language, a co-developed example being **Muldis Data Language**.

MUON groups all generic-context symbolic barewords into a single namespace
defined by a leading `\` which frees up all other possible symbol sequences
to be defined by the superset; as it isn't typical for any languages to use
a `\` for their symbolic operator names, the languages can be natural.

While MUON also has some free `.+-*/^`, those only appear adjacent to
numeric barewords and are considered part of those numeric literals, and so
shouldn't interfere with a superset using those for regular operators.

Likewise, any uses of `:` or `,` are only used by MUON within various kinds
of bracketing pairs and a superset should be able to also use them.

MUON has no alpha barewords except for `False` and `True` that can appear
in isolation from a `\foo` prefix, so to not interfere with any other
alpha keywords or reserved words a superset may want to use.

MUON does not use the single-quote string delimiter character `'` for
anything, and leaves it reserved for a superset to use as it sees fit.

MUON makes sure to avoid using the parenthesis pair `()` in any way that
might be confused with a superset using it as generic grouping syntax.
Any uses by MUON either has a `\foo` prefix or must contain a `,` or `:`.

MUON does not use the semicolon `;` for anything, so a superset grammar can
use it for things like separating statements and thus disambiguating its
own uses of bracketing characters to define statement or expression groups.

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
          |                        | * delimit quoted code identifiers/names
          |                        | * delimit Calendar-Instant zone names
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
          |                        | * delimit Set/Bag/Mix selectors
          |                        | * delimit Interval-Set/Interval-Bag selectors
          |                        | * delimit nonempty-Relation/Tuple-Bag sels
    ------+------------------------+---------------------------------------
    ()    | aordered collections   | * delimit heterogeneous aordered collections
          |                        |   of attributes, concept nominal+asset pairs
          |                        | * delimit Tuple/Article/Excuse selectors
          |                        | * delimit Heading literals
          |                        | * delimit empty-Tuple-Array/Relation/Tuple-Bag lits
          |                        | * delimit Calendar-*, Geographic-* literals
    ------+------------------------+---------------------------------------
    :     | pairings               | * indicates a pairing context
          |                        | * separates the 2 parts of a pair
          |                        | * optional pair separator in Array/Set sels
          |                        | * pair separator in Bag/Mix sels
          |                        | * optional attr name/asset separator in Tuple/Article/Excuse sels
          |                        | * optional pair separator in nonempty-TA/Rel/TB sels
          |                        | * label/attributes separator in Article/Excuse sels
          |                        | * disambiguate Bag/Mix sels from Set sel
          |                        | * L2 of prefix for Renaming literals
    ------+------------------------+---------------------------------------
    ,     | list builders          | * separates collection elements
          |                        | * separate members in Array/Set/Bag/Mix sels
          |                        | * separate members in nonempty-TA/Rel/TB sels
          |                        | * separate attributes in Tuple/Article/Excuse sels
          |                        | * separate attributes in Heading lits
          |                        | * disambiguate unary named Tuple sels from Article sels
          |                        | * separate elements in Calendar-*, Geographic-* lits
    ------+------------------------+---------------------------------------
    ~     | sequences/stitching    | * indicates a sequencing context
          |                        | * L1 of prefix for Bits/Blob literals
          |                        | * L1 of conceptual prefix for quoted-Text literals
          |                        | * L1 of prefix for code-point-Text literals
          |                        | * L1 of conceptual prefix for Array selectors
          |                        | * L1 of prefix for Tuple-Array lits/sels
    ------+------------------------+---------------------------------------
    ?     | qualifications/is?/so  | * indicates a qualifying/yes-or-no context
          |                        | * L1 of conceptual prefix for Boolean literals
          |                        | * L2 of prefix for Bits literals
          |                        | * L1 of conceptual prefix for Set selectors
          |                        | * L1 of prefix for Interval-Set selectors
          |                        | * L1 of prefix for Relation lits/sels
    ------+------------------------+---------------------------------------
    +     | quantifications/count  | * indicates an integral quantifying/count context
          |                        | * L1 of conceptual prefix for Integer literals
          |                        | * L2 of prefix for Blob literals
          |                        | * L1 of conceptual prefix for Bag selectors
          |                        | * L1 of prefix for Interval-Bag selectors
          |                        | * L1 of prefix for Tuple-Bag lits/sels
          |                        | * L2 of prefix for Calendar-Duration literals
          |                        | * indicates elevation in Geographic-Point literals
    ------+------------------------+---------------------------------------
    /     | fractions/measures     | * indicates a fractional quantifying/count context
          |                        | * L1 of conceptual prefix for Fraction literals
          |                        | * L1 of conceptual prefix for Mix selectors
          | division               | * disambiguate Fraction lit from Integer lit
          |                        | * numerator/denominator separator in Fraction literals
    ------+------------------------+---------------------------------------
    ..    | intervals/ranges       | * L1 of prefix for Interval selectors
          |                        | * L2 of prefix for Interval-Set/Interval-Bag selectors
          |                        | * pair separator in Interval/Ivl-Set/Ivl-Bag selectors
    ------+------------------------+---------------------------------------
    %     | tuples/heterogeneous   | * indicates that tuples are featured
          |                        | * L1 of conceptual prefix for Tuple selectors
          |                        | * L2 of prefix for Tuple-Array/Relation/Tuple-Bag lits/sels
          |                        | * L2 of prefix for Calendar-Time literals
    ------+------------------------+---------------------------------------
    @     | at/locators/when/where | * indicates temporals/spatials are featured
          |                        | * L1 of prefix for Calendar-*, Geographic-* literals
          |                        | * L2 of prefix for Geographic-Point literals
          |                        | * base/offset/zone separator in Calendar-Instant lits
    ------+------------------------+---------------------------------------
    *     | generics/whatever      | * indicates a generic type context
          |                        | * L1 of conceptual prefix for generic-Article selectors
          |                        | * L1 of prefix for singleton-Article literals
          | multiplication         | * significand/radix separator in Fraction literals
    ------+------------------------+---------------------------------------
    !     | excuses/but/not        | * indicates that excuses are featured
          |                        | * L1 of prefix for Excuse literals/selectors
    ------+------------------------+---------------------------------------
    $     | identifiers/names      | * indicates identifiers/names are featured
          |                        | * L1 of prefix for Heading literals
          |                        | * L1 of prefix for Renaming literals
          |                        | * a triple of this indicates an entity marker
    ------+------------------------+---------------------------------------
    -     | subtraction            | * indicates negative-Integer/Fraction literal
          |                        | * indicates open endpoint in Interval selectors
    ------+------------------------+---------------------------------------
    .     | radix point            | * disambiguate Fraction lit from Integer lit
    ------+------------------------+---------------------------------------
    ^     | exponentiation         | * radix/exponent separator in Fraction literals
          | up-pointing-arrow      | * indicates latitude in Geographic-Point literals
    ------+------------------------+---------------------------------------
    >     | right-pointing-arrow   | * indicates longitude in Geographic-Point literals
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

# SEE ALSO

*TODO.*

# AUTHOR

Darren Duncan - darren@DarrenDuncan.net

# LICENSE AND COPYRIGHT

This file is part of the formal specification named
**Muldis Object Notation** (**MUON**).

MUON is Copyright © 2002-2019, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of [Overview](Muldis_Object_Notation.md) for details.

# TRADEMARK POLICY

The TRADEMARK POLICY in [Overview](Muldis_Object_Notation.md) applies to this file too.

# ACKNOWLEDGEMENTS

The ACKNOWLEDGEMENTS in [Overview](Muldis_Object_Notation.md) apply to this file too.
