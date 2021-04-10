# NAME

Muldis Object Notation (MUON) - Source code and data interchange format

# VERSION

The fully-qualified name of this document is
`Muldis_Object_Notation https://muldis.com 0.300.0`.

# PART

This artifact is part 2 of 5 of the document
`Muldis_Object_Notation https://muldis.com 0.300.0`;
its part name is `Semantics`.

# DESCRIPTION

This document consists of multiple parts; for a directory to all of the
parts, see [Overview](Muldis_Object_Notation.md).

This part of the **Muldis Object Notation** document specifies the
general semantics of MUON that apply in common to all of its syntaxes.

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

A *possrep* corresponds to the concept of a *data type*, where the latter
is characterized by a set of *values*, and one may choose to use those
terms interchangeably in less formal speech.  But formally a *data type*
exists only as part of an external data model used with MUON and is not
part of MUON itself.  Depending on the data model in question, each MUON
possrep may correspond to exactly 1 data type, or to multiple data types,
or multiple possreps may correspond to 1 data type.

This document avoids defining any relationship between these possreps, and
officially leaves it up to each external data model used with MUON to
define for itself whether any two given possreps are *conjoined* (have any
values in common) or *disjoint* (have no values in common).  For example,
some external data models may consider **Integer** to correspond to a
*subtype* of what **Fraction** corresponds to (`42` is a member of both)
while others may consider the two possreps to be disjoint (`42` and `42.0`
do not compare as equal).  The sole exceptions are that the (not listed
above) **Any** and **None** possreps explicitly correspond to a *supertype*
or *subtype* respectively of what every other possrep corresponds to,
regardless of the data model, for what that's worth.

When an external data model is used with MUON, MUON requires that a
thorough mapping is defined for every MUON possrep to some data type of
that model.  The intent here is that every well-formed MUON *parsing unit*
can be deterministically parsed into some value of that model, and
therefore that there would never be a MUON parsing failure due to the data
model not supporting some particular data type.  The mapping should be a
reasonable best fit, even if crude, when there isn't a perfect analogy.
In contrast, MUON does *not* require that a mapping exist from every value
of an external data model to MUON, in particular types that are like opaque
pointers to memory addresses which don't meaningfully serialize.  MUON also
does require that any value which a data model supports generating a MUON
parsing unit from must be losslessly round-trippable, that when one
generates MUON from said value, and then turns around and parses that MUON
with the same model, it will be parsed as the exact same value.
Note that the **Article** possrep is the idiomatic way for an external data
model to represent "new" types as MUON in a consistent way.

## Any / Universal Type Possrep

The **Any** possrep corresponds to the *universal type*, which is the
maximal data type of each type system and consists of all values which can
possibly exist.

## None / Empty Type Possrep

The **None** possrep corresponds to the *empty type*, which is the minimal
data type of each type system and consists of exactly zero values.
This has no representation in any grammar, but is mentioned for parity.

## Ignorance

The singleton **Ignorance** value is
characterized by an **Excuse** which simply says that an ordinary value for
any given domain is missing and that there is simply no excuse that has
been given for this; in other words, something has gone wrong without the
slightest hint of an explanation.

This is conceptually the most generic excuse value there is and it can
be used by lazy programmers as a fallback for when they don't have even a
semblance of a better explanation for why an ordinary value is missing.

The **Ignorance** value has its own special syntax in MUON disjoint from
any **Excuse** syntax so that this MUON-defined excuse doesn't step on any
possible name that a particular external data model might use.

When an external data model natively has exactly one generic *null* or
*nil* or *undefined* or *unknown* or similar value or quasi-value,
**Ignorance** is the official way to represent an instance of it in MUON.

When an external data model natively has a concept of 3-valued logic (MUON
itself does not), specifically a concept like such where the multiplicity
of scenarios that may produce a special no-regular-value-is-here marker do
in fact all produce the exact same marker, **Ignorance** is the official
way to represent that marker.  This includes the *null* of any common
dialect of SQL.  Whereas, for external data models that distinguish the
reasons for why a regular value may be missing, **Ignorance** should NOT be
used and instead other more applicable **Excuse** values should instead.

## Boolean

A **Boolean** value is a general purpose 2-valued logic boolean or *truth
value*, or specifically it is one of the 2 values *false* and *true*.

## Integer

An **Integer** value is a general purpose
exact integral number of any magnitude, which explicitly does not represent
any kind of thing in particular, neither cardinal nor ordinal nor nominal.
It has no minimum or maximum value.

## Fraction

A **Fraction** value is a general purpose
exact rational number of any magnitude and precision, which explicitly does
not represent any kind of thing in particular, neither cardinal nor ordinal
nor nominal.  It has no minimum or maximum value.

The general form of a **Fraction** literal is `N/D*R^E` such that {N,D,R,E}
are each integers and the literal represents the rational number that
results from evaluating the mathematical expression using the following
implicit order of operations, `(N/D)*(R^E)` such that `/` means divide, `*`
means multiply, and `^` means exponentiate.

MUON does not require the numerator/denominator pair to be coprime, but
typically a type system will normalize the pair as such when determining
value identity.  Similarly, MUON does not require any other kind of
normalization between the components of a **Fraction** literal.

While the wider general format `N/D*R^E` can represent every rational
number, as can just the `N/D` portion by itself, the alternate but typical
format `X.X` can only represent a proper subset of the rational numbers,
that subset being every rational number that can be represented as a
terminating decimal number.  Note that every rational number that can be
represented as a terminating binary or octal or hexadecimal number can also
be represented as a terminating decimal number.

## Calendar Time

A **Calendar Time** value is
characterized by a **Tuple** having any subset of the 6 attributes of the
heading `(Heading:(year,month,day,hour,minute,second))`
or `(Heading:(y,m,d,h,i,s))` where each attribute is a
**Fraction**, or alternately by an isomorphic **Mix**.  For each of the 6
attributes, it explicitly distinguishes between the attribute value being
specified as zero versus being unspecified; omitting the attribute entirely
means the latter.  Its main intended purpose is to be a more generic common
element for a variety of other, more specific time-related possreps,
including ones representing both durations and instants, or for direct use
with types defined by external data models.  It does *not* specifically
represent a time of day.

## Calendar Duration

A **Calendar Duration** value is a
length of time expressed in terms of the units of a standard civil or
similar calendar.  It is characterized by a **Calendar Time**.  It is up to
the context supplied or interpreted by an external data model to give it
further meaning, such as whether not specifying any smallest units means an
uncertainty interval versus treating them as zero, and so on.

## Calendar Instant

A **Calendar Instant** value is a
particular moment in time expressed in terms of a standard civil or similar
calendar.  It is characterized by an *instant base* (characterized by a
**Calendar Time**) that is either standalone or is paired with an *instant
offset* (characterized by a **Calendar Duration**) or an *instant zone* (a
time zone name characterized by a **Text**).

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

## Geographic Point

A **Geographic Point** value is a
particular point location on the Earth's surface characterized by cartesian
coordinates named *longitude* and *latitude* and *elevation*, where each of
the latter is characterized by a single **Fraction** value.  Each
coordinate may be either specified or unspecified; omitting it means the
latter and providing it, even if zero, means the former.

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

## Bits

A **Bits** value is characterized by an
arbitrarily-long sequence of *bits* where each bit is represented by an
**Integer** in the range 0..1,
which explicitly does not represent any kind of thing in particular.

## Blob

A **Blob** value is characterized by an
arbitrarily-long sequence of *octets* where each octet is represented by an
**Integer** in the range 0..255,
which explicitly does not represent any kind of thing in particular.

## Text / Attribute Name

A **Text** value is characterized by an
arbitrarily-long sequence of **Unicode** 12.1 standard *character
code points*, where each distinct code point corresponds to a distinct
integer in the set **{0..0xD7FF,0xE000..0x10FFFF}**,
which explicitly does not represent any kind of thing in particular.

See also <https://unicode.org>.

A **Text** value has 2 fundamental uses, one being for generic user data,
and the other being the canonical form of a standalone *attribute name*
(see the **Tuple** possrep) which is an unqualified program identifier.

Note that some programming languages or execution environments support a
"Unicode character string" concept that is less strict than the **Unicode**
standard, and thus allow malformed character strings.  For example, some
may allow isolated/non-paired UTF-16 "surrogate" code points corresponding
to integers in the set **{0xD800..0xDFFF}**.  MUON forbids the use of any
such "character strings" using the **Text** possrep.  However, such data can
still be conveyed using other means such as MUON's **Array**+**Integer**.

## Nesting / Attribute Name List

A **Nesting** value is an arbitrarily-large
nonempty ordered collection of attribute names, intended for referencing an
entity in a multi-level namespace, such as nested **Tuple** may implement.

## Pair

A **Pair** value is a general purpose 2-element ordered heterogeneous
collection whose elements in order are *this* and *that*, each of which may
be any other value.  A **Pair** value is also characterized by a **Tuple**
value having exactly 2 "positional" attributes.

## Tuple / Attribute Set

A **Tuple** value is a general purpose
arbitrarily-large unordered heterogeneous collection of named *attributes*,
such that no 2 attributes have the same *attribute name*, which explicitly
does not represent any kind of thing in particular, and is simply the sum
of its attributes.  An attribute is conceptually a name-asset pair, the
name being used to look up the attribute in a **Tuple**.  An *attribute
name* is an unqualified program identifier and is conceptually a character
string that is not a **Text** value.  In the general case each attribute of
a tuple is of a distinct data type, though multiple attributes often have
the same type.  The set of attribute names of a **Tuple** is called its
*heading*, and the corresponding attribute assets are called its *body*.

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
names like **name** or **age**; said first 32 would likewise be distinct in
appearance from all regular printable numbers used as attribute names.

## Lot

A **Lot** value is a general purpose arbitrarily-long ordered sequence of
any **Pair** values, which explicitly does not represent any kind of thing
in particular, and is simply the sum of its members.  A **Lot** value is
dense; iff it has any members, then its first-ordered member is at ordinal
position **0**, and its last-ordinal-positioned member is at the ordinal
position that is one less than the count of its members.  A **Lot** in the
general case may have multiple members that are the same value, and any
duplicates may or may not exist at consecutive ordinal positions.

The **Lot** possrep is the idiomatic generalization of a discrete
homogeneous collection, such that any given MUON syntax can choose to just
have **Lot** as a fundamental syntax, and then any other possreps for
discrete homogeneous collections can be represented just as a **Lot** plus
a plain unary type cast in the form of a **Pair** possrep.

The intended use of the **Lot** possrep is to represent a value expression
node for selecting at runtime a value of any of the other discrete
homogeneous collection types where their member values or multiplicities
are defined by arbitrarily complex sub-expressions.

## Interval

An **Interval** value is a general purpose
arbitrarily-large unordered collection of any other, *member* values, which
explicitly does not represent any kind of thing in particular, and is
simply the sum of its members; the count of members may be either finite or
infinite depending on the external data model or type system in question.

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

## Array

An **Array** value is a general purpose
arbitrarily-long ordered sequence of any other, *member* values, which
explicitly does not represent any kind of thing in particular, and is
simply the sum of its members.  An **Array** value is dense; iff it has any
members, then its first-ordered member is at ordinal position **0**, and
its last-ordinal-positioned member is at the ordinal position that is one
less than the count of its members.  An **Array** in the general case may
have multiple members that are the same value, and any duplicates may or
may not exist at consecutive ordinal positions.

## Set

A **Set** value is a general purpose
arbitrarily-large unordered collection of any other, *member* values, which
explicitly does not represent any kind of thing in particular, and is
simply the sum of its members.  A **Set** ensures that no 2 of its members
are the same value.

A **Set** value is also characterized by a set of 0..N *multiplied members*
such that each *multiplied member* is a *member* / *multiplicity* pair such
that no 2 *member* are the same value and *multiplicity* is 1.

## Bag / Multiset

A **Bag** value is a general purpose
arbitrarily-large unordered collection of any other, *member* values, which
explicitly does not represent any kind of thing in particular, and is
simply the sum of its members.  A **Bag** in the general case may have
multiple members that are the same value.

A **Bag** value is also characterized by a set of 0..N *multiplied members*
such that each *multiplied member* is a *member* / *multiplicity* pair such
that no 2 *member* are the same value and *multiplicity* is a positive
**Integer**.

## Mix

A **Mix** value is a general purpose
arbitrarily-large unordered collection of any other, *member* values, which
explicitly does not represent any kind of thing in particular, and is
simply the sum of its members.  A **Mix** in the general case may have
multiple members that are the same value, and it may have fractions of
members, and it may have negations of members.

A **Mix** value is also characterized by a set of 0..N *multiplied members*
such that each *multiplied member* is a *member* / *multiplicity* pair such
that no 2 *member* are the same value and *multiplicity* is a nonzero
**Fraction**.

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

See also <http://unitsofmeasure.org/ucum.html>.

## Interval Set

An **Interval Set** value is
characterized by a **Set** value such that every member value of the
**Set** is an **Interval**.  An **Interval Set** is alternately
characterized by a single **Interval** that is allowed to have
discontinuities, and is in the typical case characterized by more than 2
*endpoint* values.

When reasoning about an interval in terms of defining a set of values by
endpoints under a total order rather than by enumeration, an **Interval
Set** is the actual best direct analogy to a **Set** because every possible
distinct **Set** value can map to a distinct **Interval Set** value but
only a proper subset of the former can map to an **Interval**.  The
**Interval Set** type is closed under *set union* operations just as
**Set** is, while **Interval** is not.

Unlike with the **Set** type, the **Interval Set** type also has a
meaningful *set absolute complement* operation applicable to it.

## Interval Bag

An **Interval Bag** value is
characterized by a generalization of an **Interval Set** that permits
multiple members to have the same value; an **Interval Bag** is isomorphic
to a **Bag** in the same way that an **Interval Set** is to a **Set**;
every possible distinct **Bag** can map to a distinct **Interval Bag**.

## Tuple Array

A **Tuple Array** value is characterized
by the pairing of a **Heading** value with an **Array** value, which define
its *heading* and *body*, respectively.  A **Tuple Array** is isomorphic to
a **Relation** with the sole exception of being based on an **Array**
rather than a **Set**.

## Relation / Tuple Set

A **Relation** value is characterized
by the pairing of a **Heading** value with a **Set** value, which define
its *heading* and *body*, respectively.  A **Relation** ensures that every
*member* of its *body* is a **Tuple** having the same *heading* (set of
*attribute names*) as its own *heading*.  A **Relation** is alternately
characterized by the pairing of a single set of attribute names with a set
of corresponding attribute assets for each attribute name.

With respect to the relational model of data, a *heading* represents a
predicate, for which each *attribute name* is a free variable, and a
**Relation** as a whole represents a set of derived propositions, where the
corresponding attribute asset values substitute for the free variables;
however, any actual predicate/etc is defined by the context of a
**Relation** value and a **Relation** in isolation explicitly does not
represent any proposition in particular.

## Tuple Bag

A **Tuple Bag** value is characterized
by the pairing of a **Heading** value with a **Bag** value, which define
its *heading* and *body*, respectively.  A **Tuple Bag** is isomorphic to
a **Relation** with the sole exception of being based on a **Bag**
rather than a **Set**.

## Article / Labelled Tuple

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
`0` (the first conceptually ordered attribute name) when there isn't an
actual meaningful name to give it.

## Excuse

An **Excuse** value is an explicitly stated
reason for why, given some particular problem domain, a value is not being
used that is ordinary for that domain.  Alternately, an **Excuse** is
characterized by an **Article** that has the added semantic of representing
some kind of error condition, in contrast to an actual **Article** which
explicitly does *not* represent an error condition in the general case.

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

## Heading / Attribute Name Set

A **Heading** value is an arbitrarily-large
unordered collection of *attribute names*, such that no 2 attribute names
are the same.

## Renaming / Attribute Name Map

A **Renaming** value is an arbitrarily-large
unordered collection of attribute renaming specifications.

Each attribute renaming specification is a pair of attribute names marked
with a `->` or a `<-` element; the associated `<attr_name_before>` and
`<attr_name_after>` indicate the name that an attribute has *before* and
*after* the renaming operation, respectively.  Iff the renaming
specification is an `<anon_attr_rename>` then either the *before* or
*after* name is an ordered attribute name corresponding to the ordinal
position of the renaming specification element in the
`<Renaming>`, starting at zero.

# EXCLUDED DATA TYPE POSSREPS

Muldis Object Notation eschews dedicated possreps for some data types that
users might expect to see here.  This section enumerates some and says why.

IEEE floating-point signed zeroes, infinities, and NaNs are not part of the
**Fraction** possrep (only regular finite numbers are included) and rather
would be their own singleton **Article** or **Excuse** possreps, usually
left up to the overlaid data model.

Fixed-precision/scale numbers and/or significant figures indication and/or
error margin indication, left up to the overlaid data model.  Any added
would be bareword only as expected to be relatively short. They would be
defined in terms of being a scaled integer or fixed-denominator fraction.

While **Mix** is characterized by a generalization of a **Bag**, there are
currently no possreps defined like **Interval Mix** or **Tuple Mix**,
because there doesn't seem to be a use case for them.  However, if it turns
out that either would have a practical use, there is appropriate syntax
already reserved for them, as described in the Syntax Plain Text section.

Dictionary types in the general case are excluded because the relational
types should be able to represent all their variations (eg, unordered,
ordered, one-directional vs bi-directional, with or without duplicates,
etc) more effectively and in a more generic manner.  The canonical way to
represent a dictionary used like an anonymous structure or class, where the
dictionary keys are all character strings, is the **Tuple**.  The canonical
way to represent the general case of a dictionary where the dictionary keys
might be of any data type is with a binary **Relation** with 2 "positional"
attributes, and a single key-value pair of such a dictionary is a binary
**Tuple**.  A canonical syntax specific to the most common case of a
Dictionary, namely unordered, one-directional, any key type, no duplicates,
might be added later.

Most complexities related to temporal types are excluded by MUON, and are
best handled by a data model layered over top of MUON.  For example, MUON
itself does not place any restrictions on how many
months/days/hours/minutes/seconds are permitted in particular slots for the
possreps it does provide.  Also, MUON itself makes no assumptions on what
particular calendars/eras/epochs are in use, eg Gregorian or other.

Most complexities related to spatial types are excluded by MUON, and are
best handled by a data model layered over top of MUON.  While MUON includes
the **Geographic Point** possrep to handle the generally most simple and
widely useful geographic coordinate type, it doesn't explicitly support any
other kinds of geometries.

Currency types in the general case are excluded because the **Mix** possrep
should be able to represent all their variations in a more generic manner.

Media types in the general case, such as audio or still or moving visual,
are excluded because they are better defined by a data model layered over
top of MUON and they are complex.  Only generic plain-text media is native.

Source code types in the general case, such as definitions of functions or
procedures or data types, are excluded because they are better defined by a
data model layered over top of MUON and they are both complex and highly
variable.  Only a few source code types have dedicated MUON syntax because
they specifically benefit from that and conceptually they are simple even
if they may vary greatly in implementation, such as unqualified identifiers
(via **Text**) and **Nesting**, **Heading**, **Renaming**.

Generic foreign serialization types such as JSON and XML are excluded
because MUON as a whole is supposed to natively handle everything they can
represent but better; otherwise one can still use **Text** to embed those.

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
