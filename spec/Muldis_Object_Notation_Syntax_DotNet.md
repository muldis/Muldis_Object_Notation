# NAME

Muldis Object Notation (MUON) -
Source code and data interchange format

# VERSION

The fully-qualified name of this document is
`Muldis_Object_Notation http://muldis.com 0.300.0`.

# PART

This artifact is part 5 of 5 of the document
`Muldis_Object_Notation http://muldis.com 0.300.0`;
its part name is `Syntax_DotNet`.

# SYNOPSIS

*TODO.*

# DESCRIPTION

This document consists of multiple parts; for a directory to all of the
parts, see [Overview](Muldis_Object_Notation.md).

This part of the **Muldis Object Notation** document specifies the
canonical .NET/C\# hosted syntax of MUON, which expresses a MUON artifact
in terms of a native in-memory value or object of the .NET/C\# programming
language, .NET Standard version 2.0 (2017; or Framework 4.0, 2010) or later,
as a non-cyclic data structure composed only using system-defined types,
and specifically the subset that are *CLS-compliant*.
This is derived from and maps with the MUON `Syntax_Plain_Text`.

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

See also [https://dotnet.microsoft.com](https://dotnet.microsoft.com).

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

# GRAMMAR

Each valid MUON artifact is an instance of a single MUON possrep.  Every
possrep has one or more general *qualified* formats characterized by the
pairing of a *predicate* with a *subject*.  Each of a subset of the
possreps also has one or more *unqualified* formats characterized by the
*subject* on its own.  Using the qualified formats exclusively is better
for normalization and consistency, while employing unqualified formats
where available is better for brevity and more efficient resource usage.

Every qualified MUON artifact is a value of the .NET structure type
`System.Collections.Generic.KeyValuePair` (`KeyValuePair`); its
`Key` is the *predicate* and its `Value` is the *subject*.

Every MUON possrep *predicate* is an object of the .NET class
`System.String` (`String`), and that value is characterized by the name
of the MUON possrep in this document.  Every MUON possrep *predicate*
conforms to the character string pattern `[<[A..Z]><[a..z]>+]+`.

The general case of every MUON possrep *subject* is an object of the .NET
class `System.Object` (`Object`), or loosely speaking, any .NET value or
object at all, though strictly speaking, the validity of a *subject* is
constrained to those enumerated by the MUON possreps.

## Any / Universal Type Possrep

An **Any** artifact is an artifact that qualifies as any of the other MUON
artifacts, since the **Any** possrep is characterized by the union of all
other possreps.  Loosely speaking, it is any object of the .NET class
`System.Object` (`Object`).

## None / Empty Type Possrep

A **None** artifact is an artifact that qualifies as none of the other MUON
artifacts, since the **None** possrep is characterized by the intersection
of all other possreps.  That is, there are no **None** artifacts at all,
and this possrep is just mentioned for parity.

## Boolean

A **Boolean** artifact has the predicate `Boolean`.

When its subject is any of the following, the predicate is optional:

* Any value of the .NET structure type `System.Boolean` (`Boolean`).

## Integer

An **Integer** artifact has the predicate `Integer`.

When its subject is any of the following, the predicate is optional:

* Any value of any of the .NET structure types
`System.Byte` (`Byte`),
`System.Int16` (`Int16`),
`System.Int32` (`Int32`),
`System.Int64` (`Int64`).

* Any value of the .NET structure type `System.Numerics.BigInteger` (`BigInteger`).

## Fraction

A **Fraction** artifact has the predicate `Fraction`.

When its subject is any of the following, the predicate is optional:

* Any non-special value of any of the .NET structure types
`System.Single` (`Single`),
`System.Double` (`Double`).

* Any value of the .NET structure type `System.Decimal` (`Decimal`).

*TODO: Be more specific about what float/double/etc are allowed or not.*

*TODO: Add more options.*

## Bits

A **Bits** artifact has the predicate `Bits`.

When its subject is any of the following, the predicate is optional:

* Any object of the .NET class `System.Collections.BitArray` (`BitArray`).

## Blob

A **Blob** artifact has the predicate `Blob`.

When its subject is any of the following, the predicate is required:

* Any value of the .NET structure type array `System.Byte[]`.

Note that an unqualified subject of a `System.Byte[]` is treated as an `Array`.

## Text / Attribute Name

A **Text** artifact has the predicate `Text`.

When its subject is any of the following, the predicate is optional:

* Any value of the .NET structure type `System.Char` (`Char`) that is
not a UTF-16 "surrogate" code point.

* Any object of the .NET class `System.String` (`String`), but that it
does not contain any invalid uses of UTF-16 "surrogate" code points.

* Any object of the .NET class `System.Text.StringBuilder` (`StringBuilder`)
but that it does not contain any invalid uses of UTF-16 "surrogate" code points.

Not permitted are .NET alternatives such as `Char[]`; if
you have one, convert it into a .NET `String` first.

## Array

An **Array** artifact has the predicate `Array`.

When its subject is any of the following, the predicate is optional:

* Any object of any of the .NET array classes, which is any .NET object
for whose class the predicate `Type.IsArray()` results in `true`
(each such class has a name like `foo[]`), but that every one of its
members is a valid **Any** artifact.

* Any value of any of the following .NET structure types that compose the
.NET interface `System.Collections.Generic.IList` (`IList`), but that every
one of its members is a valid **Any** artifact:
`System.Collections.Immutable.ImmutableArray` (`ImmutableArray`).

* Any object of any of the following .NET classes that compose the
.NET interface `System.Collections.Generic.IList` (`IList`), but that every
one of its members is a valid **Any** artifact:
`System.Collections.Generic.List` (`List`),
`System.Collections.Immutable.ImmutableList` (`ImmutableList`).

*TODO: Add more options and/or remove some.*

## Set

A **Set** artifact has the predicate `Set`.

When its subject is any of the following, the predicate is optional:

* Any object of any of the following .NET classes that compose the
.NET interface `System.Collections.Generic.ISet` (`ISet`), but that every
one of its members is a valid **Any** artifact:
`System.Collections.Generic.HashSet` (`HashSet`),
`System.Collections.Generic.SortedSet` (`SortedSet`),
`System.Collections.Immutable.ImmutableHashSet` (`ImmutableHashSet`).
`System.Collections.Immutable.ImmutableSortedSet` (`ImmutableSortedSet`).

When its subject is any of the following, the predicate is required:

* Any **Array** subject.

* Any object of the .NET class `System.Collections.Generic.Dictionary`
(`Dictionary`), but that every one of its keys is a valid **Any** artifact
and every one of its values is a valid **Boolean** subject.

*TODO: Add more options and/or remove some.*

## Bag / Multiset

A **Bag** artifact has the predicate `Bag`.

When its subject is any of the following, the predicate is optional:

* Any object of the .NET class
`System.Collections.Concurrent.ConcurrentBag` (`ConcurrentBag`), but that
every one of its members is a valid **Any** artifact.

When its subject is any of the following, the predicate is required:

* Any **Set** subject.

* Any object of the .NET class `System.Collections.Generic.Dictionary`
(`Dictionary`), but that every one of its keys is a valid **Any** artifact
and every one of its values is a valid **Integer** subject
which denotes a non-negative integer.

*TODO: Add more options and/or remove some.*

## Mix

A **Mix** artifact has the predicate `Mix`.

When its subject is any of the following, the predicate is required:

* Any **Bag** subject.

* Any object of the .NET class `System.Collections.Generic.Dictionary`
(`Dictionary`), but that every one of its keys is a valid **Any** artifact
and every one of its values is a valid **Fraction** subject.

*TODO: Add more options.*

## Interval

An **Interval** artifact has the predicate `Interval`.

*TODO: Add more options.*

## Interval Set

An **Interval Set** artifact has the predicate `IntervalSet`.

*TODO: Add more options.*

## Interval Bag

An **Interval Bag** artifact has the predicate `IntervalBag`.

*TODO: Add more options.*

## Tuple / Attribute Set

A **Tuple** artifact has the predicate `Tuple`.

When its subject is any of the following, the predicate is optional:

* Any value of any of the following .NET structure types that compose the
.NET interface `System.Runtime.CompilerServices.ITuple` (`ITuple`)
but that every one of its keys is a valid **Text** subject
and every one of its values is a valid **Any** artifact:
`System.ValueTuple<...>` (`ValueTuple`).

* Any value of any of the following .NET structure types that compose the
.NET interface `System.Runtime.CompilerServices.ITuple` (`ITuple`)
but that every one of its keys is a valid **Text** subject
and every one of its values is a valid **Any** artifact:
`System.Tuple<...>` (`Tuple`).

When its subject is any of the following, the predicate is required:

* Any **Array** subject.

* Any object of the .NET class `System.Collections.Generic.Dictionary`
(`Dictionary`), but that every one of its keys is a valid **Text** subject
and every one of its values is a valid **Any** artifact.

*TODO: Add more options, such as .NET anonymous types.*

## Tuple Array

A **Tuple Array** artifact has the predicate `TupleArray`.

*TODO: Add more options.*

## Relation / Tuple Set

A **Relation** artifact has the predicate `Relation`.

*TODO: Add more options.*

## Tuple Bag

A **Tuple Bag** artifact has the predicate `TupleBag`.

*TODO: Add more options.*

## Calendar Time

A **Calendar Time** artifact has the predicate `CalendarTime`.

*TODO: Add more options.*

## Calendar Duration

A **Calendar Duration** artifact has the predicate `CalendarDuration`.

When its subject is any of the following, the predicate is optional:

* Any value of the .NET structure type `System.TimeSpan` (`TimeSpan`),

*TODO: Add more options.*

## Calendar Instant

A **Calendar Instant** artifact has the predicate `CalendarInstant`.

When its subject is any of the following, the predicate is optional:

* Any value of any of the .NET structure types
`System.DateTime` (`DateTime`),
`System.DateTimeOffset` (`DateTimeOffset`).

*TODO: Add more options.*

## Geographic Point

A **Geographic Point** artifact has the predicate `GeographicPoint`.

* Any coordinate-specifying object of the .NET class
`System.Data.Spatial.DbGeography` (`DbGeography`).

*TODO: Check if DbGeography is actually in .NET Standard 2.0 or not.*

*TODO: Add more options.*

## Article / Labelled Tuple

An **Article** artifact has the predicate `Article`.

*TODO: Add more options.*

## Excuse

An **Excuse** artifact has the predicate `Excuse`.

*TODO: Add more options.*

## Ignorance

An **Ignorance** artifact has the predicate `Ignorance`.

When its subject is any of the following, the predicate is optional:

* The special .NET `null` value.

* The only object of the .NET singleton class `System.DBNull` (`DBNull`).

## Nesting / Attribute Name List

A **Nesting** artifact has the predicate `Nesting`.

*TODO: Add more options.*

## Heading / Attribute Name Set

A **Heading** artifact has the predicate `Heading`.

*TODO: Add more options.*

## Renaming / Attribute Name Map

A **Renaming** artifact has the predicate `Renaming`.

*TODO: Add more options.*

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
