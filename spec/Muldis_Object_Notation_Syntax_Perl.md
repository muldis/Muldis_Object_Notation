# NAME

Muldis Object Notation (MUON) - Source code and data interchange format

# VERSION

The fully-qualified name of this document is
`Muldis_Object_Notation https://muldis.com 0.300.0`.

# PART

This artifact is part 8 of 15 of the document
`Muldis_Object_Notation https://muldis.com 0.300.0`;
its part name is `Syntax_Perl`.

# SYNOPSIS

```
    [Syntax=>[[Lot=>["Muldis_Object_Notation_Perl", "https://muldis.com", "0.300.0"]] =>
        [Model=>[[Lot=>["Muldis_Data_Language", "https://muldis.com", "0.300.0"]] =>
            [Relation=>[Lot=>[
                {name => "Jane Ives", birth_date => [Calendar_Instant=>{y=>1971,m=>11,d=>6}],
                    phone_numbers => [Set=>[Lot=>["+1.4045552995", "+1.7705557572"]]]},
                {name => "Layla Miller", birth_date => [Calendar_Instant=>{y=>1995,m=>8,d=>27}],
                    phone_numbers => [Set=>[Lot=>[]]]},
                {name => "岩倉 玲音", birth_date => [Calendar_Instant=>{y=>1984,m=>7,d=>6}],
                    phone_numbers => [Set=>[Lot=>["+81.9072391679"]]]},
            ]]]
        ]]
    ]]
```

# DESCRIPTION

This document consists of multiple parts; for a directory to all of the
parts, see [Overview](Muldis_Object_Notation.md).

This part of the **Muldis Object Notation** document specifies the
canonical concrete Perl hosted syntax of MUON,
which expresses a MUON artifact in terms of a native in-memory value or
object of the Perl programming language,
version 5.36 (2022; or 5.8, 2002) or later,
as a non-cyclic data structure composed only using system-defined types.

The MUON `Syntax_Perl` is derived from and maps with the MUON
[Syntax_Abstract](Muldis_Object_Notation_Syntax_Abstract.md); see that plus
[Semantics](Muldis_Object_Notation_Semantics.md) for further context.

The MUON Perl-hosted format is semi-lightweight and designed to support
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

The prescribed standard *syntax predicate* of a **Syntax** signature for a
MUON Perl-hosted artifact is `Muldis_Object_Notation_Perl`.

See also <https://perl.org>.

# SIMPLE PRIMARY DATA TYPE POSSREPS

## Ignorance

An **Ignorance** artifact is any of the following:

* The special Perl `undef` value.

## Boolean

A **Boolean** artifact is any of the following:

* Any *SYS_Boolean_as_of_536*.

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `Boolean`
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
form based on *SYS_Duo_TA* to be portable.  If you use the unqualified form,
then the exact same Perl logic may produce values that are interpreted as
**Boolean** artifacts on higher Perl versions and as either **Text** or
**Integer** artifacts on lower Perl versions.

## Integer

An **Integer** artifact is any of the following:

* Any *SYS_Integer*.

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `Integer`
and its *SYS_that* is any *SYS_Integer*.

A *SYS_Integer* is any of the following:

* Any *SYS_Scalar* that is canonically or "originally"
a Perl integer value and only a integer value.

* Any object of the Perl class `Math::BigInt`
that represents a finite number or signed zero value;
both signed zeroes are treated as the same plain zero.

Not permitted for a *SYS_Integer* is any of the following,
to keep things more correct and simpler:

* Any *SYS_Scalar* that is canonically or "originally"
a Perl boolean or float or string or anything else besides an integer value.

* Any object of the Perl class `Math::BigInt` that represents an infinity or NaN.

* Any value of any character string type such that it represents a
sequence of digits or anything else resembles a numeric literal.
This is because that would be interpreted as a **Text** artifact.

Note that the fully-qualified (via *SYS_Duo_TA*) form of an **Integer**
artifact could theoretically also support some formats of numeric-looking
character strings (via *SYS_Text*), but we currently disallow this to keep
things simpler and avoid possibly non-deterministic interpretation in the
face of the wide variety of formats that could exist, and instead we force
users to disambiguate by explicitly doing any string to number conversions
themselves before input, in the general case typically aided by
`Math::BigInt`.  This might be changed in the future if justified.

## Fraction

A **Fraction** artifact is any of the following:

* Any *SYS_Fraction*.

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `Fraction`
and its *SYS_that* is the *significand*.

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `Fraction`
and its *SYS_that* is any *SYS_Tuple_Ordered* having exactly 1 element which
is the *significand*.

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `Fraction`
and its *SYS_that* is any *SYS_Tuple_Ordered* having exactly 2 elements which in
ascending order are the *numerator* and *denominator*.

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `Fraction`
and its *SYS_that* is any *SYS_Tuple_Ordered* having exactly 3 elements which in
ascending order are the *significand*, *radix*, and *exponent*.

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `Fraction`
and its *SYS_that* is any *SYS_Tuple_Ordered* having exactly 4 elements which in
ascending order are the *numerator*, *denominator*, *radix*, and *exponent*.

A *significand* is any *SYS_Fraction* or any *SYS_Integer*.

A *numerator* is any *SYS_Integer*.

A *denominator* is any *SYS_Integer* which denotes a nonzero integer.

A *radix* is any *SYS_Integer* which denotes an integer that is at least 2.

An *exponent* is any *SYS_Integer*.

A *SYS_Fraction* is any of the following:

* Any *SYS_Scalar* that is canonically or "originally"
a Perl float value and only a float value.

* Any object of the Perl class `Math::BigRat`
that represents a finite number or signed zero value;
both signed zeroes are treated as the same plain zero.

* Any object of the Perl class `Math::BigFloat`
that represents a finite number or signed zero value;
both signed zeroes are treated as the same plain zero.

Not permitted for a *SYS_Fraction* is any of the following,
to keep things more correct and simpler:

* Any *SYS_Scalar* that is canonically or "originally"
a Perl boolean or integer or string or anything else besides a float value.

* Any object of the Perl class `Math::BigRat` that represents an infinity or NaN.

* Any object of the Perl class `Math::BigFloat` that represents an infinity or NaN.

* Any value of any character string type such that it represents a
sequence of digits or anything else resembles a numeric literal.
This is because that would typically be interpreted as a **Text** artifact.

## Bits

A **Bits** artifact is any of the following:

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `Bits`
and its *SYS_that* is any *SYS_Array_A*
such that every element is either of the 2 *SYS_Integer* values `0`, `1`.

## Blob

A **Blob** artifact is any of the following:

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `Blob` and
its *SYS_that* is any *SYS_String* whose UTF8 flag is false.

Not permitted for a **Blob** is any of the following,
to prevent ambiguity and simplify things:

* Any *SYS_String*.
This is because that would be interpreted as a **Text** artifact if not invalid.

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `Blob` and
its *SYS_that* is any *SYS_String* whose UTF8 flag is true.

## Text / Attribute Name

A **Text** artifact is any of the following:

* Any *SYS_Text*.

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `Text` and
its *SYS_that* is any *SYS_Text*.

A *SYS_Text* is any of the following:

* Any *SYS_String* either whose UTF8 flag is true
or all of whose octets are in the set `0..127`,
and that is *well formed*.

Not permitted for a *SYS_Text* is any of the following,
to keep things more correct and simpler:

* Any *SYS_String* whose UTF8 flag is false
and which has at least one octet not in the set `0..127`,
or that is not *well formed*.

Note that *well formed* means all octet sequences are valid Unicode UTF-8
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

* Any *SYS_Duo_AA* such that its *SYS_this* is *this* (any **Any** artifact
except for any *Primary_Possrep_Name*) and its *SYS_that* is *that* (any
**Any** artifact).

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `Duo` and
its *SYS_that* is any *SYS_Duo_AA* such that its *SYS_this* is *this* (any
**Any** artifact) and its *SYS_that* is *that* (any **Any** artifact).

A *SYS_Duo_TA* is any of the following:

* Any *SYS_Duo_AA* such that its *SYS_this* is any *SYS_Text*.

A *SYS_Duo_AA* is any of the following:

* Any *SYS_Tuple_Ordered* having exactly 2 elements
such that its first element is *SYS_this* and its second element is *SYS_that*.

A *SYS_Duo_Over_Dictionary* is any of the following:

* Any *SYS_Dictionary* having exactly 1 element
such that this element's key is *SYS_this* and its value is *SYS_that*.

## Lot

A **Lot** artifact is any of the following:

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `Lot` and
its *SYS_that* is any *SYS_Array_A* such that each of its elements in turn is
*member* (any **Any** artifact) and its corresponding *multiplicity* is 1.

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `Lot` and
its *SYS_that* is any *SYS_Duo_Over_Dictionary*
such that its *SYS_this* is the *SYS_Text* value `multiplied` and
its *SYS_that* is any *SYS_Array_A* such that each of its elements in turn is
*multiplied member*, which is any *SYS_Duo_AA* such that its
*SYS_this* is *member* (any **Any** artifact) and its *SYS_that* is
*multiplicity* (any **Any** artifact but conceptually a real number).

A *SYS_Array_A* is any of the following:

* Any Perl non-blessed array-reference value.

Not permitted for a *SYS_Array_A* is any of the following,
to keep things more correct and simpler:

* Any Perl blessed array-reference value.

* Any Perl typeglob-reference value.

## Kit

A **Kit** artifact is any of the following:

* Any *SYS_Dictionary* such that each of its elements in turn is
*attribute* whose element key is *name* (any *SYS_Text*)
and whose element value is *asset* (any **Any** artifact);
this is the simplest format for the general case of any **Kit** having
named attributes for which we *don't* need the system to persist the
literal order of attributes in the source code.

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `Kit` and
its *SYS_that* is any *SYS_Tuple_Ordered* such that each of its elements
in turn is *attribute asset* (any **Any** artifact) and its corresponding
*attribute name* is the ordinal position of that element;
this is the simplest format for a **Kit** having only normalized ordered
attributes and with no special handling for nested tuples.

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `Kit` and
its *SYS_that* is any *SYS_Duo_Over_Dictionary*
such that its *SYS_this* is the *SYS_Text*
value `named` and its *SYS_that* is any *SYS_Array_A* such that each of
its elements in turn is *attribute*, which is any *SYS_Duo_AA*
such that its *SYS_this* is *name* (any *SYS_Text*) and its
*SYS_that* is *asset* (any **Any** artifact); this is the format for the
general case of any **Kit** having named attributes for which we *do* need
the system to persist the literal order of attributes in the source code.

A *SYS_Dictionary* is any of the following:

* Any Perl non-blessed hash-reference value.

Not permitted for a *SYS_Dictionary* is any of the following,
to keep things more correct and simpler:

* Any Perl blessed hash-reference value.

* Any Perl typeglob-reference value.

A *SYS_Tuple_Ordered* is any of the following:

* Any *SYS_Array_A*.

## Article / Labelled Tuple

An **Article** artifact is any of the following:

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `Article`
and its *SYS_that* is any *SYS_Duo_AA* such that
its *SYS_this* is *label* (any *SYS_Nesting*) and
its *SYS_that* is *attributes* (any **Kit** artifact).

## Excuse

An **Excuse** artifact is any of the following:

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `Excuse`
and its *SYS_that* is any *SYS_Duo_AA* such that
its *SYS_this* is *label* (any *SYS_Nesting*) and
its *SYS_that* is *attributes* (any **Kit** artifact).

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
