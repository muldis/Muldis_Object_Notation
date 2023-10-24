<a name="TOP"></a>

# NAME

Muldis Object Notation (MUON) - Source code and data interchange format

# VERSION

The fully-qualified name of this document is
`Muldis_Object_Notation https://muldis.com 0.300.0`.

# PART

This artifact is part 3 of 22 of the document
`Muldis_Object_Notation https://muldis.com 0.300.0`;
its part name is `Container_Plain_Aggregate`.

# CONTENTS

- [SYNOPSIS](#SYNOPSIS)
- [DESCRIPTION](#DESCRIPTION)
- [SEE ALSO](#SEE-ALSO)
- [AUTHOR](#AUTHOR)
- [LICENSE AND COPYRIGHT](#LICENSE-AND-COPYRIGHT)
- [TRADEMARK POLICY](#TRADEMARK-POLICY)
- [ACKNOWLEDGEMENTS](#ACKNOWLEDGEMENTS)

[RETURN](#TOP)

<a name="SYNOPSIS"></a>

# SYNOPSIS

```
    #!/usr/bin/env muldisder
    `Muldis_Object_Notation_Sync_Mark`
    "The first artifact"
    `Muldis_Object_Notation_Sync_Mark`
    42
    `Muldis_Object_Notation_Sync_Mark`
    [
        1,
        2,
        3,
    ]
    `Muldis_Object_Notation_Sync_Mark`
    "Some text"
        " literal spread"
        " over several lines"
    `Muldis_Object_Notation_Sync_Mark`
    "The fifth artifact"
```

[RETURN](#TOP)

<a name="DESCRIPTION"></a>

# DESCRIPTION

This document consists of multiple parts; for a directory to all of the
parts, see [Overview](Muldis_Object_Notation.md).

This part of the **Muldis Object Notation** document specifies the
canonical concrete nonhosted plain aggregate container format of MUON,
which expresses a sequence of mutually independent MUON artifacts
in terms of an octet string, or a Unicode character string,
conforming to a well-defined pattern,
which can exist as a raw file in a filesystem or be exchanged over a
network or exist in memory of any program as an octet/character string value.

The MUON `Container_Plain_Aggregate` format is strictly a proper superset
of *all* of the canonical concrete nonhosted "plain" syntaxes of MUON:

1. [Syntax_Plain_Text](Muldis_Object_Notation_Syntax_Plain_Text.md)
1. [Syntax_Plain_Text_Lax](Muldis_Object_Notation_Syntax_Plain_Text_Lax.md)
1. [Syntax_Packed_Plain_Text](Muldis_Object_Notation_Syntax_Packed_Plain_Text.md)

This means that any octet string which conforms to any of those 3 also
conforms to `Container_Plain_Aggregate`, interpreted as a sequence of 1
MUON artifact, and likewise for any Unicode character string as applicable.

The MUON `Container_Plain_Aggregate` (CPA) format is extremely simple.

The MUON CPA format is nothing more than the simple catenation of 1 or more
*parsing unit* into a single *parsing unit aggregate* such that each pair
of consecutive components is separated by an *aggregate
self-synchronization mark* (*assm*), which is this exact octet/character string:

```
    `Muldis_Object_Notation_Sync_Mark`
```

To be clear, the alphanumeric string `Muldis_Object_Notation_Sync_Mark` by
itself is *not* an *assm*; only with immediately adjacent grave accent
delimiters is it one.

A *parsing unit* is a completely arbitrary octet string having 0 or more
octets, where *arbitrary* has the sole exception that each *parsing unit*
is expressly forbidden from containing anywhere the *assm* (but the string
`Muldis_Object_Notation_Sync_Mark` without bounding `` ` `` is ok).

Strictly speaking the MUON CPA format can be used as a container for any
other file types, subject to their not containing the *assm* literally, but
all of the canonical concrete nonhosted "plain" syntaxes of MUON explicitly
forbid the presence of the *assm* (data logically having such is escaped),
while other file types typically do not have that restriction in their format.

The general case of a *parsing unit aggregate* is that each component
*parsing unit* may be of a different format or different MUON syntax, but
in practice it is anticipated all components will be the same MUON syntax.

The general case of the MUON CPA format is an octet string that is not a
valid Unicode character string, but when every component being aggregated
is of a MUON syntax also characterized by a Unicode character string such
as the Plain Text (strict) syntax, then for such use cases the CPA format
is likewise additionally characterized by a Unicode character string.

The prescribed standard filename extension for files conforming to a MUON
Plain Aggregate container is `.muon`, which is the same as for the
Plain Text (strict) syntax, though as per standard UNIX conventions,
such MUON files can in fact have any filename extension when there is other
context to interpret them with.  Filename extensions are more for the
benefit of the operating system or command shell or users than for a MUON
parser or generator, the latter just cares about the content of the file.

The CPA format does not itself prescribe special support or handling for a
UNIX *shebang line* interpreter directive at the beginning of a *parsing
unit aggregate*, but if the very first *parsing* unit has a valid one, then
that is functionally a *shebang line* for the entire aggregate.
In any event, every individual *parsing unit* in a *parsing unit aggregate*
may start with its own *shebang line*, which would become functional if the
*parsing unit* was separated into its own file later.
It may be useful to have an extra *parsing unit* at the start of a
*parsing unit aggregate* which is nothing but a *shebang line*.

Likewise, each text-based *parsing unit* in a *parsing unit aggregate* may
start with its own Unicode BOM (byte order mark), not just the first one.

It is mandatory for every MUON parser to recognize and specially handle the
edge case of data corruption on the boundary of two *parsing unit* such
that there may be 2 otherwise adjacent *assm* that share a grave accent
`` ` `` like this:

```
    `Muldis_Object_Notation_Sync_Mark`Muldis_Object_Notation_Sync_Mark`
```

To be specific, if there is ever a run of 2..N connected *assm* like this,
then each shared grave accent should be treated as if there were 2 adjacent
grave accents instead, as if the input was this:

```
    `Muldis_Object_Notation_Sync_Mark``Muldis_Object_Notation_Sync_Mark`
```

The idea is to ensure that such a partial *assm* is not treated as if it
was part of one of the *parsing unit*.

(While an alternate special handling could be to treat such a run as if it
was a single *assm*, the above would more closely match original intent,
and can make it easier to recognize the corruption if the normal case of a
*parsing unit* is to have more than zero octets.)

Such corruption can happen if a file write is interrupted before finishing.

There is *no* requirement that an *assm* is on its own line, however doing
so is strongly recommended.

It is mandatory for every MUON parser that, no matter where it appears, any
*assm* is treated as a hard boundary between two *parsing unit*, which no
single *parsing unit* crosses over.  It is as if the *assm* is the end of a
file, or the start of a file, respectively.

It is mandatory for every MUON parser that, within the context of a single
input **Text** or **Blob** that represents a *parsing unit aggregate*,
there is more than one *parsing unit* if and only if each one is separated
from each of its neighbors by an *assm*.  While in many common cases it is
conceivable that one could suss out consecutive separate top-level MUON
possreps without an *assm* separator, that isn't true in all cases, and
supporting this would place a significantly higher complexity burden on the
parsers proper, as well as on human readers, and so it is disallowed.

It is optional, but recommended, for every MUON parser to support actually
acquiring multiple *parsing unit* when they are present.  Otherwise, the
parser can choose to simply acquire just the first *parsing unit* it finds,
and then on encountering an *assm* treat it as if it were the end of the
file and ignore anything after it.  It is recommended that a MUON parser
supports both modes such that the user can choose depending on context.

As to the rationale of supporting *parsing unit* aggregation as a distinct
feature from using a single larger collection-typed MUON artifact whose
elements are the otherwise-distinct artifacts, there are several.

A primary rationale is to better support open-ended streaming for temporal
or other log-like data where a producer, either single or aggregate, is
continually sending messages in a single octet stream or rolling file, and
one or more consumers may be starting to read this stream at potentially
any position in the middle, not necessarily from the start, and may stop
and resume reading at different times.  Each *assm* is a clear signal to
each consumer for where each message starts, so it can be properly
interpreted, and errors from trying to parse from the middle of a MUON
artifact as if it was the start is avoided.  This is the same concept but
higher level of other codes supporting self-synchonization such as UTF-8.

Another rationale is to better support multi-part requests or responses in
client-server communications such that the individual parts are mutually
asynchronous or independent but are moved as a batch for efficiency.

Another rationale is to better support scaling to handle larger amounts of
data by dividing it up into discrete chunks that can each be parsed and
digested independently, because the entire data set doesn't need to be
specially started or ended with a delimiter pair designating a collection
value having everything.  That is, a direct analogy to SQL dumps is
supported, which tends to be a sequence of discrete statements rather than
a collection literal.

Another rationale is to support a simple alternate archive format for
combining what may otherwise be multiple file system files into one file.
A special case is supporting multi-versioning of a data structure in a
single append-only file where the changes of each new version is just
appended to the file as a new *parsing unit*.

[RETURN](#TOP)

<a name="SEE-ALSO"></a>

# SEE ALSO

*TODO.*

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

[RETURN](#TOP)

<a name="TRADEMARK-POLICY"></a>

# TRADEMARK POLICY

The TRADEMARK POLICY in [Overview](Muldis_Object_Notation.md) applies to this file too.

[RETURN](#TOP)

<a name="ACKNOWLEDGEMENTS"></a>

# ACKNOWLEDGEMENTS

The ACKNOWLEDGEMENTS in [Overview](Muldis_Object_Notation.md) apply to this file too.
