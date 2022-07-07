# NAME

Muldis Object Notation (MUON) - Source code and data interchange format

# VERSION

The fully-qualified name of this document is
`Muldis_Object_Notation https://muldis.com 0.300.0`.

# PART

This artifact is part 10 of 15 of the document
`Muldis_Object_Notation https://muldis.com 0.300.0`;
its part name is `Syntax_DotNet`.

# SYNOPSIS

```
    new KeyValuePair<String, Object>("Syntax", new KeyValuePair<String[], Object>(
        new String[]{"Muldis_Object_Notation", "https://muldis.com", "0.300.0"},
        new KeyValuePair<String, Object>("Model", new KeyValuePair<String[], Object>(
            new String[]{"Muldis_Data_Language", "https://muldis.com", "0.300.0"},
            new KeyValuePair<String, Object[]>("Relation", new Object[]{
                new Dictionary<String, Object>(){
                    {"name", "Jane Ives"},
                    {"birth_date", new KeyValuePair<String, Object>("Calendar_Instant",
                        new Dictionary<String, Int32>(){{"y", 1971}, {"m", 11}, {"d", 6}}
                    )},
                    {"phone_numbers", new KeyValuePair<String, Object[]>("Set",
                        new String[]{"+1.4045552995", "+1.7705557572"}
                    )}
                },
                new Dictionary<String, Object>(){
                    {"name", "Layla Miller"},
                    {"birth_date", new KeyValuePair<String, Object>("Calendar_Instant",
                        new Dictionary<String, Int32>(){{"y", 1995}, {"m", 8}, {"d", 27}}
                    )},
                    {"phone_numbers", new KeyValuePair<String, Object[]>("Set", new String[]{})}
                },
                new Dictionary<String, Object>(){
                    {"name", "岩倉 玲音"},
                    {"birth_date", new KeyValuePair<String, Object>("Calendar_Instant",
                        new Dictionary<String, Int32>(){{"y", 1984}, {"m", 7}, {"d", 6}}
                    )},
                    {"phone_numbers", new KeyValuePair<String, Object[]>("Set",
                        new String[]{"+81.9072391679"}
                    )}
                },
            })
        ))
    ))
```

# DESCRIPTION

This document consists of multiple parts; for a directory to all of the
parts, see [Overview](Muldis_Object_Notation.md).

This part of the **Muldis Object Notation** document specifies the
canonical concrete .NET/C\# hosted syntax of MUON,
which expresses a MUON artifact in terms of a native in-memory value or
object of the .NET/C\# programming language,
.NET version 6.0 (2021; or Framework 4.0, 2010) or later,
as a non-cyclic data structure composed only using system-defined types,
and specifically the subset that are *CLS-compliant*.

The MUON `Syntax_DotNet` is derived from and maps with the MUON
[Syntax_Abstract](Muldis_Object_Notation_Syntax_Abstract.md); see that plus
[Semantics](Muldis_Object_Notation_Semantics.md) for further context.

The MUON .NET-hosted format is semi-lightweight and designed to support
interchange of source code and data between any 2 environments that do have
a common working memory and run the .NET/C\# programming language, such as
because they collectively are part of a single process of a Common Language
Runtime (CLR).  One typical use case is a .NET library generic API that
accepts or returns structured data using a well-defined protocol such that
the library and its users require no common dependencies besides .NET
standard library classes.  Another typical use case is the bridge format of
a .NET library for generating or parsing MUON `Syntax_Plain_Text`.
The format is fairly easy for humans to read and write in terms of plain
.NET/C\# source code.  It is fairly easy for machines to parse and generate.

See also <https://dotnet.microsoft.com>.

# SIMPLE PRIMARY DATA TYPE POSSREPS

## Ignorance

An **Ignorance** artifact is any of the following:

* The special .NET `null` value.

Not permitted is any of the following, to keep things simpler:

* The only object of the .NET singleton class `System.DBNull`.

## Boolean

A **Boolean** artifact is any of the following:

* Any value of the .NET structure type `System.Boolean`.

Not permitted is any of the following, to keep things more correct and simpler:

* Any numeric type such that zero/one represents false/true.

* Any value of some other type that might represent a boolean.

## Integer

An **Integer** artifact is any of the following:

* Any value of any of the .NET structure types `System.Int32`, `System.Int64`.

* Any value of the .NET structure type `System.Numerics.BigInteger`.

Not permitted is any of the following, to keep things simpler:

* Any value of any of the .NET structure types `System.Byte`, `System.Int16`.

## Fraction

A **Fraction** artifact is any of the following:

* Any *SYS_Fraction*.

* Any *SYS_Duo* such that its *SYS_this* is the **Text** artifact `Fraction`
and its *SYS_that* is the *significand*.

* Any *SYS_Duo* such that its *SYS_this* is the **Text** artifact `Fraction`
and its *SYS_that* is any *SYS_Array* having exactly 1 element which
is the *significand*.

* Any *SYS_Duo* such that its *SYS_this* is the **Text** artifact `Fraction`
and its *SYS_that* is any *SYS_Array* having exactly 2 elements which in
ascending order are the *numerator* and *denominator*.

* Any *SYS_Duo* such that its *SYS_this* is the **Text** artifact `Fraction`
and its *SYS_that* is any *SYS_Array* having exactly 3 elements which in
ascending order are the *significand*, *radix*, and *exponent*.

* Any *SYS_Duo* such that its *SYS_this* is the **Text** artifact `Fraction`
and its *SYS_that* is any *SYS_Array* having exactly 4 elements which in
ascending order are the *numerator*, *denominator*, *radix*, and *exponent*.

A *significand* is any *SYS_Fraction* or any **Integer** artifact.

A *numerator* is any **Integer** artifact.

A *denominator* is any **Integer** artifact which denotes a nonzero integer.

A *radix* is any **Integer** artifact which denotes an integer that is at least 2.

An *exponent* is any **Integer** artifact.

A *SYS_Fraction* is any of the following:

* Any finite number or signed zero value of any of the .NET structure types
`System.Single`, `System.Double`;
both signed zeroes are treated as the same plain zero.

* Any value of the .NET structure type `System.Decimal`.

Not permitted for a *SYS_Fraction* is any of the following,
to keep things more correct and simpler:

* Any infinity or NaN value of any of the .NET structure types
`System.Single`, `System.Double`.

## Bits

A **Bits** artifact is any of the following:

* Any object of the .NET class `System.Collections.BitArray`.

## Blob

A **Blob** artifact is any of the following:

* Any *SYS_Duo* such that its *SYS_this* is the **Text** artifact `Blob`
and its *SYS_that* is any value of the .NET structure type array `System.Byte[]`.

Not permitted is any of the following, to prevent ambiguity and simplify things:

* Any value of the .NET structure type array `System.Byte[]`.
This is because to keep things simple we treat all standalone .NET array
values as being attempts at **Lot** artifacts, so we can succeed at
interpreting possreps or fail fast rather than having to scan a whole one
in case it is all `Byte` elements.

## Text / Attribute Name

A **Text** artifact is any of the following:

* Any object of the .NET class `System.String` that is *well formed*.

Not permitted is any of the following, to keep things simpler or more correct:

* Any object of the .NET class `System.String` that is not *well formed*.

* Any value of the .NET structure type `System.Char`.

* Any object of the .NET class `System.Text.StringBuilder`.

* Any raw or internal alternatives such as `Char[]`.

A .NET `System.String` is characterized as an ordered sequence of 0..N `System.Char`
such that each of the latter is an unsigned 16-bit integer *C*.
A *well formed* string denotes a Unicode BMP code point with a single *C*
in the non-surrogate set `{0..0xD7FF,0xE000..0xFFFF}`
(`System.Char.IsSurrogate()` is false) or it denotes a Unicode
non-BMP code point with an ordered pair of *C* each in the surrogate set
`{0xD800..0xDFFF}` (`System.Char.IsSurrogate()` is true) and the pair
is also well formed (`System.Char.IsSurrogatePair()` is true); a
*well formed* string does not contain any *C* in the surrogate set that
isn't so paired.

## Nesting / Attribute Name List

A **Nesting** artifact is any of the following:

* Any *SYS_Duo* such that its *SYS_this* is the **Text** artifact `Nesting`
and its *SYS_that* is any value of the .NET structure type array `System.String[]`
such that every element is any **Text** artifact.

* Any *SYS_Duo* such that its *SYS_this* is the **Text** artifact `Nesting`
and its *SYS_that* is any **Text** artifact.

Not permitted is any of the following, to prevent ambiguity and simplify things:

* Any value of the .NET structure type array `System.String[]`.
This is because that would be interpreted as a **Lot** artifact all of whose
members are any **Text** artifacts.

# COLLECTIVE PRIMARY DATA TYPE POSSREPS

## Duo

A **Duo** artifact is any of the following:

* Any *SYS_Duo* such that its *SYS_this* is *this* (any **Any** artifact
except for any *Primary_Possrep_Name*) and its *SYS_that* is *that* (any
**Any** artifact).

* Any *SYS_Duo* such that its *SYS_this* is the **Text** artifact `Duo` and
its *SYS_that* is any *SYS_Duo* such that its *SYS_this* is *this* (any
**Any** artifact) and its *SYS_that* is *that* (any **Any** artifact).

A *SYS_Duo* is any of the following:

* Any value of the .NET structure type `System.Collections.Generic.KeyValuePair`
such that its `Key` property is *SYS_this* and its `Value` property is *SYS_that*.

Not permitted for a *SYS_Duo* is any of the following, to keep things simpler:

* Any values or objects of N-ary collection types having exactly 2 elements.

## Lot

A **Lot** artifact is any of the following:

* Any *SYS_Array* such that each of its elements in turn is *member*
(any **Any** artifact) and its corresponding *multiplicity* is 1.

* Any *SYS_Duo* such that its *SYS_this* is the **Text** artifact `Lot` and
its *SYS_that* is any *SYS_Array* such that each of its elements in turn is
*multiplied member*, which is any *SYS_Duo* such that its
*SYS_this* is *member* (any **Any** artifact) and its *SYS_that* is
*multiplicity* (any **Any** artifact but conceptually a real number).

A *SYS_Array* is any of the following:

* Any object of any .NET array class
(an array class has a name like `foo[]` and is a class for whom
the predicate `Type.IsArray()` results in true).

* Any value of any .NET structure type
that composes the .NET interface `System.Collections.Generic.IList`.

* Any object of any .NET class
that composes the .NET interface `System.Collections.Generic.IList`.

Note that example composers of `System.Collections.Generic.IList` are:
`System.Collections.Immutable.ImmutableArray`,
`System.Collections.Generic.List`,
`System.Collections.Immutable.ImmutableList`.

## Kit / Multi-Level Tuple

A **Kit** artifact is any of the following:

* Any *SYS_Dictionary* such that each of its elements in turn is
*multi-level attribute* whose element key is *name* (any **Nesty** artifact)
and whose element key is *asset* (any **Any** artifact);
this is the simplest format for the general case of any **Kit** having
named attributes for which we *don't* need the system to persist the
literal order of attributes in the source code.

* Any *SYS_Tuple_Ordered* such that each of its elements in turn is
*attribute asset* (any **Any** artifact) and its corresponding *attribute
name* is the ordinal position of that element; this is one simplest format,
and the most canonical, for a **Kit** having only normalized ordered
attributes and with no special handling for nested tuples.

* Any *SYS_Duo* such that its *SYS_this* is the **Text** artifact `Kit` and
its *SYS_that* is any *SYS_Array* such that each of its elements in turn is
*attribute asset* (any **Any** artifact) and its corresponding *attribute
name* is the ordinal position of that element; this is another simplest
format, and less canonical, for a **Kit** having only normalized ordered
attributes and with no special handling for nested tuples.

* Any *SYS_Duo* such that its *SYS_this* is the **Text** artifact `Kit` and
its *SYS_that* is any *SYS_Duo* such that its *SYS_this* is the **Text**
artifact `named` and its *SYS_that* is any *SYS_Array* such that each of
its elements in turn is *multi-level attribute*, which is any *SYS_Duo*
such that its *SYS_this* is *name* (any **Nesty** artifact) and its
*SYS_that* is *asset* (any **Any** artifact); this is the format for the
general case of any **Kit** having named attributes for which we *do* need
the system to persist the literal order of attributes in the source code.

*TODO: Consider adding .NET anonymous types as an option if feasible.*

A *SYS_Dictionary* is any of the following:

* Any object of the .NET class `System.Collections.Generic.Dictionary`.

A *SYS_Tuple_Ordered* is any of the following:

* Any value of any .NET structure type
that composes the .NET interface `System.Runtime.CompilerServices.ITuple`.

* Any object of any .NET class
that composes the .NET interface `System.Runtime.CompilerServices.ITuple`.

Note that example composers of `System.Runtime.CompilerServices.ITuple` are:
`System.ValueTuple<...>`,
`System.Tuple<...>`.

Not permitted for a **Kit** is any of the following, to keep things simpler:

* Any object of the .NET class `System.Data.DataRow`.

## Article / Labelled Tuple

An **Article** artifact is any of the following:

* Any *SYS_Duo* such that its *SYS_this* is the **Text** artifact `Article`
and its *SYS_that* is any *SYS_Duo* such that its *SYS_this* is *label*
(any **Nesty** artifact) and its *SYS_that* is *attributes* (any **Kit**
artifact such that every one of its *multi-level attribute names* has
exactly 1 element).

## Excuse

An **Excuse** artifact is any of the following:

* Any *SYS_Duo* such that its *SYS_this* is the **Text** artifact `Excuse`
and its *SYS_that* is any *SYS_Duo* such that its *SYS_this* is *label*
(any **Nesty** artifact) and its *SYS_that* is *attributes* (any **Kit**
artifact such that every one of its *multi-level attribute names* has
exactly 1 element).

# ADDITIONAL SECONDARY DATA TYPE POSSREP FORMATS

## Calendar Duration

A **Calendar Duration** artifact is additionally any of the following:

* Any value of the .NET structure type `System.TimeSpan`.

## Calendar Instant

A **Calendar Instant** artifact is additionally any of the following:

* Any value of any of the .NET structure types
`System.DateTime`,
`System.DateTimeOffset`.

## Geographic Point

A **Geographic Point** artifact is additionally any of the following:

* Any coordinate-specifying object of the .NET class
`System.Data.Spatial.DbGeography`.

*TODO: Check if DbGeography is actually in .NET 5+ or not.*

## Set

A **Set** artifact is additionally any of the following:

* Any object of any .NET class
that composes the .NET interface `System.Collections.Generic.ISet`
such that each of its elements in turn is *member* (any **Any** artifact).

Note that example composers of `System.Collections.Generic.ISet` are:
`System.Collections.Generic.HashSet`,
`System.Collections.Generic.SortedSet`,
`System.Collections.Immutable.ImmutableHashSet`.
`System.Collections.Immutable.ImmutableSortedSet`.

## Bag / Multiset

A **Bag** artifact is additionally any of the following:

* Any object of the .NET class `System.Collections.Concurrent.ConcurrentBag`
such that each of its elements in turn is *member* (any **Any** artifact).

*TODO: Revisit this.*

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
