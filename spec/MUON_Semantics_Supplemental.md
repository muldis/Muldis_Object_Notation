<a name="TOP"></a>

# Muldis Object Notation (MUON) Semantics Supplemental

This document features supplemental material that used to be the content of
various mainly **SECONDARY DATA TYPE POSSREPS** sections of
[Semantics](Muldis_Object_Notation_Semantics.md)
but was removed from there when MUON itself was narrowed in scope to
encompass just what was previouly called its **PRIMARY** possreps.
In particular, it was deemed better for the complementary **Muldis Data
Language** (**MDL**) specification to have the sole canonical definitions
of these **SECONDARY** possreps, in the form of corresponding data type
definitions, rather than MUON having many mostly redundant definitions.
But this document is provided for posterity of how they were defined in the
form of MUON possreps, in case that may be helpful to MUON implementations.

## CONTENTS

- [FOLDING ALGEBRAIC DATA TYPE POSSREPS](#FOLDING-ALGEBRAIC-DATA-TYPE-POSSREPS)
    - [Fractional](#Fractional)
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
    - [Interval Set](#Interval-Set)
    - [Interval Bag](#Interval-Bag)
    - [Pair](#Pair)
    - [Heading / Attribute Name Set](#Heading---Attribute-Name-Set)
    - [Renaming / Attribute Name Map](#Renaming---Attribute-Name-Map)
    - [Tuple / Attribute Set](#Tuple---Attribute-Set)
    - [Tuple Array](#Tuple-Array)
    - [Relation / Tuple Set](#Relation---Tuple-Set)
    - [Tuple Bag](#Tuple-Bag)
    - [Article / Labelled Tuple](#Article---Labelled-Tuple)
    - [Excuse](#Excuse)
- [SIGNATURE DECLARING SECONDARY DATA TYPE POSSREPS](#SIGNATURE-DECLARING-SECONDARY-DATA-TYPE-POSSREPS)
    - [Syntax](#Syntax)
    - [Model](#Model)

[RETURN](#TOP)

<a name="FOLDING-ALGEBRAIC-DATA-TYPE-POSSREPS"></a>

## FOLDING ALGEBRAIC DATA TYPE POSSREPS

[RETURN](#TOP)

<a name="Fractional"></a>

### Fractional

The **Fractional** possrep is the union of the **Fraction** and **Integer**
possreps.  It is used where a context may conceptually require a **Fraction**
but it would also accept an **Integer** that would be interpreted as the
**Fraction** artifact with the same numeric value.

[RETURN](#TOP)

<a name="LESS-COLLECTIVE-SECONDARY-DATA-TYPE-POSSREPS"></a>

## LESS-COLLECTIVE SECONDARY DATA TYPE POSSREPS

[RETURN](#TOP)

<a name="Calendar-Time"></a>

### Calendar Time

A **Calendar Time** value is characterized by a **Tuple** having any subset
of the 6 attributes of the heading
[`y|year`,`m|month`,`d|day`,`h|hour`,`i|minute`,`s|second`] such that each
attribute asset is a **Fractional**, or alternately by an isomorphic **Mix**.
For each of the 6 attributes, it explicitly distinguishes between the
attribute value being specified as zero versus being unspecified; omitting
the attribute entirely means the latter.  Its main intended purpose is to
be a more generic common element for a variety of other, more specific
time-related possreps, including ones representing both durations and
instants, or for direct use with types defined by external data models.
It does *not* specifically represent a time of day.

[RETURN](#TOP)

<a name="Calendar-Duration"></a>

### Calendar Duration

A **Calendar Duration** value is a length of time expressed in terms of the
units of a standard civil or similar calendar.  It is characterized by a
**Calendar Time**.  It is up to the context supplied or interpreted by an
external data model to give it further meaning, such as whether not
specifying any smallest units means an uncertainty interval versus treating
them as zero, and so on.

[RETURN](#TOP)

<a name="Calendar-Instant"></a>

### Calendar Instant

A **Calendar Instant** value is a particular moment in time expressed in
terms of a standard civil or similar calendar.  It is characterized by an
*instant base* (characterized by a **Calendar Time**) that is either
standalone or is paired with an *instant offset* (characterized by a
**Calendar Duration**) or an *instant zone* (a time zone name characterized
by a **Text**).

Alternately, a **Calendar Instant** value is characterized by a **Tuple**
having a subset of the 3 attributes of the heading [`base`,`offset`,`zone`]
such that `base` must always be given, and at most one of [`offset`,`zone`]
may be given.

When a **Calendar Instant** consists only of an *instant base*, it
explicitly defines a *floating* instant, either a calendar date or
timestamp that is not associated with a specific time zone or a time zone
offset, or it defines a time of day not associated with any particular day.

When a **Calendar Instant** also has an *instant offset*, it explicitly
defines a calendar date or time that is local to a time zone offset from
UTC, and also indicates what that offset amount is.

When a **Calendar Instant** also has an *instant zone*, it explicitly
defines a calendar date or time that is local to a geographic time zone and
also indicates the name of that time zone.

Beyond that it is up to the context supplied or interpreted by an external
data model to give it further meaning, such as whether it is Gregorian or
Julian etc, or whether not specifying any largest units means a repeating
event or not, or whether not specifying any smallest units means an
interval or a point, and so on.  Also, it is up to the external data model
to define what are valid time zone names; MUON accepts any **Text** value.

*TODO: Consider further changes to support explicit indication of daylight
savings time observence or similar things, which might be satisfied by
permitting both an instant offset and zone name to be given together;
the existing time zone name support may also indicate this by itself.*

[RETURN](#TOP)

<a name="Geographic-Point"></a>

### Geographic Point

A **Geographic Point** value is a particular point location on the Earth's
surface characterized by cartesian coordinates named *longitude* and
*latitude* and *elevation*, where each of the latter is characterized by a
single **Fractional** value.  Each coordinate may be either specified or
unspecified; omitting it means the latter and providing it, even if zero,
means the former.

Alternately, a **Geographic Point** value is characterized by a **Tuple**
having any subset of the 3 attributes of the heading
[`">"|longitude`,`"^"|latitude`,`"+"|elevation`] such that each
attribute asset is a **Fractional**.

The coordinates may be specified in any order, and are distinguished by
their own prefix symbols.  The literal syntax has right-pointing `>` and
up-pointing `^` arrows that are meant to visually evoke *longitude* and
*latitude* respectively, so that it is more clear at a glance which of the
coordinates is which.  The `+` literal syntax represents *elevation*.  A
more-positive *longitude* is further to the East than a more-negative one,
while a more-positive *latitude* is further to the North than a
more-negative one, and a more-positive *elevation* is further from the
center of the Earth than a more-negative one.

While the *latitude* and *longitude* have semi-specific meanings, which
loosely are possibly fractional degrees in the range -180..180 and -90..90
respectively, MUON explicitly does not ascribe any specific interpretation
to the *elevation* value, aside from it increasing away from the center of
the Earth.  It is up to an external data model used with MUON to specify
the *elevation* units, such as meters or feet or whatever, as well as the
starting point, such as the center of the Earth or the surface or whatever.
The external data model also gives the more specific meanings of *latitude*
and *longitude*, such as whether they are along the surface of the Earth or
something more specific.

[RETURN](#TOP)

<a name="MORE-COLLECTIVE-SECONDARY-DATA-TYPE-POSSREPS"></a>

## MORE-COLLECTIVE SECONDARY DATA TYPE POSSREPS

[RETURN](#TOP)

<a name="Array"></a>

### Array

An **Array** value is a general purpose arbitrarily-large ordered sequence
of any other, *member* values, which explicitly does not represent any kind
of thing in particular, and is simply the sum of its members.
An **Array** in the general case may have multiple members that are the same
value, and any duplicates may or may not exist at consecutive ordinal positions.
An **Array** value is dense; iff it has any members, then its first-ordered
member is at ordinal position `0`, and its last-ordinal-positioned member
is at the ordinal position that is one less than the count of its members.

An **Array** value is also characterized by a sequence of 0..N *multiplied members*
such that each *multiplied member* is a *member*/*multiplicity* pair such that
any 2 *member* might be the same value and *multiplicity* is a positive **Integer**;
this characterization is merely a shorthand for the other one that could
manifest as a more terse run-length encoded syntax.

[RETURN](#TOP)

<a name="Set"></a>

### Set

A **Set** value is a general purpose arbitrarily-large unordered collection
of any other, *member* values, which explicitly does not represent any kind
of thing in particular, and is simply the sum of its members.
A **Set** ensures that no 2 of its members are the same value.

A **Set** value is also characterized by a set of 0..N *multiplied members*
such that each *multiplied member* is a *member*/*multiplicity* pair such that
no 2 *member* are the same value and *multiplicity* is 1.

[RETURN](#TOP)

<a name="Bag---Multiset"></a>

### Bag / Multiset

A **Bag** value is a general purpose arbitrarily-large unordered collection
of any other, *member* values, which explicitly does not represent any kind
of thing in particular, and is simply the sum of its members.
A **Bag** in the general case may have multiple members that are the same value.

A **Bag** value is also characterized by a set of 0..N *multiplied members*
such that each *multiplied member* is a *member*/*multiplicity* pair such that
no 2 *member* are the same value and *multiplicity* is a positive **Integer**.

[RETURN](#TOP)

<a name="Mix"></a>

### Mix

A **Mix** value is a general purpose arbitrarily-large unordered collection
of any other, *member* values, which explicitly does not represent any kind
of thing in particular, and is simply the sum of its members.
A **Mix** in the general case may have multiple members that are the same value,
and it may have fractions of members, and it may have negations of members.

A **Mix** value is also characterized by a set of 0..N *multiplied members*
such that each *multiplied member* is a *member*/*multiplicity* pair such that
no 2 *member* are the same value and *multiplicity* is a nonzero **Fractional**.

The **Mix** possrep is the idiomatic way for an external data model to
represent the general case of a *measure*, a measurement of some quantity
or position or other kind of thing that one measures, in terms of a number
paired with a unit, or a set of 0..N of such, which explicitly is agnostic
to any externally defined standards and should be able to represent units
from any of them.  In this context, a *member* represents each measurement
unit and its *multiplicity* is the measurement in that unit.  While **Mix**
allows each *member* to have any possrep, in practice the **Nesting** and
**Text** possreps are the most common, or an external data model might have
a dedicated type to represent a unit definition.

See also <https://unitsofmeasure.org/ucum.html>.

[RETURN](#TOP)

<a name="Interval"></a>

### Interval

An **Interval** value is a general purpose arbitrarily-large unordered
collection of any other, *member* values, which explicitly does not
represent any kind of thing in particular, and is simply the sum of its
members; the count of members may be either finite or infinite depending on
the external data model or type system in question.

In stark contrast to a **Set** value, whose set of members is characterized
by an enumeration of every member value, an **Interval** value's set of
members is instead characterized by exactly 2 *endpoint* values (or exactly
1 or exactly zero) of some *orderable* type such that every value in the
type system with a defined total order between those 2 endpoints is
considered to be a member value of the **Interval**.  Depending on the
external data model or type system in question, an **Interval** value may
(and typically does) consist of an infinite set of members, in contrast
with a **Set** which can only have a finite set of members.

An *empty interval* has exactly zero members.  A *unit interval* has
exactly 1 member.  A *closed interval* includes both endpoint values in its
membership; an *open interval* excludes both endpoint values; a
*half-closed, half-open interval* includes one and excludes the other.
A *half-unbounded, half-bounded interval* includes all values that are
ordered either before or after the single endpoint; a *universal interval*
or *unbounded interval* includes every value in the type system.

In the general case, for MUON-defined types, only a *bounded interval* over
2 distinct **Integer** (or **Boolean**) endpoints has a finite member
count; whereas, a *bounded interval* over 2 distinct endpoints over any
other type (such as **Fraction** or **Text**) has an infinite member count,
because given any 2 distinct values of most types you can find another
distinct value that is ordered between them.  Also, a non-bounded interval
over **Integer** has an infinite member count in MUON.  An external data
model can only change this by defining its corresponding member data types
to have a finite membership themselves, in contrast to mathematics.

Note that it is up to the external data model to define any total orders
for any member value types, either which one is used implicitly when the
**Interval** has no explicit context to specify one, or how to interpret
that explicit context.  For a common example, there exist a wide variety of
character string collations in common use, and it would require context or
the external data model to declare which to use for **Text** members.
MUON itself simply characterizes an **Interval** *as* its endpoints.

[RETURN](#TOP)

<a name="Interval-Set"></a>

### Interval Set

An **Interval Set** value is characterized by a **Set** value such that
every member value of the **Set** is an **Interval**.  An **Interval Set**
is alternately characterized by a single **Interval** that is allowed to
have discontinuities, and is in the typical case characterized by more than
2 *endpoint* values.

When reasoning about an interval in terms of defining a set of values by
endpoints under a total order rather than by enumeration, an **Interval
Set** is the actual best direct analogy to a **Set** because every possible
distinct **Set** value can map to a distinct **Interval Set** value but
only a proper subset of the former can map to an **Interval**.  The
**Interval Set** type is closed under *set union* operations just as
**Set** is, while **Interval** is not.

Unlike with the **Set** type, the **Interval Set** type also has a
meaningful *set absolute complement* operation applicable to it.

[RETURN](#TOP)

<a name="Interval-Bag"></a>

### Interval Bag

An **Interval Bag** value is characterized by a generalization of an
**Interval Set** that permits multiple members to have the same value; an
**Interval Bag** is isomorphic to a **Bag** in the same way that an
**Interval Set** is to a **Set**; every possible distinct **Bag** can map
to a distinct **Interval Bag**.

[RETURN](#TOP)

<a name="Pair"></a>

### Pair

A **Pair** value is a general purpose 2-element ordered heterogeneous
collection whose elements in order are *this* and *that*, each of which may
be any other value.  A **Pair** value is also characterized by a **Tuple**
value having exactly 2 "positional" attributes.

[RETURN](#TOP)

<a name="Heading---Attribute-Name-Set"></a>

### Heading / Attribute Name Set

A **Heading** value is an arbitrarily-large unordered collection of
*attribute names*, such that no 2 attribute names are the same.
A **Heading** value can be characterized by a **Set** value such that every
*member* value of the latter is any **Text** value.

[RETURN](#TOP)

<a name="Renaming---Attribute-Name-Map"></a>

### Renaming / Attribute Name Map

A **Renaming** value is an arbitrarily-large unordered collection of
attribute renaming specifications.

A **Renaming** value is characterized by a **Tuple** such that each
attribute asset is a **Text**, and no 2 attribute asset values are the same
value; for each *attribute*, that attribute's name and asset respectively
specify the *name before* and *name after* of some other attribute being
renamed of some other attributive value.

[RETURN](#TOP)

<a name="Tuple---Attribute-Set"></a>

### Tuple / Attribute Set

A **Tuple** value is a general purpose arbitrarily-large unordered
heterogeneous collection of named *attributes*, such that no 2 attributes
have the same *attribute name*, which explicitly does not represent any
kind of thing in particular, and is simply the sum of its attributes.
An attribute is conceptually a name-asset pair, the name being used to look
up the attribute in a **Tuple**.  An *attribute name* is an unqualified
program identifier and is conceptually a character string that is not a
**Text** value.  In the general case each attribute of a tuple is of a
distinct data type, though multiple attributes often have the same type.
The set of attribute names of a **Tuple** is called its *heading*, and the
corresponding attribute assets are called its *body*.

With respect to the relational model of data, a *heading* represents a
predicate, for which each *attribute name* is a free variable, and a
**Tuple** as a whole represents a derived proposition, where the
corresponding attribute asset values substitute for the free variables;
however, any actual predicate/etc is defined by the context of a
**Tuple** value and a **Tuple** in isolation explicitly does not
represent any proposition in particular.

The canonical way to represent the concept of a *tuple* that has ordered
attributes is to use integral names; to be specific, the attribute name
consisting of just the character code point 0 would mark the first ordered
attribute, the name consisting of just the code point 1 would mark the
second, and so on; this can be repeated up to 32 "positional" names whose
names would correspond to non-printing Unicode code points and would
alphabetically sort correctly and prior to any normal text-like attribute
names like `name` or `age`; said first 32 would likewise be distinct in
appearance from all regular printable numbers used as attribute names.

[RETURN](#TOP)

<a name="Tuple-Array"></a>

### Tuple Array

A **Tuple Array** value is characterized by the pairing of a **Heading**
value with an **Array** value, which define its *heading* and *body*,
respectively.  A **Tuple Array** is isomorphic to a **Relation** with the
sole exception of being based on an **Array** rather than a **Set**.

[RETURN](#TOP)

<a name="Relation---Tuple-Set"></a>

### Relation / Tuple Set

A **Relation** value is characterized by the pairing of a **Heading**
value with a **Set** value, which define its *heading* and *body*,
respectively.  A **Relation** ensures that every *member* of its *body* is
a **Tuple** having the same *heading* (set of *attribute names*) as its own
*heading*.  A **Relation** is alternately characterized by the pairing of a
single set of attribute names with a set of corresponding attribute assets
for each attribute name.

With respect to the relational model of data, a *heading* represents a
predicate, for which each *attribute name* is a free variable, and a
**Relation** as a whole represents a set of derived propositions, where the
corresponding attribute asset values substitute for the free variables;
however, any actual predicate/etc is defined by the context of a
**Relation** value and a **Relation** in isolation explicitly does not
represent any proposition in particular.

[RETURN](#TOP)

<a name="Tuple-Bag"></a>

### Tuple Bag

A **Tuple Bag** value is characterized by the pairing of a **Heading**
value with a **Bag** value, which define its *heading* and *body*,
respectively.  A **Tuple Bag** is isomorphic to a **Relation** with the
sole exception of being based on a **Bag** rather than a **Set**.

[RETURN](#TOP)

<a name="Article---Labelled-Tuple"></a>

### Article / Labelled Tuple

An **Article** value is characterized by the pairing of a *label*, which is
a **Nesting** value, with a set of 0..N *attributes*, where that set is a
**Tuple** value.

The **Article** possrep is the idiomatic way for an external data model to
represent "new" types of a nominal type system in a consistent way.  The
*label* represents a fully-qualified external data type name, and thus a
namespace within all the **Article** values, while the *attributes* define
all the components of a value of that external type.  Thus an **Article**
corresponds to a generic *object* of an object-oriented language, the
*label* is the *class* of that *object*, and *attributes* are *properties*.

As a primary exception to the above, the large number of *exception* or
*error* types common in some data models / type systems should *not* be
represented using an **Article** but rather with the structurally identical
**Excuse** which natively carries that extra semantic.

The idiomatic way to represent a singleton type value is as an **Article**
where the *label* is the singleton type name and the *attributes* is the
**Tuple** with zero attributes.

The idiomatic default attribute name for a single-attribute **Article** is
`0t0` (the first conceptually ordered attribute name) when there isn't an
actual meaningful name to give it.

[RETURN](#TOP)

<a name="Excuse"></a>

### Excuse

An **Excuse** value is an explicitly stated reason for why, given some
particular problem domain, a value is not being used that is ordinary for
that domain.  Alternately, an **Excuse** is characterized by an **Article**
that has the added semantic of representing some kind of error condition,
in contrast to an actual **Article** which explicitly does *not* represent
an error condition in the general case.

For example, the typical integer division operation is not defined to give
an integer result when the divisor is zero, and so a function for integer
division could be defined to result in an **Excuse** value rather than
throw an exception in that case.  For another example, an **Excuse** value
could be used to declare that the information we are storing about a person
is missing certain details and why those are missing, such as because the
person left the birthdate field blank on their application form.

An **Excuse** is isomorphic to an *exception* but that use of the former is
not meant to terminate execution of code early unlike the latter which is.

The **Excuse** possrep is the idiomatic way for an external data model to
represent "new" *error* or *exception* types of a nominal type system in a
consistent way.  The counterpart **Article** possrep should *not* be used for
these things, but rather just every other kind of externally-defined type.

[RETURN](#TOP)

<a name="SIGNATURE-DECLARING-SECONDARY-DATA-TYPE-POSSREPS"></a>

## SIGNATURE DECLARING SECONDARY DATA TYPE POSSREPS

*This whole section is quite rough and will be rewritten at some future time.*

[RETURN](#TOP)

<a name="Syntax"></a>

### Syntax

A **Syntax** value is characterized by the pairing of a *syntax predicate*
value with a *syntax subject* value, such that the former describes the latter.

A *syntax predicate* consists of, in order, the *syntax base name*,
*authority* and *version number* of the fully-qualified name of the
language syntax specification, or faked stand-in name,
that the *syntax subject*, or the **Syntax** value as a whole, conforms to.

There may be multiple nested **Syntax**; when this is the case,
it means the most-nested *syntax subject* conforms to every one of those syntaxes,
typically because only the lowest common denominators of said were used.

[RETURN](#TOP)

<a name="Model"></a>

### Model

A **Model** value is characterized by the pairing of a *model predicate*
value with a *model subject* value, such that the former describes the latter.

A *model predicate* consists of, in order, the *data model base name*,
*authority* and *version number* of the fully-qualified name of the
data model or type system specification, or faked stand-in name,
that the *model subject*, or the **Model** value as a whole, represents values of,
and influences what specific data types a parser maps data to.

There may be multiple nested **Model**; when this is the case,
it means the most-nested *model subject* conforms to every one of those data models,
typically because only the lowest common denominators of said were used.
