# NAME

Muldis Object Notation (MUON) - Source code and data interchange format

# VERSION

The fully-qualified name of this document is
`Muldis_Object_Notation https://muldis.com 0.300.0`.

# PART

This artifact is part 5 of 15 of the document
`Muldis_Object_Notation https://muldis.com 0.300.0`;
its part name is `Syntax_Packed_Plain_Text`.

# SYNOPSIS

*TODO.*

# DESCRIPTION

This document consists of multiple parts; for a directory to all of the
parts, see [Overview](Muldis_Object_Notation.md).

This part of the **Muldis Object Notation** document specifies the
canonical concrete packed plain text syntax of MUON,
which expresses a MUON artifact in terms of an octet string
conforming to a well-defined pattern,
which can exist as a raw file in a filesystem or be exchanged over a
network or exist in memory of any program as an octet string value.

The MUON `Syntax_Packed_Plain_Text` is derived from and maps with the MUON
[Syntax_Abstract](Muldis_Object_Notation_Syntax_Abstract.md); see that plus
[Semantics](Muldis_Object_Notation_Semantics.md) for further context.

The MUON canonical packed plain text format is semi-lightweight and designed to
support interchange of source code and data between any 2 environments that
do not have a common working memory, such as because they are distinct
machine processes written in different programming languages, or because
they are on distinct machines, or because they are mediated by a network or
disk file.  The format is fairly easy for machines to parse and generate.
It is *not* intended for humans to read and write.

The MUON `Syntax_Packed_Plain_Text` exists as an alternative to the MUON
[Syntax_Plain_Text](Muldis_Object_Notation_Syntax_Plain_Text.md)
under the theory that the former may be more performant for machines to
parse and generate, or may occupy fewer resources (network bandwidth,
working memory, disk space) than the latter.

The prescribed standard filename extension for files featuring a MUON Packed Plain
Text parsing unit is `.muonppt`, though as per standard UNIX conventions,
such MUON files can in fact have any filename extension when there is other
context to interpret them with.  Filename extensions are more for the
benefit of the operating system or command shell or users than for a MUON
parser or generator, the latter just cares about the content of the file.

# SIMPLE PRIMARY DATA TYPE POSSREPS

## Ignorance

*TODO.*

## Boolean

*TODO.*

## Integer

*TODO.*

## Fraction

*TODO.*

## Bits

*TODO.*

## Blob

*TODO.*

## Text / Attribute Name

*TODO.*

## Nesting / Attribute Name List

*TODO.*

# COLLECTIVE PRIMARY DATA TYPE POSSREPS

## Duo

*TODO.*

## Lot

*TODO.*

## Kit / Multi-Level Tuple

*TODO.*

## Article / Labelled Tuple

*TODO.*

## Excuse

*TODO.*

# SEE ALSO

*TODO.*

# AUTHOR

Darren Duncan - darren@DarrenDuncan.net

# LICENSE AND COPYRIGHT

This file is part of the formal specification named
**Muldis Object Notation** (**MUON**).

MUON is Copyright © 2002-2022, Muldis Data Systems, Inc.

See the LICENSE AND COPYRIGHT of [Overview](Muldis_Object_Notation.md) for details.

# TRADEMARK POLICY

The TRADEMARK POLICY in [Overview](Muldis_Object_Notation.md) applies to this file too.

# ACKNOWLEDGEMENTS

The ACKNOWLEDGEMENTS in [Overview](Muldis_Object_Notation.md) apply to this file too.
