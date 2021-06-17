# Muldis Object Notation (MUON) Syntax_Plain_Text Supplemental

This document features supplemental material that used to be part of
[Syntax_Plain_Text](Muldis_Object_Notation_Syntax_Plain_Text.md)
but was removed from there as it was deemed to fit better as part of a
possible superset of the MUON grammar rather than as part of MUON proper.

## Expansion of Possrep Any

Grammar:

```
    token Any
    {
          ...
        | <Calendar_Time>
        | <Calendar_Duration>
        | <Calendar_Instant>
        | <Geographic_Point>
        | <Interval>
    }
```

## Added Dedicated Format for Calendar Time

A **Calendar Time** artifact has the dedicated concrete literal format
described by `<Calendar_Time>`.

Grammar:

```
    token Calendar_Time
    {
        0Lct [<sp>? '@' <sp>? <time_elements>]?
    }

    token time_elements
    {
        [<time_unit> <sp>? <loc_multiplicity>]+ % [<sp>? '|' <sp>?]
    }

    token time_unit
    {
        <[ymdhis]>
    }

    token loc_multiplicity
    {
        <Integer> | <Fraction>
    }
```

Examples:

```
    `No measurement was taken or specified at all.`
    0Lct

    `Either an unspecified period in 1970 or a duration of 1970 years.`
    0Lct@y1970

    `Either a civil calendar date 2015-5-3 or a duration of 2015y+5m+3d.`
    0Lct@y2015|m5|d3

    `Either a military calendar date 1998-300 or a duration of 1998y+300d.`
    0Lct@y1998|d300

    `Either the 6th week of 1776 or a duration of 1776 years + 6 weeks.`
    0Lct@y1776|d42

    `Either the first quarter of 1953 or a duration of 1953.25 years.`
    0Lct@y1953.25

    `Either high noon on an unspecified day or a duration of 12 hours.`
    0Lct@h12|i0|s0

    `Either a fully specified civil date and time or a 6-part duration.`
    0Lct@y1884|m10|d17|h20|i55|s30

    `Either an ancient date and time or a negative duration.`
    0Lct@y-370|m1|d24|h11|i0|s0

    `Either a time on some unspecified day or a duration of seconds.`
    0Lct@s5923.21124603
```

## Added Dedicated Format for Calendar Duration

A **Calendar Duration** artifact has the dedicated concrete literal format
described by `<Calendar_Duration>`.

Grammar:

```
    token Calendar_Duration
    {
        0Lcd [<sp>? '@' <sp>? <time_elements>]?
    }
```

Examples:

```
    `Addition of 2 years and 3 months.`
    0Lcd@y2|m3|d0|h0|i0|s0

    `Subtraction of 22 hours.`
    0Lcd@y0|m0|d0|h-22|i0|s0
```

## Added Dedicated Format for Calendar Instant

A **Calendar Instant** artifact has the dedicated concrete literal format
described by `<Calendar_Instant>`.

Grammar:

```
    token Calendar_Instant
    {
        0Lci [<sp>? '@' <sp>? <instant_base>
            [<sp>? '@' <sp>? [<instant_offset> | <instant_zone>]]?
        ]?
    }

    token instant_base
    {
        <time_elements>
    }

    token instant_offset
    {
        <time_elements>
    }

    token instant_zone
    {
        <quoted_text_segment>
    }
```

Examples:

```
    `The Day The Music Died (if paired with Gregorian calendar).`
    0Lci@y1959|m2|d3

    `A time of day when one might have breakfast.`
    0Lci@h7|i30|s0

    `What was now in the Pacific zone (if paired with Gregorian calendar).`
    0Lci@y2018|m9|d3|h20|i51|s17@h-8|i0|s0

    `A time of day in the UTC zone on an unspecified day.`
    0Lci@h9|i25|s0@h0|i0|s0

    `A specific day and time in the Pacific Standard Time zone.`
    0Lci@y2001|m4|d16|h20|i1|s44@"PST"
```

## Added Dedicated Format for Geographic Point

A **Geographic Point** artifact has the dedicated concrete literal format
described by `<Geographic_Point>`.

Grammar:

```
    token Geographic_Point
    {
        0Lgp [<sp>? '@' <sp>? <geo_elements>]?
    }

    token geo_elements
    {
        [<geo_unit> <sp>? <loc_multiplicity>]+ % [<sp>? '|' <sp>?]
    }

    token geo_unit
    {
        <[>^+]>
    }
```

Examples:

```
    `No specified coordinates at all.`
    0Lgp

    `Just an elevation specified.`
    0Lgp@+920

    `Geographic surface coordinates of Googleplex; elevation not specified.`
    0Lgp@>-122.0857017|^37.4218363

    `Same thing.`
    0Lgp@^37.4218363|>-122.0857017

    `Some location with all coordinates specified.`
    0Lgp@>-101|^-70|+1000

    `Another place.`
    0Lgp@>-94.746094|^37.483577
```

## Added Dedicated Format for Interval

An **Interval** artifact has the dedicated concrete literal format
described by `<Interval>`.

Grammar:

```
    token Interval
    {
        ['[' <sp>?] ~ [<sp>? ']'] <interval_members>
    }

    token interval_members
    {
        <interval_empty> | <interval_single> | <interval_range>
    }

    token interval_empty
    {
        ''
    }

    token interval_single
    {
        <Any>
    }

    token interval_range
    {
          [[<interval_low> <sp>? '<' '='?]? '*'  ['<' '='? <sp>? <interval_high>]?]
        | [ <interval_low> <sp>?            '..'           <sp>? <interval_high>  ]
    }

    token interval_low
    {
        <Any>
    }

    token interval_high
    {
        <Any>
    }
```

Examples:

```
    `Empty interval (zero members).`
    []

    `Unit interval (one member).`
    [abc]

    `Closed interval (probably 10 members, depending on the model used).`
    [1 <=*<= 10]

    `Same thing.`
    [1..10]

    `Left-closed, right-open interval; every Fraction x in [2.7<=x<9.3].`
    [2.7 <=*< 9.3]

    `Left-open, right-closed interval; every Text x ordered in [a<x<=z].`
    [a <*<= z]

    `Open interval; time period between Dec 6 and 20 excluding both.`
    [0Lci@y2002|m12|d6@"UTC" <*< 0Lci@y2002|m12|d20@"UTC"]

    `Left-unbounded, right-closed interval; every Integer x where x <= 3.`
    [*<= 3]

    `Left-closed, right-unbounded interval; every Integer x where 29 <= x.`
    [29 <=*]

    `Universal interval; unbounded; every value of type system is a member.`
    [*]
```

## More Compact Examples of Interval Set

```
    `Empty interval-set (zero members).`
    (Interval_Set:{})

    `Unit interval-set (one member).`
    (Interval_Set:{[abc]})

    `Probably 10 members, depending on the model used.`
    (Interval_Set:{[1<=*<=10]})

    `Same thing.`
    (Interval_Set:{[1..10]})

    `Probably 6 members.`
    (Interval_Set:{[1..3],[6],[8..9]})

    `Every Integer x except for {4..13,22..28}`
    (Interval_Set:{[*<=3],[14..21],[29<=*]})

    `Set of all valid Unicode code points.`
    (Interval_Set:{[0..0xD7FF],[0xE000..0x10FFFF]})

    `Probably 15 members (no duplicates), depending on the model used.`
    (Interval_Set:{[1..10],[6..15]})

    `Probably same thing, regardless of data model used.`
    (Interval_Set:{[1<=*<6],[6..10]:2,[10<*<=15]})
```

## More Compact Examples of Interval Bag

```
    `Empty interval-bag (zero members).`
    (Interval_Bag:{})

    `Unit interval-bag (one member).`
    (Interval_Bag:{[abc]})

    `Five members (4 duplicates).`
    (Interval_Bag:{[def]:5})

    `Probably 20 members (5 duplicates), depending on the model used.`
    (Interval_Bag:{[1<=*<=10],[6<=*<=15]})

    `Same thing.`
    (Interval_Bag:{[1..10],[6..15]})

    `Probably same thing, regardless of data model used.`
    (Interval_Bag:{[1<=*<6],[6..10]:2,[10<*<=15]})
```

## More Compact Examples of Relation

```
    `Some people records.`
    (Relation:{
        (name : "Jane Ives", birth_date : 0Lci@y1971|m11|d06,
            phone_numbers : (Set:{"+1.4045552995", "+1.7705557572"})),
        (name : "Layla Miller", birth_date : 0Lci@y1995|m08|d27,
            phone_numbers : (Set:{})),
        (name : "岩倉 玲音", birth_date : 0Lci@y1984|m07|d06,
            phone_numbers : (Set:{"+81.9072391679"})),
    })

    `Same thing.`
    (Relation:(
            (name          , birth_date        , phone_numbers)
        : {
            ("Jane Ives"   , 0Lci@y1971|m11|d06, (Set:{"+1.4045552995", "+1.7705557572"})),
            ("Layla Miller", 0Lci@y1995|m08|d27, (Set:{})),
            ("岩倉 玲音", 0Lci@y1984|m07|d06, (Set:{"+81.9072391679"})),
        }
    ))
```
