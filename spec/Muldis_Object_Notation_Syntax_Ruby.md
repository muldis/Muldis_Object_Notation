<a name="TOP"></a>

# NAME

Muldis Object Notation (MUON) - Source code and data interchange format

# VERSION

The fully-qualified name of this document is
`Muldis_Object_Notation https://muldis.com 0.400.0`.

# PART

This artifact is part 18 of 22 of the document
`Muldis_Object_Notation https://muldis.com 0.400.0`;
its part name is `Syntax_Ruby`.

# CONTENTS

- [SYNOPSIS](#SYNOPSIS)
- [DESCRIPTION](#DESCRIPTION)
- [SIMPLE DATA TYPE POSSREPS](#SIMPLE-DATA-TYPE-POSSREPS)
    - [Ignorance](#Ignorance)
    - [Boolean](#Boolean)
    - [Integer](#Integer)
    - [Rational](#Rational)
    - [Bits](#Bits)
    - [Blob](#Blob)
    - [Text / Attribute Name](#Text---Attribute-Name)
    - [Nesting / Attribute Name List](#Nesting---Attribute-Name-List)
- [COLLECTIVE DATA TYPE POSSREPS](#COLLECTIVE-DATA-TYPE-POSSREPS)
    - [Pair](#Pair)
    - [Lot](#Lot)
    - [Kit](#Kit)
- [AUTHOR](#AUTHOR)
- [LICENSE AND COPYRIGHT](#LICENSE-AND-COPYRIGHT)

[RETURN](#TOP)

<a name="SYNOPSIS"></a>

# SYNOPSIS

```
    [:Muldis_Object_Notation_Syntax,[[:Lot_m,[:Ruby, "https://muldis.com", "0.400.0"]],
        [:Muldis_Object_Notation_Model,[[:Lot_m,[:Muldis_Data_Language, "https://muldis.com", "0.400.0"]],
            [:Relation,[:Lot_m,[
                {name: "Jane Ives", birth_date: [:Calendar_Instant,{y:1971,m:11,d:6}],
                    phone_numbers: [:Set,[:Lot_m,["+1.4045552995", "+1.7705557572"]]]},
                {name: "Layla Miller", birth_date: [:Calendar_Instant,{y:1995,m:8,d:27}],
                    phone_numbers: [:Set,[:Lot_m,[]]]},
                {name: "岩倉 玲音", birth_date: [:Calendar_Instant,{y:1984,m:7,d:6}],
                    phone_numbers: [:Set,[:Lot_m,["+81.9072391679"]]]},
            ]]]
        ]]
    ]]
```

[RETURN](#TOP)

<a name="DESCRIPTION"></a>

# DESCRIPTION

This document consists of multiple parts; for a directory to all of the
parts, see [Overview](Muldis_Object_Notation.md).

This part of the **Muldis Object Notation** document specifies the
canonical concrete Ruby hosted syntax of MUON,
which expresses a MUON artifact in terms of a native in-memory value or
object of the Ruby programming language,
version 3.2 (2022) or later,
as a non-cyclic data structure composed only using system-defined types.

The MUON `Syntax_Ruby` is derived from and maps with the MUON
[Syntax_Abstract](Muldis_Object_Notation_Syntax_Abstract.md); see that plus
[Semantics](Muldis_Object_Notation_Semantics.md) for further context.

The MUON Ruby hosted format is semi-lightweight and designed to support
interchange of source code and data between any 2 environments that do have
a common working memory and run the Ruby programming language, such as
because they collectively are part of a single process of a Ruby virtual
machine.  One typical use case is a Ruby library generic API that
accepts or returns structured data using a well-defined protocol such that
the library and its users require no common dependencies besides Ruby
standard library classes.  Another typical use case is the bridge format of
a Ruby library for generating or parsing MUON `Syntax_Plain_Text`.
The format is fairly easy for humans to read and write in terms of plain
Ruby source code.  It is fairly easy for machines to parse and generate.

The prescribed standard *syntax base name* of a *syntax-qualified artifact*
for a MUON Ruby hosted artifact is `Ruby`.

See also <https://ruby-lang.org>.

[RETURN](#TOP)

<a name="SIMPLE-DATA-TYPE-POSSREPS"></a>

# SIMPLE DATA TYPE POSSREPS

[RETURN](#TOP)

<a name="Ignorance"></a>

## Ignorance

An **Ignorance** artifact is any of the following:

* The only object of the Ruby singleton class `NilClass`,
which corresponds to the constant `nil`.

[RETURN](#TOP)

<a name="Boolean"></a>

## Boolean

A **Boolean** artifact is any of the following:

* The only object of the Ruby singleton class `FalseClass`,
which corresponds to the constant `false`.

* The only object of the Ruby singleton class `TrueClass`,
which corresponds to the constant `true`.

Not permitted for a **Boolean** is any of the following,
to keep things more correct and simpler:

* Any object of any numeric class such that zero/one represents false/true.

* Any object of some other class that might represent a boolean.

[RETURN](#TOP)

<a name="Integer"></a>

## Integer

An **Integer** artifact is any of the following:

* Any *SYS_Integer*.

A *SYS_Integer* is any of the following:

* Any object of the Ruby class `Integer`.

Not permitted for a *SYS_Integer* is any of the following,
to keep things more correct and simpler:

* Any object of any Ruby class that inherits from the Ruby class
`Numeric` besides `Integer`.

* Any object of any character string class such that it represents a
sequence of digits or anything else resembles a numeric literal.
This is because that would be interpreted as a **Text** artifact.

[RETURN](#TOP)

<a name="Rational"></a>

## Rational

A **Rational** artifact is any of the following:

* Any *SYS_Rational*.

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Rational`
and its *SYS_that* is any *SYS_Non_Qualified_Rational*.

A *SYS_Non_Qualified_Rational* is any of the following:

* Any *significand*.

* Any *SYS_Positional_Tuple_A* having exactly 1 element which
is the *significand*.

* Any *SYS_Positional_Tuple_A* having exactly 2 elements which in
ascending order are the *numerator* and *denominator*.

* Any *SYS_Positional_Tuple_A* having exactly 3 elements which in
ascending order are the *significand*, *radix*, and *exponent*.

* Any *SYS_Positional_Tuple_A* having exactly 4 elements which in
ascending order are the *numerator*, *denominator*, *radix*, and *exponent*.

A *significand* is any *SYS_Rational* or any *SYS_Integer*.

A *numerator* is any *SYS_Integer*.

A *denominator* is any *SYS_Integer* which denotes a nonzero integer.

A *radix* is any *SYS_Integer* which denotes an integer that is at least 2.

An *exponent* is any *SYS_Integer*.

A *SYS_Rational* is any of the following:

* Any object of the Ruby class `Rational`.

* Any object of the Ruby class `Float`
that represents a finite number or signed zero;
both signed zeroes are treated as the same plain zero.

Not permitted for a *SYS_Rational* is any of the following,
to keep things more correct and simpler:

* Any object of the Ruby class `Float`
that represents an infinity or NaN.

* Any object of any Ruby class that inherits from the Ruby class
`Numeric` besides `Float`, `Rational`.

* Any object of any character string class such that it represents a
sequence of digits or anything else resembles a numeric literal.
This is because that would typically be interpreted as a **Text** artifact.

[RETURN](#TOP)

<a name="Bits"></a>

## Bits

A **Bits** artifact is any of the following:

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Bits`
and its *SYS_that* is any *SYS_Blob*
such that every octet is in the set `0..1`.

Not permitted for a **Bits** is any of the following,
to prevent ambiguity and simplify things:

* Any *SYS_Blob*.
This is because that would be interpreted as a **Blob** artifact.

[RETURN](#TOP)

<a name="Blob"></a>

## Blob

A **Blob** artifact is any of the following:

* Any *SYS_Blob*.

A *SYS_Blob* is any of the following:

* Any *SYS_String* whose associated Ruby `Encoding` object
is `Encoding::ASCII_8BIT`.

Not permitted for a **SYS_Blob** is any of the following,
to prevent ambiguity and simplify things:

* Any *SYS_String* whose associated Ruby `Encoding` object
is not `Encoding::ASCII_8BIT`.

A *SYS_String* is any of the following:

* Any object of any of the Ruby classes `String`, `Symbol`.

[RETURN](#TOP)

<a name="Text---Attribute-Name"></a>

## Text / Attribute Name

A **Text** artifact is any of the following:

* Any *SYS_Text*.

A *SYS_Text* is any of the following:

* Any *SYS_String* whose associated Ruby `Encoding` object
is `Encoding::UTF_8`
and that is *well formed UTF-8*.

Not permitted for a *SYS_Text* is any of the following,
to keep things more correct and simpler:

* Any *SYS_String* whose associated Ruby `Encoding` object
is not `Encoding::UTF_8`
or that is not *well formed UTF-8*.

Note that *well formed UTF-8* means all octet sequences are valid Unicode
UTF-8 and there are no UTF-16 surrogate code points defined in it that
aren't in valid surrogate pairs.

[RETURN](#TOP)

<a name="Nesting---Attribute-Name-List"></a>

## Nesting / Attribute Name List

A **Nesting** artifact is any of the following:

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Nesting`
and its *SYS_that* is any *SYS_Nesting*.

Not permitted for a **Nesting** is any of the following,
to prevent ambiguity and simplify things:

* Any *SYS_Array_T*.  This is because that would be interpreted as
a **Pair** artifact all of whose members are any **Text** artifacts,
or as something invalid.

A *SYS_Nesting* is any of the following:

* Any *SYS_Array_T*.

* Any *SYS_Text*.

A *SYS_Array_T* is any of the following:

* Any *SYS_Array_A* such that each of its elements is any *SYS_Text*.

[RETURN](#TOP)

<a name="COLLECTIVE-DATA-TYPE-POSSREPS"></a>

# COLLECTIVE DATA TYPE POSSREPS

[RETURN](#TOP)

<a name="Pair"></a>

## Pair

A **Pair** artifact is any of the following:

* Any *SYS_Pair_AA* such that its *SYS_this* is *this*
(any **Any** artifact except for any of the *SYS_Text* values
`Ignorance`, `Boolean`, `Integer`, `Rational`, `Bits`, `Blob`, `Text`,
`Nesting`, `Pair`, `Lot_m`, `Lot_mm`, `Kit_a`, `Kit_na`)
and its *SYS_that* is *that* (any **Any** artifact).

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Pair`
and its *SYS_that* is
any *SYS_Pair_AA* such that its *SYS_this* is *this* (any **Any** artifact)
and its *SYS_that* is *that* (any **Any** artifact).

A *SYS_Pair_TA* is any of the following:

* Any *SYS_Pair_AA* such that its *SYS_this* is any *SYS_Text*.

A *SYS_Pair_AA* is any of the following:

* Any *SYS_Positional_Tuple_A* having exactly 2 elements
such that its first element is *SYS_this* and its second element is *SYS_that*.

[RETURN](#TOP)

<a name="Lot"></a>

## Lot

A **Lot** artifact is any of the following:

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Lot_m`
and its *SYS_that* is any *SYS_Non_Qualified_Lot_M*.

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Lot_mm`
and its *SYS_that* is
any *SYS_Ordered_Dictionary_AA* such that each of its elements in turn is
*multiplied member* whose element key is *member* (any **Any** artifact)
and whose element value is *multiplicity*
(any **Any** artifact but conceptually a real number);
this format can express any **Lot** such that every member is a **Text**,
such that an explicit multiplicity is specified for each member as a number
rather than by repeating the member value for each instance.

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Lot_mm`
and its *SYS_that* is
any *SYS_Array_DAA* such that each of its elements in turn is
*multiplied member* whose *SYS_this* is *member* (any **Any** artifact)
and whose *SYS_that* is *multiplicity*
(any **Any** artifact but conceptually a real number);
this format can express every possible **Lot**,
such that an explicit multiplicity is specified for each member as a number
rather than by repeating the member value for each instance.

A *SYS_Non_Qualified_Lot_M* is any of the following:

* Any *SYS_Array_A* such that each of its elements in turn is *member*
(any **Any** artifact) and its corresponding *multiplicity* is 1;
this format can express every possible **Lot**,
such that each distinct member repeats per instance.

A *SYS_Array_DAA* is any of the following:

* Any *SYS_Array_A* such that each of its elements is any *SYS_Pair_AA*.

A *SYS_Array_A* is any of the following:

* Any object of the Ruby class `Array`.

[RETURN](#TOP)

<a name="Kit"></a>

## Kit

A **Kit** artifact is any of the following:

* Any *SYS_Non_Qualified_Kit_NA*.

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Kit_a`
and its *SYS_that* is
any *SYS_Array_A* having at most 32 elements such that each of its elements
in turn is *attribute asset* (any **Any** artifact) and its corresponding
*attribute name* is the ordinal position of that element;
this format can express any **Kit** which has only normalized positional attributes
and which has 0..32 attributes,
so to specify 33 or more attributes, the general format must be used.

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Kit_na`
and its *SYS_that* is any *SYS_Non_Qualified_Kit_NA*.

A *SYS_Non_Qualified_Kit_NA* is any of the following:

* Any *SYS_Ordered_Dictionary_AA* such that each of its elements in turn is
*attribute* whose element key is *attribute name* (any *SYS_Text*)
and whose element value is *attribute asset* (any **Any** artifact);
this format can express every possible **Kit**.

A *SYS_Ordered_Dictionary_AA* is any of the following:

* Any object of the Ruby class `Hash`.

A *SYS_Positional_Tuple_A* is any of the following:

* Any *SYS_Array_A*.

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
