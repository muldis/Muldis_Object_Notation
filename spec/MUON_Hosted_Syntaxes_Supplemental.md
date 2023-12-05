<a name="TOP"></a>

# Muldis Object Notation (MUON) Hosted Syntaxes Supplemental

This document features supplemental material that used to be the content of
the **ADDITIONAL SECONDARY DATA TYPE POSSREP FORMATS** sections of the MUON
formal specification for each respective hosted syntax but was removed from
there when MUON itself was narrowed in scope to encompass just what was
previouly called its **PRIMARY** possreps.
The material may be helpful for MUON implementations over each respective
host language that may choose to provide a superset of its hosted syntax.

## CONTENTS

- [Syntax_Muldis_Data_Language](#Syntax_Muldis_Data_Language)
- [Syntax_Raku](#Syntax_Raku)
- [Syntax_DotNet](#Syntax_DotNet)
- [Syntax_Java](#Syntax_Java)
- [Syntax_ECMAScript](#Syntax_ECMAScript)
- [Syntax_Ruby](#Syntax_Ruby)
- [Syntax_Python](#Syntax_Python)
- [Syntax_PHP](#Syntax_PHP)

[RETURN](#TOP)

<a name="Syntax_Muldis_Data_Language"></a>

## [Syntax_Muldis_Data_Language](Muldis_Object_Notation_Syntax_Muldis_Data_Language.md)

A **Calendar Time** artifact is additionally any of the following:

* Any value of the MDL type `fdn::Calendar_Time`.

A **Calendar Duration** artifact is additionally any of the following:

* Any value of the MDL type `fdn::Calendar_Duration`.

A **Calendar Instant** artifact is additionally any of the following:

* Any value of the MDL type `fdn::Calendar_Instant`.

A **Geographic Point** artifact is additionally any of the following:

* Any value of the MDL type `fdn::Geographic_Point`.

[RETURN](#TOP)

<a name="Syntax_Raku"></a>

## [Syntax_Raku](Muldis_Object_Notation_Syntax_Raku.md)

A **Calendar Duration** artifact is additionally any of the following:

* Any object of the Raku class `Duration`.

A **Calendar Instant** artifact is additionally any of the following:

* Any object of any of the Raku classes `Date`, `DateTime`, `Instant`.

An **Interval** artifact is additionally any of the following:

* Any object of the Raku class `Range`
such that each of its `min` and `max` properties is any **Any** artifact.

[RETURN](#TOP)

<a name="Syntax_DotNet"></a>

## [Syntax_DotNet](Muldis_Object_Notation_Syntax_DotNet.md)

A **Calendar Duration** artifact is additionally any of the following:

* Any value of the .NET structure type `System.TimeSpan`.

A **Calendar Instant** artifact is additionally any of the following:

* Any value of any of the .NET structure types
`System.DateTime`,
`System.DateTimeOffset`.

A **Geographic Point** artifact is additionally any of the following:

* Any coordinate-specifying object of the .NET class
`System.Data.Spatial.DbGeography`.

*Note: DbGeography is only in .NET Framework; it is not in .NET 5+.*

[RETURN](#TOP)

<a name="Syntax_Java"></a>

## [Syntax_Java](Muldis_Object_Notation_Syntax_Java.md)

A **Calendar Duration** artifact is additionally any of the following:

* Any object of any of the Java classes
`java.time.Duration`,
`java.time.Period`.

A **Calendar Instant** artifact is additionally any of the following:

* Any object of any of the Java classes
`java.time.Instant`,
`java.time.LocalDate`,
`java.time.LocalDateTime`,
`java.time.LocalTime`,
`java.time.Month`,
`java.time.MonthDay`,
`java.time.OffsetDateTime`,
`java.time.OffsetTime`,
`java.time.Year`,
`java.time.YearMonth`,
`java.time.ZonedDateTime`,
`java.time.ZoneOffset`.

[RETURN](#TOP)

<a name="Syntax_ECMAScript"></a>

## [Syntax_ECMAScript](Muldis_Object_Notation_Syntax_ECMAScript.md)

A **Calendar Instant** artifact is additionally any of the following:

* Any value of the ECMAScript type `Date`.

[RETURN](#TOP)

<a name="Syntax_Ruby"></a>

## [Syntax_Ruby](Muldis_Object_Notation_Syntax_Ruby.md)

A **Calendar Instant** artifact is additionally any of the following:

* Any object of the Ruby class `Time`.

An **Interval** artifact is additionally any of the following:

* Any object of the Ruby class `Range`.

[RETURN](#TOP)

<a name="Syntax_Python"></a>

## [Syntax_Python](Muldis_Object_Notation_Syntax_Python.md)

A **Calendar Duration** artifact is additionally any of the following:

* Any value of the Python type `datetime.timedelta`.

A **Calendar Instant** artifact is additionally any of the following:

* Any value of any of the Python types
`datetime.datetime`,
`datetime.date`,
`datetime.time`.

An **Interval** artifact is additionally any of the following:

* Any object of the Python class `range`.

[RETURN](#TOP)

<a name="Syntax_PHP"></a>

## [Syntax_PHP](Muldis_Object_Notation_Syntax_PHP.md)

A **Calendar Duration** artifact is additionally any of the following:

* Any object of the PHP class `DateInterval`.

A **Calendar Instant** artifact is additionally any of the following:

* Any object of any of the PHP classes `DateTime`, `DateTimeImmutable`.

An **Interval** artifact is additionally any of the following:

* Any object of the PHP class `DatePeriod`.
