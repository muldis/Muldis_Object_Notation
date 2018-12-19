# Muldis Object Notation (MUON) Feature Comparison

This document features a comparison between Muldis Object Notation (MUON)
and other data formats or programming languages used for similar purposes.

*Each section below is an unordered set of notes until otherwise finished.*

## JSON - JavaScript Object Notation

[https://www.json.org](https://www.json.org)

JSON is one of the most direct counterpart languages to MUON both in form
and in function; MUON is intended to compete for all of the same use cases.

Most notably, the name **Muldis Object Notation (MUON)** was intentionally
chosen out of various alternatives to directly mirror the names of JSON, so
anyone is correct to think that the similar names imply they are related.

MUON competes as a JSON alternative primarily by being more strongly typed.

While JSON aims for the most reasonably minimal grammar, MUON provides a
larger set of syntactic options that are each more specialized, so that
MUON is more explicit about the intended meaning of the conveyed data.
Users of JSON would only be able to convey the level of meaning that MUON
can do natively by layering an extra data model over top, thus making the
JSON version more verbose.  But for simpler cases where that extra meaning
is not needed, JSON and MUON should be about equal in verbosity.

MUON and JSON are equal in expressivity regarding logical boolean values,
as each provides distinct *false* and *true* literals that are distinct
values from numbers and strings and anything else.

MUON is more expressive than JSON regarding numeric literals.
MUON supports 4 numeric bases (2,8,10,16) for all numeric literals,
while JSON only supports base 10 for all numeric literals.
(This is merely a syntactic convenience given that all rational values that
are terminating in base 2/8/16 are also terminating in base 10.)
MUON also natively supports exact rational numeric literals that are *not*
terminating in base 10, using its **Fraction** syntax, while JSON does not.
Both MUON and JSON support scientific notation for numeric literals, though
their exact syntax differs, `4.263*10^15` and `4.263e15` respectively.

MUON is more expressive than JSON regarding character string literals.
MUON directly supports expression of all 17 **Unicode** planes, that is all
of the code points up to 0x10FFFF, while JSON only directly supports the
BMP, that is only the code points up to 0xFFFF.  Users of JSON must
explicitly use pairs of UTF-16 surrogate code points to represent code points
on the other 16 planes, which is a separate data model layer above the JSON.

MUON uses the same string delimiters `"` as JSON but MUON is easier to
parse because the escape sequence for said delimiter is `\q` in MUON versus
`\"` in JSON; a MUON delimited string never contains its delimiter.

MUON is more expressive than JSON regarding simple collections.
MUON has distinct Array/Set/Bag collections so it is clear whether the
ordinal position and or the multiplicity of members is significant or not;
in contrast, JSON provides no native way to distinguish these factors.

JSON has no native support for parser-ignorable (treated like insignificant
whitespace) comments, as an intentional difference from JavaScript, while
MUON does support such comments.

MUON provides an explicit possrep/syntax **Article** to indicate that a
particular user-defined collection denotes a value or object of some
user-defined type or class, while those using JSON tend to overload the
meaning of the elements of an *object* to indicate either object type or
object attributes/properties, and this is done ad-hoc by an overlaid extra
type system layer; MUON types and attributes are clearly distinguished.

*TODO.*

## XML - Extensible Markup Language

[https://www.w3.org/XML](https://www.w3.org/XML)

XML is, after JSON particularly, one of the most direct counterpart
languages to MUON both somewhat in form and in function; MUON is intended
to compete for all of the same use cases.

MUON competes as a JSON alternative primarily by being both more strongly
typed and, like JSON, in being much less verbose.

*TODO.*

## SQL: ISO/IEC 9075 - Structured Query Language

[https://www.iso.org/standard/63555.html](https://www.iso.org/standard/63555.html)

SQL is, in parallel to JSON, one of the most direct counterpart languages
to MUON both in form and in function; MUON is intended to compete for all
of the same use cases, particularly as a database dump/export/import format.

MUON competes as a SQL alternative primarily by being more strongly typed
and by having a syntax that is more clean and consistent.

*TODO.*

MUON is more expressive than SQL regarding tuple/row collections.
MUON has distinct Tuple Array / Relation / Tuple Bag collections so it is
clear whether the ordinal position and or the multiplicity of tuples is
significant or not; in contrast, SQL provides no native or elegant or
portable way to be explicit about these factors.

MUON is more expressive than SQL regarding missing information.
SQL provides the *null* quasi-value concept to indicate that a regular
value of some type is not present, but does not provide any standard way of
indicating the reason for its absense, such as that a regular value is
*unknown* versus *not applicable* versus *no matching record* or whatever;
in contrast, MUON provides the generic extensible **Excuse** concept, as
well as other tools, so that reasons can be specified.

*TODO.*

## .NET "dot net" / C# "c sharp"

[https://www.microsoft.com/net](https://www.microsoft.com/net)

.NET has a direct `Any` analogy which is provided by the .NET
class `System.Object`.

.NET has a direct `Boolean` analogy which is provided by the .NET
struct `System.Boolean`.

.NET has a direct `Integer` analogy which is provided by the .NET struct
`System.Numerics.BigInteger`; it also provides a handful of fixed-size
integral types, of which `System.Int32` is the most commonly used.

.NET doesn't have a native dedicated unlimited-size-fraction type but does
provide several fixed-size exact rational types such as `System.Decimal`
and `System.Float`.

.NET has a direct `Bits` analogy which is provided by the .NET
class `System.Collections.BitArray`.

.NET has a direct `Blob` analogy which is an array of `System.Byte`.

.NET has a direct `Text` analogy which is provided by the .NET
class `System.String`.

Every `Text` value corresponds 1:1 with a .NET `String` value, but a .NET
`String` is also capable of being malformed, and contain isolated UTF-16
"surrogate" Char elements that don't correspond to valid Unicode code points.

.NET has a direct `Array` analogy which is provided by the .NET
class `System.Collections.Generic.List`.

.NET has a direct `Set` analogy which is provided by the .NET
class `System.Collections.Generic.HashSet`.

.NET has a direct `Bag` analogy which is provided by the .NET class
`System.Collections.Generic.Dictionary` where every dictionary value is a
positive integer.

.NET has a direct `Tuple` analogy which is "anonymous types"; it also
provides support for an unlimited number of attributes with the .NET class
`System.Collections.Generic.Dictionary` where every dictionary key is a
string; it also provides a handful of fixed-degree ordered-attribute tuple
types via `System.Tuple`.

.NET has a direct `Excuse` analogy which is provided by the .NET class
`System.Exception`.

.NET has a direct `Ignorance` analogy which is provided by `null`,
and another provided by the .NET singleton class `System.DBNull`.

*TODO.*

## ECMAScript / JavaScript

[https://www.ecma-international.org/publications/standards/Ecma-262.htm](
https://www.ecma-international.org/publications/standards/Ecma-262.htm)

*TODO.*

## Java

[https://docs.oracle.com/javase/specs/jls/se8/html/index.html](
https://docs.oracle.com/javase/specs/jls/se8/html/index.html)

*TODO.*

## Perl 5 / Pumpkin Perl

[https://www.perl.org](https://www.perl.org)

The Perl 5 analogy to the universal type is `UNIVERSAL` and/or the set of
everything that can possibly be assigned to a Perl 5 scalar variable.

Perl 5 doesn't have a native dedicated boolean type and canonically
represents I<false> and I<true> with the results of `(1==0)` and `(1==1)`
aka the non-ref scalars for the empty string and integer 1 respectively.

Perl 5 doesn't have a native dedicated unlimited-size-integer type but
provides multiple alternatives for representing them.  A non-ref Perl 5
scalar can natively represent an integer as an IV when its size is within
the range of a signed 32-bit or 64-bit integer, the available option
depending on how that Perl was compiled.  A non-ref Perl 5 scalar can
natively represent any integer at all as a character string enumerating its
digits (or hexits etc).  A Perl 5 `Math::BigInt` object (class bundled with
the Perl 5 core) is semantically the closest thing to a native dedicated
unlimited-size-integer type, expecially when one wants to perform math.

Perl 5 doesn't have a native dedicated unlimited-size-fraction type but
provides multiple alternatives for representing them.  A non-ref Perl 5
scalar can natively represent a very specific subset of the rational
numbers as a native floating-point number, but for all practical purposes
this representation format is unsuitable.  A non-ref Perl 5 scalar can
natively represent a subset of rationals in full precision as a character
string enumerating its digits (or hexits etc) that also has a radix point
character.  A Perl 5 `Math::BigRat` object (class bundled with the Perl 5
core) is semantically the closest thing to a native dedicated
unlimited-size-fraction type, expecially when one wants to perform math.

Perl 5 can natively represent a short `Bits` string either as a Perl 5
integer (short sequences only) or as a Perl 5 string.

Perl 5 can natively represent a `Blob` string as a Perl 5 string whose
UTF8 flag is false.

The Perl 5 `BLOB` class provided on CPAN "aims to be the single way of
indicating that a string is binary, not text" and is semantically quite
appropriate for the task of representing a `Blob` value in Perl 5 land.

Perl 5 can natively represent a `Text` string as a Perl 5 string either
whose UTF8 flag is true or all of whose octets are in the range 0..127.

Perl 5 has a native dedicated unlimited-size-array-of-generic-members type
such that each array value is natively represented by a Perl 5
array-reference.  Certain special cases of arrays can also be compactly
represented by Perl 5 scalars that are Perl 5 strings.

Perl 5 doesn't have a native dedicated set-of-generic-members type but a
Perl 5 array can be used with the presumption that the order of its
elements is not significant and that any multiplicity of elements
representing the same I<value> only counts as 1 instance of each value.

Perl 5 doesn't have a native dedicated multiset-of-generic-members type but
a Perl 5 array can be used with the presumption that the order of its
elements is not significant.

For all practical purposes, Perl 5 has a native dedicated
unlimited-size-tuple-of-generic-members type such that each tuple value is
natively represented by a Perl 5 hash-reference, where the Perl 5 hash keys
and values are the attribute names and assets respectively.

Perl 5 has a dedicated generic excuse-with-no-reason singleton which is the
Perl 5 scalar value `undef`.

*TODO.*

## Perl 6 / Raku

[https://perl6.org](https://perl6.org)

Perl 6 has a direct `Any` analogy which is provided by the Perl 6 class `Any`.

Perl 6 has a direct `Boolean` analogy which is provided by the Perl 6 enumeration `Bool`.

Perl 6 has a direct `Integer` analogy which is provided by the Perl 6 class `Int`.

Perl 6 has a direct `Fraction` analogy which is provided by the Perl 6 class `FatRat`.

Perl 6 has a direct `Bits` analogy which is provided by the Perl 6 role
class `Blob`, or specifically by a composing class that uses a list of
unsigned 1-bit integers, an immutable list being the best match.

Perl 6 has a direct `Blob` analogy which is provided by the Perl 6 role
class `Blob`, or specifically by a composing class that uses a list of
unsigned 8-bit integers, an immutable list being the best match.

Perl 6 has a direct `Text` analogy which is provided by the Perl 6 class `Str`.

Perl 6 has a direct `Array` analogy which is provided by the Perl 6 class `List`.

Perl 6 has a direct `Set` analogy which is provided by the Perl 6 class `Set`.

Perl 6 has a direct `Bag` analogy which is provided by the Perl 6 class `Bag`.

Perl 6 has a direct `Tuple` analogy which is provided by the Perl 6
class `Capture`.  This analogy extends to the fact that a primary purpose
of both is to represent a collection of arguments for a routine.

Perl 6 has a direct `Excuse` analogy which is provided by the Perl 6 class `Failure`.

Also of note, `X::AdHoc` is the Perl 6 type into which objects are wrapped
if they are thrown as exceptions, but don't inherit from `Exception`.

Perl 6 has a direct `Ignorance` analogy which is provided by the Perl 6 class `Nil`.

*TODO.*
