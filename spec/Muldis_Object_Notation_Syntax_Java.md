# NAME

Muldis Object Notation (MUON) - Source code and data interchange format

# VERSION

The fully-qualified name of this document is
`Muldis_Object_Notation https://muldis.com 0.300.0`.

# PART

This artifact is part 4 of 5 of the document
`Muldis_Object_Notation https://muldis.com 0.300.0`;
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

See also <https://docs.oracle.com/javase/specs/jls/se8/html/index.html>.

See also <https://docs.oracle.com/javase/specs/jls/se11/html/index.html>.

# DATA TYPE POSSREPS

**Muldis Object Notation** is mainly characterized by a set of *data type
possreps* or *possreps* (*possible representations*) that all *values*
represented with MUON syntax are characterized by.
Each MUON possrep corresponds 1:1 with a distinct grammar in each MUON syntax.

- Devoid: Ignorance
- Logical: Boolean
- Numeric: Integer, Fraction
- Locational: Calendar Time, Calendar Duration, Calendar Instant, Geographic Point
- Stringy: Bits, Blob, Text
- Identifier: Nesting

- Collective: Pair, Tuple, Lot, Interval

- Discrete: Array, Set, Bag, Mix
- Continuous: Interval Set, Interval Bag
- Relational: Tuple Array, Relation, Tuple Bag
- Generic: Article, Excuse
- Source Code: Heading, Renaming

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

## SYS_Null

A `SYS_Null` is any of the following:

* The special Java `null` value.

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

* Any finite number value of any of the Java primitive types `float`, `double`;
both signed zeroes are treated as the same plain zero.

* Any finite number or signed zero object of any of the Java classes
`java.lang.Float`, `java.lang.Double`;
both signed zeroes are treated as the same plain zero.

Not permitted is any of the following, to keep things more correct and simpler:

* Any infinity or NaN value of any of the Java primitive types `float`, `double`.

* Any infinity or NaN object of any of the Java classes
`java.lang.Float`, `java.lang.Double`.

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

* Any object of the Java class `java.lang.String` that is *well formed*.

Not permitted is any of the following, to keep things simpler or more correct:

* Any object of the Java class `java.lang.String` that is not *well formed*.

* Any value of the Java primitive type `char`.

* Any object of the Java class `java.lang.Character`.

* Any object of any of the Java classes
`java.lang.StringBuffer`, `java.lang.StringBuilder`.

* Any raw or internal alternatives such as `char[]`, `int[]`, `byte[]`.

A Java `java.lang.String` is characterized as a sequence of 0..N `char`
such that each of the latter is an unsigned 16-bit integer *C*.
A *well formed* string denotes a Unicode BMP code point with a single *C*
in the non-surrogate set {0..0xD7FF,0xE000..0xFFFF}
(`java.lang.Character.isSurrogate()` is false) and it denotes a Unicode
non-BMP code point with an ordered pair of *C* each in the surrogate set
{0xD800..0xDFFF} (`java.lang.Character.isSurrogate()` is true) and the pair
is also well formed (`java.lang.Character.isSurrogatePair()` is true); a
*well formed* string does not contain any *C* in the surrogate set that
isn't so paired.

## SYS_Pair_KV

A `SYS_Pair_KV` is any of the following:

* Any object of the Java class `java.util.AbstractMap.SimpleImmutableEntry`;
the aliases `SYS_key` and `SYS_value` refer to
its (`SYS_Object` typed) properties `key` and `value`.

Not permitted is any of the following, to keep things simpler:

* Any other composers of the Java interface `java.util.Map.Entry`,
such as `java.util.AbstractMap.SimpleEntry`.

* Any values or objects of N-ary collection types having exactly 2 elements.

## SYS_Array

A `SYS_Array` is any of the following:

* Any object of any Java array class
(an array class has a name like `foo[]` and is a class for whom
the predicate `java.lang.Class.isArray()` results in true);
the alias `SYS_members` refers to its (`SYS_Object` typed) elements;
the alias `SYS_pairs_opm` refers to its (`SYS_Object` typed) elements
paired with their corresponding (`SYS_Integer_Fixed` typed) ordinal positions,
those being referred to with `SYS_pair_member` and `SYS_pair_ord_pos`.

* Any object of any Java class that composes the Java interface `java.util.List`;
the alias `SYS_members` refers to its (`SYS_Object` typed) elements;
the alias `SYS_pairs_opm` refers to its (`SYS_Object` typed) elements
paired with their corresponding (`SYS_Integer_Fixed` typed) ordinal positions,
those being referred to with `SYS_pair_member` and `SYS_pair_ord_pos`.

Note that example composers of `java.util.List` are:
`java.util.ArrayList`,
`java.util.LinkedList`,
`java.util.Vector`,
`java.util.concurrent.CopyOnWriteArrayList`.

## SYS_Set

A `SYS_Set` is any of the following:

* Any object of any Java class that composes the Java interface `java.util.Set`;
the alias `SYS_members` refers to its (`SYS_Object` typed) elements.

Note that example composers of `java.util.Set` are:
`java.util.HashSet`,
`java.util.TreeSet`,
`java.util.concurrent.ConcurrentSkipListSet`,
`java.util.concurrent.CopyOnWriteArraySet`.

## SYS_Dictionary

A `SYS_Dictionary` is any of the following:

* Any object of any Java class that composes the Java interface `java.util.Map`;
the alias `SYS_pairs_kv` refers to its (`SYS_Pair_KV` typed) elements.

Note that example composers of `java.util.Map` are:
`java.util.HashMap`,
`java.util.TreeMap`,
`java.util.LinkedHashMap`.

## SYS_Tuple_Ordered

A `SYS_Tuple_Ordered` is any of the following:

* Any `SYS_Tuple_Ordered_As_Array`.

## SYS_Tuple_Ordered_As_Array

A `SYS_Tuple_Ordered_As_Array` is any of the following:

* Any `SYS_Array`; the alias `SYS_attrs_na` refers to its `SYS_pairs_opm`,
such that the aliases `SYS_attr_name` and `SYS_attr_asset` refer in turn to
each `SYS_pair_ord_pos` (interpreted as a Unicode code point
as a `SYS_Char_String`) and `SYS_pair_member`.

## SYS_Tuple_Ordered_D1

A `SYS_Tuple_Ordered_D1` is any of the following:

* Any `SYS_Tuple_Ordered` that has exactly 1 attribute.

## SYS_Tuple_Ordered_D2

A `SYS_Tuple_Ordered_D2` is any of the following:

* Any `SYS_Tuple_Ordered` that has exactly 2 attributes.

## SYS_Tuple_Ordered_D3

A `SYS_Tuple_Ordered_D3` is any of the following:

* Any `SYS_Tuple_Ordered` that has exactly 3 attributes.

## SYS_Tuple_Ordered_D4

A `SYS_Tuple_Ordered_D4` is any of the following:

* Any `SYS_Tuple_Ordered` that has exactly 4 attributes.

## SYS_Tuple_Ordered_D6

A `SYS_Tuple_Ordered_D6` is any of the following:

* Any `SYS_Tuple_Ordered` that has exactly 6 attributes.

## SYS_Tuple_Named_As_Dictionary

A `SYS_Tuple_Named_As_Dictionary` is any of the following:

* Any `SYS_Dictionary` such that for every one of its `SYS_pairs_kv`, that
member's `SYS_key` is a `SYS_Char_String`; the alias `SYS_attrs_na` refers
to its `SYS_pairs_kv`, such that the aliases `SYS_attr_name` and
`SYS_attr_asset` refer in turn to each `SYS_key` and `SYS_value`.

# GRAMMAR

Each valid MUON artifact is an instance of a single MUON possrep.  Every
possrep has one or more general *qualified* formats characterized by the
pairing of a *predicate* with a *subject*.  Each of a subset of the
possreps also has one or more *unqualified* formats characterized by the
*subject* on its own.  Using the qualified formats exclusively is better
for normalization and consistency, while employing unqualified formats
where available is better for brevity and more efficient resource usage.

Every qualified MUON artifact is a `SYS_Pair_KV`;
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

## Ignorance

An **Ignorance** artifact has the predicate `Ignorance`.

When its subject is any of the following, the predicate is optional:

* Any `SYS_Null`.

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

When its subject is any of the following, the predicate is required:

* Any `SYS_Tuple_Ordered_D1` such that the 1 attribute asset is the *significand*.

* Any `SYS_Tuple_Ordered_D2` such that the 2 attribute assets in ascending
order are the *numerator* and *denominator*.

* Any `SYS_Tuple_Ordered_D3` such that the 3 attribute assets in ascending
order are the *significand*, *radix*, and *exponent*.

* Any `SYS_Tuple_Ordered_D4` such that the 4 attribute assets in ascending
order are the *numerator*, *denominator*, *radix*, and *exponent*.

The above components are defined as follows:

* A *significand* is any `SYS_Float_Fixed` or `SYS_Decimal_Big` or **Integer** subject.

* A *numerator* is any **Integer** subject.

* A *denominator* is any **Integer** subject which denotes a nonzero integer.

* A *radix* is any **Integer** subject which denotes an integer that is at least 2.

* An *exponent* is any **Integer** subject.

## Calendar Time

A **Calendar Time** artifact has the predicate `Calendar_Time`.

When its subject is any of the following, the predicate is required:

* Any `SYS_Tuple_Ordered_D6` such that the 6 attribute assets in ascending
order are the *year*, *month*, *day*, *hour*, *minute*, *second*; each of
those 6 is any `SYS_Null` or  **Integer** subject or **Fraction** subject.

## Calendar Duration

A **Calendar Duration** artifact has the predicate `Calendar_Duration`.

When its subject is any of the following, the predicate is optional:

* Any object of any of the Java classes
`java.time.Duration`,
`java.time.Period`.

*TODO: Consider removing some of the above options.*

When its subject is any of the following, the predicate is required:

* Any **Calendar Time** subject.

## Calendar Instant

A **Calendar Instant** artifact has the predicate `Calendar_Instant`.

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

*TODO: Consider removing some of the above options.*

When its subject is any of the following, the predicate is required:

* Any `SYS_Tuple_Ordered_D1` such that attribute 0 is the *instant base*
(any **Calendar Time** subject);
this designates a *floating* instant not associated with any zone or offset.

* Any `SYS_Tuple_Ordered_D2` such that attribute 0 is the *instant base*
(any **Calendar Time** subject) and attribute 1 is the *instant offset*
(any `SYS_Tuple_Ordered_D3` such that the 3 attribute assets in ascending
order are the *hour*, *minute*, *second*; same types as in *instant base*);
this designates an instant local to any zone with a specific offset from UTC.

* Any `SYS_Tuple_Ordered_D2` such that attribute 0 is the *instant base*
(any **Calendar Time** subject) and attribute 1 is the *instant zone* (any
**Text** subject); this designates an instant local to the named zone.

## Geographic Point

A **Geographic Point** artifact has the predicate `Geographic_Point`.

When its subject is any of the following, the predicate is required:

* Any `SYS_Array` *T* such that every one of its `SYS_members` is a
`SYS_Pair_KV` (alias `SYS_attrs_na`) such that,
for each of the 3 possible attributes *A* {*longitude*, *latitude*, *elevation*},
at most 1 of the `SYS_attrs_na` of *T* defines an *A*.

* Any `SYS_Tuple_Named_As_Dictionary` *T* such that,
for each of the 3 possible attributes *A* {*longitude*, *latitude*, *elevation*},
at most 1 of the `SYS_attrs_na` of *T* defines an *A*.

The above components are defined as follows:

* A *longitude* is such that
its `SYS_attr_name` is the `SYS_Char_String` value `>` and
its `SYS_attr_asset` is any `SYS_Null` or  **Integer** subject or **Fraction** subject.

* A *latitude* is such that
its `SYS_attr_name` is the `SYS_Char_String` value `^` and
its `SYS_attr_asset` is any `SYS_Null` or  **Integer** subject or **Fraction** subject.

* An *elevation* is such that
its `SYS_attr_name` is the `SYS_Char_String` value `+` and
its `SYS_attr_asset` is any `SYS_Null` or  **Integer** subject or **Fraction** subject.

## Bits

A **Bits** artifact has the predicate `Bits`.

When its subject is any of the following, the predicate is optional:

* Any `SYS_Bit_String`.

## Blob

A **Blob** artifact has the predicate `Blob`.

When its subject is any of the following, the predicate is required:

* Any `SYS_Byte_String`.

Note that an unqualified subject of a `SYS_Byte_String` is treated as an **Array**.

## Text / Attribute Name

A **Text** artifact has the predicate `Text`.

When its subject is any of the following, the predicate is optional:

* Any `SYS_Char_String`.

## Nesting / Attribute Name List

A **Nesting** artifact has the predicate `Nesting`.

When its subject is any of the following, the predicate is required:

* Any `SYS_Array` such that every one of its `SYS_members` is any
**Text** subject.

## Pair

An **Pair** artifact has the predicate `Pair`.

When its subject is any of the following, the predicate is required:

* Any `SYS_Pair_KV` such that its `SYS_key` is the *this* (any **Any**
artifact) and its `SYS_value` is the *that* (any **Any** artifact).

## Tuple / Attribute Set

A **Tuple** artifact has the predicate `Tuple`.

When its subject is any of the following, the predicate is required:

* Any `SYS_Tuple_Ordered_As_Array` such that for every one of its
`SYS_attrs_na`, its `SYS_attr_asset` is any **Any** artifact.

* Any `SYS_Pair_KV` such that its `SYS_key` is the `SYS_Char_String` value
`%` and its `SYS_value` is any `SYS_Array` such that every one of its
`SYS_members` is a `SYS_Pair_KV` (alias `SYS_attrs_na`) such that its
`SYS_key` (alias `SYS_attr_name`) is any **Text** subject and its
`SYS_value` (alias `SYS_attr_asset`) is any **Any** artifact.

* Any `SYS_Tuple_Named_As_Dictionary` such that for every one of its
`SYS_attrs_na`, that member's `SYS_attr_name` is any **Text** subject
and that member's `SYS_attr_asset` is any **Any** artifact.

*TODO: Consider adding Java anonymous types as an option if feasible.*

## Lot

A **Lot** artifact has the predicate `Lot`.

When its subject is any of the following, the predicate is required:

* Any `SYS_Array` such that every one of its `SYS_members` is any
**Any** artifact.

* Any `SYS_Pair_KV` such that its `SYS_key` is the `SYS_Char_String` value
`+` and its `SYS_value` is any `SYS_Array` such that every one of its
`SYS_members` is a `SYS_Pair_KV` such that its `SYS_key` is any
**Any** artifact and its `SYS_value` is any **Integer** subject which
denotes a non-negative integer *multiplicity*.

## Interval

An **Interval** artifact has the predicate `Interval`.

When its subject is any of the following, the predicate is required:

* Any `SYS_Tuple_Ordered_D1` such that attribute 0 is the `SYS_Char_String`
empty string value; this designates an *empty interval*.

* Any `SYS_Tuple_Ordered_D2` such that attribute 0 is the `SYS_Char_String`
empty string value and attribute 1 is any **Any** artifact;
this designates a *unit interval*.

* Any `SYS_Tuple_Ordered_D3` such that attribute 0 is any of the
4 `SYS_Char_String` values {`..`, `..-`, `-..`, `-..-`}
and attributes 1 and 2 are each any **Any** artifact;
this designates a *bounded interval*.

* Any `SYS_Tuple_Ordered_D2` such that attribute 0 is any of the
8 `SYS_Char_String` values
{`..*`, `..-*`, `-..*`, `-..-*`, `*..`, `*..-`, `*-..`, `*-..-`}
and attribute 1 is any **Any** artifact;
this designates a *half-unbounded, half-bounded interval*.

* Any `SYS_Tuple_Ordered_D1` such that attribute 0 is any of the
4 `SYS_Char_String` values {`*..*`, `*..-*`, `*-..*`, `*-..-*`};
this designates a *universal interval* or *unbounded interval*.

## Array

An **Array** artifact has the predicate `Array`.

When its subject is any of the following, the predicate is optional:

* Any `SYS_Array` such that every one of its `SYS_members` is any
**Any** artifact.

When its subject is any of the following, the predicate is required:

* Any `SYS_Pair_KV` such that its `SYS_key` is the `SYS_Char_String` value
`+` and its `SYS_value` is any `SYS_Array` such that every one of its
`SYS_members` is a `SYS_Pair_KV` such that its `SYS_key` is any
**Any** artifact and its `SYS_value` is any **Integer** subject which
denotes a non-negative integer *multiplicity*.

## Set

A **Set** artifact has the predicate `Set`.

When its subject is any of the following, the predicate is optional:

* Any `SYS_Set` such that every one of its `SYS_members` is any
**Any** artifact.

When its subject is any of the following, the predicate is required:

* Any `SYS_Array` such that every one of its `SYS_members` is any
**Any** artifact.

* Any `SYS_Pair_KV` such that its `SYS_key` is the `SYS_Char_String` value
`?` and its `SYS_value` is any `SYS_Array` such that every one of its
`SYS_members` is a `SYS_Pair_KV` such that its `SYS_key` is any
**Any** artifact and its `SYS_value` is any **Boolean** subject.

* Any `SYS_Dictionary` such that for every one of its `SYS_pairs_kv`,
that member's `SYS_key` is any **Any** artifact and
that member's `SYS_value` is any **Boolean** subject.

## Bag / Multiset

A **Bag** artifact has the predicate `Bag`.

When its subject is any of the following, the predicate is required:

* Any **Set** subject.

* Any `SYS_Array` such that every one of its `SYS_members` is a `SYS_Pair_KV`
such that its `SYS_key` is any **Any** artifact and its `SYS_value`
is any **Integer** subject which denotes a non-negative integer *multiplicity*.

* Any `SYS_Dictionary` such that for every one of its `SYS_pairs_kv`,
that member's `SYS_key` is any **Any** artifact and
that member's `SYS_value` is any **Integer** subject
which denotes a non-negative integer *multiplicity*.

Note that the Java interface `java.util.Collection` is documented such that
one should compose it directly when implementing bag/multiset types, but
no standard classes stood out for use as an unqualified **Bag** subject.

## Mix

A **Mix** artifact has the predicate `Mix`.

When its subject is any of the following, the predicate is required:

* Any **Bag** subject.

* Any `SYS_Array` such that every one of its `SYS_members` is a `SYS_Pair_KV`
such that its `SYS_key` is any **Any** artifact and its `SYS_value`
is any **Fraction** subject.

* Any `SYS_Dictionary` such that for every one of its `SYS_pairs_kv`,
that member's `SYS_key` is any **Any** artifact and
that member's `SYS_value` is any **Fraction** subject.

## Interval Set

An **Interval Set** artifact has the predicate `Interval_Set`.

When its subject is any of the following, the predicate is required:

* Any `SYS_Set` such that every one of its `SYS_members` is any
**Interval** subject.

* Any `SYS_Array` such that every one of its `SYS_members` is any
**Interval** subject.

* Any `SYS_Pair_KV` such that its `SYS_key` is the `SYS_Char_String` value
`?` and its `SYS_value` is any `SYS_Array` such that every one of its
`SYS_members` is a `SYS_Pair_KV` such that its `SYS_key` is any
**Interval** subject and its `SYS_value` is any **Boolean** subject.

* Any `SYS_Dictionary` such that for every one of its `SYS_pairs_kv`,
that member's `SYS_key` is any **Interval** subject and
that member's `SYS_value` is any **Boolean** subject.

## Interval Bag

An **Interval Bag** artifact has the predicate `Interval_Bag`.

When its subject is any of the following, the predicate is required:

* Any **Interval Set** subject.

* Any `SYS_Array` such that every one of its `SYS_members` is a `SYS_Pair_KV`
such that its `SYS_key` is any **Interval** subject and its `SYS_value`
is any **Integer** subject which denotes a non-negative integer *multiplicity*.

* Any `SYS_Dictionary` such that for every one of its `SYS_pairs_kv`,
that member's `SYS_key` is any **Interval** subject and
that member's `SYS_value` is any **Integer** subject
which denotes a non-negative integer *multiplicity*.

## Tuple Array

A **Tuple Array** artifact has the predicate `Tuple_Array`.

When its subject is any of the following, the predicate is required:

* Any `SYS_Pair_KV` such that its `SYS_key` is the `SYS_Char_String` value
`$` and its `SYS_value` is any **Heading** subject.

* Any `SYS_Pair_KV` such that its `SYS_key` is the `SYS_Char_String` value
`%` and its `SYS_value` is
any `SYS_Array` such that every one of its `SYS_members` is any
**Tuple** subject.

* Any `SYS_Pair_KV` such that its `SYS_key` is the `SYS_Char_String` value
`%` and its `SYS_value` is
any `SYS_Pair_KV` such that its `SYS_key` is the `SYS_Char_String` value
`+` and its `SYS_value` is any `SYS_Array` such that every one of its
`SYS_members` is a `SYS_Pair_KV` such that its `SYS_key` is any
**Tuple** subject and its `SYS_value` is any **Integer** subject which
denotes a non-negative integer *multiplicity*.

## Relation / Tuple Set

A **Relation** artifact has the predicate `Relation`.

When its subject is any of the following, the predicate is required:

* Any `SYS_Pair_KV` such that its `SYS_key` is the `SYS_Char_String` value
`$` and its `SYS_value` is any **Heading** subject.

* Any `SYS_Pair_KV` such that its `SYS_key` is the `SYS_Char_String` value
`%` and its `SYS_value` is
any `SYS_Set` such that every one of its `SYS_members` is any
**Tuple** subject.

* Any `SYS_Pair_KV` such that its `SYS_key` is the `SYS_Char_String` value
`%` and its `SYS_value` is
any `SYS_Array` such that every one of its `SYS_members` is any
**Tuple** subject.

* Any `SYS_Pair_KV` such that its `SYS_key` is the `SYS_Char_String` value
`%` and its `SYS_value` is
any `SYS_Pair_KV` such that its `SYS_key` is the `SYS_Char_String` value
`?` and its `SYS_value` is any `SYS_Array` such that every one of its
`SYS_members` is a `SYS_Pair_KV` such that its `SYS_key` is any
**Tuple** subject and its `SYS_value` is any **Boolean** subject.

* Any `SYS_Pair_KV` such that its `SYS_key` is the `SYS_Char_String` value
`%` and its `SYS_value` is
any `SYS_Dictionary` such that for every one of its `SYS_pairs_kv`,
that member's `SYS_key` is any **Tuple** subject and
that member's `SYS_value` is any **Boolean** subject.

## Tuple Bag

A **Tuple Bag** artifact has the predicate `Tuple_Bag`.

When its subject is any of the following, the predicate is required:

* Any **Relation** subject.

* Any `SYS_Pair_KV` such that its `SYS_key` is the `SYS_Char_String` value
`%` and its `SYS_value` is
any `SYS_Array` such that every one of its `SYS_members` is a `SYS_Pair_KV`
such that its `SYS_key` is any **Tuple** subject and its `SYS_value`
is any **Integer** subject which denotes a non-negative integer *multiplicity*.

* Any `SYS_Pair_KV` such that its `SYS_key` is the `SYS_Char_String` value
`%` and its `SYS_value` is
any `SYS_Dictionary` such that for every one of its `SYS_pairs_kv`,
that member's `SYS_key` is any **Tuple** subject and
that member's `SYS_value` is any **Integer** subject
which denotes a non-negative integer *multiplicity*.

## Article / Labelled Tuple

An **Article** artifact has the predicate `Article`.

When its subject is any of the following, the predicate is required:

* Any `SYS_Pair_KV` such that its `SYS_key` is the *label* (any **Nesting**
subject) and its `SYS_value` is the *attributes* (any **Tuple** subject).

* Any **Nesting** subject, which is the *label* (and there are no *attributes*).

## Excuse

An **Excuse** artifact has the predicate `Excuse`.

When its subject is any of the following, the predicate is required:

* Any **Article** subject.

## Heading / Attribute Name Set

A **Heading** artifact has the predicate `Heading`.

When its subject is any of the following, the predicate is required:

* Any `SYS_Set` such that every one of its `SYS_members` is any
**Text** subject.

* Any `SYS_Array` such that every one of its `SYS_members` is any
**Text** subject.

* Any `SYS_Dictionary` such that for every one of its `SYS_pairs_kv`,
that member's `SYS_key` is any **Text** subject and
that member's `SYS_value` is any **Boolean** subject.

## Renaming / Attribute Name Map

A **Renaming** artifact has the predicate `Renaming`.

When its subject is any of the following, the predicate is required:

* Any `SYS_Pair_KV` such that its `SYS_key` is the `SYS_Char_String` value
`->` and its `SYS_value` is
any `SYS_Array` such that every one of its `SYS_members` is a `SYS_Pair_KV`
such that its `SYS_key` is the *name before* (any **Text** subject) and its
`SYS_value` is the *name after* (any **Text** subject).

* Any `SYS_Pair_KV` such that its `SYS_key` is the `SYS_Char_String` value
`<-` and its `SYS_value` is
any `SYS_Array` such that every one of its `SYS_members` is a `SYS_Pair_KV`
such that its `SYS_key` is the *name after* (any **Text** subject) and its
`SYS_value` is the *name before* (any **Text** subject).

* Any `SYS_Pair_KV` such that its `SYS_key` is the `SYS_Char_String` value
`->` and its `SYS_value` is
any `SYS_Dictionary` such that for every one of its `SYS_pairs_kv`,
that member's `SYS_key` is the *name before* (any **Text** subject) and
that member's `SYS_value` is the *name after* (any **Text** subject).

* Any `SYS_Pair_KV` such that its `SYS_key` is the `SYS_Char_String` value
`<-` and its `SYS_value` is
any `SYS_Dictionary` such that for every one of its `SYS_pairs_kv`,
that member's `SYS_key` is the *name after* (any **Text** subject) and
that member's `SYS_value` is the *name before* (any **Text** subject).

# SEE ALSO

*TODO.*

# AUTHOR

Darren Duncan - darren@DarrenDuncan.net

# LICENSE AND COPYRIGHT

This file is part of the formal specification named
**Muldis Object Notation** (**MUON**).

MUON is Copyright © 2002-2021, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of [Overview](Muldis_Object_Notation.md) for details.

# TRADEMARK POLICY

The TRADEMARK POLICY in [Overview](Muldis_Object_Notation.md) applies to this file too.

# ACKNOWLEDGEMENTS

The ACKNOWLEDGEMENTS in [Overview](Muldis_Object_Notation.md) apply to this file too.
