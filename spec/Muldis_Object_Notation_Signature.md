<a name="TOP"></a>

# NAME

Muldis Object Notation (MUON) - Source code and data interchange format

# VERSION

The fully-qualified name of this document is
`Muldis_Object_Notation https://muldis.com 0.400.0`.

# PART

This artifact is part 4 of 22 of the document
`Muldis_Object_Notation https://muldis.com 0.400.0`;
its part name is `Signature`.

# CONTENTS

- [SYNOPSIS](#SYNOPSIS)
- [DESCRIPTION](#DESCRIPTION)
- [AUTHOR](#AUTHOR)
- [LICENSE AND COPYRIGHT](#LICENSE-AND-COPYRIGHT)

[RETURN](#TOP)

<a name="SYNOPSIS"></a>

# SYNOPSIS

```
    (Muldis_Object_Notation_Syntax:([Plain_Text, "https://muldis.com", "0.400.0"]:
        42
    ))

    (Muldis_Object_Notation_Model:([Muldis_Data_Language, "https://muldis.com", "0.400.0"]:
        42
    ))
```

[RETURN](#TOP)

<a name="DESCRIPTION"></a>

# DESCRIPTION

This document consists of multiple parts; for a directory to all of the
parts, see [Overview](Muldis_Object_Notation.md).

This part of the **Muldis Object Notation** document specifies the
canonical artifact signature format of MUON, which expresses explicit
declarations that are used alongside or embedded in data to declare more
unambiguously how the latter was intended by its authors to be interpreted.

The MUON signature format expresses declarations in terms of the abstract
MUON possreps defined by [Semantics](Muldis_Object_Notation_Semantics.md)
and [Syntax_Abstract](Muldis_Object_Notation_Syntax_Abstract.md).

Applying a syntax signature to a MUON artifact, *syntax subject*, consists of
wrapping it in another MUON artifact, *syntax-qualified artifact*, that pairs
it with a *syntax predicate*, such that the latter describes the former.

A *syntax-qualified artifact* is any **Pair** artifact such that its *this*
is the **Text** artifact `Muldis_Object_Notation_Syntax` and its *that* is
any **Pair** artifact such that its *this* and *that* are the
*syntax predicate* and *syntax subject* respectively.

A *syntax subject* (being wrapped) is any **Any** artifact.

A *syntax predicate* consists of, in order, the *syntax base name*,
*authority* and *version number* of the fully-qualified name of the MUON
concrete syntax specification that the *syntax subject*, or the
*syntax-qualified artifact* artifact as a whole, conforms to.

A *syntax predicate* is any **Lot** artifact that typically consists of 3
**Text** artifacts.

There may be multiple nested *syntax-qualified artifact*; when this is the
case, it means the most-nested *syntax subject* conforms to every one of
those syntaxes, typically because only the lowest common denominators of
said were used.

Applying a model signature to a MUON artifact, *model subject*, consists of
wrapping it in another MUON artifact, *model-qualified artifact*, that pairs
it with a *model predicate*, such that the latter describes the former.

A *model-qualified artifact* is any **Pair** artifact such that its *this*
is the **Text** artifact `Muldis_Object_Notation_Model` and its *that* is
any **Pair** artifact such that its *this* and *that* are the
*model predicate* and *model subject* respectively.

A *model subject* (being wrapped) is any **Any** artifact.

A *model predicate* consists of, in order, the *data model base name*,
*authority* and *version number* of the fully-qualified name of the data
model or type system specification, or faked stand-in name, that the *model
subject*, or the *model-qualified artifact* artifact as a whole, represents
values of, and influences what specific data types a parser maps data to.

A *model predicate* is any **Lot** artifact that typically consists of 3
**Text** artifacts.

There may be multiple nested *model-qualified artifact*; when this is the
case, it means the most-nested *model subject* conforms to every one of
those data models, typically because only the lowest common denominators of
said were used.

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
