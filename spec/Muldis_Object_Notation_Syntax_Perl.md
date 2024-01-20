<a name="TOP"></a>

# NAME

Muldis Object Notation (MUON) - Source code and data interchange format

# VERSION

The fully-qualified name of this document is
`Muldis_Object_Notation https://muldis.com 0.400.0`.

# PART

This artifact is part 11 of 22 of the document
`Muldis_Object_Notation https://muldis.com 0.400.0`;
its part name is `Syntax_Perl`.

# CONTENTS

- [SYNOPSIS](#SYNOPSIS)
- [DESCRIPTION](#DESCRIPTION)
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
- [AUTHOR](#AUTHOR)
- [LICENSE AND COPYRIGHT](#LICENSE-AND-COPYRIGHT)

[RETURN](#TOP)

<a name="SYNOPSIS"></a>

# SYNOPSIS

```
    [Muldis_Object_Notation_Syntax=>[[Lot_m=>["Perl", "https://muldis.com", "0.400.0"]]=>
        [Muldis_Object_Notation_Model=>[[Lot_m=>["Muldis_Data_Language", "https://muldis.com", "0.400.0"]]=>
            [Relation=>[Lot_m=>[
                [Kit_na=>[
                    [name => "Jane Ives"],
                    [birth_date => [Calendar_Instant=>
                        [Kit_na=>[[y=>1971],[m=>11],[d=>6]]]]],
                    [phone_numbers => [Set=>[Lot_m=>["+1.4045552995", "+1.7705557572"]]]],
                ]],
                [Kit_na=>[
                    [name => "Layla Miller"],
                    [birth_date => [Calendar_Instant=>
                        [Kit_na=>[[y=>1995],[m=>8],[d=>27]]]]],
                    [phone_numbers => [Set=>[Lot_m=>[]]]],
                ]],
                [Kit_na=>[
                    [name => "岩倉 玲音"],
                    [birth_date => [Calendar_Instant=>
                        [Kit_na=>[[y=>1984],[m=>7],[d=>6]]]]],
                    [phone_numbers => [Set=>[Lot_m=>["+81.9072391679"]]]],
                ]],
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
canonical concrete Perl hosted syntax of MUON,
which expresses a MUON artifact in terms of a native in-memory value or
object of the Perl programming language,
version 5.38 (2023; or 5.8, 2002) or later,
as a non-cyclic data structure composed only using system-defined types.

The MUON `Syntax_Perl` is derived from and maps with the MUON
[Syntax_Abstract](Muldis_Object_Notation_Syntax_Abstract.md); see that plus
[Semantics](Muldis_Object_Notation_Semantics.md) for further context.

The MUON Perl hosted format is semi-lightweight and designed to support
interchange of source code and data between any 2 environments that do have
a common working memory and run the Perl programming language, such as
because they collectively are part of a single process of a Perl virtual
machine.  One typical use case is a Perl library generic API that
accepts or returns structured data using a well-defined protocol such that
the library and its users require no common dependencies besides Perl
standard library classes.  Another typical use case is the bridge format of
a Perl library for generating or parsing MUON `Syntax_Plain_Text`.
The format is fairly easy for humans to read and write in terms of plain
Perl source code.  It is fairly easy for machines to parse and generate.

The prescribed standard *syntax base name* of a *syntax-qualified artifact*
for a MUON Perl hosted artifact is `Perl`.

See also <https://perl.org>.

[RETURN](#TOP)

<a name="SIMPLE-DATA-TYPE-POSSREPS"></a>

# SIMPLE DATA TYPE POSSREPS

[RETURN](#TOP)

<a name="Ignorance"></a>

## Ignorance

An **Ignorance** artifact is any of the following:

* The special Perl `undef` value.

[RETURN](#TOP)

<a name="Boolean"></a>

## Boolean

A **Boolean** artifact is any of the following:

* Any *SYS_Boolean_as_of_536*.

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Boolean`
and its *SYS_that* is any *SYS_Boolean_as_of_536* or *SYS_Boolean_before_536*.

A *SYS_Boolean_as_of_536* is any of the following:

* Any *SYS_Scalar* that is canonically or "originally"
a Perl boolean value and only a boolean value,
such as the special Perl values resulting from `false`, `true`, `!!0`, `!!1`
when running under Perl versions at least 5.36;
these are not available when running under Perl versions prior to 5.36.

Not permitted for a *SYS_Boolean_as_of_536* is any of the following,
to keep things more correct and simpler:

* Any *SYS_Scalar* that is canonically or "originally"
a Perl numeric or string or anything else besides a boolean value;
these are all values when running under Perl versions prior to 5.36.

A *SYS_Boolean_before_536* is any of the following:

* Any of the special Perl values resulting from `!!0`, `!!1`
which are *SYS_Text* and *SYS_Integer* respectively
when running under Perl versions prior to 5.36.

Not permitted for a *SYS_Boolean_before_536* is any of the following,
to keep things more correct and simpler:

* Any *SYS_Scalar* that is not
any of the special Perl values resulting from `!!0`, `!!1`
when running under Perl versions prior to 5.36.

**WARNING:**  Due to the fundamental change of behavior introduced in Perl
5.36 concerning what values are flagged as being "originally" a Perl
boolean value, given any Perl source code that defines MUON `Syntax_Perl`
artifacts and that is intended to execute under both older and newer Perl
versions, all **Boolean** artifacts therein should use the fully-qualified
form based on *SYS_Pair_TA* to be portable.  If you use the unqualified form,
then the exact same Perl logic may produce values that are interpreted as
**Boolean** artifacts on higher Perl versions and as either **Text** or
**Integer** artifacts on lower Perl versions.

[RETURN](#TOP)

<a name="Integer"></a>

## Integer

An **Integer** artifact is any of the following:

* Any *SYS_Integer*.

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Integer`
and its *SYS_that* is any *SYS_Integer*.

A *SYS_Integer* is any of the following:

* Any object of the Perl class `Math::BigInt`
that represents a finite number or signed zero;
both signed zeroes are treated as the same plain zero.

* Any *SYS_Scalar* that is canonically or "originally"
a Perl integer value and only a integer value.

Not permitted for a *SYS_Integer* is any of the following,
to keep things more correct and simpler:

* Any object of the Perl class `Math::BigInt`
that represents an infinity or NaN.

* Any *SYS_Scalar* that is canonically or "originally"
a Perl boolean or float or string or anything else besides an integer value.

* Any value of any character string type such that it represents a
sequence of digits or anything else resembles a numeric literal.
This is because that would be interpreted as a **Text** artifact.

Note that the fully-qualified (via *SYS_Pair_TA*) form of an **Integer**
artifact could theoretically also support some formats of numeric-looking
character strings (via *SYS_Text*), but we currently disallow this to keep
things simpler and avoid possibly non-deterministic interpretation in the
face of the wide variety of formats that could exist, and instead we force
users to disambiguate by explicitly doing any string to number conversions
themselves before input, in the general case typically aided by
`Math::BigInt`.  This might be changed in the future if justified.

[RETURN](#TOP)

<a name="Rational"></a>

## Rational

A **Rational** artifact is any of the following:

* Any *SYS_Rational*.

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Rational`
and its *SYS_that* is any *SYS_Rational* or any *SYS_Binary* or any *SYS_Integer*.

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Rational`
and its *SYS_that* is
any *SYS_Pair_AA* such that its *SYS_this* and *SYS_that* correspond to
the *numerator* (any *SYS_Integer*) and *denominator* (any *SYS_Integer*
which denotes a nonzero integer) of the new **Rational** respectively.

A *SYS_Rational* is any of the following:

* Any object of the Perl class `Math::BigRat`
that represents a finite number or signed zero;
both signed zeroes are treated as the same plain zero.

[RETURN](#TOP)

<a name="Binary"></a>

## Binary

A **Binary** artifact is any of the following:

* Any *SYS_Binary*.

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Binary`
and its *SYS_that* is any *SYS_Binary* or any *SYS_Integer*.

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Binary`
and its *SYS_that* is
any *SYS_Pair_AA* such that its *SYS_this* and *SYS_that* correspond to
the *significand* (any *SYS_Binary* or any *SYS_Integer*) and *exponent*
(any *SYS_Integer*) of the new **Binary** respectively.

A *SYS_Binary* is any of the following:

* Any object of the Perl class `Math::BigFloat`
that represents a finite number or signed zero;
both signed zeroes are treated as the same plain zero.

* Any *SYS_Scalar* that is canonically or "originally"
a Perl float value and only a float value.

Not permitted for a *SYS_Binary* is any of the following,
to keep things more correct and simpler:

* Any object of the Perl class `Math::BigFloat`
that represents an infinity or NaN.

* Any *SYS_Scalar* that is canonically or "originally"
a Perl boolean or integer or string or anything else besides a float value.

* Any value of any character string type such that it represents a
sequence of digits or anything else resembles a numeric literal.
This is because that would typically be interpreted as a **Text** artifact.

[RETURN](#TOP)

<a name="Decimal"></a>

## Decimal

A **Decimal** artifact is any of the following:

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Decimal`
and its *SYS_that* is any *SYS_Integer*.

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Decimal`
and its *SYS_that* is
any *SYS_Pair_AA* such that its *SYS_this* and *SYS_that* correspond to
the *significand* (any *SYS_Integer*) and *exponent*
(any *SYS_Integer*) of the new **Decimal** respectively.

[RETURN](#TOP)

<a name="Bits"></a>

## Bits

A **Bits** artifact is any of the following:

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Bits`
and its *SYS_that* is any *SYS_String* whose UTF8 flag is false
such that every octet is in the set `0..1`.

[RETURN](#TOP)

<a name="Blob"></a>

## Blob

A **Blob** artifact is any of the following:

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Blob`
and its *SYS_that* is any *SYS_String* whose UTF8 flag is false.

Not permitted for a **Blob** is any of the following,
to prevent ambiguity and simplify things:

* Any *SYS_String*.
This is because that would be interpreted as a **Text** artifact if not invalid.

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Blob`
and its *SYS_that* is any *SYS_String* whose UTF8 flag is true.

[RETURN](#TOP)

<a name="Text---Attribute-Name"></a>

## Text / Attribute Name

A **Text** artifact is any of the following:

* Any *SYS_Text*.

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Text`
and its *SYS_that* is any *SYS_Text*.

A *SYS_Text* is any of the following:

* Any *SYS_String* either whose UTF8 flag is true
or all of whose octets are in the set `0..127`,
and that is *well formed UTF-8*.

Not permitted for a *SYS_Text* is any of the following,
to keep things more correct and simpler:

* Any *SYS_String* whose UTF8 flag is false
and which has at least one octet not in the set `0..127`,
or that is not *well formed UTF-8*.

Note that *well formed UTF-8* means all octet sequences are valid Unicode UTF-8
and there are no UTF-16 surrogate code points
defined in it that aren't in valid surrogate pairs.

A *SYS_String* is any of the following:

* Any *SYS_Scalar* that is canonically or "originally"
a Perl string value and only a string value.

Not permitted for a *SYS_String* is any of the following,
to keep things more correct and simpler:

* Any *SYS_Scalar* that is canonically or "originally"
a Perl boolean or numeric or anything else besides a string value.

A *SYS_Scalar* is any of the following:

* Any Perl defined non-reference non-dualvar value.

Not permitted for a *SYS_Scalar* is any of the following,
to keep things more correct and simpler:

* The special Perl `undef` value.

* Any Perl reference value, even if it could be coerced to a non-reference.

* Any Perl dualvar value.

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
`Ignorance`, `Boolean`, `Integer`, `Rational`, `Binary`, `Decimal`, `Bits`,
`Blob`, `Text`, `Nesting`, `Pair`, `Lot_m`, `Lot_mm`, `Kit_a`, `Kit_na`)
and its *SYS_that* is *that* (any **Any** artifact).

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Pair`
and its *SYS_that* is
any *SYS_Pair_AA* such that its *SYS_this* is *this* (any **Any** artifact)
and its *SYS_that* is *that* (any **Any** artifact).

A *SYS_Pair_TA* is any of the following:

* Any *SYS_Pair_AA* such that its *SYS_this* is any *SYS_Text*.

A *SYS_Pair_AA* is any of the following:

* Any *SYS_Array_A* having exactly 2 elements
such that its first element is *SYS_this* and its second element is *SYS_that*.

[RETURN](#TOP)

<a name="Lot"></a>

## Lot

A **Lot** artifact is any of the following:

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Lot_m`
and its *SYS_that* is any *SYS_Non_Qualified_Lot_M*.

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

* Any Perl non-blessed array-reference value.

Not permitted for a *SYS_Array_A* is any of the following,
to keep things more correct and simpler:

* Any Perl blessed array-reference value.

* Any Perl typeglob-reference value.

[RETURN](#TOP)

<a name="Kit"></a>

## Kit

A **Kit** artifact is any of the following:

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Kit_a`
and its *SYS_that* is
any *SYS_Array_A* having at most 32 elements such that each of its elements
in turn is *attribute asset* (any **Any** artifact) and its corresponding
*attribute name* is the ordinal position of that element;
this format can express any **Kit** which has only normalized positional attributes
and which has 0..32 attributes,
so to specify 33 or more attributes, the general format must be used;
this format is more concise than the general format.

* Any *SYS_Pair_TA* such that its *SYS_this* is the *SYS_Text* value `Kit_na`
and its *SYS_that* is any *SYS_Non_Qualified_Kit_NA*.

A *SYS_Non_Qualified_Kit_NA* is any of the following:

* Any *SYS_Array_DAA* such that each of its elements in turn is
*attribute* whose *SYS_this* is *attribute name* (any *SYS_Text*)
and whose *SYS_that* is *attribute asset* (any **Any** artifact);
this format can express every possible **Kit**.

Note that Perl non-blessed hash-reference values
are not used to represent collections of pairs because they are
unordered collections, and Perl doesn't provide any ordered analogy.

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
