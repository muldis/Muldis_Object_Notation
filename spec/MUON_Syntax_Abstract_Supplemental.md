<a name="TOP"></a>

# Muldis Object Notation (MUON) Syntax_Abstract Supplemental

This document features supplemental material that used to be the content of
various mainly **SECONDARY DATA TYPE POSSREPS** sections of
[Syntax_Abstract](Muldis_Object_Notation_Syntax_Abstract.md)
but was removed from there when MUON itself was narrowed in scope to
encompass just what was previouly called its **PRIMARY** possreps.
In particular, it was deemed better for the complementary **Muldis Data
Language** (**MDL**) specification to have the sole canonical definitions
of these **SECONDARY** possreps, in the form of corresponding data type
definitions, rather than MUON having many mostly redundant definitions.
But this document is provided for posterity of how they were defined in the
form of MUON possreps, in case that may be helpful to MUON implementations.

## CONTENTS

- [OVERVIEW OF ABSTRACT DATA TYPE POSSREPS](#OVERVIEW-OF-ABSTRACT-DATA-TYPE-POSSREPS)
- [FOLDING ALGEBRAIC DATA TYPE POSSREPS](#FOLDING-ALGEBRAIC-DATA-TYPE-POSSREPS)
    - [Fractional](#Fractional)
- [COMMON QUALITIES OF ABSTRACT SECONDARY DATA TYPE POSSREPS](#COMMON-QUALITIES-OF-ABSTRACT-SECONDARY-DATA-TYPE-POSSREPS)
- [LESS-COLLECTIVE SECONDARY DATA TYPE POSSREPS](#LESS-COLLECTIVE-SECONDARY-DATA-TYPE-POSSREPS)
    - [Calendar Time](#Calendar-Time)
    - [Calendar Duration](#Calendar-Duration)
    - [Calendar Instant](#Calendar-Instant)
    - [Geographic Point](#Geographic-Point)
- [MORE-COLLECTIVE SECONDARY DATA TYPE POSSREPS](#MORE-COLLECTIVE-SECONDARY-DATA-TYPE-POSSREPS)
    - [Array](#Array)
    - [Set](#Set)
    - [Bag / Multiset](#Bag---Multiset)
    - [Mix](#Mix)
    - [Interval](#Interval)
    - [Set Of Interval](#Set-Of-Interval)
    - [Bag Of Interval](#Bag-Of-Interval)
    - [Heading / Attribute Name Set](#Heading---Attribute-Name-Set)
    - [Renaming / Attribute Name Map](#Renaming---Attribute-Name-Map)
    - [Tuple / Attribute Set](#Tuple---Attribute-Set)
    - [Orderelation / Tuple Array](#Orderelation---Tuple-Array)
    - [Relation / Tuple Set](#Relation---Tuple-Set)
    - [Multirelation / Tuple Bag](#Multirelation---Tuple-Bag)
    - [Article / Labelled Tuple](#Article---Labelled-Tuple)
    - [Excuse](#Excuse)

[RETURN](#TOP)

<a name="OVERVIEW-OF-ABSTRACT-DATA-TYPE-POSSREPS"></a>

# OVERVIEW OF ABSTRACT DATA TYPE POSSREPS

This document section still has a counterpart in
[Syntax_Abstract](Muldis_Object_Notation_Syntax_Abstract.md)
as of the creation of this current **Supplemental** document,
but it was rewritten to something much shorter.

Each valid abstract MUON artifact is an instance of a single abstract MUON
possrep.  Each abstract MUON possrep is of exactly one of these 3 kinds:
*algebraic possrep*, *primary possrep*, *secondary possrep*.

This document considers each abstract MUON *primary possrep* to be
fundamental and to simply exist.  It is manadatory that each concrete MUON
syntax will bootstrap a *primary possrep* in terms of one or more
dedicated concrete literal formats or host language data types.

This document considers each abstract MUON *secondary possrep* to be
non-fundamental and to be defined as a special case of a *primary possrep*.
Each concrete MUON syntax does not have to say anything at all about any
*secondary possrep*, but it may optionally provide for it one or more
dedicated concrete literal formats or host language data types.

This document considers each abstract MUON *algebraic possrep* to be
non-fundamental and to be defined as a union of 0..N *primary possrep*.

See [Semantics](Muldis_Object_Notation_Semantics.md) for further context.

This document part provides illustrative example code in the concrete
[Syntax_Plain_Text](Muldis_Object_Notation_Syntax_Plain_Text.md)
but expressly limits itself to the *primary possrep* literal formats.

[RETURN](#TOP)

<a name="FOLDING-ALGEBRAIC-DATA-TYPE-POSSREPS"></a>

## FOLDING ALGEBRAIC DATA TYPE POSSREPS

[RETURN](#TOP)

<a name="Fractional"></a>

### Fractional

A **Fractional** artifact is an artifact that qualifies as either
any **Rational** artifact or as any **Integer** artifact.
A context explicitly requiring any **Fractional** artifact implicitly requires
any **Rational** artifact; when an **Integer** artifact is instead given,
then the proper interpretation is as if a **Rational** artifact was
actually given whose numeric value was the same as that **Integer**.

[RETURN](#TOP)

<a name="COMMON-QUALITIES-OF-ABSTRACT-SECONDARY-DATA-TYPE-POSSREPS"></a>

## COMMON QUALITIES OF ABSTRACT SECONDARY DATA TYPE POSSREPS

Every abstract MUON *secondary possrep* has one or more general *qualified*
formats characterized by the pairing of a *predicate* with a *subject*.
There is NOT any abstract MUON secondary possrep that has any alternative
*nonqualified* formats characterized by the *subject* on its own; however,
the latter is a common option for concrete MUON possreps.

Every (qualified) abstract MUON artifact is a **Pair** artifact;
its *this* is the *predicate* and its *that* is the *subject*.

Every MUON possrep *predicate* is a **Name** artifact,
and that value is characterized by the name
of the MUON possrep in this document.  Every MUON possrep *predicate*
conforms to the character string pattern `[<[A..Z]><[a..z]>+]+ % _`.

The general case of every MUON possrep *subject* is, loosely speaking, an
**Any** artifact, though strictly speaking, the validity of a *subject* is
constrained to those enumerated by the MUON possreps.

[RETURN](#TOP)

<a name="LESS-COLLECTIVE-SECONDARY-DATA-TYPE-POSSREPS"></a>

## LESS-COLLECTIVE SECONDARY DATA TYPE POSSREPS

[RETURN](#TOP)

<a name="Calendar-Time"></a>

### Calendar Time

A **Calendar Time** artifact has the predicate `Calendar_Time`.

Its subject is any of the following:

* Any **Kit** artifact having any subset of the 6 attributes of the
heading [`y|year`,`m|month`,`d|day`,`h|hour`,`i|minute`,`s|second`] such
that their corresponding attribute assets are [*year*, *month*, *day*,
*hour*, *minute*, *second*]; each of those 6 is any **Fractional** artifact.

Examples:

```
    `No measurement was taken or specified at all.`
    (:Calendar_Time : {})

    `Either an unspecified period in 1970 or a duration of 1970 years.`
    (:Calendar_Time : {y:1970})

    `Either a civil calendar date 2015-5-3 or a duration of 2015y+5m+3d.`
    (:Calendar_Time : {y:2015,m:5,d:3})

    `Either a military calendar date 1998-300 or a duration of 1998y+300d.`
    (:Calendar_Time : {y:1998,d:300})

    `Either the 6th week of 1776 or a duration of 1776 years + 6 weeks.`
    (:Calendar_Time : {y:1776,d:42})

    `Either the first quarter of 1953 or a duration of 1953.25 years.`
    (:Calendar_Time : {y:1953.25})

    `Either high noon on an unspecified day or a duration of 12 hours.`
    (:Calendar_Time : {h:12,i:0,s:0})

    `Either a fully specified civil date and time or a 6-part duration.`
    (:Calendar_Time : {y:1884,m:10,d:17,h:20,i:55,s:30})

    `Either an ancient date and time or a negative duration.`
    (:Calendar_Time : {y:-370,m:1,d:24,h:11,i:0,s:0})

    `Either a time on some unspecified day or a duration of seconds.`
    (:Calendar_Time : {s:5923.21124603})
```

[RETURN](#TOP)

<a name="Calendar-Duration"></a>

### Calendar Duration

A **Calendar Duration** artifact has the predicate `Calendar_Duration`.

Its subject is any of the following:

* Any **Calendar Time** subject.

Examples:

```
    `Addition of 2 years and 3 months.`
    (:Calendar_Duration : {y:2,m:3,d:0,h:0,i:0,s:0})

    `Subtraction of 22 hours.`
    (:Calendar_Duration : {y:0,m:0,d:0,h-22,i:0,s:0})
```

[RETURN](#TOP)

<a name="Calendar-Instant"></a>

### Calendar Instant

A **Calendar Instant** artifact has the predicate `Calendar_Instant`.

Its subject is any of the following:

* Any *instant base*.

* Any **Pair** artifact such that its *this* and *that* respectively are
the *instant base* and *instant offset*.

* Any **Pair** artifact such that its *this* and *that* respectively are
the *instant base* and *instant zone*.

The above components are defined as follows:

* An *instant base* is any **Calendar Time** subject.

* An *instant offset* is any **Calendar Time** subject
such that it is restricted to a subset of [*hour*, *minute*, *second*].

* An *instant zone* is any **Text** artifact.

Examples:

```
    `The Day The Music Died (if paired with Gregorian calendar).`
    (:Calendar_Instant : {y:1959,m:2,d:3})

    `A time of day when one might have breakfast.`
    (:Calendar_Instant : {h:7,i:30,s:0})

    `What was now in the Pacific zone (if paired with Gregorian calendar).`
    (:Calendar_Instant : ({y:2018,m:9,d:3,h:20,i:51,s:17}:{h:-8,i:0,s:0}))

    `A time of day in the UTC zone on an unspecified day.`
    (:Calendar_Instant : ({h:9,i:25,s:0}:{h:0,i:0,s:0}))

    `A specific day and time in the Pacific Standard Time zone.`
    (:Calendar_Instant : ({y:2001,m:4,d:16,h:20,i:1,s:44}:"PST"))
```

[RETURN](#TOP)

<a name="Geographic-Point"></a>

### Geographic Point

A **Geographic Point** artifact has the predicate `Geographic_Point`.

Its subject is any of the following:

* Any **Kit** artifact having any subset of the 3 attributes of the
heading [`">"|longitude`,`"^"|latitude`,`"+"|elevation`] such that their
corresponding attribute assets are [*longitude*, *latitude*, *elevation*];
each of those 6 is any **Fractional** artifact.

Examples:

```
    `No specified coordinates at all.`
    (:Geographic_Point : {})

    `Just an elevation specified.`
    (:Geographic_Point : {"+":920})

    `Geographic surface coordinates of Googleplex; elevation not specified.`
    (:Geographic_Point : {">":-122.0857017,"^":37.4218363})

    `Same thing.`
    (:Geographic_Point : {"^":37.4218363,">":-122.0857017})

    `Some location with all coordinates specified.`
    (:Geographic_Point : {">":-101,"^":-70,"+":1000})

    `Another place.`
    (:Geographic_Point : {">":-94.746094,"^":37.483577})
```

[RETURN](#TOP)

<a name="MORE-COLLECTIVE-SECONDARY-DATA-TYPE-POSSREPS"></a>

## MORE-COLLECTIVE SECONDARY DATA TYPE POSSREPS

[RETURN](#TOP)

<a name="Array"></a>

### Array

An **Array** artifact has the predicate `Array`.

Its subject is any of the following:

* Any **Lot** artifact such that for every one of its *multiplied members*
LM, that member denotes a sequence of consecutive identical members AM of
the **Array**; LM's *member* denotes the value of each AM and LM's
*multiplicity* is any **Integer** artifact which denotes a non-negative
integer and indicates how many elements that sequence has.

Examples:

```
    `Zero members.`
    (:Array : [])

    `One member.`
    (:Array : [ "You got it!" ])

    `Three members.`
    (:Array : [
        "Alphonse",
        "Edward",
        "Winry",
    ])

    `Five members (1 duplicate).`
    (:Array : [
        57,
        45,
        63,
        61,
        63,
    ])

    `32 members (28 duplicates in 2 runs).`
    (:Array : [
        "/",
        "*" : 20,
        "+" : 10,
        "-",
    ])
```

[RETURN](#TOP)

<a name="Set"></a>

### Set

A **Set** artifact has the predicate `Set`.

Its subject is any of the following:

* Any **Lot** artifact such that for every one of its *multiplied members*,
that multiplied member's *member* denotes a potential distinct member of
the **Set** and the multiplied member's *multiplicity* is any **Integer**
artifact which denotes a non-negative integer *multiplicity*
(any greater than 1 is treated as 1).

Examples:

```
    `Zero members.`
    (:Set : [])

    `One member.`
    (:Set : [ "I know this one!" ])

    `Four members (no duplicates).`
    (:Set : [
        "Canada",
        "Spain",
        "Jordan",
        "Jordan",
        "Thailand",
    ])

    `Three members.`
    (:Set : [
        3,
        16,
        85,
    ])

    `Two members.`
    (:Set : [
        21 : 1,
        62 : 0,
        3 : 1,
        101 : 0,
    ])
```

[RETURN](#TOP)

<a name="Bag---Multiset"></a>

### Bag / Multiset

A **Bag** artifact has the predicate `Bag`.

Its subject is any of the following:

* Any **Lot** artifact such that for every one of its *multiplied members*,
that multiplied member's *member* denotes a potential distinct member of
the **Bag** and the multiplied member's *multiplicity* is any **Integer**
artifact which denotes a non-negative integer *multiplicity*.

Examples:

```
    `Zero members.`
    (:Bag : [])

    `One member.`
    (:Bag : [ "I hear that!": 1 ])

    `1200 members (1197 duplicates).`
    (:Bag : [
        "Apple"  : 500,
        "Orange" : 300,
        "Banana" : 400,
    ])

    `Six members (2 duplicates).`
    (:Bag : [
        "Foo" : 1,
        "Quux" : 1,
        "Foo" : 1,
        "Bar" : 1,
        "Baz" : 1,
        "Baz" : 1,
    ])
```

[RETURN](#TOP)

<a name="Mix"></a>

### Mix

A **Mix** artifact has the predicate `Mix`.

Its subject is any of the following:

* Any **Lot** artifact such that for every one of its *multiplied members*,
that multiplied member's *member* denotes a potential distinct member of
the **Mix** and the multiplied member's *multiplicity* is any **Fractional**
artifact which denotes a nonzero possibly fractional *multiplicity*.

Examples:

```
    `Zero members; we measured zero of nothing in particular.`
    (:Mix : [])

    `One member; one gram of mass.`
    (:Mix : [::Gram: 1.0])

    `29.95 members (28.95 duplicates); the cost of a surgery.`
    (:Mix : [::USD: 29.95])

    `9.8 members; acceleration under Earth's gravity.`
    (:Mix : [::Meter_Per_Second_Squared: 9.8])

    `0.615 members (fractions of 3 distinct members); recipe.`
    (:Mix : [
        ::Butter : 0.22,
        ::Sugar  : 0.1,
        ::Flour  : 0.275,
        ::Sugar  : 0.02,
    ])

    `4/3 members (fractions of 3 distinct members); this-mix.`
    (:Mix : [
        Sugar: 1/3,
        Spice: 1/4,
        All_Things_Nice: 3/4,
    ])

    `-1.5 members; adjustment for recipe.`
    (:Mix : [
        Rice: +4.0,
        Beans: -5.7,
        Carrots: +0.2,
    ])
```

[RETURN](#TOP)

<a name="Interval"></a>

### Interval

An **Interval** artifact has the predicate `Interval`.

Its subject is any of the following:

* The **Text** artifact empty string value; this designates an *empty interval*.

* Any **Pair** artifact such that its *this* is the **Text** artifact empty
string value and its *that* is any **Any** artifact; this designates a
*unit interval*, and *that* corresponds to its sole member.

* Any **Pair** artifact such that its *this* is any of the 5 **Text**
artifacts [`<=*<=`, `<=*<`, `<*<=`, `<*<`, `..`] and its *that* is any
**Pair** artifact such that its *this* and *that* respectively are each any
**Any** artifact; this designates a *bounded interval*, and the latter
*this* and *that* correspond respectively to the low and high endpoints.

* Any **Pair** artifact such that its *this* is any of the 2 **Text**
artifacts [`<=*`, `<*`] and its *that* is any **Any** artifact; this
designates a *low-bounded, high-unbounded interval*, and *that* corresponds
to the low endpoint.

* Any **Pair** artifact such that its *this* is any of the 2 **Text**
artifacts [`*<=`, `*<`] and its *that* is any **Any** artifact; this
designates a *low-unbounded, high-bounded interval*, and *that* corresponds
to the high endpoint.

* The **Text** artifact `*`;
this designates a *universal interval* or *unbounded interval*.

Examples:

```
    `Empty interval (zero members).`
    (:Interval : "")

    `Unit interval (one member).`
    (:Interval : ("":"abc"))

    `Closed interval (probably 10 members, depending on the model used).`
    (:Interval : ("<=*<=":(1:10)))

    `Same thing.`
    (:Interval : ("..":(1:10)))

    `Left-closed, right-open interval; every Rational x in [2.7<=x<9.3].`
    (:Interval : ("<=*<":(2.7:9.3)))

    `Left-open, right-closed interval; every Text x ordered in [a<x<=z].`
    (:Interval : ("<*<=":(:a : z)))

    `Open interval; time period between Dec 6 and 20 excluding both.`
    (:Interval : ("<*<":(
          (:Calendar_Instant : ({y:2002,m:12,d: 6}:"UTC"))
        : (:Calendar_Instant : ({y:2002,m:12,d:20}:"UTC"))
    )))

    `Left-unbounded, right-closed interval; every Integer x where x <= 3.`
    (:Interval : ("*<=":3))

    `Left-closed, right-unbounded interval; every Integer x where 29 <= x.`
    (:Interval : ("<=*":29))

    `Universal interval; unbounded; every value of type system is a member.`
    (:Interval : "*")
```

[RETURN](#TOP)

<a name="Set-Of-Interval"></a>

### Set Of Interval

A **Set Of Interval** artifact has the predicate `Set_Of_Interval`.

Its subject is any of the following:

* Any **Set** subject such that every *member* is an **Interval** subject.

Examples:

```
    `Empty set-of-interval (zero members).`
    (:Set_Of_Interval : [])

    `Unit set-of-interval (one member).`
    (:Set_Of_Interval : [("":"abc")])

    `Probably 10 members, depending on the model used.`
    (:Set_Of_Interval : [("<=*<=":(1:10))])

    `Same thing.`
    (:Set_Of_Interval : [("..":(1:10))])

    `Probably 6 members.`
    (:Set_Of_Interval : [("..":(1:3)),("":6),("..":(8:9))])

    `Every Integer x except for [4..13,22..28]`
    (:Set_Of_Interval : [("*<=":3),("..":(14:21)),("<=*":29)])

    `Set of all valid Unicode code points.`
    (:Set_Of_Interval : [("..":(0:0xD7FF)),("..":(0xE000:0x10FFFF))])

    `Probably 15 members (no duplicates), depending on the model used.`
    (:Set_Of_Interval : [("..":(1:10)),("..":(6:15))])

    `Probably same thing, regardless of data model used.`
    (:Set_Of_Interval : [("<=*<":(1:6)),("..":(6:10)):2,("<*<=":(10:15))])
```

[RETURN](#TOP)

<a name="Bag-Of-Interval"></a>

### Bag Of Interval

A **Bag Of Interval** artifact has the predicate `Bag_Of_Interval`.

Its subject is any of the following:

* Any **Set Of Interval** subject but that any **Bag** subject is used in
place of the specified any **Set** subject.

Examples:

```
    `Empty bag-of-interval (zero members).`
    (:Bag_Of_Interval : [])

    `Unit bag-of-interval (one member).`
    (:Bag_Of_Interval : [("":"abc")])

    `Five members (4 duplicates).`
    (:Bag_Of_Interval : [("":def):5])

    `Probably 20 members (5 duplicates), depending on the model used.`
    (:Bag_Of_Interval : [("<=*<=":(1:10)),("<=*<=":(6:15))])

    `Same thing.`
    (:Bag_Of_Interval : [("..":(1:10)),("..":(6:15))])

    `Probably same thing, regardless of data model used.`
    (:Bag_Of_Interval : [("<=*<":(1:6)),("..":(6:10)):2,("<*<=":(10:15))])
```

[RETURN](#TOP)

<a name="Heading---Attribute-Name-Set"></a>

### Heading / Attribute Name Set

A **Heading** artifact has the predicate `Heading`.

Its subject is any of the following:

* Any **Kit** artifact such that every one of its attribute assets is a
**Text** artifact, and no 2 attribute asset values are the same value (and
presumably the attribute names are all positional).  The *attribute assets*
of the **Kit** denote the *attribute names* of the **Heading**.

Examples:

```
    `Zero attributes.`
    (:Heading : {})

    `One named attribute.`
    (:Heading : {sales})

    `Same thing.`
    (:Heading : {"sales"})

    `One positional attribute.`
    (:Heading : {:0})

    `Same thing.`
    (:Heading : {"\(0)"})

    `Three named attributes.`
    (:Heading : {:region,:revenue,:qty})

    `Three positional attributes.`
    (:Heading : {:0,:1,:2})

    `One of each.`
    (:Heading : {:1,age})

    `Some attribute names can only appear quoted.`
    (:Heading : {"Street Address"})

    `A non-Latin name.`
    (:Heading : {"サンプル"})
```

[RETURN](#TOP)

<a name="Renaming---Attribute-Name-Map"></a>

### Renaming / Attribute Name Map

A **Renaming** artifact has the predicate `Renaming`.

Its subject is any of the following:

* Any **Kit** artifact such that every one of its attribute assets is a
**Text** artifact, and no 2 attribute asset values are the same value; for
each *attribute*, that attribute's name and asset respectively specify the
*name before* and *name after* name of some other attribute being renamed
of some other attributive value.

Examples:

```
    `Zero renamings, a no-op.`
    (:Renaming : {})

    `Also a no-op.`
    (:Renaming : {age->age})

    `Also a no-op.`
    (:Renaming : {:0})

    `Rename one attribute.`
    (:Renaming : {fname->:first_name})

    `Same thing.`
    (:Renaming : {fname : :first_name})

    `Swap 2 named attributes.`
    (:Renaming : {foo->:bar,bar->:foo})

    `Convert positional names to nonpositional.`
    (:Renaming : {:foo,:bar})

    `Same thing.`
    (:Renaming : {0->:foo,1->:bar})

    `Convert nonpositional names to positional.`
    (:Renaming : {foo->:0,bar->:1})

    `Swap 2 positional attributes.`
    (:Renaming : {0->:1,1->:0})

    `Same thing.`
    (:Renaming : {:1,:0})

    `Some attribute names can only appear quoted.`
    (:Renaming : {"First Name"->:"Last Name"})
```

[RETURN](#TOP)

<a name="Tuple---Attribute-Set"></a>

### Tuple / Attribute Set

A **Tuple** artifact has the predicate `Tuple`.

Its subject is any of the following:

* Any **Kit** artifact such that its *attributes* define the same
*attributes* of the **Tuple**.  This is the idiomatic format for specifying
a **Tuple** where the attribute names and assets appear interleaved.

* Any **Pair** artifact such that its *this* and *that* correspond to the
*heading* and *body* of the new **Tuple** respectively, and its *that* is
any **Tuple** subject, and its *this* is any **Renaming** subject such
that its set of *name before* is identical to the set of attribute names of
*that*.  This is the idiomatic format for specifying a **Tuple** where all
the attribute names appear first and then all the corresponding attribute
assets appear second, like in a terse columnar format with a single data row.

Examples:

```
    `Zero attributes.`
    (:Tuple : {})

    `One named attribute.`
    (:Tuple : {"First Name": "Joy"})

    `One positional attribute.`
    (:Tuple : {53})

    `Three positional attributes.`
    (:Tuple : {"hello",26,0bTRUE})

    `One of each.`
    (:Tuple : {"Jay", age: 10})

    `Two named attributes.`
    (:Tuple : {
        name : "Michelle",
        age  : 17,
    })

    `Same thing.`
    (:Tuple : (
          {:name     , :age}
        : {"Michelle", 17  }
    ))
```

[RETURN](#TOP)

<a name="Orderelation---Tuple-Array"></a>

### Orderelation / Tuple Array

An **Orderelation** artifact has the predicate `Orderelation`.

Its subject is any of the following:

* Any **Relation** subject but that any **Array** subject is used in
place of the specified any **Set** subject.

Examples:

```
    `Zero attributes + zero tuples.`
    (:Orderelation : {})

    `Zero attributes + one tuple.`
    (:Orderelation : [{}])

    `Three named attributes + zero tuples.`
    (:Orderelation : {:x,:y,:z})

    `Three positional attributes + zero tuples.`
    (:Orderelation : {:0,:1,:2})

    `Two named attributes + three tuples (1 duplicate).`
    (:Orderelation : [
        {name: "Amy"     , age: 14},
        {name: "Michelle", age: 17},
        {name: "Amy"     , age: 14},
    ])

    `Two positional attributes + two tuples.`
    (:Orderelation : [
        {"Michelle", 17},
        {"Amy"     , 14},
    ])
```

[RETURN](#TOP)

<a name="Relation---Tuple-Set"></a>

### Relation / Tuple Set

A **Relation** artifact has the predicate `Relation`.

Its subject is any of the following:

* Any **Heading** subject, which denotes the *heading* of the
**Relation**, and the *body* of the **Relation** has zero tuples.
This is the idiomatic format for an empty (zero-tuple) **Relation**.

* Any **Set** subject such that every *member* is a **Tuple**
subject, and the count of its members is at least 1, and no 2 members have
different *headings*.  The *members* of the **Set** subject denote the *body* or
*members* of the **Relation**, and any one *member* also denotes the
*heading* of the **Relation**.  This is the idiomatic format for specifying
a non-empty (at least one tuple) **Relation** where the attribute names
repeat for every tuple.

* Any **Pair** artifact such that its *this* and *that* correspond to the
*heading* and *body* of the new **Relation** respectively, and its *that*
is any **Set** subject per the prior bullet point but that it may have
zero members, and its *this* is any **Renaming** subject such that its set
of *name before* is identical to the set of attribute names in every
*member* of *that*.  This is the idiomatic format for specifying a
**Relation** where the attribute names just appear once and are shared for
every tuple, like in a terse columnar table format; it is expected the
normal use case of this format is that every **Set** subject member only has
positional attributes and the **Renaming** is effectively giving them
non-positional names.

Examples:

```
    `Zero attributes + zero tuples.`
    (:Relation : {})

    `Same thing.`
    (:Relation : ({}:[]))

    `Zero attributes + one tuple.`
    (:Relation : [{}])

    `Same thing.`
    (:Relation : ({}:[{}]))

    `Three named attributes + zero tuples.`
    (:Relation : {:x,:y,:z})

    `Three positional attributes + zero tuples.`
    (:Relation : {:0,:1,:2})

    `Two named attributes + two tuples.`
    (:Relation : [
        {name: "Michelle", age: 17},
        {name: "Amy"     , age: 14},
    ])

    `Same thing.`
    (:Relation : (
            {:name     , :age}
        : [
            {"Michelle", 17  },
            {"Amy"     , 14  },
        ]
    ))

    `Two positional attributes + two tuples.`
    (:Relation : [
        {"Michelle", 17},
        {"Amy"     , 14},
    ])

    `Some people records.`
    (:Relation : [
        {name : "Jane Ives", birth_date : (:Calendar_Instant : {y:1971,m:11,d:6}),
            phone_numbers : (:Set : ["+1.4045552995", "+1.7705557572"])},
        {name : "Layla Miller", birth_date : (:Calendar_Instant : {y:1995,m:8,d:27}),
            phone_numbers : (:Set : [])},
        {name : "岩倉 玲音", birth_date : (:Calendar_Instant : {y:1984,m:7,d:6}),
            phone_numbers : (:Set : ["+81.9072391679"])},
    ])

    `Same thing.`
    (:Relation : (
            {:name         , :birth_date                            , :phone_numbers}
        : [
            {"Jane Ives"   , (:Calendar_Instant : {y:1971,m:11,d:6}), (:Set : ["+1.4045552995", "+1.7705557572"])},
            {"Layla Miller", (:Calendar_Instant : {y:1995,m:8,d:27}), (:Set : [])},
            {"岩倉 玲音", (:Calendar_Instant : {y:1984,m:7,d:6}), (:Set : ["+81.9072391679"])},
        ]
    ))
```

[RETURN](#TOP)

<a name="Multirelation---Tuple-Bag"></a>

### Multirelation / Tuple Bag

A **Multirelation** artifact has the predicate `Multirelation`.

Its subject is any of the following:

* Any **Relation** subject but that any **Bag** subject is used in
place of the specified any **Set** subject.

Examples:

```
    `Zero attributes + zero tuples.`
    (:Multirelation : {})

    `Zero attributes + one tuple.`
    (:Multirelation : [{}])

    `Three named attributes + zero tuples.`
    (:Multirelation : {:x,:y,:z})

    `Three positional attributes + zero tuples.`
    (:Multirelation : {:0,:1,:2})

    `Two named attributes + six tuples (4 duplicates).`
    (:Multirelation : [
        {name: "Michelle", age: 17},
        {name: "Amy"     , age: 14} : 5,
    ])

    `Two positional attributes + two tuples.`
    (:Multirelation : [
        {"Michelle", 17},
        {"Amy"     , 14},
    ])
```

[RETURN](#TOP)

<a name="Article---Labelled-Tuple"></a>

### Article / Labelled Tuple

An **Article** artifact has the predicate `Article`.

Its subject is any of the following:

* Any **Nesting** artifact, which denotes the *label* of the
**Article**, and the **Article** has zero attributes.
This is the idiomatic format for a nullary (zero-attribute) **Article**.

* Any **Pair** artifact such that its *this* and *that* correspond to the
*label* (any **Nesting** artifact) and *attributes* (any **Kit** artifact)
of the new **Article** respectively.

Examples:

```
    (:Article : (::Point : {x : 5, y : 3}))

    (:Article : (::Float : {
        significand : 45207196,
        radix       : 10,
        exponent    : 37,
    }))

    (:Article : (::the_db::UTC_Date_Time : {
        year   : 2003,
        month  : 10,
        day    : 26,
        hour   : 1,
        minute : 30,
        second : 0.0,
    }))

    (:Article : (::Positive_Infinity : {}))

    (:Article : (::Negative_Zero : {}))
```

[RETURN](#TOP)

<a name="Excuse"></a>

### Excuse

An **Excuse** artifact has the predicate `Excuse`.

Its subject is any of the following:

* Any **Article** subject.

Examples:

```
    (:Excuse : (::Input_Field_Wrong : {name : "Your Age"}))

    (:Excuse : (::Div_By_Zero : {}))

    (:Excuse : (::No_Such_Attr_Name : {}))
```
