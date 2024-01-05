<a name="TOP"></a>

# NAME

Muldis Object Notation (MUON) - Source code and data interchange format

# VERSION

The fully-qualified name of this document is
`Muldis_Object_Notation https://muldis.com 0.400.0`.

# PART

This artifact is part 2 of 22 of the document
`Muldis_Object_Notation https://muldis.com 0.400.0`;
its part name is `Semantics`.

# CONTENTS

- [DESCRIPTION](#DESCRIPTION)
- [OVERVIEW OF DATA TYPE POSSREPS](#OVERVIEW-OF-DATA-TYPE-POSSREPS)
- [ALGEBRAIC DATA TYPE POSSREPS](#ALGEBRAIC-DATA-TYPE-POSSREPS)
    - [Any / Universal Type Possrep](#Any---Universal-Type-Possrep)
    - [None / Empty Type Possrep](#None---Empty-Type-Possrep)
- [SIMPLE DATA TYPE POSSREPS](#SIMPLE-DATA-TYPE-POSSREPS)
    - [Ignorance](#Ignorance)
    - [Boolean](#Boolean)
    - [Integer](#Integer)
    - [Rational](#Rational)
    - [Binary](#Binary)
    - [Decimal](#Decimal)
    - [Bits](#Bits)
    - [Blob](#Blob)
    - [Text / Attribute Name](#Text---Attribute-Name)
    - [Nesting / Attribute Name List](#Nesting---Attribute-Name-List)
- [COLLECTIVE DATA TYPE POSSREPS](#COLLECTIVE-DATA-TYPE-POSSREPS)
    - [Pair](#Pair)
    - [Lot](#Lot)
    - [Kit](#Kit)
- [EXCLUDED DATA TYPE POSSREPS](#EXCLUDED-DATA-TYPE-POSSREPS)
- [AUTHOR](#AUTHOR)
- [LICENSE AND COPYRIGHT](#LICENSE-AND-COPYRIGHT)

[RETURN](#TOP)

<a name="DESCRIPTION"></a>

# DESCRIPTION

This document consists of multiple parts; for a directory to all of the
parts, see [Overview](Muldis_Object_Notation.md).

This part of the **Muldis Object Notation** document specifies the
general semantics of MUON that apply in common to all of its syntaxes.

[RETURN](#TOP)

<a name="OVERVIEW-OF-DATA-TYPE-POSSREPS"></a>

# OVERVIEW OF DATA TYPE POSSREPS

**Muldis Object Notation** is mainly characterized by a set of *data type
possreps* or *possreps* (*possible representations*) that all *values*
represented with MUON syntax are characterized by.

A *possrep* corresponds to the concept of a *data type*, where the latter
is characterized by a set of *values*, and one may choose to use those
terms interchangeably in less formal speech.  But formally a *data type*
exists only as part of an external data model used with MUON and is not
part of MUON itself.  Depending on the data model in question, each MUON
possrep may correspond to exactly 1 data type, or to multiple data types,
or multiple possreps may correspond to 1 data type.

This document largely avoids defining any relationship between these possreps,
and officially leaves it up to each external data model used with MUON to
define for itself whether any two given possreps are *conjoined* (have any
values in common) or *disjoint* (have no values in common).  For example,
some external data models may consider **Integer** to correspond to a
*subtype* of what **Rational** corresponds to (`42` is a member of both)
while others may consider the two possreps to be disjoint (`42` and `42.0`
are not the same value).  The sole exceptions are that the
**Any** and **None** possreps explicitly correspond to a *supertype*
or *subtype* respectively of what every other possrep corresponds to,
regardless of the data model.

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
*does* require that any value which a data model supports generating a MUON
parsing unit from must be losslessly round-trippable, that when one
generates MUON from said value, and then turns around and parses that MUON
with the same model, it will be parsed as the exact same value.

Each MUON possrep is of exactly one of these 2 kinds:
*algebraic possrep*, *non-algebraic possrep*.

An *algebraic possrep* has no format of its own and just exists as a
concept defined in terms of the union of 0..N other possreps, and in
practice any reference to an algebraic possrep is just a shorthand for
referring to a set of the possreps it is defined in terms of.
There are exactly 2 of these:

- **Any**
- **None**

A *non-algebraic possrep* does have a format of its own.  Each one is of
exactly one of these 2 kinds:  *simple possrep*, *collective possrep*.
No non-algebraic possrep is defined in terms of any other possrep, it is
conceptually opaque.  Every syntax must have a reasonably uncomplicated
format for each non-algebraic possrep that is disjoint from the formats of
all other non-algebraic possreps, and typically there would be a simple
literal or system-defined data type corresponding directly to each one.

A *simple possrep* has a strictly non-recursive definition, and
never is expressed in terms of **Any** components directly or indirectly,
and typically corresponds to the concept of a single non-collective item.
There are exactly 10 of these:

- **Ignorance**
- **Boolean**
- Numeric: **Integer**, **Rational**, **Binary**, **Decimal**
- Stringy: **Bits**, **Blob**, **Text**
- **Nesting**

A *collective possrep* has a strictly recursive definition, and is
expressed mainly in terms of **Any** components directly or indirectly,
and typically corresponds to the concept of a single collective item.
There are exactly 3 of these:

- **Pair**
- **Lot**
- **Kit**

[RETURN](#TOP)

<a name="ALGEBRAIC-DATA-TYPE-POSSREPS"></a>

# ALGEBRAIC DATA TYPE POSSREPS

[RETURN](#TOP)

<a name="Any---Universal-Type-Possrep"></a>

## Any / Universal Type Possrep

The **Any** possrep corresponds to the *universal type*, which is the
maximal data type of each type system and consists of all values which can
possibly exist.  It is the union of all other possreps.  It explicitly
corresponds to a *supertype* of what every other possrep corresponds to,
regardless of the data model.  When a syntax uses **Any** somewhere,
typically as an element of a generic collection, it means that potentially
any other possrep may be used there.

[RETURN](#TOP)

<a name="None---Empty-Type-Possrep"></a>

## None / Empty Type Possrep

The **None** possrep corresponds to the *empty type*, which is the minimal
data type of each type system and consists of exactly zero values.  It is
the intersection of all other possreps.  It explicitly corresponds to a
*subtype* of what every other possrep corresponds to, regardless of the
data model.  No syntax uses **None** at all, it is just mentioned here as
the logical complement of **Any**.

[RETURN](#TOP)

<a name="SIMPLE-DATA-TYPE-POSSREPS"></a>

# SIMPLE DATA TYPE POSSREPS

[RETURN](#TOP)

<a name="Ignorance"></a>

## Ignorance

The singleton **Ignorance** value is characterized by an *excuse* which
simply says that an ordinary value for any given domain is missing and that
there is simply no excuse that has been given for this; in other words,
something has gone wrong without the slightest hint of an explanation.

This is conceptually the most generic excuse value there is and it can
be used by lazy programmers as a fallback for when they don't have even a
semblance of a better explanation for why an ordinary value is missing.

The **Ignorance** value has its own special syntax in MUON disjoint from
any **Pair** (*excuse*) syntax so that this MUON-defined excuse doesn't step
on any possible name that a particular external data model might use.

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
used and instead other more applicable **Pair** (*excuse*) values should instead.

[RETURN](#TOP)

<a name="Boolean"></a>

## Boolean

A **Boolean** value is a general purpose 2-valued logic boolean or *truth
value*, or specifically it is one of the 2 values *false* and *true*.

[RETURN](#TOP)

<a name="Integer"></a>

## Integer

An **Integer** value is a general purpose exact integral number of any
magnitude, which explicitly does not represent any kind of
thing in particular, neither cardinal nor ordinal nor nominal.
It has no minimum or maximum value.

[RETURN](#TOP)

<a name="Rational"></a>

## Rational

A **Rational** value is a general purpose exact rational number of any
magnitude and precision, which explicitly does not represent any kind of
thing in particular, neither cardinal nor ordinal nor nominal.
It has no minimum or maximum value.

A **Rational** value is characterized by the pairing of a *numerator*,
which is an **Integer** value, with a *denominator*, which is an
**Integer** value that is non-zero.

The intended interpretation of a **Rational** is as the rational number
that results from evaluating the given 2 integers as the mathematical
expression `numerator/denominator`, such that `/` means divide.

MUON does not require any mathematical normalization of a **Rational**
artifact's components in order for it to be a valid artifact;
the numerator/denominator pair do not need to be coprime
and the denominator does not need to be positive.  But typically a
type system will hide from the user the actual physical representation of
whatever value a given **Rational** artifact resolves to, and would
determine value identity based on the actual logical rational number.

[RETURN](#TOP)

<a name="Binary"></a>

## Binary

A **Binary** value is a general purpose exact rational number of any
magnitude and precision, which is a binary fraction (an exact multiple of
any power of two), which explicitly does not represent any kind of
thing in particular, neither cardinal nor ordinal nor nominal.
It has no minimum or maximum value.

A **Binary** value is characterized by the pairing of a *significand*,
which is an **Integer** value, with a *exponent*, which is an
**Integer** value.

The intended interpretation of a **Binary** is as the rational number
that results from evaluating the given 2 integers as the mathematical
expression `significand*(2^exponent)`, such that `*` means multiply
and `^` means exponentiate.

MUON does not require any mathematical normalization of a **Binary**
artifact's components in order for it to be a valid artifact.

[RETURN](#TOP)

<a name="Decimal"></a>

## Decimal

A **Decimal** value is a general purpose exact rational number of any
magnitude and precision, which is a decimal fraction (an exact multiple of
any power of ten), which explicitly does not represent any kind of
thing in particular, neither cardinal nor ordinal nor nominal.
It has no minimum or maximum value.

A **Decimal** value is characterized by the pairing of a *significand*,
which is an **Integer** value, with a *exponent*, which is an
**Integer** value.

The intended interpretation of a **Decimal** is as the rational number
that results from evaluating the given 2 integers as the mathematical
expression `significand*(10^exponent)`, such that `*` means multiply
and `^` means exponentiate.

MUON does not require any mathematical normalization of a **Decimal**
artifact's components in order for it to be a valid artifact.

[RETURN](#TOP)

<a name="Bits"></a>

## Bits

A **Bits** value is characterized by an arbitrarily-large ordered sequence of
*bits* where each bit is represented by an **Integer** in the set `0..1`,
which explicitly does not represent any kind of thing in particular.

[RETURN](#TOP)

<a name="Blob"></a>

## Blob

A **Blob** value is characterized by an arbitrarily-large ordered sequence of
*octets* where each octet is represented by an **Integer** in the set `0..255`,
which explicitly does not represent any kind of thing in particular.

[RETURN](#TOP)

<a name="Text---Attribute-Name"></a>

## Text / Attribute Name

A **Text** value is characterized by an arbitrarily-large ordered sequence of
**Unicode** standard *character code points*, where each distinct code
point corresponds to a distinct integer in the set
`[0..0xD7FF,0xE000..0x10FFFF]`,
which explicitly does not represent any kind of thing in particular.

See also <https://unicode.org>.

A **Text** value has 2 fundamental uses, one being for generic user data,
and the other being the canonical form of a standalone *attribute name*
(see the **Kit** possrep) which is an unqualified program identifier.

Note that some programming languages or execution environments support a
"Unicode character string" concept that is less strict than the **Unicode**
standard, and thus allow malformed character strings.  For example, some
may allow isolated/non-paired UTF-16 "surrogate" code points corresponding
to integers in the set **[0xD800..0xDFFF]**.  MUON forbids the use of any
such "character strings" using the **Text** possrep.  However, such data can
still be conveyed using other means such as MUON's **Lot**+**Integer**.

[RETURN](#TOP)

<a name="Nesting---Attribute-Name-List"></a>

## Nesting / Attribute Name List

A **Nesting** value is characterized by an arbitrarily-large ordered
sequence of *attribute names* (each one a **Text**), having at least 1
element, intended for referencing an entity in a multi-level namespace,
such as nested **Kit** may implement.

[RETURN](#TOP)

<a name="COLLECTIVE-DATA-TYPE-POSSREPS"></a>

# COLLECTIVE DATA TYPE POSSREPS

[RETURN](#TOP)

<a name="Pair"></a>

## Pair

A **Pair** value is a general purpose 2-element ordered heterogeneous
collection whose elements in order are *this* and *that*, each of which may
be any other value.  A **Pair** value is also characterized by a **Kit**
value having exactly 2 "positional" attributes.

A primary intended use of the **Pair** possrep is to be the idiomatic way
for an external data model to represent "new" types of a nominal type
system in a consistent way.

For that usage, a **Pair** value is further characterized as an *article*,
by the pairing of a *label* (*this*), which is a **Nesting** value, with a
set of 0..N *attributes* (*that*), where that set is a **Kit** value.

The *label* represents a fully-qualified external data type name, and thus
a namespace within all the *article* values, while the *attributes* define
all the components of a value of that external type.  Thus an *article*
corresponds to a generic *object* of an object-oriented language, the
*label* is the *class* of that *object*, and *attributes* are *properties*.

The idiomatic way to represent a singleton type value is as an *article*
where the *label* is the singleton type name and the *attributes* has zero
attributes.  The idiomatic default attribute name for a single-attribute
*article* is `0t0` (the first conceptually positional attribute name) when
there isn't an actual meaningful name to give it.

A common special case of an *article* is an *excuse*, which has the added
semantic of representing some kind of error condition.  That is, an
*excuse* is the idiomatic way for an external data model to represent "new"
*error* or *exception* types.

An *excuse* value is an explicitly stated reason for why, given some
particular problem domain, a value is not being used that is ordinary for
that domain.

For example, the typical integer division operation is not defined to give
an integer result when the divisor is zero, and so a function for integer
division could be defined to result in an *excuse* value rather than
throw an exception in that case.  For another example, an *excuse* value
could be used to declare that the information we are storing about a person
is missing certain details and why those are missing, such as because the
person left the birthdate field blank on their application form.

[RETURN](#TOP)

<a name="Lot"></a>

## Lot

A **Lot** value is a general purpose arbitrarily-large ordered sequence of
*multiplied members*, which explicitly does not represent any kind of thing
in particular, and is simply the sum of its multiplied members.
A **Lot** in the general case may have multiple multiplied members that are
the same, and any duplicates may or may not exist at consecutive ordinal positions.
A **Lot** value is dense; iff it has any multiplied members, then its
first-ordered multiplied member is at ordinal position `0`, and its
last-ordinal-positioned multiplied member is at the ordinal position that
is one less than the count of its multiplied members.

A multiplied member is conceptually a *member*/*multiplicity* pair such that
a *member* is any other value at all and a *multiplicity* is a real number
indicating how many consecutive instances of the *member* are in the sequence.

Conceptually a **Lot** value is an ordered sequence of *members* that has
been run-length encoded but that it can also represent fractional instances.

The **Lot** possrep is an idiomatic generalization of a discrete
homogeneous collection, such that any given MUON syntax can choose to just
have **Lot** as a fundamental syntax, and then any other possreps for
discrete homogeneous collections can be represented just as a **Lot**
plus a plain unary type cast in the form of a **Pair** possrep.

A primary intended use of the **Lot** possrep is to be the idiomatic way
for an external data model to represent generic high-cardinality
homogeneous collections of user data.  Fundamental examples of these are
*arrays*, *sets*, *bags*, *mixes*; they are variations of
generic collections of members that may or may not be ordered and may or
may not have duplicates.  When the members are all *tuples* (typically
**Kit**), such **Lot** examples also include *relations* or *dictionaries*.
A **Lot** by itself would represent an anonymous or structural type, but
when wrapped with a **Pair** providing a name, it represents a nominal type.

The intended use of the **Lot** possrep is to represent a value
expression node for selecting at runtime a value of any of the other
discrete homogeneous collection types where their member values or
multiplicities are defined by arbitrarily complex sub-expressions.

A key feature of **Lot** is that it natively preserves the relative
order of its child nodes even when the value being selected is an unordered
type, which can be considered essential for round tripping source code that
better resembles what the programmer wrote.

[RETURN](#TOP)

<a name="Kit"></a>

## Kit

A **Kit** value is a general purpose arbitrarily-large ordered
heterogeneous collection of named *attributes*, such that no 2 attributes
have the same *attribute name*, which explicitly does not represent any
kind of thing in particular, and is simply the sum of its attributes.
An attribute is conceptually a name-asset pair, the name being used to look
up the attribute in a **Kit**.  An *attribute name* is an unqualified
program identifier and is conceptually a character string that is not a
**Text** value.  In the general case each attribute of a **Kit** is of a
distinct data type, though multiple attributes often have the same type.

The **Kit** possrep is an idiomatic generalization of a discrete
heterogeneous collection, such that any given MUON syntax can choose to just
have **Kit** as a fundamental syntax, and then any other possreps for
discrete heterogeneous collections can be represented just as a **Kit**
plus a plain unary type cast in the form of a **Pair** possrep.

A primary intended use of the **Kit** possrep is to be the idiomatic way
for an external data model to represent generic low-cardinality
heterogeneous collections of user data.  Fundamental examples of these are
*tuples*, *records*, *structs*, *objects*; they are variations of
generic collections of named or positional attributes with no duplicate names.
When a set of **Kit** with common attribute names are collected in a
**Lot**, such a **Lot** can also represent a *relation* or *dictionary*.
A **Kit** by itself would represent an anonymous or structural type, but
when wrapped with a **Pair** providing a name, it represents a nominal type.

A **Kit** value is also characterized by a *tuple* of the relational model
of data but that its collection of attributes is ordered rather than
unordered.  For the usage of a **Kit** to represent a *tuple*, the set of
attribute names of a **Kit** is called its *heading*, and the corresponding
attribute assets are called its *body*.

With respect to the relational model of data, a *heading* represents a
predicate, for which each *attribute name* is a free variable, and a
*tuple* as a whole represents a derived proposition, where the
corresponding attribute asset values substitute for the free variables;
however, any actual predicate/etc is defined by the context of a
*tuple* value and a *tuple* in isolation explicitly does not
represent any proposition in particular.

The canonical way to represent the concept of a *tuple* that has positional
attributes is to use integral names; to be specific, the attribute name
consisting of just the character code point 0 would mark the first positional
attribute, the name consisting of just the code point 1 would mark the
second, and so on; this can be repeated up to 32 "positional" names whose
names would correspond to non-printing Unicode code points and would
alphabetically sort correctly and prior to any normal text-like attribute
names like `name` or `age`; said first 32 would likewise be distinct in
appearance from all regular printable numbers used as attribute names.

While strictly speaking a **Kit** possrep could support a much larger count
of "positional" attribute names by extending the same pattern of
single-code-point names beyond 0..31, officially MUON limits this concept
to the first 32 code points, and for any attribute name consisting of a
single Unicode code point of 32 and higher, that name is officially
considered "named" and NOT "positional".

One reason for the limit of 32 is that attribute names in the extended
range quickly get into single-letter names like `x` which can easily be
confused as ones that are conceptually named.  Another reason is that
thanks to the complexities of Unicode with its UTF-16 surrogates, after the
range `0..0xD7FF` the normal code points are non-contiguous, so the simple
correspondence of ordinal number to code point number no longer matches;
supporting "positional" beyond 0xD7FF would be much more complicated and
best avoided, and in practice stopping at 32 seems no more arbitrary than
at 0xD7FF so choosing the lower number seems better.  Another reason is
that the practical value of a "positional" attribute name is a diminishing
return with each additional one, and 32 should be plenty in practice.
Finally, implementations of MUON and corresponding data models should be
somewhat more efficient with the limit of 32 required to be supported.

The intended use of the **Kit** possrep is to represent a value
expression node for selecting at runtime a value of any of the other
discrete heterogeneous collection types where their assets are defined by
arbitrarily complex sub-expressions
(and their names are hard-coded **Text** values).

A key feature of **Kit** is that it natively preserves the relative
order of its child nodes even when the value being selected is an unordered
type, which can be considered essential for round tripping source code that
better resembles what the programmer wrote.

For the usage of a **Lot** whose members are each **Kit** to represent a
*relation*, a *relation* value is characterized by the pairing of a
*heading* with a set of *tuple*, which define its *heading* and *body*,
respectively.  A *relation* ensures that every *member* of its *body* is
a *tuple* having the same *heading* (set of *attribute names*) as its own
*heading*.  A *relation* is alternately characterized by the pairing of a
single set of attribute names with a set of corresponding attribute assets
for each attribute name.

With respect to the relational model of data, a *heading* represents a
predicate, for which each *attribute name* is a free variable, and a
*relation* as a whole represents a set of derived propositions, where the
corresponding attribute asset values substitute for the free variables;
however, any actual predicate/etc is defined by the context of a
*relation* value and a *relation* in isolation explicitly does not
represent any proposition in particular.

[RETURN](#TOP)

<a name="EXCLUDED-DATA-TYPE-POSSREPS"></a>

# EXCLUDED DATA TYPE POSSREPS

Muldis Object Notation eschews dedicated possreps for some data types that
users might expect to see here.  This section enumerates some and says why.

IEEE floating-point signed zeroes, infinities, and NaNs are not part of the
**Rational** possrep (only regular finite numbers are included) and rather
would be left up to the overlaid data model.

Fixed-precision/scale numbers and/or significant figures indication and/or
error margin indication, left up to the overlaid data model.  Any added
would be bareword only as expected to be relatively short.  They would be
defined in terms of being a scaled integer or fixed-denominator rational.

Collective types in the general case are left up to the overlaid data model
and all their variations should be expressible concisely in MUON as
combinations of the provided **Pair** and **Lot** and **Kit** collective
possreps, such that **Pair** lets one tag an arbitrary structure with a
label (typically a **Nesting**) to indicate its type, while **Lot** is the
basis for larger homogeneous types like arrays, sets, and relations, and
**Kit** is the basis for smaller heterogeneous types like tuples or
structs or "objects".

Temporal and spatial and currency types are left up to the overlaid data
model and are expressible concisely in MUON as small collective types.

Media types in the general case, such as audio or still or moving visual,
are excluded because they are better defined by a data model layered over
top of MUON and they are complex.  Only generic plain-text media is native.

Source code types in the general case, such as definitions of functions or
procedures or data types, are excluded because they are better defined by a
data model layered over top of MUON and they are both complex and highly
variable.  Only a few source code types have dedicated MUON syntax because
they specifically benefit from that and conceptually they are simple even
if they may vary greatly in implementation, such as unqualified identifiers
(via **Text**) and **Nesting**, and special **Kit** shorthand syntaxes.

Generic foreign serialization types such as JSON and XML are excluded
because MUON as a whole is supposed to natively handle everything they can
represent but better; otherwise one can still use **Text** to embed those.

[RETURN](#TOP)

<a name="AUTHOR"></a>

# AUTHOR

Darren Duncan - darren@DarrenDuncan.net

[RETURN](#TOP)

<a name="LICENSE-AND-COPYRIGHT"></a>

# LICENSE AND COPYRIGHT

This file is part of the formal specification named
**Muldis Object Notation** (**MUON**).

MUON is Copyright © 2002-2023, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of [Overview](Muldis_Object_Notation.md) for details.
