<a name="TOP"></a>

# Muldis Object Notation (MUON) Feature Comparison

This document features a comparison between Muldis Object Notation (MUON)
and other data formats or programming languages used for similar purposes.

*Each section below is an unordered set of notes until otherwise finished.*

## CONTENTS

- [JSON - JavaScript Object Notation](#JSON---JavaScript-Object-Notation)
- [XML - Extensible Markup Language](#XML---Extensible-Markup-Language)
- [SQL: ISO/IEC 9075 - Structured Query Language](#SQL--ISO-IEC-9075---Structured-Query-Language)

[RETURN](#TOP)

<a name="JSON---JavaScript-Object-Notation"></a>

## JSON - JavaScript Object Notation

<https://json.org>

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

MUON and JSON are equal in expressivity regarding integer values, to the
extent that each can denote any integer of any magnitude, and their integer
literals are distinct from booleans and strings and non-numerics.

MUON is more expressive than JSON regarding numeric literals in general.
MUON natively supports distinct syntaxes for integers and the general case
of rational numbers, such that `1` and `1.0` are distinct, helping preserve
intended data types for applications that care about the distinction,
while JSON only has a single numeric syntax and can't distinguish the two.
MUON natively supports exact rational numeric values that are *not*
terminating in base 10, so for example `1/3` can be conveyed losslessly,
while JSON only natively supports exact rational numeric values that *are*
terminating in base 10.
Both MUON and JSON support scientific notation for numeric literals.
MUON supports 4 numeric bases (2,8,10,16) for all numeric literals,
while JSON only supports base 10 for all numeric literals.
(This is merely a syntactic convenience given that all rational values that
are terminating in base 2/8/16 are also terminating in base 10.)

MUON and JSON are equal in expressivity regarding character string values,
to the extent that each can denote any **Unicode** character string, of any
string length, using any code points up to `0x10FFFF` (all 17 planes), and
all code points can be denoted natively as themselves, save for a small
handful forbidden to appear literally that must be denoted in escaped form.

MUON is more expressive than JSON regarding character string literals, in
that it can natively express all **Unicode** code points as single numeric
escape sequences without using any UTF-16 surrogate code points, while JSON
can only natively denote code points up to `0xFFFF` (the BMP) as single
numeric escape sequences.  Users of JSON must explicitly use pairs of
UTF-16 surrogate code points to represent code points on the other 16
planes, which is a separate data model layer above the JSON.

MUON uses the same string delimiters `"` as JSON but MUON is easier to
parse because the escape sequence for said delimiter is `\q` in MUON versus
`\"` in JSON; a MUON delimited string never contains its delimiter.
At least that is true with the MUON Plain Text (strict) syntax; however the
MUON Plain Text Lax syntax also supports `\"` for syntactic parity with JSON.

MUON is more expressive than JSON regarding simple collections.
MUON has distinct Array/Set/Bag collections so it is clear whether the
ordinal position and or the multiplicity of members is significant or not;
in contrast, JSON provides no native way to distinguish these factors.

MUON explicitly preserves the element order of all collection literals, and
so it can losslessly pass through any collection literals that are
conceptually program source code, and typically programmers consider the
element order of their source code to be intentional and worth preserving,
even if conceptually the collection is logically an unordered one, while in
contrast JSON's `object` collection is expressly unordered and so can't
preserve a very significant in practice aspect of program source code.

JSON has no native support for parser-ignorable (treated like insignificant
whitespace) comments, as an intentional difference from JavaScript, while
MUON does support such comments.

MUON provides an explicit possrep/syntax **Article** to indicate that a
particular user-defined collection denotes a value or object of some
user-defined type or class, while those using JSON tend to overload the
meaning of the elements of a JSON `object` to indicate either object type or
object attributes/properties, and this is done ad-hoc by an overlaid extra
type system layer; MUON types and attributes are clearly distinguished.

MUON also competes with JSON by being more fully specified, such that every
2 MUON libraries should exhibit the same behavior and be fully compatible,
which is apparently not true for JSON, which is much more loosely specified
or leaves important details unspecified, and has multiple competing
definitions.  See <https://seriot.ch/parsing_json.php> and
<https://github.com/nst/JSONTestSuite> for more about this.
So reliability and consistency could also be a primary benefit of MUON over
JSON, and a key reason to adopt it over JSON.
This paragraph will be fleshed out more.

*TODO.*

[RETURN](#TOP)

<a name="XML---Extensible-Markup-Language"></a>

## XML - Extensible Markup Language

<https://w3.org/XML>

XML is, after JSON particularly, one of the most direct counterpart
languages to MUON both somewhat in form and in function; MUON is intended
to compete for all of the same use cases.

MUON competes as an XML alternative primarily by being both more strongly
typed and, like JSON, in being much less verbose.

*TODO.*

[RETURN](#TOP)

<a name="SQL--ISO-IEC-9075---Structured-Query-Language"></a>

## SQL: ISO/IEC 9075 - Structured Query Language

<https://iso.org/standard/63555.html>

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
