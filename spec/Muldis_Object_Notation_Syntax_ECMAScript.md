# NAME

Muldis Object Notation (MUON) - Source code and data interchange format

# VERSION

The fully-qualified name of this document is
`Muldis_Object_Notation https://muldis.com 0.300.0`.

# PART

This artifact is part 14 of 19 of the document
`Muldis_Object_Notation https://muldis.com 0.300.0`;
its part name is `Syntax_ECMAScript`.

# SYNOPSIS

```
    ["Syntax",[["Lot",["Muldis_Object_Notation_ECMAScript", "https://muldis.com", "0.300.0"]],
        ["Model",[["Lot",["Muldis_Data_Language", "https://muldis.com", "0.300.0"]],
            ["Relation",["Lot",[
                ["Kit",["named",[
                    ["name", "Jane Ives"],
                    ["birth_date", ["Calendar_Instant",
                        ["Kit",["named",[["y",1971],["m",11],["d",6]]]]]],
                    ["phone_numbers", ["Set",["Lot",["+1.4045552995", "+1.7705557572"]]]]
                ]]],
                ["Kit",["named",[
                    ["name", "Layla Miller"],
                    ["birth_date", ["Calendar_Instant",
                        ["Kit",["named",[["y",1995],["m",8],["d",27]]]]]],
                    ["phone_numbers", ["Set",["Lot",[]]]]
                ]]],
                ["Kit",["named",[
                    ["name", "岩倉 玲音"],
                    ["birth_date", ["Calendar_Instant",
                        ["Kit",["named",[["y",1984],["m",7],["d",6]]]]]],
                    ["phone_numbers", ["Set",["Lot",["+81.9072391679"]]]]
                ]]]
            ]]]
        ]]
    ]]
```

# DESCRIPTION

This document consists of multiple parts; for a directory to all of the
parts, see [Overview](Muldis_Object_Notation.md).

This part of the **Muldis Object Notation** document specifies the
canonical concrete ECMAScript hosted syntax of MUON,
which expresses a MUON artifact in terms of a native in-memory value or
object of the ECMAScript programming language,
version 13 (2022; or 11, 2020) or later,
as a non-cyclic data structure composed only using system-defined types.

The MUON `Syntax_ECMAScript` is derived from and maps with the MUON
[Syntax_Abstract](Muldis_Object_Notation_Syntax_Abstract.md); see that plus
[Semantics](Muldis_Object_Notation_Semantics.md) for further context.

The MUON ECMAScript-hosted format is semi-lightweight and designed to support
interchange of source code and data between any 2 environments that do have
a common working memory and run the ECMAScript programming language, such as
because they collectively are part of a single process of an ECMAScript virtual
machine.  One typical use case is an ECMAScript library generic API that
accepts or returns structured data using a well-defined protocol such that
the library and its users require no common dependencies besides ECMAScript
standard library classes.  Another typical use case is the bridge format of
an ECMAScript library for generating or parsing MUON `Syntax_Plain_Text`.
The format is fairly easy for humans to read and write in terms of plain
ECMAScript source code.  It is fairly easy for machines to parse and generate.

The prescribed standard *syntax predicate* of a **Syntax** signature for a
MUON ECMAScript-hosted artifact is `Muldis_Object_Notation_ECMAScript`.

See also <https://ecma-international.org/publications-and-standards/standards/ecma-262>.

# SIMPLE PRIMARY DATA TYPE POSSREPS

## Ignorance

An **Ignorance** artifact is any of the following:

* The only value of the ECMAScript singleton type `Null`.

Not permitted for an **Ignorance** is any of the following,
to keep things more correct and simpler:

* The only value of the ECMAScript singleton type `Undefined`.

## Boolean

A **Boolean** artifact is any of the following:

* Any value of the ECMAScript type `Boolean`.

Not permitted for a **Boolean** is any of the following,
to keep things more correct and simpler:

* Any value of any numeric type such that zero/one represents false/true.

* Any value of some other type that might represent a boolean.

## Integer

An **Integer** artifact is any of the following:

* Any *SYS_Integer*.

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `Integer`
and its *SYS_that* is any *SYS_Integer*.

Not permitted for an **Integer** is any of the following,
to keep things more correct and simpler:

* Any value of any character string type such that it represents a
sequence of digits or anything else resembles a numeric literal.
This is because that would be interpreted as a **Text** artifact.

A *SYS_Integer* is any of the following:

* Any *SYS_Fraction* that represents a whole number.

* Any value of the ECMAScript type `BigInt`.

Not permitted for a *SYS_Integer* is any of the following,
to keep things more correct and simpler:

* Any *SYS_Fraction* that doesn't represent a whole number.

Note that the type `BigInt` is only part of ECMAScript starting with
version 11 (2020), so that represents the minimum required to support MUON
for the general case of unlimited size numbers.

## Fraction

A **Fraction** artifact is any of the following:

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `Fraction`
and its *SYS_that* is any *SYS_Non_Qualified_Fraction*.

Not permitted for a **Fraction** is any of the following,
to keep things more correct and simpler:

* Any *SYS_Fraction*.
This is because that would often be interpreted as an **Integer** artifact.

* Any value of any character string type such that it represents a
sequence of digits or anything else resembles a numeric literal.
This is because that would typically be interpreted as a **Text** artifact.

A *SYS_Non_Qualified_Fraction* is any of the following:

* Any *significand*.

* Any *SYS_Ordered_Tuple_A* having exactly 1 element which
is the *significand*.

* Any *SYS_Ordered_Tuple_A* having exactly 2 elements which in
ascending order are the *numerator* and *denominator*.

* Any *SYS_Ordered_Tuple_A* having exactly 3 elements which in
ascending order are the *significand*, *radix*, and *exponent*.

* Any *SYS_Ordered_Tuple_A* having exactly 4 elements which in
ascending order are the *numerator*, *denominator*, *radix*, and *exponent*.

A *significand* is any *SYS_Fraction* or any *SYS_Integer*.

A *numerator* is any *SYS_Integer*.

A *denominator* is any *SYS_Integer* which denotes a nonzero integer.

A *radix* is any *SYS_Integer* which denotes an integer that is at least 2.

An *exponent* is any *SYS_Integer*.

A *SYS_Fraction* is any of the following:

* Any value of the ECMAScript type `Number`
that represents a finite number or signed zero;
both signed zeroes are treated as the same plain zero.

Not permitted for a *SYS_Fraction* is any of the following,
to keep things more correct and simpler:

* Any value of the ECMAScript type `Number`
that represents an infinity or NaN;
note that ECMAScript has exactly 3 of these special values in total,
which have the literals `-Infinity`, `+Infinity` (or `Infinity`), `NaN`.

## Bits

A **Bits** artifact is any of the following:

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `Bits`
and its *SYS_that* is any *SYS_String*
such that every element is in the set `0..1`.

## Blob

A **Blob** artifact is any of the following:

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `Blob`
and its *SYS_that* is any *SYS_String*
such that every element is in the set `0..255`.

Not permitted for a **Blob** is any of the following,
to prevent ambiguity and simplify things:

* Any *SYS_String*.
This is because that would be interpreted as a **Text** artifact if not invalid.

## Text / Attribute Name

A **Text** artifact is any of the following:

* Any *SYS_Text*.

A *SYS_Text* is any of the following:

* Any *SYS_String* that is *well formed UTF-16*.

Not permitted for a *SYS_Text* is any of the following,
to keep things more correct and simpler:

* Any *SYS_String* that is not *well formed UTF-16*.

Note that *well formed UTF-16* means all integer sequences are valid Unicode
UTF-16 and there are no UTF-16 surrogate code points defined in it that
aren't in valid surrogate pairs.

A *SYS_String* is any of the following:

* Any value of the ECMAScript type `String`.

## Nesting / Attribute Name List

A **Nesting** artifact is any of the following:

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `Nesting`
and its *SYS_that* is any *SYS_Nesting*.

Not permitted for a **Nesting** is any of the following,
to prevent ambiguity and simplify things:

* Any *SYS_Array_T*.  This is because that would be interpreted as
a **Duo** artifact all of whose members are any **Text** artifacts,
or as something invalid.

A *SYS_Nesting* is any of the following:

* Any *SYS_Array_T*.

* Any *SYS_Text*.

A *SYS_Array_T* is any of the following:

* Any *SYS_Array_A* such that each of its elements is any *SYS_Text*.

# COLLECTIVE PRIMARY DATA TYPE POSSREPS

## Duo

A **Duo** artifact is any of the following:

* Any *SYS_Duo_AA* such that its *SYS_this* is *this*
(any **Any** artifact except for any *Primary_Possrep_Name*
and except for the *SYS_Text* values `multiplied` and `named`)
and its *SYS_that* is *that* (any **Any** artifact).

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `Duo`
and its *SYS_that* is
any *SYS_Duo_AA* such that its *SYS_this* is *this* (any **Any** artifact)
and its *SYS_that* is *that* (any **Any** artifact).

A *SYS_Duo_TA* is any of the following:

* Any *SYS_Duo_AA* such that its *SYS_this* is any *SYS_Text*.

A *SYS_Duo_AA* is any of the following:

* Any *SYS_Ordered_Tuple_A* having exactly 2 elements
such that its first element is *SYS_this* and its second element is *SYS_that*.

## Lot

A **Lot** artifact is any of the following:

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `Lot`
and its *SYS_that* is any *SYS_Non_Qualified_Lot*.

A *SYS_Non_Qualified_Lot* is any of the following:

* Any *SYS_Non_Qualified_Array_Lot*.

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `multiplied`
and its *SYS_that* is
any *SYS_Array_DAA* such that each of its elements in turn is
*multiplied member* whose *SYS_this* is *member* (any **Any** artifact)
and whose *SYS_that* is *multiplicity*
(any **Any** artifact but conceptually a real number);
this format can express every possible **Lot**,
such that an explicit multiplicity is specified for each member as a number
rather than by repeating the member value for each instance.

A *SYS_Non_Qualified_Array_Lot* is any of the following:

* Any *SYS_Array_A* such that each of its elements in turn is *member*
(any **Any** artifact) and its corresponding *multiplicity* is 1;
this format can express every possible **Lot**,
such that each distinct member repeats per instance.

A *SYS_Array_DAA* is any of the following:

* Any *SYS_Array_A* such that each of its elements is any *SYS_Duo_AA*.

A *SYS_Array_A* is any of the following:

* Any value of the ECMAScript type `Array`.

## Kit

A **Kit** artifact is any of the following:

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `Kit`
and its *SYS_that* is any *SYS_Non_Qualified_Kit*.

A *SYS_Non_Qualified_Kit* is any of the following:

* Any *SYS_Array_A* such that each of its elements
in turn is *attribute asset* (any **Any** artifact) and its corresponding
*attribute name* is the ordinal position of that element;
this format can express any **Kit** which has only normalized ordered attributes;
this format is more concise than the general format.

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `named`
and its *SYS_that* is any *SYS_Non_Qualified_Named_Kit*.

A *SYS_Non_Qualified_Named_Kit* is any of the following:

* Any *SYS_Array_DAA* such that each of its elements in turn is
*attribute* whose *SYS_this* is *attribute name* (any *SYS_Text*)
and whose *SYS_that* is *attribute asset* (any **Any** artifact);
this format can express every possible **Kit**.

Note that values of the ECMAScript type `Map`
are not used to represent collections of pairs because the ECMAScript
language standard does not guarantee that they preserve the insertion order
of elements, even if the defacto standard implementations all do so.

A *SYS_Ordered_Tuple_A* is any of the following:

* Any *SYS_Array_A*.

## Article / Labelled Tuple

An **Article** artifact is any of the following:

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `Article`
and its *SYS_that* is any *SYS_Duo_AA* such that
its *SYS_this* is *label* (any *SYS_Nesting*) and
its *SYS_that* is *attributes* (any *SYS_Non_Qualified_Named_Kit*).

## Excuse

An **Excuse** artifact is any of the following:

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `Excuse`
and its *SYS_that* is any *SYS_Duo_AA* such that
its *SYS_this* is *label* (any *SYS_Nesting*) and
its *SYS_that* is *attributes* (any *SYS_Non_Qualified_Named_Kit*).

# ADDITIONAL SECONDARY DATA TYPE POSSREP FORMATS

## Calendar Instant

A **Calendar Instant** artifact is additionally any of the following:

* Any value of the ECMAScript type `Date`.

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