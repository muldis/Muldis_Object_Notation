# Muldis Object Notation (MUON) Feature Comparison

This document features a comparison between Muldis Object Notation (MUON)
and other data formats or programming languages used for similar purposes.

*Each section below is an unordered set of notes until otherwise finished.*

## JSON - JavaScript Object Notation

<https://www.json.org>

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

MUON also competes with JSON by being more fully specified, such that every
2 MUON libraries should exhibit the same behavior and be fully compatible,
which is apparently not true for JSON, which is much more loosely specified
or leaves important details unspecified, and has multiple competing
definitions.
See
<http://seriot.ch/parsing_json.php> and
<https://github.com/nst/JSONTestSuite> for more about this.
So reliability and consistency could also be a primary benefit of MUON over
JSON, and a key reason to adopt it over JSON.
This paragraph will be fleshed out more.

*TODO.*

## XML - Extensible Markup Language

<https://www.w3.org/XML>

XML is, after JSON particularly, one of the most direct counterpart
languages to MUON both somewhat in form and in function; MUON is intended
to compete for all of the same use cases.

MUON competes as an XML alternative primarily by being both more strongly
typed and, like JSON, in being much less verbose.

*TODO.*

## SQL: ISO/IEC 9075 - Structured Query Language

<https://www.iso.org/standard/63555.html>

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

## ECMAScript / JavaScript

<https://www.ecma-international.org/publications/standards/Ecma-262.htm>

*TODO.*
