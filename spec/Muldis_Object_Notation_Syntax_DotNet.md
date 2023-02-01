# NAME

Muldis Object Notation (MUON) - Source code and data interchange format

# VERSION

The fully-qualified name of this document is
`Muldis_Object_Notation https://muldis.com 0.300.0`.

# PART

This artifact is part 10 of 20 of the document
`Muldis_Object_Notation https://muldis.com 0.300.0`;
its part name is `Syntax_DotNet`.

# SYNOPSIS

```
    ("Syntax",(("Lot",("Muldis_Object_Notation_DotNet", "https://muldis.com", "0.300.0")),
        ("Model",(("Lot",("Muldis_Data_Language", "https://muldis.com", "0.300.0")),
            ("Relation",("Lot",(
                new OrderedDictionary{
                    ["name"] = "Jane Ives",
                    ["birth_date"] = ("Calendar_Instant",
                        new OrderedDictionary{["y"]=1971,["m"]=11,["d"]=6}),
                    ["phone_numbers"] = ("Set",("Lot",("+1.4045552995", "+1.7705557572"))),
                },
                new OrderedDictionary{
                    ["name"] = "Layla Miller",
                    ["birth_date"] = ("Calendar_Instant",
                        new OrderedDictionary{["y"]=1995,["m"]=8,["d"]=27}),
                    ["phone_numbers"] = ("Set",("Lot",ValueTuple.Create())),
                },
                new OrderedDictionary{
                    ["name"] = "岩倉 玲音",
                    ["birth_date"] = ("Calendar_Instant",
                        new OrderedDictionary{["y"]=1984,["m"]=7,["d"]=6}),
                    ["phone_numbers"] = ("Set",("Lot",ValueTuple.Create("+81.9072391679"))),
                }
            )))
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

The prescribed standard *syntax predicate* of a **Syntax** signature for a
MUON .NET-hosted artifact is `Muldis_Object_Notation_DotNet`.

See also <https://dotnet.microsoft.com>.

# SIMPLE PRIMARY DATA TYPE POSSREPS

## Ignorance

An **Ignorance** artifact is any of the following:

* The special .NET `null` value.

Not permitted for an **Ignorance** is any of the following,
to keep things more correct and simpler:

* The only object of the .NET singleton class `System.DBNull`.

## Boolean

A **Boolean** artifact is any of the following:

* Any value of the .NET structure type `System.Boolean`.

Not permitted for a **Boolean** is any of the following,
to keep things more correct and simpler:

* Any value of any numeric type such that zero/one represents false/true.

* Any value of some other type that might represent a boolean.

## Integer

An **Integer** artifact is any of the following:

* Any *SYS_Integer*.

A *SYS_Integer* is any of the following:

* Any value of any of the .NET structure types `System.Int32`, `System.Int64`.

* Any value of the .NET structure type `System.Numerics.BigInteger`.

Not permitted for a *SYS_Integer* is any of the following,
to keep things more correct and simpler:

* Any value of any of the .NET structure types `System.Byte`, `System.Int16`.

* Any value of any of the .NET structure types (which are not *CLS-compliant*)
`System.UInt16`, `System.UInt32`, `System.UInt64`.

Note that the type `System.Numerics.BigInteger` is only part of .NET starting
with .NET Framework version 4.0 (2010), so that represents the minimum
required to support MUON for the general case of unlimited size numbers.

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

* Any value of any of the .NET structure types `System.Single`, `System.Double`
that represents a finite number or signed zero;
both signed zeroes are treated as the same plain zero.

* Any value of the .NET structure type `System.Decimal`.

Not permitted for a *SYS_Fraction* is any of the following,
to keep things more correct and simpler:

* Any value of any of the .NET structure types `System.Single`, `System.Double`
that represents an infinity or NaN.

## Bits

A **Bits** artifact is any of the following:

* Any object of the .NET class `System.Collections.BitArray`.

## Blob

A **Blob** artifact is any of the following:

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `Blob`
and its *SYS_that* is any value of the .NET structure type array `System.Byte[]`.

Not permitted for a **Blob** is any of the following,
to prevent ambiguity and simplify things:

* Any value of the .NET structure type array `System.Byte[]`.
This is because to keep things simple we treat all standalone .NET array
values as being attempts at **Lot** artifacts, so we can succeed at
interpreting possreps or fail fast rather than having to scan a whole one
in case it is all `Byte` elements.

## Text / Attribute Name

A **Text** artifact is any of the following:

* Any *SYS_Text*.

A *SYS_Text* is any of the following:

* Any object of the .NET class `System.String` that is *well formed*.

Not permitted for a *SYS_Text* is any of the following,
to keep things more correct and simpler:

* Any object of the .NET class `System.String` that is not *well formed*.

* Any value of the .NET structure type `System.Char`.

* Any object of the .NET class `System.Text.StringBuilder`.

* Any raw or internal alternatives such as `Char[]`.

A .NET `System.String` is characterized as an ordered sequence of 0..N `System.Char`
such that each of the latter is an unsigned 16-bit integer *C*.
A *well formed* string denotes a Unicode BMP code point with a single *C*
in the non-surrogate set `[0..0xD7FF,0xE000..0xFFFF]`
(`System.Char.IsSurrogate()` is false) or it denotes a Unicode
non-BMP code point with an ordered pair of *C* each in the surrogate set
`[0xD800..0xDFFF]` (`System.Char.IsSurrogate()` is true) and the pair
is also well formed (`System.Char.IsSurrogatePair()` is true); a
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

* Any *SYS_Ordered_Tuple_A* such that each of its elements is any *SYS_Text*.

* Any *SYS_Array_T*.

* Any *SYS_Text*.

A *SYS_Array_T* is any of the following:

* Any *SYS_Array_A* such that each of its elements is any *SYS_Text*;
for example, any value of the .NET structure type array `System.String[]`.

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

* Any *SYS_Ordered_Tuple_A* having exactly 2 elements
such that its `Item1` field is *SYS_this* and its `Item2` field is *SYS_that*.

Not permitted for a *SYS_Duo_AA* is any of the following,
to keep things more correct and simpler:

* Any value of the .NET structure type `System.Collections.Generic.KeyValuePair`.

* Any values or objects of N-ary collection types,
except for `System.ValueTuple`, having exactly 2 elements.

Important note:  While a `System.Collections.Generic.KeyValuePair` value is
conceptually the most direct analogy in .NET to a **Duo** or **Pair**
artifact, MUON uses `System.ValueTuple` instead, because the literal syntax
for the latter, `(this,that)`, is *much* less verbose than for the former,
`new KeyValuePair<This,That>(this,that)`.  Given how **Duo** is
conceptually one of the simplest possreps *and* it is one of the most
frequently used in typical MUON artifacts, this choice is a huge win for
brevity and usability, despite the trade-off that a common positional
format of **Kit** or **Tuple** are somewhat more verbose as a result.

## Lot

A **Lot** artifact is any of the following:

* Any *SYS_Non_Qualified_Array_Lot*.

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `Lot`
and its *SYS_that* is any *SYS_Non_Qualified_Lot*.

A *SYS_Non_Qualified_Lot* is any of the following:

* Any *SYS_Ordered_Tuple_A* such that each of its elements in turn is *member*
(any **Any** artifact) and its corresponding *multiplicity* is 1;
this format can express any **Lot** which has 0..7 members,
so to specify 8 or more members, one of the other formats must be used.

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

## Kit

A **Kit** artifact is any of the following:

* Any *SYS_Non_Qualified_Named_Kit*.

* Any *SYS_Duo_TA* such that its *SYS_this* is the *SYS_Text* value `Kit`
and its *SYS_that* is any *SYS_Non_Qualified_Kit*.

A *SYS_Non_Qualified_Kit* is any of the following:

* Any *SYS_Ordered_Tuple_A* such that each of its elements
in turn is *attribute asset* (any **Any** artifact) and its corresponding
*attribute name* is the ordinal position of that element;
this format can express any **Kit** which has only normalized ordered attributes
and which has 0..7 attributes,
so to specify 8 or more attributes, one of the other formats must be used;
this format is even more concise than the other ordered-specific format.

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

* Any object of the .NET class `System.Collections.Specialized.OrderedDictionary`.

Not permitted for a *SYS_Ordered_Dictionary_AA* is any of the following,
to prevent ambiguity and simplify things:

* Any object of the .NET class `System.Collections.Generic.Dictionary`,
because its collection of elements is unordered.

* Any object of the .NET class `System.Data.DataRow`.

A *SYS_Ordered_Tuple_A* is any of the following:

* Any value of the .NET structure type `System.ValueTuple`
that has 0..7 components.

Not permitted for a *SYS_Ordered_Tuple_A* is any of the following,
to keep things more correct and simpler:

* Any value of the .NET structure type `System.ValueTuple`
that has 8 or more conceptual components,
because the 8th and higher are faked by using another `System.ValueTuple`
as the 8th actual component, recursively as needed.

* Any object of the .NET class `System.Tuple`.

* Any value of any .NET structure type, except for `System.ValueTuple`,
or object of any .NET class,
that composes the .NET interface `System.Runtime.CompilerServices.ITuple`.

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

*Note: DbGeography is only in .NET Framework; it is not in .NET 6.*

## Pair

A **Pair** artifact is additionally any of the following:

* Any value of the .NET structure type `System.Collections.Generic.KeyValuePair`
such that its `Key` property is *this* (any **Any** artifact)
and its `Value` property is *that* (any **Any** artifact).

# SEE ALSO

*TODO.*

# AUTHOR

Darren Duncan - darren@DarrenDuncan.net

# LICENSE AND COPYRIGHT

This file is part of the formal specification named
**Muldis Object Notation** (**MUON**).

MUON is Copyright © 2002-2023, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of [Overview](Muldis_Object_Notation.md) for details.

# TRADEMARK POLICY

The TRADEMARK POLICY in [Overview](Muldis_Object_Notation.md) applies to this file too.

# ACKNOWLEDGEMENTS

The ACKNOWLEDGEMENTS in [Overview](Muldis_Object_Notation.md) apply to this file too.
