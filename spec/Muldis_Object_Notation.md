<a name="TOP"></a>

# NAME

Muldis Object Notation (MUON) - Source code and data interchange format

# VERSION

The fully-qualified name of this document is
`Muldis_Object_Notation https://muldis.com 0.400.0`.

# PART

This artifact is part 1 of 22 of the document
`Muldis_Object_Notation https://muldis.com 0.400.0`;
its part name is `Overview`.

# CONTENTS

- [SYNOPSIS](#SYNOPSIS)
- [DESCRIPTION](#DESCRIPTION)
- [FEATURES](#FEATURES)
    - [Data Type Possreps](#Data-Type-Possreps)
    - [Ease of Use](#Ease-of-Use)
    - [Resiliency](#Resiliency)
    - [Extensibility](#Extensibility)
- [VERSIONING](#VERSIONING)
- [AUTHOR](#AUTHOR)
- [LICENSE AND COPYRIGHT](#LICENSE-AND-COPYRIGHT)
- [TRADEMARK POLICY](#TRADEMARK-POLICY)
- [ACKNOWLEDGEMENTS](#ACKNOWLEDGEMENTS)
- [FORUMS](#FORUMS)

[RETURN](#TOP)

<a name="SYNOPSIS"></a>

# SYNOPSIS

```
    (:Muldis_Object_Notation_Syntax : (["Plain_Text", "https://muldis.com", "0.400.0"]:
        (:Muldis_Object_Notation_Model : (["Muldis_Data_Language", "https://muldis.com", "0.400.0"]:
            (:Relation : [
                {name : "Jane Ives", birth_date : (:Calendar_Instant : {y:1971,m:11,d:6}),
                    phone_numbers : (:Set : ["+1.4045552995", "+1.7705557572"])},
                {name : "Layla Miller", birth_date : (:Calendar_Instant : {y:1995,m:8,d:27}),
                    phone_numbers : (:Set : [])},
                {name : "岩倉 玲音", birth_date : (:Calendar_Instant : {y:1984,m:7,d:6}),
                    phone_numbers : (:Set : ["+81.9072391679"])},
            ])
        ))
    ))
```

[RETURN](#TOP)

<a name="DESCRIPTION"></a>

# DESCRIPTION

This document is the human readable authoritative formal specification named
**Muldis Object Notation** (**MUON**).
The fully-qualified name of this document and specification is
`Muldis_Object_Notation https://muldis.com 0.400.0`.
This is the official/original version by the authority Muldis Data Systems
(`https://muldis.com`), version number `0.400.0`.

**Muldis Object Notation** specifies a semi-lightweight source code and
data interchange abstract format.  It is fairly easy for humans to read and
write.  It is fairly easy for machines to parse and generate.  MUON is
fundamentally an abstract format defined in terms of a few kinds of simple
generic data structures such as integers and ordered lists.  MUON also
consists of multiple concrete formats which satisfy the requirements of the
abstract format and all have deterministic mappings with each other.
MUON's canonical concrete format is plain text and is completely language
independent but uses conventions that are familiar to programmers of many
other languages.  MUON's other concrete formats are defined in terms of
data structures of other languages.

This document consists of multiple parts:

1. Overview (the current part)
1. [Semantics](Muldis_Object_Notation_Semantics.md)
1. [Container_Plain_Aggregate](Muldis_Object_Notation_Container_Plain_Aggregate.md)
1. [Signature](Muldis_Object_Notation_Signature.md)
1. [Syntax_Abstract](Muldis_Object_Notation_Syntax_Abstract.md)
1. [Syntax_Plain_Text](Muldis_Object_Notation_Syntax_Plain_Text.md)
1. [Syntax_Plain_Text_Lax](Muldis_Object_Notation_Syntax_Plain_Text_Lax.md)
1. [Syntax_Packed_Plain_Text](Muldis_Object_Notation_Syntax_Packed_Plain_Text.md)
1. [Syntax_Muldis_Data_Language](Muldis_Object_Notation_Syntax_Muldis_Data_Language.md)
1. [Syntax_Raku](Muldis_Object_Notation_Syntax_Raku.md)
1. [Syntax_Perl](Muldis_Object_Notation_Syntax_Perl.md)
1. [Syntax_DotNet](Muldis_Object_Notation_Syntax_DotNet.md)
1. [Syntax_Java](Muldis_Object_Notation_Syntax_Java.md)
1. Syntax_Swift
1. Syntax_Rust
1. Syntax_Go
1. [Syntax_ECMAScript](Muldis_Object_Notation_Syntax_ECMAScript.md)
1. [Syntax_Ruby](Muldis_Object_Notation_Syntax_Ruby.md)
1. [Syntax_Python](Muldis_Object_Notation_Syntax_Python.md)
1. [Syntax_PHP](Muldis_Object_Notation_Syntax_PHP.md)
1. [Syntax_JSON](Muldis_Object_Notation_Syntax_JSON.md)
1. [Syntax_XML](Muldis_Object_Notation_Syntax_XML.md)

[RETURN](#TOP)

<a name="FEATURES"></a>

# FEATURES

These sections outline some key features of MUON, including some that are
more unique to it and some reasons for why one might want to use it.

[RETURN](#TOP)

<a name="Data-Type-Possreps"></a>

## Data Type Possreps

**Muldis Object Notation** is mainly characterized by a set of *data type
possreps* or *possreps* (*possible representations*) that all *values*
represented with MUON syntax are characterized by.

- **Any**
- **Ignorance**
- **Boolean**
- **Integer**
- **Rational**
- **Binary**
- **Decimal**
- **Bits**
- **Blob**
- **Text**
- **Name**
- **Nesting**
- **Pair**
- **Lot**
- **Kit**

See [Semantics](Muldis_Object_Notation_Semantics.md) for details.

[RETURN](#TOP)

<a name="Ease-of-Use"></a>

## Ease of Use

*TODO.*

[RETURN](#TOP)

<a name="Resiliency"></a>

## Resiliency

*TODO.*

[RETURN](#TOP)

<a name="Extensibility"></a>

## Extensibility

*TODO.*

[RETURN](#TOP)

<a name="VERSIONING"></a>

# VERSIONING

Every version of this specification document is expected to declare its own
fully-qualified name, or *identity*, so that it can easily be referred to
and be distinguished from every other version that does or might exist.

The expected fully-qualified name of every version of this specification
document, as either declared in said document or as referenced by other
documents or by source code, has 3 main parts: *document base name*,
*authority*, and *version number*.

The *document base name* is the character string `Muldis_Object_Notation`.

An *authority* is some nonempty character string whose value uniquely
identifies the authority or author of the versioned entity.  Generally
speaking, the community at large should self-regulate authority identifier
strings so they are reasonable formats and so each prospective
authority/author has one of their own that everyone recognizes as theirs.
Note that an authority/author doesn't have to be an individual person; it
could be some corporate entity instead.

Examples of recommended *authority* naming schemes include a qualified
base HTTP url belonging to the authority (example `https://muldis.com`) or
a qualified user identifier at some well-known asset repository
(example `https://github.com/muldis` or `cpan:DUNCAND`).

For all official/original works by Muldis Data Systems, Inc., the
*authority* has always been `https://muldis.com` and is expected to remain
so during the foreseeable future.

If someone else wants to *embrace and extend* this specification document,
then they must use their own (not `https://muldis.com`) base authority
identifier, to prevent ambiguity, assist quality control, and give due credit.

In this context, *embrace and extend* means for someone to do any of the
following:

- Releasing a modified version of this current document or any
component thereof where the original of the modified version was released
by someone else (the original typically being the official release), as
opposed to just releasing a delta document that references the current one
as a foundation.  This applies both for unofficial modifications and for
official modifications following a change of who is the official maintainer.

- Releasing a delta document for a version of this current document or
any component thereof where the referenced original is released by someone
else, and where the delta either makes significant incompatible changes.

A *version number* is an ordered sequence of 1 or more integers.  A
*version number* is used to distinguish between all of the versions of a
named entity that have a common *authority*, per each kind of versioned
entity; version numbers typically indicate the release order of these
related versions and how easily users can substitute one version for
another.  The actual intended meaning of any given *version number*
regarding for example substitutability is officially dependant on each
*authority* and no implicit assumptions should be made that 2 *version
number* with different *authority* are comparable in any meaningful way,
aside from case-by-case where a particular *authority* declares they use a
scheme compatible with another.  The only thing this document requires is that
every distinct version of an entity has a distinct fully-qualified name.

For each official/original work by Muldis Data Systems related to this
specification document and released after 2016 April 1, except where
otherwise stated, it uses *semantic versioning* for each *version number*,
as described below.  Others are encouraged to follow the same format, but
are not required to.  For all intents and purposes, every *version number*
of an official Muldis work is intended to conform to the external public
standard **Semantic Versioning 2.0.0** as published at
<https://semver.org>, but it is re-explained below for
clarity or in case the external document disappears.

A *version number* for authority `https://muldis.com` is an ordered sequence
of integers, the order of these being from most significant to least, with
3 positions [MAJOR,MINOR,PATCH] and further ones possible.  The version
sequence may have have as few as 1 most significant position.  Any omitted
trailing position is treated as if it were zero.  Each of
{MAJOR,MINOR,PATCH} must be a non-negative integer. MAJOR is always (except
when it is zero) incremented when a change is made which breaks
backwards-compatibility for functioning uses, such as when removing a
feature; it may optionally be incremented at other times, such as for
marketing purposes.  Otherwise, MINOR is always incremented when a change
is made that breaks forwards-compatibility for functioning uses, such as
when adding a feature; it may optionally be incremented at other times,
such as for when a large internals change is made.  Otherwise, PATCH must
be incremented when making any kind or size of change at all, as long as it
doesn't break compatibility; typically this is bug-fixes or performance
improvements or some documentation changes or any test suite changes.  For
fixes to bugs or security holes which users may have come to rely on in
conceptually functioning uses, they should be treated like API changes.
When MAJOR is zero, MINOR is incremented for any kind of breaking change.
There is no requirement that successive versions have adjacent integers,
but they must be increases.

Strictly speaking a *version number* reflects intention of the authority's
release and not necessarily its actuality.  If PATCH is incremented but the
release unknowingly had a breaking change, then once this is discovered
another release should be made which increments PATCH again and undoes that
breaking change, in order to safeguard upgrading users from surprises; an
additional release can be made which instead increments MAJOR or MINOR with
the breaking change if that change was actually desired.

*Currently this document does not specify matters such as how to indicate
maturity, for example production vs pre-production/beta/etc, so explicit
markers of such can either be omitted or be based on other standards.
However, a major version of zero should be considered either pre-production
or that the authority expects frequent upcoming backwards-incompatible changes.*

See also <https://design.raku.org/S11.html#Versioning> which was the primary
influence for the versioning scheme described above.

[RETURN](#TOP)

<a name="AUTHOR"></a>

# AUTHOR

Darren Duncan - darren@DarrenDuncan.net

[RETURN](#TOP)

<a name="LICENSE-AND-COPYRIGHT"></a>

# LICENSE AND COPYRIGHT

This file is part of the formal specification named
**Muldis Object Notation** (**MUON**).

MUON is Copyright © 2002-2024, Muldis Data Systems, Inc.

<https://muldis.com>

MUON is free documentation for software;
you can redistribute it and/or modify it under the terms of the Apache
License, Version 2.0 (AL2) as published by the Apache Software Foundation
(<https://apache.org>).  You should have received a copy of the
AL2 as part of the MUON distribution, in the file
[LICENSE/Apache-2.0.txt](../LICENSE/Apache-2.0.txt); if not, see
<https://apache.org/licenses/LICENSE-2.0>.

Any versions of MUON that you modify and distribute must carry prominent
notices stating that you changed the files and the date of any changes, in
addition to preserving this original copyright notice and other credits.

While it is by no means required, the copyright holder of MUON
would appreciate being informed any time you create a modified version of
MUON that you are willing to distribute, because that is a
practical way of suggesting improvements to the standard version.

[RETURN](#TOP)

<a name="TRADEMARK-POLICY"></a>

# TRADEMARK POLICY

**MULDIS** and **MULDIS MULTIVERSE OF DISCOURSE** are trademarks of Muldis
Data Systems, Inc. (<https://muldis.com>).
The trademarks apply to computer database software and related services.
See <https://muldis.com/trademark_policy.html> for the full written details
of Muldis Data Systems' trademark policy.

[RETURN](#TOP)

<a name="ACKNOWLEDGEMENTS"></a>

# ACKNOWLEDGEMENTS

*None yet.*

[RETURN](#TOP)

<a name="FORUMS"></a>

# FORUMS

*TODO.*
