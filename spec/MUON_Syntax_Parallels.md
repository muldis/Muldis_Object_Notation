<a name="TOP"></a>

# Muldis Object Notation (MUON) Syntax Parallels

This document has extra copies of the SYNOPSIS sections of each part of the
actual MUON spec documents, making it easier to see at a glance how the
mutually alternative MUON concrete syntaxes compare with each other.

## CONTENTS

- [Syntax_Plain_Text](#Syntax_Plain_Text)
- [Syntax_Plain_Text_Lax](#Syntax_Plain_Text_Lax)
- [Syntax_Packed_Plain_Text](#Syntax_Packed_Plain_Text)
- [Syntax_Muldis_Data_Language](#Syntax_Muldis_Data_Language)
- [Syntax_Raku](#Syntax_Raku)
- [Syntax_Perl](#Syntax_Perl)
- [Syntax_DotNet](#Syntax_DotNet)
- [Syntax_Java](#Syntax_Java)
- [Syntax_Swift](#Syntax_Swift)
- [Syntax_Rust](#Syntax_Rust)
- [Syntax_Go](#Syntax_Go)
- [Syntax_ECMAScript](#Syntax_ECMAScript)
- [Syntax_Ruby](#Syntax_Ruby)
- [Syntax_Python](#Syntax_Python)
- [Syntax_PHP](#Syntax_PHP)
- [Syntax_JSON](#Syntax_JSON)
- [Syntax_XML](#Syntax_XML)

[RETURN](#TOP)

<a name="Syntax_Plain_Text"></a>

## [Syntax_Plain_Text](Muldis_Object_Notation_Syntax_Plain_Text.md)

Common **Relation** "named" format with attribute names repeating per tuple.

```
    (Syntax:([Muldis_Object_Notation_Plain_Text, "https://muldis.com", "0.300.0"]:
        (Model:([Muldis_Data_Language, "https://muldis.com", "0.300.0"]:
            (Relation:[
                {name : "Jane Ives", birth_date : (Calendar_Instant:{y:1971,m:11,d:6}),
                    phone_numbers : (Set:["+1.4045552995", "+1.7705557572"])},
                {name : "Layla Miller", birth_date : (Calendar_Instant:{y:1995,m:8,d:27}),
                    phone_numbers : (Set:[])},
                {name : "岩倉 玲音", birth_date : (Calendar_Instant:{y:1984,m:7,d:6}),
                    phone_numbers : (Set:["+81.9072391679"])},
            ])
        ))
    ))
```

Alternate **Relation** "positional" format with attribute names declared
once between all tuples.

```
    (Syntax:([Muldis_Object_Notation_Plain_Text, "https://muldis.com", "0.300.0"]:
        (Model:([Muldis_Data_Language, "https://muldis.com", "0.300.0"]:
            (Relation:(
                    {name, birth_date, phone_numbers}
                : [
                    {"Jane Ives", (Calendar_Instant:{y:1971,m:11,d:6}),
                        (Set:["+1.4045552995", "+1.7705557572"])},
                    {"Layla Miller", (Calendar_Instant:{y:1995,m:8,d:27}),
                        (Set:[])},
                    {"岩倉 玲音", (Calendar_Instant:{y:1984,m:7,d:6}),
                        (Set:["+81.9072391679"])},
                ]
            ))
        ))
    ))
```

[RETURN](#TOP)

<a name="Syntax_Plain_Text_Lax"></a>

## [Syntax_Plain_Text_Lax](Muldis_Object_Notation_Syntax_Plain_Text_Lax.md)

*No example provided as it would be identical to the MUON Plain Text (strict) version.*

[RETURN](#TOP)

<a name="Syntax_Packed_Plain_Text"></a>

## [Syntax_Packed_Plain_Text](Muldis_Object_Notation_Syntax_Packed_Plain_Text.md)

Common **Relation** "named" format with attribute names repeating per tuple.

```
    D zSyntax D M[T"Muldis_Object_Notation_Packed_Plain_Text" T"https://muldis.com" T"0.300.0"]
        D yModel D M[T"Muldis_Data_Language" T"https://muldis.com" T"0.300.0"]
            D T"Relation" M[
                K[xname T"Jane Ives"
                    T"birth_date" D T"Calendar_Instant" K[uy e\07\B3 um q ud 6]
                    T"phone_numbers" D wSet M[T"+1.4045552995" T"+1.7705557572"]]
                K[xname T"Layla Miller"
                    T"birth_date" D T"Calendar_Instant" K[uy e\07\CB um 8 ud c\1B]
                    T"phone_numbers" D wSet l]
                K[xname T"\E5\B2\A9\E5\80\89 \E7\8E\B2\E9\9F\B3"
                    T"birth_date" D T"Calendar_Instant" K[uy e\07\C0 um 7 ud 6]
                    T"phone_numbers" D wSet M[T"+81.9072391679"]]
            ]
```

Alternate **Relation** "positional" format with attribute names declared
once between all tuples.

```
    D zSyntax D M[T"Muldis_Object_Notation_Packed_Plain_Text" T"https://muldis.com" T"0.300.0"]
        D yModel D M[T"Muldis_Data_Language" T"https://muldis.com" T"0.300.0"]
            D T"Relation" D
                    J[xname T"birth_date" T"phone_numbers"]
                M[
                    J[T"Jane Ives"
                        D T"Calendar_Instant" K[uy e\07\B3 um q ud 6]
                        D wSet M[T"+1.4045552995" T"+1.7705557572"]]
                    J[T"Layla Miller"
                        D T"Calendar_Instant" K[uy e\07\CB um 8 ud c\1B]
                        D wSet l]
                    J[T"\E5\B2\A9\E5\80\89 \E7\8E\B2\E9\9F\B3"
                        D T"Calendar_Instant" K[uy e\07\C0 um 7 ud 6]
                        D wSet M[T"+81.9072391679"]]
                ]
```

[RETURN](#TOP)

<a name="Syntax_Muldis_Data_Language"></a>

## [Syntax_Muldis_Data_Language](Muldis_Object_Notation_Syntax_Muldis_Data_Language.md)

```
    (Syntax:([Muldis_Object_Notation_Muldis_Data_Language, "https://muldis.com", "0.300.0"]:
        (Model:([Muldis_Data_Language, "https://muldis.com", "0.300.0"]:
            (Relation:[
                {name : "Jane Ives", birth_date : (Calendar_Instant:{y:1971,m:11,d:6}),
                    phone_numbers : (Set:["+1.4045552995", "+1.7705557572"])},
                {name : "Layla Miller", birth_date : (Calendar_Instant:{y:1995,m:8,d:27}),
                    phone_numbers : (Set:[])},
                {name : "岩倉 玲音", birth_date : (Calendar_Instant:{y:1984,m:7,d:6}),
                    phone_numbers : (Set:["+81.9072391679"])},
            ])
        ))
    ))
```

[RETURN](#TOP)

<a name="Syntax_Raku"></a>

## [Syntax_Raku](Muldis_Object_Notation_Syntax_Raku.md)

```
    :Syntax(("Muldis_Object_Notation_Raku", "https://muldis.com", "0.300.0")=>
        :Model(("Muldis_Data_Language", "https://muldis.com", "0.300.0")=>
            :Relation(
                :Kit(:named(
                    name => "Jane Ives",
                    birth_date => :Calendar_Instant(:Kit(:named(y=>1971,m=>11,d=>6))),
                    phone_numbers => :Set("+1.4045552995", "+1.7705557572"),
                )),
                :Kit(:named(
                    name => "Layla Miller",
                    birth_date => :Calendar_Instant(:Kit(:named(y=>1995,m=>8,d=>27))),
                    phone_numbers => :Set(),
                )),
                :Kit(:named(
                    name => "岩倉 玲音",
                    birth_date => :Calendar_Instant(:Kit(:named(y=>1984,m=>7,d=>6))),
                    phone_numbers => :Set("+81.9072391679",),
                )),
            )
        )
    )
```

[RETURN](#TOP)

<a name="Syntax_Perl"></a>

## [Syntax_Perl](Muldis_Object_Notation_Syntax_Perl.md)

```
    [Syntax=>[[Lot=>["Muldis_Object_Notation_Perl", "https://muldis.com", "0.300.0"]]=>
        [Model=>[[Lot=>["Muldis_Data_Language", "https://muldis.com", "0.300.0"]]=>
            [Relation=>[Lot=>[
                [Kit=>[named=>[
                    [name => "Jane Ives"],
                    [birth_date => [Calendar_Instant=>
                        [Kit=>[named=>[[y=>1971],[m=>11],[d=>6]]]]]],
                    [phone_numbers => [Set=>[Lot=>["+1.4045552995", "+1.7705557572"]]]],
                ]]],
                [Kit=>[named=>[
                    [name => "Layla Miller"],
                    [birth_date => [Calendar_Instant=>
                        [Kit=>[named=>[[y=>1995],[m=>8],[d=>27]]]]]],
                    [phone_numbers => [Set=>[Lot=>[]]]],
                ]]],
                [Kit=>[named=>[
                    [name => "岩倉 玲音"],
                    [birth_date => [Calendar_Instant=>
                        [Kit=>[named=>[[y=>1984],[m=>7],[d=>6]]]]]],
                    [phone_numbers => [Set=>[Lot=>["+81.9072391679"]]]],
                ]]],
            ]]]
        ]]
    ]]
```

[RETURN](#TOP)

<a name="Syntax_DotNet"></a>

## [Syntax_DotNet](Muldis_Object_Notation_Syntax_DotNet.md)

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

[RETURN](#TOP)

<a name="Syntax_Java"></a>

## [Syntax_Java](Muldis_Object_Notation_Syntax_Java.md)

```
    new AbstractMap.SimpleEntry("Syntax", new AbstractMap.SimpleEntry(
        new String[]{"Muldis_Object_Notation_Java", "https://muldis.com", "0.300.0"},
        new AbstractMap.SimpleEntry("Model", new AbstractMap.SimpleEntry(
            new String[]{"Muldis_Data_Language", "https://muldis.com", "0.300.0"},
            new AbstractMap.SimpleEntry("Relation", new LinkedHashMap[]{
                new LinkedHashMap(){{
                    put("name", "Jane Ives");
                    put("birth_date", new AbstractMap.SimpleEntry("Calendar_Instant",
                        new LinkedHashMap(){{put("y",1971); put("m",11); put("d",6);}}
                    ));
                    put("phone_numbers", new AbstractMap.SimpleEntry("Set",
                        new String[]{"+1.4045552995", "+1.7705557572"}
                    ));
                }},
                new LinkedHashMap(){{
                    put("name", "Layla Miller");
                    put("birth_date", new AbstractMap.SimpleEntry("Calendar_Instant",
                        new LinkedHashMap(){{put("y",1995); put("m",8); put("d",27);}}
                    ));
                    put("phone_numbers", new AbstractMap.SimpleEntry("Set", new String[]{}));
                }},
                new LinkedHashMap(){{
                    put("name", "岩倉 玲音");
                    put("birth_date", new AbstractMap.SimpleEntry("Calendar_Instant",
                        new LinkedHashMap(){{put("y",1984); put("m",7); put("d",6);}}
                    ));
                    put("phone_numbers", new AbstractMap.SimpleEntry("Set",
                        new String[]{"+81.9072391679"}
                    ));
                }},
            })
        ))
    ))
```

[RETURN](#TOP)

<a name="Syntax_Swift"></a>

## Syntax_Swift

*TODO.*

[RETURN](#TOP)

<a name="Syntax_Rust"></a>

## Syntax_Rust

*TODO.*

[RETURN](#TOP)

<a name="Syntax_Go"></a>

## Syntax_Go

*TODO.*

[RETURN](#TOP)

<a name="Syntax_ECMAScript"></a>

## [Syntax_ECMAScript](Muldis_Object_Notation_Syntax_ECMAScript.md)

```
    ["Syntax",[["Lot",["Muldis_Object_Notation_ECMAScript", "https://muldis.com", "0.300.0"]],
        ["Model",[["Lot",["Muldis_Data_Language", "https://muldis.com", "0.300.0"]],
            ["Relation",["Lot",[
                ["Kit",["named",[
                    ["name", "Jane Ives"],
                    ["birth_date", ["Calendar_Instant",
                        ["Kit",["named",[["y",1971],["m",11],["d",6]]]]]],
                    ["phone_numbers", ["Set",["Lot",["+1.4045552995", "+1.7705557572"]]]]
                ]]],
                ["Kit",["named",[
                    ["name", "Layla Miller"],
                    ["birth_date", ["Calendar_Instant",
                        ["Kit",["named",[["y",1995],["m",8],["d",27]]]]]],
                    ["phone_numbers", ["Set",["Lot",[]]]]
                ]]],
                ["Kit",["named",[
                    ["name", "岩倉 玲音"],
                    ["birth_date", ["Calendar_Instant",
                        ["Kit",["named",[["y",1984],["m",7],["d",6]]]]]],
                    ["phone_numbers", ["Set",["Lot",["+81.9072391679"]]]]
                ]]]
            ]]]
        ]]
    ]]
```

[RETURN](#TOP)

<a name="Syntax_Ruby"></a>

## [Syntax_Ruby](Muldis_Object_Notation_Syntax_Ruby.md)

```
    [:Syntax,[[:Lot,[:Muldis_Object_Notation_Ruby, "https://muldis.com", "0.300.0"]],
        [:Model,[[:Lot,[:Muldis_Data_Language, "https://muldis.com", "0.300.0"]],
            [:Relation,[:Lot,[
                {name: "Jane Ives", birth_date: [:Calendar_Instant,{y:1971,m:11,d:6}],
                    phone_numbers: [:Set,[:Lot,["+1.4045552995", "+1.7705557572"]]]},
                {name: "Layla Miller", birth_date: [:Calendar_Instant,{y:1995,m:8,d:27}],
                    phone_numbers: [:Set,[:Lot,[]]]},
                {name: "岩倉 玲音", birth_date: [:Calendar_Instant,{y:1984,m:7,d:6}],
                    phone_numbers: [:Set,[:Lot,["+81.9072391679"]]]},
            ]]]
        ]]
    ]]
```

[RETURN](#TOP)

<a name="Syntax_Python"></a>

## [Syntax_Python](Muldis_Object_Notation_Syntax_Python.md)

```
    ("Syntax",(["Muldis_Object_Notation_Python", "https://muldis.com", "0.300.0"],
        ("Model",(["Muldis_Data_Language", "https://muldis.com", "0.300.0"],
            ("Relation",[
                {"name" : "Jane Ives", "birth_date" : ("Calendar_Instant",{"y":1971,"m":11,"d":6}),
                    "phone_numbers" : ("Set",["+1.4045552995", "+1.7705557572"])},
                {"name" : "Layla Miller", "birth_date" : ("Calendar_Instant",{"y":1995,"m":8,"d":27}),
                    "phone_numbers" : ("Set",[])},
                {"name" : "岩倉 玲音", "birth_date" : ("Calendar_Instant",{"y":1984,"m":7,"d":6}),
                    "phone_numbers" : ("Set",["+81.9072391679"])},
            ])
        ))
    ))
```

[RETURN](#TOP)

<a name="Syntax_PHP"></a>

## [Syntax_PHP](Muldis_Object_Notation_Syntax_PHP.md)

```
    ["Syntax",[["Lot",["Muldis_Object_Notation_PHP", "https://muldis.com", "0.300.0"]],
        ["Model",[["Lot",["Muldis_Data_Language", "https://muldis.com", "0.300.0"]],
            ["Relation",["Lot",[
                [
                    "name" => "Jane Ives",
                    "birth_date" => ["Calendar_Instant",["y"=>1971,"m"=>11,"d"=>6]],
                    "phone_numbers" => ["Set",["Lot",["+1.4045552995", "+1.7705557572"]]],
                ],
                [
                    "name" => "Layla Miller",
                    "birth_date" => ["Calendar_Instant",["y"=>1995,"m"=>8,"d"=>27]],
                    "phone_numbers" => ["Set",["Lot",[]]],
                ],
                [
                    "name" => "岩倉 玲音",
                    "birth_date" => ["Calendar_Instant",["y"=>1984,"m"=>7,"d"=>6]],
                    "phone_numbers" => ["Set",["Lot",["+81.9072391679"]]],
                ],
            ]]]
        ]]
    ]]
```

[RETURN](#TOP)

<a name="Syntax_JSON"></a>

## [Syntax_JSON](Muldis_Object_Notation_Syntax_JSON.md)

```
    ["Syntax",[["Lot",["Muldis_Object_Notation_JSON", "https://muldis.com", "0.300.0"]],
        ["Model",[["Lot",["Muldis_Data_Language", "https://muldis.com", "0.300.0"]],
            ["Relation",["Lot",[
                ["Kit",["named",[
                    ["name", "Jane Ives"],
                    ["birth_date", ["Calendar_Instant",
                        ["Kit",["named",[["y",1971],["m",11],["d",6]]]]]],
                    ["phone_numbers", ["Set",["Lot",["+1.4045552995", "+1.7705557572"]]]]
                ]]],
                ["Kit",["named",[
                    ["name", "Layla Miller"],
                    ["birth_date", ["Calendar_Instant",
                        ["Kit",["named",[["y",1995],["m",8],["d",27]]]]]],
                    ["phone_numbers", ["Set",["Lot",[]]]]
                ]]],
                ["Kit",["named",[
                    ["name", "岩倉 玲音"],
                    ["birth_date", ["Calendar_Instant",
                        ["Kit",["named",[["y",1984],["m",7],["d",6]]]]]],
                    ["phone_numbers", ["Set",["Lot",["+81.9072391679"]]]]
                ]]]
            ]]]
        ]]
    ]]
```

[RETURN](#TOP)

<a name="Syntax_XML"></a>

## [Syntax_XML](Muldis_Object_Notation_Syntax_XML.md)

```
    <?xml version="1.0" encoding="UTF-8"?>
    <MUON>
        <Duo this="Syntax"><Duo>
            <this><Lot><m>Muldis_Object_Notation_XML</m><m><q>https://muldis.com</q></m><m><q>0.300.0</q></m></Lot></this>
            <that><Duo this="Model"><Duo>
                <this><Lot><m>Muldis_Data_Language</m><m><q>https://muldis.com</q></m><m><q>0.300.0</q></m></Lot></this>
                <that><Duo this="Relation"><Lot>
                    <m><Kit>
                        <a n="name"><q>Jane Ives</q></a>
                        <a n="birth_date"><Duo this="Calendar_Instant"><Kit><a n="y">1971</a><a n="m">11</a><a n="d">6</a></Kit></Duo></a>
                        <a n="phone_numbers"><Duo this="Set"><Lot><m><q>+1.4045552995</q></m><m><q>+1.7705557572</q></m></Lot></Duo></a>
                    </Kit></m>
                    <m><Kit>
                        <a n="name"><q>Layla Miller</q></a>
                        <a n="birth_date"><Duo this="Calendar_Instant"><Kit><a n="y">1995</a><a n="m">8</a><a n="d">27</a></Kit></Duo></a>
                        <a n="phone_numbers"><Duo this="Set"><Lot/></Duo></a>
                    </Kit></m>
                    <m><Kit>
                        <a n="name"><q>岩倉 玲音</q></a>
                        <a n="birth_date"><Duo this="Calendar_Instant"><Kit><a n="y">1984</a><a n="m">7</a><a n="d">6</a></Kit></Duo></a>
                        <a n="phone_numbers"><Duo this="Set"><Lot><m><q>+81.9072391679</q></m></Lot></Duo></a>
                    </Kit></m>
                </Lot></Duo></that>
            </Duo></Duo></that>
        </Duo></Duo>
    </MUON>
```
