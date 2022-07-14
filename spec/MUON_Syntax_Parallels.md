# Muldis Object Notation (MUON) Syntax Parallels

This document has extra copies of the SYNOPSIS sections of each part of the
actual MUON spec documents, making it easier to see at a glance how the
mutually alternative MUON concrete syntaxes compare with each other.

## [Syntax_Plain_Text](Muldis_Object_Notation_Syntax_Plain_Text.md)

```
    (Syntax:({Muldis_Object_Notation, "https://muldis.com", "0.300.0"}:
        (Model:({Muldis_Data_Language, "https://muldis.com", "0.300.0"}:
            (Relation:{
                (name : "Jane Ives", birth_date : (Calendar_Instant:(y:1971,m:11,d:6)),
                    phone_numbers : (Set:{"+1.4045552995", "+1.7705557572"})),
                (name : "Layla Miller", birth_date : (Calendar_Instant:(y:1995,m:8,d:27)),
                    phone_numbers : (Set:{})),
                (name : "岩倉 玲音", birth_date : (Calendar_Instant:(y:1984,m:7,d:6)),
                    phone_numbers : (Set:{"+81.9072391679"})),
            })
        ))
    ))
```

## [Syntax_Raku](Muldis_Object_Notation_Syntax_Raku.md)

```
    :Syntax(("Muldis_Object_Notation", "https://muldis.com", "0.300.0") =>
        :Model(("Muldis_Data_Language", "https://muldis.com", "0.300.0") =>
            :Relation(Set.new(
                {name => "Jane Ives", birth_date => :Calendar_Instant({y=>1971,m=>11,d=>6}),
                    phone_numbers => Set.new("+1.4045552995", "+1.7705557572")},
                {name => "Layla Miller", birth_date => :Calendar_Instant({y=>1995,m=>8,d=>27}),
                    phone_numbers => Set.new()},
                {name => "岩倉 玲音", birth_date => :Calendar_Instant({y=>1984,m=>7,d=>6}),
                    phone_numbers => Set.new("+81.9072391679")},
            ))
        )
    )
```

## [Syntax_Perl](Muldis_Object_Notation_Syntax_Perl.md)

```
    [Syntax=>[[Lot=>["Muldis_Object_Notation", "https://muldis.com", "0.300.0"]] =>
        [Model=>[[Lot=>["Muldis_Data_Language", "https://muldis.com", "0.300.0"]] =>
            [Relation=>[Lot=>[
                {name => "Jane Ives", birth_date => [Calendar_Instant=>{y=>1971,m=>11,d=>6}],
                    phone_numbers => [Set=>[Lot=>["+1.4045552995", "+1.7705557572"]]]},
                {name => "Layla Miller", birth_date => [Calendar_Instant=>{y=>1995,m=>8,d=>27}],
                    phone_numbers => [Set=>[Lot=>[]]]},
                {name => "岩倉 玲音", birth_date => [Calendar_Instant=>{y=>1984,m=>7,d=>6}],
                    phone_numbers => [Set=>[Lot=>["+81.9072391679"]]]},
            ]]]
        ]]
    ]]
```

## [Syntax_Java](Muldis_Object_Notation_Syntax_Java.md)

```
    new AbstractMap.SimpleEntry<String, Object>("Syntax", new AbstractMap.SimpleEntry<String[], Object>(
        new String[]{"Muldis_Object_Notation", "https://muldis.com", "0.300.0"},
        new AbstractMap.SimpleEntry<String, Object>("Model", new AbstractMap.SimpleEntry<String[], Object>(
            new String[]{"Muldis_Data_Language", "https://muldis.com", "0.300.0"},
            new AbstractMap.SimpleEntry<String, Object[]>("Relation", new Object[]{
                Map.of(
                   "name", "Jane Ives",
                   "birth_date", new AbstractMap.SimpleEntry<String, Object>("Calendar_Instant",
                       Map.of("y", 1971, "m", 11, "d", 6)
                   ),
                   "phone_numbers", new AbstractMap.SimpleEntry<String, Object[]>("Set",
                        new String[]{"+1.4045552995", "+1.7705557572"}
                    )
                ),
                Map.of(
                    "name", "Layla Miller",
                    "birth_date", new AbstractMap.SimpleEntry<String, Object>("Calendar_Instant",
                        Map.of("y", 1995, "m", 8, "d", 27)
                    ),
                    "phone_numbers", new AbstractMap.SimpleEntry<String, Object[]>("Set", new String[]{})
                ),
                Map.of(
                    "name", "岩倉 玲音",
                    "birth_date", new AbstractMap.SimpleEntry<String, Object>("Calendar_Instant",
                        Map.of("y", 1984, "m", 7, "d", 6)
                    ),
                    "phone_numbers", new AbstractMap.SimpleEntry<String, Object[]>("Set",
                        new String[]{"+81.9072391679"}
                    )
                ),
            })
        ))
    ))
```

## [Syntax_DotNet](Muldis_Object_Notation_Syntax_DotNet.md)

```
    new KeyValuePair<String, Object>("Syntax", new KeyValuePair<String[], Object>(
        new String[]{"Muldis_Object_Notation", "https://muldis.com", "0.300.0"},
        new KeyValuePair<String, Object>("Model", new KeyValuePair<String[], Object>(
            new String[]{"Muldis_Data_Language", "https://muldis.com", "0.300.0"},
            new KeyValuePair<String, Object[]>("Relation", new Object[]{
                new Dictionary<String, Object>(){
                    {"name", "Jane Ives"},
                    {"birth_date", new KeyValuePair<String, Object>("Calendar_Instant",
                        new Dictionary<String, Int32>(){{"y", 1971}, {"m", 11}, {"d", 6}}
                    )},
                    {"phone_numbers", new KeyValuePair<String, Object[]>("Set",
                        new String[]{"+1.4045552995", "+1.7705557572"}
                    )}
                },
                new Dictionary<String, Object>(){
                    {"name", "Layla Miller"},
                    {"birth_date", new KeyValuePair<String, Object>("Calendar_Instant",
                        new Dictionary<String, Int32>(){{"y", 1995}, {"m", 8}, {"d", 27}}
                    )},
                    {"phone_numbers", new KeyValuePair<String, Object[]>("Set", new String[]{})}
                },
                new Dictionary<String, Object>(){
                    {"name", "岩倉 玲音"},
                    {"birth_date", new KeyValuePair<String, Object>("Calendar_Instant",
                        new Dictionary<String, Int32>(){{"y", 1984}, {"m", 7}, {"d", 6}}
                    )},
                    {"phone_numbers", new KeyValuePair<String, Object[]>("Set",
                        new String[]{"+81.9072391679"}
                    )}
                },
            })
        ))
    ))
```

## [Syntax_XML](Muldis_Object_Notation_Syntax_XML.md)

```
    <?xml version="1.0" encoding="UTF-8"?>
    <MUON>
        <Duo this="Syntax"><Duo>
            <this><Lot><m>Muldis_Object_Notation</m><m><q>https://muldis.com</q></m><m><q>0.300.0</q></m></Lot></this>
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
