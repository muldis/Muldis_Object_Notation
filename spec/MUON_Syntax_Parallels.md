# Muldis Object Notation (MUON) Syntax Parallels

This document has extra copies of the SYNOPSIS sections of each part of the
actual MUON spec documents, making it easier to see at a glance how the
mutually alternative MUON concrete syntaxes compare with each other.

## [Syntax_Plain_Text](Muldis_Object_Notation_Syntax_Plain_Text.md)

```
    (Syntax:([Muldis_Object_Notation_Plain_Text, "https://muldis.com", "0.300.0"]:
        (Model:([Muldis_Data_Language, "https://muldis.com", "0.300.0"]:
            (Relation:[
                (name : "Jane Ives", birth_date : (Calendar_Instant:(y:1971,m:11,d:6)),
                    phone_numbers : (Set:["+1.4045552995", "+1.7705557572"])),
                (name : "Layla Miller", birth_date : (Calendar_Instant:(y:1995,m:8,d:27)),
                    phone_numbers : (Set:[])),
                (name : "岩倉 玲音", birth_date : (Calendar_Instant:(y:1984,m:7,d:6)),
                    phone_numbers : (Set:["+81.9072391679"])),
            ])
        ))
    ))
```

## [Syntax_Muldis_Data_Language](Muldis_Object_Notation_Syntax_Muldis_Data_Language.md)

```
    (Syntax:([Muldis_Object_Notation_Muldis_Data_Language, "https://muldis.com", "0.300.0"]:
        (Model:([Muldis_Data_Language, "https://muldis.com", "0.300.0"]:
            (Relation:[
                (name : "Jane Ives", birth_date : (Calendar_Instant:(y:1971,m:11,d:6)),
                    phone_numbers : (Set:["+1.4045552995", "+1.7705557572"])),
                (name : "Layla Miller", birth_date : (Calendar_Instant:(y:1995,m:8,d:27)),
                    phone_numbers : (Set:[])),
                (name : "岩倉 玲音", birth_date : (Calendar_Instant:(y:1984,m:7,d:6)),
                    phone_numbers : (Set:["+81.9072391679"])),
            ])
        ))
    ))
```

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
