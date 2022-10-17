# NAME

Muldis Object Notation (MUON) - Source code and data interchange format

# VERSION

The fully-qualified name of this document is
`Muldis_Object_Notation https://muldis.com 0.300.0`.

# PART

This artifact is part 17 of 19 of the document
`Muldis_Object_Notation https://muldis.com 0.300.0`;
its part name is `Syntax_PHP`.

# SYNOPSIS

```
    ["Syntax",[["Lot",["Muldis_Object_Notation_PHP", "https://muldis.com", "0.300.0"]],
        ["Model",[["Lot",["Muldis_Data_Language", "https://muldis.com", "0.300.0"]],
            ["Relation",["Lot",[
                [
                    "name" => "Jane Ives",
                    "birth_date" => ["Calendar_Instant",["y"=>1971,"m"=>11,"d"=>6]],
                    "phone_numbers" => ["Set",["Lot",["+1.4045552995", "+1.7705557572"]]],
                ],
                [
                    "name" => "Layla Miller",
                    "birth_date" => ["Calendar_Instant",["y"=>1995,"m"=>8,"d"=>27]],
                    "phone_numbers" => ["Set",["Lot",[]]],
                ],
                [
                    "name" => "岩倉 玲音",
                    "birth_date" => ["Calendar_Instant",["y"=>1984,"m"=>7,"d"=>6]],
                    "phone_numbers" => ["Set",["Lot",["+81.9072391679"]]],
                ],
            ]]]
        ]]
    ]]
```

# DESCRIPTION

This document consists of multiple parts; for a directory to all of the
parts, see [Overview](Muldis_Object_Notation.md).

This part of the **Muldis Object Notation** document specifies the
canonical concrete PHP hosted syntax of MUON,
which expresses a MUON artifact in terms of a native in-memory value or
object of the PHP programming language, version 8.1 (2021) or later,
as a non-cyclic data structure composed only using system-defined types.

The MUON `Syntax_PHP` is derived from and maps with the MUON
[Syntax_Abstract](Muldis_Object_Notation_Syntax_Abstract.md); see that plus
[Semantics](Muldis_Object_Notation_Semantics.md) for further context.

The MUON PHP-hosted format is semi-lightweight and designed to support
interchange of source code and data between any 2 environments that do have
a common working memory and run the PHP programming language, such as
because they collectively are part of a single process of a PHP virtual
machine.  One typical use case is a PHP library generic API that
accepts or returns structured data using a well-defined protocol such that
the library and its users require no common dependencies besides PHP
standard library classes.  Another typical use case is the bridge format of
a PHP library for generating or parsing MUON `Syntax_Plain_Text`.
The format is fairly easy for humans to read and write in terms of plain
PHP source code.  It is fairly easy for machines to parse and generate.

The prescribed standard *syntax predicate* of a **Syntax** signature for a
MUON PHP-hosted artifact is `Muldis_Object_Notation_PHP`.

See also <https://php.net>.

# SIMPLE PRIMARY DATA TYPE POSSREPS

## Ignorance

An **Ignorance** artifact is any of the following:

* The special PHP `null` value.

## Boolean

A **Boolean** artifact is any of the following:

* Any value of the PHP type `bool`.

Not permitted for a **Boolean** is any of the following,
to keep things more correct and simpler:

* Any value of any numeric type such that zero/one represents false/true.

* Any value of some other type that might represent a boolean.

## Integer

An **Integer** artifact is any of the following:

* Any *SYS_Integer*.

A *SYS_Integer* is any of the following:

* Any value of the PHP type `int`.

* Any object of the PHP class `GMP`
that represents a finite number or signed zero;
both signed zeroes are treated as the same plain zero.

Not permitted for a *SYS_Integer* is any of the following,
to keep things more correct and simpler:

* Any object of the PHP class `GMP`
that represents an infinity or NaN.

* Any value of any character string type such that it represents a
sequence of digits or anything else resembles a numeric literal.
This is because that would be interpreted as a **Text** artifact.

Note, since its name isn't descriptive in that respect, that the PHP `GMP`
class is integer-specific and doesn't implement non-integral numbers.

Note that the PHP `BCMath` library uses PHP character strings to represent
numbers and doesn't have its own PHP type we can use, in contrast with `GMP`.

## Fraction

A **Fraction** artifact is any of the following:

* Any *SYS_Fraction*.

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `Fraction`
and its *SYS_that* is any *SYS_Non_Qualified_Fraction*.

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

* Any value of the PHP type `float`
that represents a finite number or signed zero;
both signed zeroes are treated as the same plain zero.

Not permitted for a *SYS_Fraction* is any of the following,
to keep things more correct and simpler:

* Any value of the PHP type `float`
that represents an infinity or NaN.

* Any value of any character string type such that it represents a
sequence of digits or anything else resembles a numeric literal.
This is because that would typically be interpreted as a **Text** artifact.

## Bits

A **Bits** artifact is any of the following:

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `Bits`
and its *SYS_that* is any *SYS_String*
such that every octet is in the set `0..1`.

## Blob

A **Blob** artifact is any of the following:

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `Blob`
and its *SYS_that* is any *SYS_String*.

Not permitted for a **Blob** is any of the following,
to prevent ambiguity and simplify things:

* Any *SYS_String*.
This is because that would be interpreted as a **Text** artifact if not invalid.

A *SYS_String* is any of the following:

* Any value of the PHP type `string`.

Note that a PHP `string` value is officially a generic octet sequence
with no further native semantics.  One is treated as a character string
only by convention, and different PHP functions or other contexts may
expect that it represents characters in a particular character encoding and
don't usually auto-detect which of several it may be.

Note that while a PHP `string` is semantically a MUON **Blob** in its
purest form, we choose to use (a restricted subset of) it non-qualified to
mean a **Text** instead because that is much better huffman coding, since
typical MUON use cases would involve **Text** artifacts more likely by
several orders of magnitude than **Blob** artifacts.

## Text / Attribute Name

A **Text** artifact is any of the following:

* Any *SYS_Text*.

A *SYS_Text* is any of the following:

* Any *SYS_String* that is *well formed UTF-8*.

Not permitted for a *SYS_Text* is any of the following,
to keep things more correct and simpler:

* Any *SYS_String* that is not *well formed UTF-8*.

Note that *well formed UTF-8* means all octet sequences are valid Unicode
UTF-8 and there are no UTF-16 surrogate code points defined in it that
aren't in valid surrogate pairs.

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
and except for the *SYS_Text* value `multiplied`)
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

* Any *SYS_Ordered_Dictionary_AA* such that each of its elements in turn is
*multiplied member* whose element key is *member* (any **Text** artifact)
and whose element value is *multiplicity*
(any **Any** artifact but conceptually a real number);
this format can express any **Lot** such that every member is a **Text**,
such that an explicit multiplicity is specified for each member as a number
rather than by repeating the member value for each instance.

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

* Any value of the PHP type `array` for which `array_is_list()` is true.

Not permitted for a *SYS_Array_A* is any of the following,
to prevent ambiguity and simplify things:

* Any value of the PHP type `array` for which `array_is_list()` is false.

Note that `array_is_list()` is only built-in to PHP starting with version
8.1 (2021), but it can be implemented in user code on older PHP versions.

## Kit

A **Kit** artifact is any of the following:

* Any *SYS_Non_Qualified_Named_Kit*.

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `Kit`
and its *SYS_that* is any *SYS_Non_Qualified_Kit*.

A *SYS_Non_Qualified_Kit* is any of the following:

* Any *SYS_Array_A* such that each of its elements
in turn is *attribute asset* (any **Any** artifact) and its corresponding
*attribute name* is the ordinal position of that element;
this format can express any **Kit** which has only normalized ordered attributes
or which has zero attributes.

* Any *SYS_Non_Qualified_Named_Kit*.

A *SYS_Non_Qualified_Named_Kit* is any of the following:

* Any *SYS_Ordered_Dictionary_AA* such that each of its elements in turn is
*attribute* whose element key is *attribute name* (any *SYS_Text*)
and whose element value is *attribute asset* (any **Any** artifact);
this format can express any **Kit** which has at least one non-ordered attribute.

A *SYS_Ordered_Dictionary_AA* is any of the following:

* Any value of the PHP type `array` for which `array_is_list()` is false.

Not permitted for a *SYS_Ordered_Dictionary_AA* is any of the following,
to prevent ambiguity and simplify things:

* Any value of the PHP type `array` for which `array_is_list()` is true.

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

## Calendar Duration

A **Calendar Duration** artifact is additionally any of the following:

* Any object of the PHP class `DateInterval`.

## Calendar Instant

A **Calendar Instant** artifact is additionally any of the following:

* Any object of any of the PHP classes `DateTime`, `DateTimeImmutable`.

## Interval

An **Interval** artifact is additionally any of the following:

* Any object of the PHP class `DatePeriod`.

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