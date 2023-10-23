<a name="TOP"></a>

# NAME

Muldis Object Notation (MUON) - Source code and data interchange format

# VERSION

The fully-qualified name of this document is
`Muldis_Object_Notation https://muldis.com 0.300.0`.

# PART

This artifact is part 21 of 21 of the document
`Muldis_Object_Notation https://muldis.com 0.300.0`;
its part name is `Syntax_XML`.

# CONTENTS

- [SYNOPSIS](#SYNOPSIS)
- [DESCRIPTION](#DESCRIPTION)
- [SIMPLE DATA TYPE POSSREPS](#SIMPLE-DATA-TYPE-POSSREPS)
    - [Ignorance](#Ignorance)
    - [Boolean](#Boolean)
    - [Integer](#Integer)
    - [Fraction](#Fraction)
    - [Bits](#Bits)
    - [Blob](#Blob)
    - [Text / Attribute Name](#Text---Attribute-Name)
    - [Nesting / Attribute Name List](#Nesting---Attribute-Name-List)
- [COLLECTIVE DATA TYPE POSSREPS](#COLLECTIVE-DATA-TYPE-POSSREPS)
    - [Duo](#Duo)
    - [Lot](#Lot)
    - [Kit](#Kit)
- [SEE ALSO](#SEE-ALSO)
- [AUTHOR](#AUTHOR)
- [LICENSE AND COPYRIGHT](#LICENSE-AND-COPYRIGHT)
- [TRADEMARK POLICY](#TRADEMARK-POLICY)
- [ACKNOWLEDGEMENTS](#ACKNOWLEDGEMENTS)

[RETURN](#TOP)

<a name="SYNOPSIS"></a>

# SYNOPSIS

```
    <?xml version="1.0" encoding="UTF-8"?>
    <MUON>
        <Duo this="Syntax"><Duo>
            <this><Lot_m><m>Muldis_Object_Notation_XML</m><m><q>https://muldis.com</q></m><m><q>0.300.0</q></m></Lot_m></this>
            <that><Duo this="Model"><Duo>
                <this><Lot_m><m>Muldis_Data_Language</m><m><q>https://muldis.com</q></m><m><q>0.300.0</q></m></Lot_m></this>
                <that><Duo this="Relation"><Lot_m>
                    <m><Kit_na>
                        <a n="name"><q>Jane Ives</q></a>
                        <a n="birth_date"><Duo this="Calendar_Instant"><Kit_na><a n="y">1971</a><a n="m">11</a><a n="d">6</a></Kit_na></Duo></a>
                        <a n="phone_numbers"><Duo this="Set"><Lot_m><m><q>+1.4045552995</q></m><m><q>+1.7705557572</q></m></Lot_m></Duo></a>
                    </Kit_na></m>
                    <m><Kit_na>
                        <a n="name"><q>Layla Miller</q></a>
                        <a n="birth_date"><Duo this="Calendar_Instant"><Kit_na><a n="y">1995</a><a n="m">8</a><a n="d">27</a></Kit_na></Duo></a>
                        <a n="phone_numbers"><Duo this="Set"><Lot/></Duo></a>
                    </Kit_na></m>
                    <m><Kit_na>
                        <a n="name"><q>岩倉 玲音</q></a>
                        <a n="birth_date"><Duo this="Calendar_Instant"><Kit_na><a n="y">1984</a><a n="m">7</a><a n="d">6</a></Kit_na></Duo></a>
                        <a n="phone_numbers"><Duo this="Set"><Lot_m><m><q>+81.9072391679</q></m></Lot_m></Duo></a>
                    </Kit_na></m>
                </Lot_m></Duo></that>
            </Duo></Duo></that>
        </Duo></Duo>
    </MUON>
```

[RETURN](#TOP)

<a name="DESCRIPTION"></a>

# DESCRIPTION

This document consists of multiple parts; for a directory to all of the
parts, see [Overview](Muldis_Object_Notation.md).

This part of the **Muldis Object Notation** document specifies the
canonical concrete Extensible Markup Language (XML) hosted syntax of MUON,
which expresses a MUON artifact in terms of a well-formed XML document,
which can exist as a raw file in a filesystem or be exchanged over a
network or exist in memory of any program as a character string value.

The MUON `Syntax_XML` is derived from and maps with the MUON
[Syntax_Abstract](Muldis_Object_Notation_Syntax_Abstract.md); see that plus
[Semantics](Muldis_Object_Notation_Semantics.md) for further context.

The MUON XML hosted format is semi-lightweight and designed to
support interchange of source code and data between any 2 environments that
do not have a common working memory, such as because they are distinct
machine processes written in different programming languages, or because
they are on distinct machines, or because they are mediated by a network or
disk file.  The format is fairly easy for humans to read and write.  It is
fairly easy for machines to parse and generate.

The prescribed standard *syntax predicate* of a **Syntax** signature for a
MUON XML hosted artifact is `Muldis_Object_Notation_XML`.

See also <https://w3.org/XML>.

[RETURN](#TOP)

<a name="SIMPLE-DATA-TYPE-POSSREPS"></a>

# SIMPLE DATA TYPE POSSREPS

[RETURN](#TOP)

<a name="Ignorance"></a>

## Ignorance

*TODO.*

[RETURN](#TOP)

<a name="Boolean"></a>

## Boolean

*TODO.*

[RETURN](#TOP)

<a name="Integer"></a>

## Integer

*TODO.*

[RETURN](#TOP)

<a name="Fraction"></a>

## Fraction

*TODO.*

[RETURN](#TOP)

<a name="Bits"></a>

## Bits

*TODO.*

[RETURN](#TOP)

<a name="Blob"></a>

## Blob

*TODO.*

[RETURN](#TOP)

<a name="Text---Attribute-Name"></a>

## Text / Attribute Name

*TODO.*

[RETURN](#TOP)

<a name="Nesting---Attribute-Name-List"></a>

## Nesting / Attribute Name List

*TODO.*

[RETURN](#TOP)

<a name="COLLECTIVE-DATA-TYPE-POSSREPS"></a>

# COLLECTIVE DATA TYPE POSSREPS

[RETURN](#TOP)

<a name="Duo"></a>

## Duo

*TODO.*

[RETURN](#TOP)

<a name="Lot"></a>

## Lot

*TODO.*

[RETURN](#TOP)

<a name="Kit"></a>

## Kit

*TODO.*

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
