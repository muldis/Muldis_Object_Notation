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
        <sp>?
            <Any>
        <sp>?
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
        '`' <-[`]>* '`'
    }

###########################################################################

    token Any
    {
        <opaque> | <collection>
    }

    token opaque
    {
          <Boolean>
        | <Integer>
        | <Fraction>
        | <Bits>
        | <Blob>
        | <Text>
        | <Calendar_Time>
        | <Calendar_Duration>
        | <Calendar_Instant>
        | <Geographic_Point>
        | <Ignorance>
        | <Nesting>
        | <Heading>
        | <Renaming>
    }

    token collection
    {
          <Array>
        | <Set>
        | <Bag>
        | <Mix>
        | <Interval>
        | <Interval_Set>
        | <Interval_Bag>
        | <Tuple>
        | <Tuple_Array>
        | <Relation>
        | <Tuple_Bag>
        | <Article>
        | <Excuse>
    }

###########################################################################

    token Boolean
    {
        False | True
    }

###########################################################################

    token Integer
    {
        <[+-]>? <sp>? <nonsigned_int>
    }

    token nonsigned_int
    {
          [ 0b <sp>?   <[ 0..1      ]>+ % [_ | <sp>]]
        | [ 0o <sp>?   <[ 0..7      ]>+ % [_ | <sp>]]
        | [[0d <sp>?]? <[ 0..9      ]>+ % [_ | <sp>]]
        | [ 0x <sp>?   <[ 0..9 A..F ]>+ % [_ | <sp>]]
    }

    token compact_nonsigned_int
    {
          [ 0b   <[ 0..1      ]>+ % _]
        | [ 0o   <[ 0..7      ]>+ % _]
        | [[0d]? <[ 0..9      ]>+ % _]
        | [ 0x   <[ 0..9 A..F ]>+ % _]
    }

###########################################################################

    token Fraction
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
          [ 0b <sp>?   [<[ 0..1      ]>+ % [_ | <sp>]] ** 2 % [<sp>? '.' <sp>?]]
        | [ 0o <sp>?   [<[ 0..7      ]>+ % [_ | <sp>]] ** 2 % [<sp>? '.' <sp>?]]
        | [[0d <sp>?]? [<[ 0..9      ]>+ % [_ | <sp>]] ** 2 % [<sp>? '.' <sp>?]]
        | [ 0x <sp>?   [<[ 0..9 A..F ]>+ % [_ | <sp>]] ** 2 % [<sp>? '.' <sp>?]]
    }

    token num_den_sig
    {
        <numerator> <sp>? '/' <sp>? <denominator>
    }

    token numerator
    {
        <Integer>
    }

    token denominator
    {
        <nonsigned_int>
    }

    token radix
    {
        <nonsigned_int>
    }

    token exponent
    {
        <Integer>
    }

###########################################################################

    token Bits
    {
          [ 0bb <sp>? <[ 0..1      ]>* % [_ | <sp>]]
        | [ 0bo <sp>? <[ 0..7      ]>* % [_ | <sp>]]
        | [ 0bx <sp>? <[ 0..9 A..F ]>* % [_ | <sp>]]
    }

###########################################################################

    token Blob
    {
          [ 0xb <sp>? [<[ 0..1      ]> ** 8]* % [_ | <sp>]]
        | [ 0xx <sp>? [<[ 0..9 A..F ]> ** 2]* % [_ | <sp>]]
    }

###########################################################################

    token Text
    {
        <quoted_text> | <code_point_text>
    }

    token quoted_text
    {
        ['"' <text_content> '"']+ % <sp>
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
        '\\' [<[qgbtnr]> | ['c<' <code_point> '>']]
    }

    token code_point_text
    {
        '\\~' <code_point>
    }

    token code_point
    {
        <compact_nonsigned_int>
    }

###########################################################################

    token Array
    {
        '[' <sp>?
            [',' <sp>?]?
            [[<Any> [<sp>? ':' <sp>? <int_multiplicity>]?]* % [<sp>? ',' <sp>?]]
            [<sp>? ',']?
        <sp>? ']'
    }

    token int_multiplicity
    {
        <compact_nonsigned_int>
    }

###########################################################################

    token Set
    {
        '{' <sp>?
            [',' <sp>?]?
            [[<Any> [<sp>? ':' <sp>? <Boolean>]?]* % [<sp>? ',' <sp>?]]
            [<sp>? ',']?
        <sp>? '}'
    }

###########################################################################

    token Bag
    {
        '{' <sp>?
            [',' <sp>?]?
            [[<Any> [<sp>? ':' <sp>? <int_multiplicity>]?]+ % [<sp>? ',' <sp>?]]
            [<sp>? ',']?
        <sp>? '}'
    }

###########################################################################

    token Mix
    {
        '{' <sp>?
            [',' <sp>?]?
            [[<Any> [<sp>? ':' <sp>? <frac_multiplicity>]?]+ % [<sp>? ',' <sp>?]]
            [<sp>? ',']?
        <sp>? '}'
    }

    token frac_multiplicity
    {
        <Fraction>
    }

###########################################################################

    token Interval
    {
        '\\..' <sp>? '{' <sp>? <interval_members> <sp>? '}'
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
        <interval_low>? <sp>? '-'? '..' '-'? <sp>? <interval_high>?
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
        '\\?..' <sp>?
        '{' <sp>?
            [',' <sp>?]?
            [[<interval_members> [<sp>? ':' <sp>? <Boolean>]?]* % [<sp>? ',' <sp>?]]
            [<sp>? ',']?
        <sp>? '}'
    }

###########################################################################

    token Interval_Bag
    {
        '\\+..' <sp>?
        '{' <sp>?
            [',' <sp>?]?
            [[<interval_members> [<sp>? ':' <sp>? <int_multiplicity>]?]* % [<sp>? ',' <sp>?]]
            [<sp>? ',']?
        <sp>? '}'
    }

###########################################################################

    token Tuple
    {
        '(' <sp>? <tuple_attrs> <sp>? ')'
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
        [[<attr_name> | <nesting_attr_names>] <sp>? ':' <sp>?]? <attr_asset>
    }

    token attr_asset
    {
        <Any>
    }

###########################################################################

    token Tuple_Array
    {
        '\\~%' <sp>? [<heading_attr_names> | <tuple_array_nonempty>]
    }

    token tuple_array_nonempty
    {
        '[' <sp>?
            [',' <sp>?]?
            [[<Tuple> [<sp>? ':' <sp>? <int_multiplicity>]?]+ % [<sp>? ',' <sp>?]]
            [<sp>? ',']?
        <sp>? ']'
    }

###########################################################################

    token Relation
    {
        '\\?%' <sp>? [<heading_attr_names> | <relation_nonempty>]
    }

    token relation_nonempty
    {
        '{' <sp>?
            [',' <sp>?]?
            [[<Tuple> [<sp>? ':' <sp>? <Boolean>]?]+ % [<sp>? ',' <sp>?]]
            [<sp>? ',']?
        <sp>? '}'
    }

###########################################################################

    token Tuple_Bag
    {
        '\\+%' <sp>? [<heading_attr_names> | <tuple_bag_nonempty>]
    }

    token tuple_bag_nonempty
    {
        '{' <sp>?
            [',' <sp>?]?
            [[<Tuple> [<sp>? ':' <sp>? <int_multiplicity>]?]+ % [<sp>? ',' <sp>?]]
            [<sp>? ',']?
        <sp>? '}'
    }

###########################################################################

    token Calendar_Time
    {
        '\\@%' <sp>? '(' <sp>? <time_ymdhms> <sp>? ')'
    }

    token time_ymdhms
    {
        <time_ymd> <sp>? ',' <sp>? <time_hms>
    }

    token time_ymd
    {
        <year>? <sp>? ',' <sp>? <month>? <sp>? ',' <sp>? <day>?
    }

    token time_hms
    {
        <hour>? <sp>? ',' <sp>? <minute>? <sp>? ',' <sp>? <second>?
    }

    token year
    {
        <loc_multiplicity>
    }

    token month
    {
        <loc_multiplicity>
    }

    token day
    {
        <loc_multiplicity>
    }

    token hour
    {
        <loc_multiplicity>
    }

    token minute
    {
        <loc_multiplicity>
    }

    token second
    {
        <loc_multiplicity>
    }

    token loc_multiplicity
    {
        <Integer> | <Fraction>
    }

###########################################################################

    token Calendar_Duration
    {
        '\\@+' <sp>? '(' <sp>? <time_ymdhms> <sp>? ')'
    }

###########################################################################

    token Calendar_Instant
    {
        '\\@' <sp>?
        '(' <sp>?
            <instant_base> [<sp>? '@' <sp>? [<instant_offset> | <instant_zone>]]?
        <sp>? ')'
    }

    token instant_base
    {
        <time_ymdhms>
    }

    token instant_offset
    {
        <time_hms>
    }

    token instant_zone
    {
        <quoted_text>
    }

###########################################################################

    token Geographic_Point
    {
        '\\@@' <sp>?
        '(' <sp>?
            [[<longitude> | <latitude> | <elevation>]* % [<sp>? ',' <sp>?]]
        <sp>? ')'
    }

    token longitude
    {
        '>' <sp>? <loc_multiplicity>
    }

    token latitude
    {
        '^' <sp>? <loc_multiplicity>
    }

    token elevation
    {
        '+' <sp>? <loc_multiplicity>
    }

###########################################################################

    token Article
    {
        <generic_article> | <singleton_article>
    }

    token generic_article
    {
        <label_attrs_pair>
    }

    token label_attrs_pair
    {
        '(' <sp>? <label> <sp>? ':' <sp>? <attrs> <sp>? ')'
    }

    token label
    {
        <Any>
    }

    token attrs
    {
        <Tuple>
    }

    token singleton_article
    {
        '\\*' <sp>? <nesting_attr_names>
    }

###########################################################################

    token Excuse
    {
        <generic_excuse> | <singleton_excuse>
    }

    token generic_excuse
    {
        '\\!' <sp>? <label_attrs_pair>
    }

    token singleton_excuse
    {
        '\\!' <sp>? <nesting_attr_names>
    }

###########################################################################

    token Ignorance
    {
        '\\!!' <sp>? Ignorance
    }

###########################################################################

    token Nesting
    {
        '\\' <sp>? <nesting_attr_names>
    }

    token nesting_attr_names
    {
        <attr_name>+ % [<sp>? '::' <sp>?]
    }

    token attr_name
    {
        <nonord_attr_name> | <ord_attr_name>
    }

    token nonord_attr_name
    {
        <nonord_nonquoted_attr_name> | <quoted_text>
    }

    token nonord_nonquoted_attr_name
    {
        <[ A..Z _ a..z ]> <[ 0..9 A..Z _ a..z ]>*
    }

    token ord_attr_name
    {
        <code_point>
    }

###########################################################################

    token Heading
    {
        '\\\$' <sp>? <heading_attr_names>
    }

    token heading_attr_names
    {
        '(' <sp>?
            [',' <sp>?]?
            [[<attr_name> | <ord_attr_name_range>]* % [<sp>? ',' <sp>?]]
            [<sp>? ',']?
        <sp>? ')'
    }

    token ord_attr_name_range
    {
        <ord_attr_name_low> <sp>? '..' <sp>? <ord_attr_name_high>
    }

    token ord_attr_name_low
    {
        <ord_attr_name>
    }

    token ord_attr_name_high
    {
        <ord_attr_name>
    }

###########################################################################

    token Renaming
    {
        '\\\$:' <sp>?
        '(' <sp>?
            [',' <sp>?]?
            [[<anon_attr_rename> | <named_attr_rename>]* % [<sp>? ',' <sp>?]]
            [<sp>? ',']?
        <sp>? ')'
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
