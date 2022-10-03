# NAME

Muldis Object Notation (MUON) - Source code and data interchange format

# VERSION

The fully-qualified name of this document is
`Muldis_Object_Notation https://muldis.com 0.300.0`.

# PART

This artifact is part 9 of 15 of the document
`Muldis_Object_Notation https://muldis.com 0.300.0`;
its part name is `Syntax_Java`.

# SYNOPSIS

```
    new AbstractMap.SimpleEntry("Syntax", new AbstractMap.SimpleEntry(
        new String[]{"Muldis_Object_Notation_Java", "https://muldis.com", "0.300.0"},
        new AbstractMap.SimpleEntry("Model", new AbstractMap.SimpleEntry(
            new String[]{"Muldis_Data_Language", "https://muldis.com", "0.300.0"},
            new AbstractMap.SimpleEntry("Relation", new LinkedHashMap[]{
                new LinkedHashMap(){{
                    put("name", "Jane Ives");
                    put("birth_date", new AbstractMap.SimpleEntry("Calendar_Instant",
                        new LinkedHashMap(){{put("y",1971); put("m",11); put("d",6);}}
                    ));
                    put("phone_numbers", new AbstractMap.SimpleEntry("Set",
                        new String[]{"+1.4045552995", "+1.7705557572"}
                    ));
                }},
                new LinkedHashMap(){{
                    put("name", "Layla Miller");
                    put("birth_date", new AbstractMap.SimpleEntry("Calendar_Instant",
                        new LinkedHashMap(){{put("y",1995); put("m",8); put("d",27);}}
                    ));
                    put("phone_numbers", new AbstractMap.SimpleEntry("Set", new String[]{}));
                }},
                new LinkedHashMap(){{
                    put("name", "岩倉 玲音");
                    put("birth_date", new AbstractMap.SimpleEntry("Calendar_Instant",
                        new LinkedHashMap(){{put("y",1984); put("m",7); put("d",6);}}
                    ));
                    put("phone_numbers", new AbstractMap.SimpleEntry("Set",
                        new String[]{"+81.9072391679"}
                    ));
                }},
            })
        ))
    ))
```

# DESCRIPTION

This document consists of multiple parts; for a directory to all of the
parts, see [Overview](Muldis_Object_Notation.md).

This part of the **Muldis Object Notation** document specifies the
canonical concrete Java hosted syntax of MUON,
which expresses a MUON artifact in terms of a native in-memory value or
object of the Java programming language,
version 17 (2021; or 8, 2014) or later,
as a non-cyclic data structure composed only using system-defined types.

The MUON `Syntax_Java` is derived from and maps with the MUON
[Syntax_Abstract](Muldis_Object_Notation_Syntax_Abstract.md); see that plus
[Semantics](Muldis_Object_Notation_Semantics.md) for further context.

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

The prescribed standard *syntax predicate* of a **Syntax** signature for a
MUON Java-hosted artifact is `Muldis_Object_Notation_Java`.

See also <https://docs.oracle.com/javase/specs/index.html>.

# SIMPLE PRIMARY DATA TYPE POSSREPS

## Ignorance

An **Ignorance** artifact is any of the following:

* The special Java `null` value.

## Boolean

A **Boolean** artifact is any of the following:

* Any value of the Java primitive type `boolean`.

* Any object of the Java class `java.lang.Boolean`.

Not permitted for a **Boolean** is any of the following,
to keep things more correct and simpler:

* Any value of any numeric type such that zero/one represents false/true.

* Any value of some other type that might represent a boolean.

## Integer

An **Integer** artifact is any of the following:

* Any *SYS_Integer*.

A *SYS_Integer* is any of the following:

* Any value of any of the Java primitive types `int`, `long`.

* Any object of any of the Java classes `java.lang.Integer`, `java.lang.Long`.

* Any object of the Java class `java.math.BigInteger`.

Not permitted for a *SYS_Integer* is any of the following,
to keep things more correct and simpler:

* Any value of any of the Java primitive types `byte`, `short`.

* Any object of any of the Java classes `java.lang.Byte`, `java.lang.Short`.

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

* Any value of any of the Java primitive types `float`, `double`
that represents a finite number or signed zero;
both signed zeroes are treated as the same plain zero.

* Any object of any of the Java classes `java.lang.Float`, `java.lang.Double`
that represents a finite number or signed zero;
both signed zeroes are treated as the same plain zero.

* Any object of the Java class `java.math.BigDecimal`.

Not permitted for a *SYS_Fraction* is any of the following,
to keep things more correct and simpler:

* Any value of any of the Java primitive types `float`, `double`
that represents an infinity or NaN.

* Any object of any of the Java classes `java.lang.Float`, `java.lang.Double`
that represents an infinity or NaN.

## Bits

A **Bits** artifact is any of the following:

* Any object of the Java class `java.util.BitSet`.

## Blob

A **Blob** artifact is any of the following:

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `Blob`
and its *SYS_that* is any value of the Java primitive type array `byte[]`.

Not permitted for a **Blob** is any of the following,
to prevent ambiguity and simplify things:

* Any value of the Java primitive type array `byte[]`.
This is because to keep things simple we treat all standalone Java array
values as being attempts at **Lot** artifacts, so we can succeed at
interpreting possreps or fail fast rather than having to scan a whole one
in case it is all `byte` elements.

## Text / Attribute Name

A **Text** artifact is any of the following:

* Any *SYS_Text*.

A *SYS_Text* is any of the following:

* Any object of the Java class `java.lang.String` that is *well formed*.

Not permitted for a *SYS_Text* is any of the following,
to keep things more correct and simpler:

* Any object of the Java class `java.lang.String` that is not *well formed*.

* Any value of the Java primitive type `char`.

* Any object of the Java class `java.lang.Character`.

* Any object of any of the Java classes
`java.lang.StringBuffer`, `java.lang.StringBuilder`.

* Any raw or internal alternatives such as `char[]`, `int[]`, `byte[]`.

A Java `java.lang.String` is characterized as an ordered sequence of 0..N `char`
such that each of the latter is an unsigned 16-bit integer *C*.
A *well formed* string denotes a Unicode BMP code point with a single *C*
in the non-surrogate set `{0..0xD7FF,0xE000..0xFFFF}`
(`java.lang.Character.isSurrogate()` is false) or it denotes a Unicode
non-BMP code point with an ordered pair of *C* each in the surrogate set
`{0xD800..0xDFFF}` (`java.lang.Character.isSurrogate()` is true) and the pair
is also well formed (`java.lang.Character.isSurrogatePair()` is true); a
*well formed* string does not contain any *C* in the surrogate set that
isn't so paired.

## Nesting / Attribute Name List

A **Nesting** artifact is any of the following:

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `Nesting`
and its *SYS_that* is any *SYS_Nesting*.

Not permitted for a **Nesting** is any of the following,
to prevent ambiguity and simplify things:

* Any *SYS_Array_T*.  This is because that would be interpreted as
a **Lot** artifact all of whose members are any **Text** artifacts.

A *SYS_Nesting* is any of the following:

* Any *SYS_Array_T*.

* Any *SYS_Text*.

A *SYS_Array_T* is any of the following:

* Any *SYS_Array_A* such that each of its elements is any *SYS_Text*;
for example, any value of the Java primitive type array `String[]`.

# COLLECTIVE PRIMARY DATA TYPE POSSREPS

## Duo

A **Duo** artifact is any of the following:

* Any *SYS_Duo_AA* such that its *SYS_this* is *this*
(any **Any** artifact except for any *Primary_Possrep_Name*)
and its *SYS_that* is *that* (any **Any** artifact).

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `Duo`
and its *SYS_that* is
any *SYS_Duo_AA* such that its *SYS_this* is *this* (any **Any** artifact)
and its *SYS_that* is *that* (any **Any** artifact).

A *SYS_Duo_TA* is any of the following:

* Any *SYS_Duo_AA* such that its *SYS_this* is any *SYS_Text*.

A *SYS_Duo_AA* is any of the following:

* Any object of any Java class that composes the Java interface `java.util.Map.Entry`
such that its `key` property is *SYS_this* and its `value` property is *SYS_that*.

Note that example composers of `java.util.Map.Entry` are:
`java.util.AbstractMap.SimpleImmutableEntry`,
`java.util.AbstractMap.SimpleEntry`.

Not permitted for a *SYS_Duo_AA* is any of the following,
to keep things more correct and simpler:

* Any values or objects of N-ary collection types having exactly 2 elements.

## Lot

A **Lot** artifact is any of the following:

* Any *SYS_Non_Qualified_Array_Lot*.

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `Lot`
and its *SYS_that* is any *SYS_Non_Qualified_Lot*.

A *SYS_Non_Qualified_Lot* is any of the following:

* Any *SYS_Non_Qualified_Array_Lot*.

* Any *SYS_Ordered_Dictionary_AA* such that each of its elements in turn is
*multiplied member* whose element key is *member* (any **Any** artifact)
and whose element value is *multiplicity*
(any **Any** artifact but conceptually a real number);
this format can express every possible **Lot**,
such that an explicit multiplicity is specified for each member as a number
rather than by repeating the member value for each instance.

A *SYS_Non_Qualified_Array_Lot* is any of the following:

* Any *SYS_Array_A* such that each of its elements in turn is *member*
(any **Any** artifact) and its corresponding *multiplicity* is 1;
this format can express every possible **Lot**,
such that each distinct member repeats per instance.

A *SYS_Array_A* is any of the following:

* Any object of any Java array class
(an array class has a name like `foo[]` and is a class for whom
the predicate `java.lang.Class.isArray()` results in true).

* Any object of any Java class that composes the Java interface `java.util.List`.

Note that example composers of `java.util.List` are:
`java.util.ArrayList`,
`java.util.LinkedList`,
`java.util.Vector`,
`java.util.concurrent.CopyOnWriteArrayList`.

## Kit

A **Kit** artifact is any of the following:

* Any *SYS_Non_Qualified_Named_Kit*.

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `Kit`
and its *SYS_that* is any *SYS_Non_Qualified_Kit*.

A *SYS_Non_Qualified_Kit* is any of the following:

* Any *SYS_Array_A* such that each of its elements
in turn is *attribute asset* (any **Any** artifact) and its corresponding
*attribute name* is the ordinal position of that element;
this format can express any **Kit** which has only normalized ordered attributes;
this format is more concise than the general format.

* Any *SYS_Non_Qualified_Named_Kit*.

A *SYS_Non_Qualified_Named_Kit* is any of the following:

* Any *SYS_Ordered_Dictionary_AA* such that each of its elements in turn is
*attribute* whose element key is *attribute name* (any *SYS_Text*)
and whose element value is *attribute asset* (any **Any** artifact);
this format can express every possible **Kit**.

A *SYS_Ordered_Dictionary_AA* is any of the following:

* Any object of the Java class `java.util.LinkedHashMap`.

Not permitted for a *SYS_Ordered_Dictionary_AA* is any of the following,
to prevent ambiguity and simplify things:

* Any object of any Java class, except for `java.util.LinkedHashMap`,
that composes the Java interface `java.util.Map`,
because its collection of elements is likely to be unordered.

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

* Any object of any of the Java classes
`java.time.Duration`,
`java.time.Period`.

*TODO: Consider removing some of the above options.*

## Calendar Instant

A **Calendar Instant** artifact is additionally any of the following:

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
