# NAME

Muldis Object Notation (MUON) -
Source code and data interchange format

# VERSION

The fully-qualified name of this document is
`Muldis_Object_Notation http://muldis.com 0.300.0`.

# PART

This artifact is part 4 of 5 of the document
`Muldis_Object_Notation http://muldis.com 0.300.0`;
its part name is `Syntax_Java`.

# SYNOPSIS

*TODO.*

# DESCRIPTION

This document consists of multiple parts; for a directory to all of the
parts, see [Overview](Muldis_Object_Notation.md).

This part of the **Muldis Object Notation** document specifies the
canonical Java hosted syntax of MUON, which expresses a MUON artifact
in terms of a native in-memory value or object of the Java programming
language, version 8 (2014) or later,
as a non-cyclic data structure composed only using system-defined types.
This is derived from and maps with the MUON `Syntax_Plain_Text`.

The MUON Java-hosted format is semi-lightweight and designed to support
interchange of source code and data between any 2 environments that do have
a common working memory and run the Java programming language, such as
because they collectively are part of a single process of a Java Virtual
Machine (JVM).  One typical use case is a Java library generic API that
accepts or returns structured data using a well-defined protocol such that
the library and its users require no common dependencies besides Java
standard library classes.  Another typical use case is the bridge format of
a Java library for generating or parsing MUON `Syntax_Plain_Text`.
The format is fairly easy for humans to read and write in terms of plain
Java source code.  It is fairly easy for machines to parse and generate.

See also [https://docs.oracle.com/javase/specs/jls/se8/html/index.html](
https://docs.oracle.com/javase/specs/jls/se8/html/index.html).

See also [https://docs.oracle.com/javase/specs/jls/se11/html/index.html](
https://docs.oracle.com/javase/specs/jls/se11/html/index.html).

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

# HOST NATIVE DATA TYPES

This document section enumerates, for the host language Java,
the system-defined types that MUON possreps may be composed of.
Some types may not exist in all language versions, and it is noted when so.
In rare cases, some third-party types may also be listed as alternatives.

This document section declares aliases in the form `SYS_Foo` by which the
host language types are referenced, for conciseness and brevity, in the
rest of the current document part.  The scope of these aliases is strictly
to `Syntax_Java` and other document parts will often be using the
exact same aliases for cross-part parity that have different definitions.

## SYS_Object

A `SYS_Object` is any of the following:

* Any value of any Java primitive type.

* Any object of any Java class, in particular `java.lang.Object`,
which is the common parent class of all Java classes.

## SYS_Boolean

A `SYS_Boolean` is any of the following:

* Any value of the Java primitive type `boolean`.

* Any object of the Java class `java.lang.Boolean`.

## SYS_Integer_Fixed

A `SYS_Integer_Fixed` is any of the following:

* Any value of any of the Java primitive types `int`, `long`.

* Any object of any of the Java classes `java.lang.Integer`, `java.lang.Long`.

Not permitted is any of the following, to keep things simpler:

* Any value of any of the Java primitive types `byte`, `short`.

* Any object of any of the Java classes `java.lang.Byte`, `java.lang.Short`.

## SYS_Integer_Big

A `SYS_Integer_Big` is any of the following:

* Any object of the Java class `java.math.BigInteger`.

## SYS_Float_Fixed

A `SYS_Float_Fixed` is any of the following:

* Any non-special value of any of the Java primitive types `float`, `double`.

* Any non-special object of any of the Java classes
`java.lang.Float`, `java.lang.Double`.

Not permitted is any of the following, to keep things more correct and simpler:

* Any special value of any of the Java primitive types `float`, `double`.

* Any special object of any of the Java classes
`java.lang.Float`, `java.lang.Double`.

*TODO: Be more specific about what float/double/etc are allowed or not.*

## SYS_Decimal_Big

A `SYS_Decimal_Big` is any of the following:

* Any object of the Java class `java.math.BigDecimal`.

## SYS_Bit_String

A `SYS_Bit_String` is any of the following:

* Any object of the Java class `java.util.BitSet`.

## SYS_Byte_String

A `SYS_Byte_String` is any of the following:

* Any value of the Java primitive type array `byte[]`.

## SYS_Char_String

A `SYS_Char_String` is any of the following:

* Any object of the Java class `java.lang.String`, but that it
does not contain any invalid uses of UTF-16 "surrogate" code points.

Not permitted is any of the following, to keep things simpler or more correct:

* Any object of the Java class `java.lang.String` that
contains any invalid uses of UTF-16 "surrogate" code points.

* Any value of the Java primitive type `char`.

* Any object of the Java class `java.lang.Character`.

* Any object of any of the Java classes
`java.lang.StringBuffer`, `java.lang.StringBuilder`.

* Any raw or internal alternatives such as `char[]`, `int[]`, `byte[]`.

## SYS_Pair_Key_Value

A `SYS_Pair_Key_Value` is any of the following:

* Any object of the Java class `java.util.AbstractMap.SimpleImmutableEntry`;
the aliases `SYS_key` and `SYS_value` refer to
its `SYS_Object` typed properties `key` and `value`.

Not permitted is any of the following, to keep things simpler:

* Any other composers of the Java interface `java.util.Map.Entry`,
such as `java.util.AbstractMap.SimpleEntry`.

* Any values or objects of N-ary collection types having exactly 2 elements.

## SYS_Array

A `SYS_Array` is any of the following:

* Any object of any Java array class
(an array class has a name like `foo[]` and is a class for whom
the predicate `java.lang.Class.isArray()` results in true);
the alias `SYS_members` refers to its `SYS_Object` typed elements.

* Any object of any Java class that composes the Java interface `java.util.List`;
the alias `SYS_members` refers to its `SYS_Object` typed elements.

Note that example composers of `java.util.List` are:
`java.util.ArrayList`,
`java.util.LinkedList`,
`java.util.Vector`,
`java.util.concurrent.CopyOnWriteArrayList`.

## SYS_Set

A `SYS_Set` is any of the following:

* Any object of any Java class that composes the Java interface `java.util.Set`;
the alias `SYS_members` refers to its `SYS_Object` typed elements.

Note that example composers of `java.util.Set` are:
`java.util.HashSet`,
`java.util.TreeSet`,
`java.util.concurrent.ConcurrentSkipListSet`,
`java.util.concurrent.CopyOnWriteArraySet`.

## SYS_Dictionary

A `SYS_Dictionary` is any of the following:

* Any object of any Java class that composes the Java interface `java.util.Map`;
the alias `SYS_members` refers to its `SYS_Pair_Key_Value` typed elements.

Note that example composers of `java.util.Map` are:
`java.util.HashMap`,
`java.util.TreeMap`,
`java.util.LinkedHashMap`.

## SYS_Null

A `SYS_Null` is any of the following:

* The special Java `null` value.

# GRAMMAR

Each valid MUON artifact is an instance of a single MUON possrep.  Every
possrep has one or more general *qualified* formats characterized by the
pairing of a *predicate* with a *subject*.  Each of a subset of the
possreps also has one or more *unqualified* formats characterized by the
*subject* on its own.  Using the qualified formats exclusively is better
for normalization and consistency, while employing unqualified formats
where available is better for brevity and more efficient resource usage.

Every qualified MUON artifact is a `SYS_Pair_Key_Value`;
its `SYS_key` is the *predicate* and its `SYS_value` is the *subject*.

Every MUON possrep *predicate* is a `SYS_Char_String`,
and that value is characterized by the name
of the MUON possrep in this document.  Every MUON possrep *predicate*
conforms to the character string pattern `[<[A..Z]><[a..z]>+]+`.

The general case of every MUON possrep *subject* is, loosely speaking, a
`SYS_Object`, though strictly speaking, the validity of a *subject* is
constrained to those enumerated by the MUON possreps.

## Any / Universal Type Possrep

An **Any** artifact is an artifact that qualifies as any of the other MUON
artifacts, since the **Any** possrep is characterized by the union of all
other possreps.  Loosely speaking, it is a `SYS_Object`.

## None / Empty Type Possrep

A **None** artifact is an artifact that qualifies as none of the other MUON
artifacts, since the **None** possrep is characterized by the intersection
of all other possreps.  That is, there are no **None** artifacts at all,
and this possrep is just mentioned for parity.

## Boolean

A **Boolean** artifact has the predicate `Boolean`.

When its subject is any of the following, the predicate is optional:

* Any `SYS_Boolean`.

Not permitted is any of the following, to keep things more correct and simpler:

* Any `SYS_Integer_Fixed`, such as zero/one representing false/true.

* Any value of some other type that might represent a boolean.

## Integer

An **Integer** artifact has the predicate `Integer`.

When its subject is any of the following, the predicate is optional:

* Any `SYS_Integer_Fixed`.

* Any `SYS_Integer_Big`.

## Fraction

A **Fraction** artifact has the predicate `Fraction`.

When its subject is any of the following, the predicate is optional:

* Any `SYS_Float_Fixed`.

* Any `SYS_Decimal_Big`.

*TODO: Add more options.*

## Bits

A **Bits** artifact has the predicate `Bits`.

When its subject is any of the following, the predicate is optional:

* Any `SYS_Bit_String`.

## Blob

A **Blob** artifact has the predicate `Blob`.

When its subject is any of the following, the predicate is required:

* Any `SYS_Byte_String`.

Note that an unqualified subject of a `SYS_Byte_String` is treated as an `Array`.

## Text / Attribute Name

A **Text** artifact has the predicate `Text`.

When its subject is any of the following, the predicate is optional:

* Any `SYS_Char_String`.

## Array

An **Array** artifact has the predicate `Array`.

When its subject is any of the following, the predicate is optional:

* Any `SYS_Array` such that every one of its `SYS_members` is a valid
**Any** artifact.

*TODO: Add options to specify with run-length encoding.*

## Set

A **Set** artifact has the predicate `Set`.

When its subject is any of the following, the predicate is optional:

* Any `SYS_Set` such that every one of its `SYS_members` is a valid
**Any** artifact.

When its subject is any of the following, the predicate is required:

* Any **Array** subject.

* Any `SYS_Dictionary` such that for every one of its `SYS_members`,
that member's `SYS_key` is a valid **Any** artifact and
that member's `SYS_value` is a valid **Boolean** subject.

## Bag / Multiset

A **Bag** artifact has the predicate `Bag`.

When its subject is any of the following, the predicate is required:

* Any **Set** subject.

* Any `SYS_Dictionary` such that for every one of its `SYS_members`,
that member's `SYS_key` is a valid **Any** artifact and
that member's `SYS_value` is a valid **Integer** subject
which denotes a non-negative integer.

Note that the Java interface `java.util.Collection` is documented such that
one should compose it directly when implementing bag/multiset types, but
no standard classes stood out for use as an unqualified **Bag** subject.

## Mix

A **Mix** artifact has the predicate `Mix`.

When its subject is any of the following, the predicate is required:

* Any **Bag** subject.

* Any `SYS_Dictionary` such that for every one of its `SYS_members`,
that member's `SYS_key` is a valid **Any** artifact and
that member's `SYS_value` is a valid **Fraction** subject.

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

When its subject is any of the following, the predicate is required:

* Any **Array** subject.

* Any `SYS_Dictionary` such that for every one of its `SYS_members`,
that member's `SYS_key` is a valid **Text** subject and
that member's `SYS_value` is a valid **Any** artifact.

*TODO: Add more options and/or remove some.*

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

* Any object of any of the Java classes
`java.time.Duration`,
`java.time.Period`.

*TODO: Add more options and/or remove some.*

## Calendar Instant

A **Calendar Instant** artifact has the predicate `CalendarInstant`.

When its subject is any of the following, the predicate is optional:

* Any object of any of the Java classes
`java.time.Instant`,
`java.time.LocalDate`,
`java.time.LocalDateTime`,
`java.time.LocalTime`,
`java.time.Month`,
`java.time.MonthDay`,
`java.time.OffsetDateTime`,
`java.time.OffsetTime`,
`java.time.Year`,
`java.time.YearMonth`,
`java.time.ZonedDateTime`,
`java.time.ZoneOffset`.

*TODO: Add more options and/or remove some.*

## Geographic Point

A **Geographic Point** artifact has the predicate `GeographicPoint`.

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

* Any `SYS_Null`.

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
