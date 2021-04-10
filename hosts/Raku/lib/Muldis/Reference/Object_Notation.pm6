###########################################################################
###########################################################################

module Muldis::Reference::Object_Notation
{
    sub extract_MUON_from_Text(Str:D $text)
    {
        return Muldis::Reference::Object_Notation::Grammar.parse(
            $text,
            :token<MUON>,
            :actions(Muldis::Reference::Object_Notation::Actions.new())
        );
    }
}

###########################################################################
###########################################################################

grammar Muldis::Reference::Object_Notation::Grammar
{

###########################################################################

    token MUON
    {
        <sp>? ~ <sp>? <Any>
    }

    token sp
    {
        [<whitespace_char> | <quoted_sp_comment_str>]+
    }

    token whitespace_char
    {
        <[ \t \n \r \x[20] ]>
    }

    token quoted_sp_comment_str
    {
        '`' ~ '`' <-[`]>*
    }

###########################################################################

    token Any
    {
        <generic_group> | <opaque> | <collection>
    }

    token generic_group
    {
        ['(' <sp>?] ~ [<sp>? ')'] <Any>
    }

    token opaque
    {
          <Ignorance>
        | <Boolean>
        | <Integer>
        | <Fraction>
        | <Calendar_Time>
        | <Calendar_Duration>
        | <Calendar_Instant>
        | <Geographic_Point>
        | <Bits>
        | <Blob>
        | <Text>
        | <Nesting>
        | <Heading>
        | <Renaming>
    }

    token collection
    {
          <Lot>
        | <Array>
        | <Set>
        | <Bag>
        | <Mix>
        | <Interval>
        | <Interval_Set>
        | <Interval_Bag>
        | <Pair>
        | <Tuple>
        | <Tuple_Array>
        | <Relation>
        | <Tuple_Bag>
        | <Article>
        | <Excuse>
    }

###########################################################################

    token Ignorance
    {
        <Ignorance_subject>
    }

    token Ignorance_subject
    {
        0sIGNORANCE
    }

###########################################################################

    token Boolean
    {
        <Boolean_subject>
    }

    token Boolean_subject
    {
        0b [FALSE | TRUE]
    }

###########################################################################

    token Integer
    {
        <Integer_subject>
    }

    token Integer_subject
    {
        <[+-]>? <sp>? <Integer_subject_nonsigned>
    }

    token Integer_subject_nonsigned
    {
          [ 0b <sp>?   [<[ 0..1      ]>+]+ % [_ | <sp>]]
        | [ 0o <sp>?   [<[ 0..7      ]>+]+ % [_ | <sp>]]
        | [[0d <sp>?]? [<[ 0..9      ]>+]+ % [_ | <sp>]]
        | [ 0x <sp>?   [<[ 0..9 A..F ]>+]+ % [_ | <sp>]]
    }

###########################################################################

    token Fraction
    {
        <Fraction_subject>
    }

    token Fraction_subject
    {
        <significand> [<sp>? '*' <sp>? <radix> <sp>? '^' <sp>? <exponent>]?
    }

    token significand
    {
        <radix_point_sig> | <num_den_sig>
    }

    token radix_point_sig
    {
        <[+-]>? <sp>? <nonsigned_radix_point_sig>
    }

    token nonsigned_radix_point_sig
    {
          [ 0b <sp>?   [[<[ 0..1      ]>+]+ % [_ | <sp>]] ** 2 % [<sp>? '.' <sp>?]]
        | [ 0o <sp>?   [[<[ 0..7      ]>+]+ % [_ | <sp>]] ** 2 % [<sp>? '.' <sp>?]]
        | [[0d <sp>?]? [[<[ 0..9      ]>+]+ % [_ | <sp>]] ** 2 % [<sp>? '.' <sp>?]]
        | [ 0x <sp>?   [[<[ 0..9 A..F ]>+]+ % [_ | <sp>]] ** 2 % [<sp>? '.' <sp>?]]
    }

    token num_den_sig
    {
        <numerator> <sp>? '/' <sp>? <denominator>
    }

    token numerator
    {
        <Integer_subject>
    }

    token denominator
    {
        <Integer_subject_nonsigned>
    }

    token radix
    {
        <Integer_subject_nonsigned>
    }

    token exponent
    {
        <Integer_subject>
    }

###########################################################################

    token Calendar_Time
    {
        <Calendar_Time_subject>
    }

    token Calendar_Time_subject
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
        <Integer_subject> | <Fraction_subject>
    }

###########################################################################

    token Calendar_Duration
    {
        <Calendar_Duration_subject>
    }

    token Calendar_Duration_subject
    {
        0Lcd [<sp>? '@' <sp>? <time_elements>]?
    }

###########################################################################

    token Calendar_Instant
    {
        <Calendar_Instant_subject>
    }

    token Calendar_Instant_subject
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

###########################################################################

    token Geographic_Point
    {
        <Geographic_Point_subject>
    }

    token Geographic_Point_subject
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

###########################################################################

    token Bits
    {
        <Bits_subject>
    }

    token Bits_subject
    {
          [ 0bb <sp>? [<[ 0..1      ]>+]* % [_ | <sp>]]
        | [ 0bo <sp>? [<[ 0..7      ]>+]* % [_ | <sp>]]
        | [ 0bx <sp>? [<[ 0..9 A..F ]>+]* % [_ | <sp>]]
    }

###########################################################################

    token Blob
    {
        <Blob_subject>
    }

    token Blob_subject
    {
          [ 0xb <sp>? [[<[ 0..1      ]> ** 8]+]* % [_ | <sp>]]
        | [ 0xx <sp>? [[<[ 0..9 A..F ]> ** 2]+]* % [_ | <sp>]]
        | [ 0xy <sp>? [[<[ A..Z a..z 0..9 + / = ]> ** 4]+]* % [_ | <sp>]]
    }

###########################################################################

    token Text
    {
        <Text_subject>
    }

    token Text_subject
    {
        <quoted_text> | <nonquoted_alphanumeric_text> | <code_point_text>
    }

    token quoted_text
    {
        <quoted_text_segment>+ % <sp>?
    }

    token quoted_text_segment
    {
        '"' ~ '"' <text_content>
    }

    token text_content
    {
        <text_nonescaped_content> | <text_escaped_content>
    }

    token text_nonescaped_content
    {
        [[<restricted_inside_char> & <-[\\]>] <restricted_inside_char>*]?
    }

    token text_escaped_content
    {
        '\\' [[<restricted_inside_char> & <-[\\]>] | <escaped_char>]*
    }

    token restricted_inside_char
    {
        <-[ \x[0]..\x[1F] "` \x[80]..\x[9F] ]>
    }

    token escaped_char
    {
        '\\' [<[qgbtnr]> | ['<' ~ '>' <code_point_text>]]
    }

    token nonquoted_alphanumeric_text
    {
        <[ A..Z _ a..z ]> <[ 0..9 A..Z _ a..z ]>*
    }

    token code_point_text
    {
          [0cb  <[ 0..1      ]>+]
        | [0co  <[ 0..7      ]>+]
        | [0cd? <[ 0..9      ]>+]
        | [0cx  <[ 0..9 A..F ]>+]
    }

###########################################################################

    token Nesting
    {
        <Nesting_subject>
    }

    token Nesting_subject
    {
        ['::' <sp>? <attr_name>]+ % <sp>?
    }

    token attr_name
    {
        <Text_subject>
    }

###########################################################################

    token Heading
    {
        ['(' <sp>?] ~ [<sp>? ')']
            Heading <sp>? ':' <sp>? <heading_attr_names>
    }

    token heading_attr_names
    {
        ['(' <sp>?] ~ [<sp>? ')']
            [',' <sp>?]?
            [<attr_name>* % [<sp>? ',' <sp>?]]
            [<sp>? ',']?
    }

###########################################################################

    token Lot
    {
        <Lot_subject>
    }

    token Lot_subject
    {
        ['{' <sp>?] ~ [<sp>? '}']
            [',' <sp>?]?
            [<this_and_maybe_that>* % [<sp>? ',' <sp>?]]
            [<sp>? ',']?
    }

    token this_and_maybe_that
    {
          <this>
        | [<this> <sp>? [':'|'->'] <sp>? <that>]
        | [<that> <sp>?      '<-'  <sp>? <this>]
    }

###########################################################################

    token Array
    {
        ['(' <sp>?] ~ [<sp>? ')']
            Array <sp>? ':' <sp>? <Array_subject>
    }

    token Array_subject
    {
        ['{' <sp>?] ~ [<sp>? '}']
            [',' <sp>?]?
            [[<Any> [<sp>? ':' <sp>? <int_multiplicity>]?]* % [<sp>? ',' <sp>?]]
            [<sp>? ',']?
    }

###########################################################################

    token Set
    {
        ['(' <sp>?] ~ [<sp>? ')']
            Set <sp>? ':' <sp>? <Set_subject>
    }

    token Set_subject
    {
        ['{' <sp>?] ~ [<sp>? '}']
            [',' <sp>?]?
            [[<Any> [<sp>? ':' <sp>? <Boolean_subject>]?]* % [<sp>? ',' <sp>?]]
            [<sp>? ',']?
    }

###########################################################################

    token Bag
    {
        ['(' <sp>?] ~ [<sp>? ')']
            Bag <sp>? ':' <sp>? <Bag_subject>
    }

    token Bag_subject
    {
        ['{' <sp>?] ~ [<sp>? '}']
            [',' <sp>?]?
            [[<Any> [<sp>? ':' <sp>? <int_multiplicity>]?]* % [<sp>? ',' <sp>?]]
            [<sp>? ',']?
    }

    token int_multiplicity
    {
        <Integer_subject_nonsigned>
    }

###########################################################################

    token Mix
    {
        ['(' <sp>?] ~ [<sp>? ')']
            Mix <sp>? ':' <sp>? <Mix_subject>
    }

    token Mix_subject
    {
        ['{' <sp>?] ~ [<sp>? '}']
            [',' <sp>?]?
            [[<Any> [<sp>? ':' <sp>? <frac_multiplicity>]?]* % [<sp>? ',' <sp>?]]
            [<sp>? ',']?
    }

    token frac_multiplicity
    {
        <Fraction_subject>
    }

###########################################################################

    token Interval
    {
         <Interval_subject>
    }

    token Interval_subject
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
        [<interval_low> <sp>? | '*'] '-'? '..' '-'? ['*' | <sp>? <interval_high>]
    }

    token interval_low
    {
        <Any>
    }

    token interval_high
    {
        <Any>
    }

###########################################################################

    token Interval_Set
    {
        ['(' <sp>?] ~ [<sp>? ')']
            Interval_Set <sp>? ':' <sp>? <Interval_Set_subject>
    }

    token Interval_Set_subject
    {
        ['{' <sp>?] ~ [<sp>? '}']
            [',' <sp>?]?
            [[<interval_members> [<sp>? ':' <sp>? <Boolean_subject>]?]* % [<sp>? ',' <sp>?]]
            [<sp>? ',']?
    }

###########################################################################

    token Interval_Bag
    {
        ['(' <sp>?] ~ [<sp>? ')']
            Interval_Bag <sp>? ':' <sp>? <Interval_Bag_subject>
    }

    token Interval_Bag_subject
    {
        ['{' <sp>?] ~ [<sp>? '}']
            [',' <sp>?]?
            [[<interval_members> [<sp>? ':' <sp>? <int_multiplicity>]?]* % [<sp>? ',' <sp>?]]
            [<sp>? ',']?
    }

###########################################################################

    token Pair
    {
         <Pair_subject>
    }

    token Pair_subject
    {
        ['(' <sp>?] ~ [<sp>? ')'] <this_and_that>
    }

    token this_and_that
    {
          [<this> <sp>? [':'|'->'] <sp>? <that>]
        | [<that> <sp>?      '<-'  <sp>? <this>]
    }

    token this
    {
        <Any>
    }

    token that
    {
        <Any>
    }

###########################################################################

    token Tuple
    {
        <Tuple_subject>
    }

    token Tuple_subject
    {
        ['(' <sp>?] ~ [<sp>? ')'] <tuple_attrs>
    }

    token tuple_attrs
    {
        <tuple_nullary> | <tuple_unary> | <tuple_nary>
    }

    token tuple_nullary
    {
        ''
    }

    token tuple_unary
    {
          [          <tuple_attr> <sp>? ',']
        | [',' <sp>? <tuple_attr> <sp>? ',']
        | [',' <sp>? <tuple_attr>          ]
    }

    token tuple_nary
    {
        [',' <sp>?]?
        [<tuple_attr> ** 2..* % [<sp>? ',' <sp>?]]
        [<sp>? ',']?
    }

    token tuple_attr
    {
        [[<attr_name> | <Nesting_subject>] <sp>? ':' <sp>?]? <attr_asset>
    }

    token attr_asset
    {
        <Any>
    }

###########################################################################

    token Tuple_Array
    {
        ['(' <sp>?] ~ [<sp>? ')']
            Tuple_Array <sp>? ':' <sp>? <Tuple_Array_subject>
    }

    token Tuple_Array_subject
    {
        <heading_attr_names> | <tuple_array_nonempty>
    }

    token tuple_array_nonempty
    {
        ['{' <sp>?] ~ [<sp>? '}']
            [',' <sp>?]?
            [[<Tuple> [<sp>? ':' <sp>? <int_multiplicity>]?]+ % [<sp>? ',' <sp>?]]
            [<sp>? ',']?
    }

###########################################################################

    token Relation
    {
        ['(' <sp>?] ~ [<sp>? ')']
            Relation <sp>? ':' <sp>? <Relation_subject>
    }

    token Relation_subject
    {
        <heading_attr_names> | <relation_nonempty>
    }

    token relation_nonempty
    {
        ['{' <sp>?] ~ [<sp>? '}']
            [',' <sp>?]?
            [[<Tuple> [<sp>? ':' <sp>? <Boolean_subject>]?]+ % [<sp>? ',' <sp>?]]
            [<sp>? ',']?
    }

###########################################################################

    token Tuple_Bag
    {
        ['(' <sp>?] ~ [<sp>? ')']
            Tuple_Bag <sp>? ':' <sp>? <Tuple_Bag_subject>
    }

    token Tuple_Bag_subject
    {
        <heading_attr_names> | <tuple_bag_nonempty>
    }

    token tuple_bag_nonempty
    {
        ['{' <sp>?] ~ [<sp>? '}']
            [',' <sp>?]?
            [[<Tuple> [<sp>? ':' <sp>? <int_multiplicity>]?]+ % [<sp>? ',' <sp>?]]
            [<sp>? ',']?
    }

###########################################################################

    token Article
    {
        ['(' <sp>?] ~ [<sp>? ')']
            Article <sp>? ':' <sp>? <Article_subject>
    }

    token Article_subject
    {
        <label_with_attrs> | <label_as_nesting>
    }

    token label_with_attrs
    {
        <Pair_subject>
    }

    token label_as_nesting
    {
        <Nesting_subject>
    }

###########################################################################

    token Excuse
    {
        ['(' <sp>?] ~ [<sp>? ')']
            Excuse <sp>? ':' <sp>? <Excuse_subject>
    }

    token Excuse_subject
    {
        <Article_subject>
    }

###########################################################################

    token Renaming
    {
        ['(' <sp>?] ~ [<sp>? ')']
            Renaming <sp>? ':' <sp>? <Renaming_subject>
    }

    token Renaming_subject
    {
        ['(' <sp>?] ~ [<sp>? ')']
            [',' <sp>?]?
            [[<anon_attr_rename> | <named_attr_rename>]* % [<sp>? ',' <sp>?]]
            [<sp>? ',']?
    }

    token anon_attr_rename
    {
          ['->' <sp>? <attr_name_after>]
        | [<attr_name_after> <sp>? '<-']
        | [<attr_name_before> <sp>? '->']
        | ['<-' <sp>? <attr_name_before>]
    }

    token named_attr_rename
    {
          [<attr_name_before> <sp>? '->' <sp>? <attr_name_after>]
        | [<attr_name_after> <sp>? '<-' <sp>? <attr_name_before>]
    }

    token attr_name_before
    {
        <attr_name>
    }

    token attr_name_after
    {
        <attr_name>
    }

###########################################################################

}

###########################################################################
###########################################################################

class Muldis::Reference::Object_Notation::Actions
{
}

###########################################################################
###########################################################################
