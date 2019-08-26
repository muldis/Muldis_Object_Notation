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

# GRAMMAR

Each valid MUON artifact is an instance of a single MUON possrep.  Every
possrep has one or more general *qualified* formats characterized by the
pairing of a *predicate* with a *subject*.  Each of a subset of the
possreps also has one or more *unqualified* formats characterized by the
*subject* on its own.  Using the qualified formats exclusively is better
for normalization and consistency, while employing unqualified formats
where available is better for brevity and more efficient resource usage.

Every qualified MUON artifact is an object of the Java class
`java.util.AbstractMap.SimpleImmutableEntry` (`SimpleImmutableEntry`); its
`key` is the *predicate* and its `value` is the *subject*.

Every MUON possrep *predicate* is an object of the Java class
`java.lang.String` (`String`), and that value is characterized by the name
of the MUON possrep in this document.  Every MUON possrep *predicate*
conforms to the character string pattern `[<[A..Z]><[a..z]>+]+`.

The general case of every MUON possrep *subject* is an object of the Java
class `java.lang.Object` (`Object`), or loosely speaking, any Java value or
object at all, though strictly speaking, the validity of a *subject* is
constrained to those enumerated by the MUON possreps.

## Any / Universal Type Possrep

An **Any** artifact is an artifact that qualifies as any of the other MUON
artifacts, since the **Any** possrep is characterized by the union of all
other possreps.  Loosely speaking, it is any object of the Java class
`java.lang.Object` (`Object`).

## None / Empty Type Possrep

A **None** artifact is an artifact that qualifies as none of the other MUON
artifacts, since the **None** possrep is characterized by the intersection
of all other possreps.  That is, there are no **None** artifacts at all,
and this possrep is just mentioned for parity.

## Boolean

A **Boolean** artifact has the predicate `Boolean`.

When its subject is any of the following, the predicate is optional:

* Any value of the Java primitive type `boolean`.

* Any object of the Java class `java.lang.Boolean` (`Boolean`).

## Integer

An **Integer** artifact has the predicate `Integer`.

When its subject is any of the following, the predicate is optional:

* Any value of any of the Java primitive types `byte`, `short`, `int`, `long`.

* Any object of any of the Java classes
`java.lang.Byte` (`Byte`),
`java.lang.Short` (`Short`),
`java.lang.Integer` (`Integer`),
`java.lang.Long` (`Long`).

* Any object of the Java class `java.math.BigInteger` (`BigInteger`).

## Fraction

A **Fraction** artifact has the predicate `Fraction`.

When its subject is any of the following, the predicate is optional:

* Any non-special value of any of the Java primitive types `float`, `double`.

* Any non-special object of any of the Java classes
`java.lang.Float` (`Float`),
`java.lang.Double` (`Double`).

* Any object of the Java class `java.math.BigDecimal` (`BigDecimal`).

*TODO: Be more specific about what float/double/etc are allowed or not.*

*TODO: Add more options.*

## Bits

A **Bits** artifact has the predicate `Bits`.

When its subject is any of the following, the predicate is optional:

* Any object of the Java class `java.util.BitSet` (`BitSet`).

## Blob

A **Blob** artifact has the predicate `Blob`.

When its subject is any of the following, the predicate is required:

* Any value of the Java primitive type array `byte[]`.

Note that an unqualified subject of a `byte[]` is treated as an `Array`.

## Text / Attribute Name

A **Text** artifact has the predicate `Text`.

When its subject is any of the following, the predicate is optional:

* Any value of the Java primitive type `char` that is not a UTF-16
"surrogate" code point.

* Any object of the Java class `java.lang.Character` (`Character`) that is
not a UTF-16 "surrogate" code point.

* Any object of the Java class `java.lang.String` (`String`), but that it
does not contain any invalid uses of UTF-16 "surrogate" code points.

* Any object of any of the Java classes
`java.lang.StringBuffer` (`StringBuffer`),
`java.lang.StringBuilder` (`StringBuilder`)
but that it does not contain any invalid uses of UTF-16 "surrogate" code points.

Not permitted are Java alternatives such as `char[]`, `int[]`, `byte[]`; if
you have one, convert it into a Java `String` first.

## Array

An **Array** artifact has the predicate `Array`.

When its subject is any of the following, the predicate is optional:

* Any object of any of the Java array classes, which is any Java object
for whose class the predicate `java.lang.Class.isArray()` results in `true`
(each such class has a name like `foo[]`), but that every one of its
members is a valid **Any** artifact.

* Any object of any of the following Java classes that compose the Java
interface `java.util.List` (`List`), but that every one of its members is
a valid **Any** artifact:
`java.util.ArrayList` (`ArrayList`).
`java.util.LinkedList` (`LinkedList`),
`java.util.Vector` (`Vector`),
`java.util.concurrent.CopyOnWriteArrayList` (`CopyOnWriteArrayList`).

*TODO: Add more options and/or remove some.*

## Set

A **Set** artifact has the predicate `Set`.

When its subject is any of the following, the predicate is optional:

* Any object of any of the following Java classes that compose the Java
interface `java.util.Set` (`Set`), but that every one of its members is a
valid **Any** artifact:
`java.util.HashSet` (`HashSet`),
`java.util.TreeSet` (`TreeSet`),
`java.util.concurrent.ConcurrentSkipListSet` (`ConcurrentSkipListSet`),
`java.util.concurrent.CopyOnWriteArraySet` (`CopyOnWriteArraySet`).

When its subject is any of the following, the predicate is required:

* Any **Array** subject.

* Any object of any of the following Java classes that compose the Java
interface `java.util.Map` (`Map`), but that every one of its keys is a valid
**Any** artifact and every one of its values is a valid **Boolean** subject:
`java.util.HashMap` (`HashMap`),
`java.util.TreeMap` (`TreeMap`),
`java.util.LinkedHashMap` (`LinkedHashMap`).

*TODO: Add more options and/or remove some.*

## Bag / Multiset

A **Bag** artifact has the predicate `Bag`.

When its subject is any of the following, the predicate is required:

* Any **Set** subject.

* Any object of any of the following Java classes that compose the Java
interface `java.util.Map` (`Map`), but that every one of its keys is a valid
**Any** artifact and every one of its values is a valid **Integer** subject
which denotes a non-negative integer:
`java.util.HashMap` (`HashMap`),
`java.util.TreeMap` (`TreeMap`),
`java.util.LinkedHashMap` (`LinkedHashMap`).

Note that the Java interface `java.util.Collection` is documented such that
one should compose it directly when implementing bag/multiset types, but
no standard classes stood out for use as an unqualified **Bag** subject.

*TODO: Add more options and/or remove some.*

## Mix

A **Mix** artifact has the predicate `Mix`.

When its subject is any of the following, the predicate is required:

* Any **Bag** subject.

* Any object of any of the following Java classes that compose the Java
interface `java.util.Map` (`Map`), but that every one of its keys is a valid
**Any** artifact and every one of its values is a valid **Fraction** subject:
`java.util.HashMap` (`HashMap`),
`java.util.TreeMap` (`TreeMap`),
`java.util.LinkedHashMap` (`LinkedHashMap`).

*TODO: Add more options and/or remove some.*

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

* Any object of any of the following Java classes that compose the Java
interface `java.util.Map` (`Map`), but that every one of its keys is a valid
**Text** subject and every one of its values is a valid **Any** artifact:
`java.util.HashMap` (`HashMap`),
`java.util.TreeMap` (`TreeMap`),
`java.util.LinkedHashMap` (`LinkedHashMap`).

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
`java.time.Duration` (`Duration`),
`java.time.Period` (`Period`).

*TODO: Add more options and/or remove some.*

## Calendar Instant

A **Calendar Instant** artifact has the predicate `CalendarInstant`.

When its subject is any of the following, the predicate is optional:

* Any object of any of the Java classes
`java.time.Instant` (`Instant`),
`java.time.LocalDate` (`LocalDate`),
`java.time.LocalDateTime` (`LocalDateTime`),
`java.time.LocalTime` (`LocalTime`),
`java.time.Month` (`Month`),
`java.time.MonthDay` (`MonthDay`),
`java.time.OffsetDateTime` (`OffsetDateTime`),
`java.time.OffsetTime` (`OffsetTime`),
`java.time.Year` (`Year`),
`java.time.YearMonth` (`YearMonth`),
`java.time.ZonedDateTime` (`ZonedDateTime`),
`java.time.ZoneOffset` (`ZoneOffset`).

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

* The special Java `null` value.

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
