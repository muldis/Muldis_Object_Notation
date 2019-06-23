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
        [<ws> | <quoted_sp_comment_str> | <entity_marker>]+
    }

    token ws
    {
        <[ \t \n \r \x[20] ]>+
    }

    token quoted_sp_comment_str
    {
        '`' <-[`]>* '`'
    }

    token entity_marker
    {
        '`\$\$\$`'
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
        <[+-]>? <ws>? <nonsigned_int>
    }

    token nonsigned_int
    {
          [ 0b <ws>?   <[ 0..1           ]>+ % [_ | <ws>]]
        | [ 0o <ws>?   <[ 0..7           ]>+ % [_ | <ws>]]
        | [[0d <ws>?]? <[ 0..9           ]>+ % [_ | <ws>]]
        | [ 0x <ws>?   <[ 0..9 A..F a..f ]>+ % [_ | <ws>]]
    }

    token compact_nonsigned_int
    {
          [ 0b   <[ 0..1           ]>+ % _]
        | [ 0o   <[ 0..7           ]>+ % _]
        | [[0d]? <[ 0..9           ]>+ % _]
        | [ 0x   <[ 0..9 A..F a..f ]>+ % _]
    }

###########################################################################

    token Fraction
    {
        <significand> [<ws>? '*' <ws>? <radix> <ws>? '^' <ws>? <exponent>]?
    }

    token significand
    {
        <radix_point_sig> | <num_den_sig>
    }

    token radix_point_sig
    {
        <[+-]>? <ws>? <nonsigned_radix_point_sig>
    }

    token nonsigned_radix_point_sig
    {
          [ 0b <ws>?   [<[ 0..1           ]>+ % [_ | <ws>]] ** 2 % [<ws>? '.' <ws>?]]
        | [ 0o <ws>?   [<[ 0..7           ]>+ % [_ | <ws>]] ** 2 % [<ws>? '.' <ws>?]]
        | [[0d <ws>?]? [<[ 0..9           ]>+ % [_ | <ws>]] ** 2 % [<ws>? '.' <ws>?]]
        | [ 0x <ws>?   [<[ 0..9 A..F a..f ]>+ % [_ | <ws>]] ** 2 % [<ws>? '.' <ws>?]]
    }

    token num_den_sig
    {
        <numerator> <ws>? '/' <ws>? <denominator>
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
        '\\~?' <ws>? [['"' <[ 0..1 _ ]>* '"']+ % <ws>]
    }

###########################################################################

    token Blob
    {
        '\\~+' <ws>? [['"' [<[ 0..9 A..F a..f ]> ** 2 | _]* '"']+ % <ws>]
    }

###########################################################################

    token Text
    {
        <quoted_text> | <code_point_text>
    }

    token quoted_text
    {
        ['"' <text_content> '"']+ % <ws>
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
        <-[ \x[0]..\x[1F] "` \x[80]..\x[9F] ]>*
    }

    token escaped_char
    {
          '\\q' | '\\g'
        | '\\b'
        | '\\t' | '\\n' | '\\r'
        | ['\\c<' <code_point> '>']
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
        <ord_member_commalist>
    }

    token ord_member_commalist
    {
        '[' <sp>? <member_commalist> <sp>? ']'
    }

###########################################################################

    token Set
    {
        <nonord_member_commalist>
    }

###########################################################################

    token Bag
    {
        <nonord_member_commalist>
    }

    token nonord_member_commalist
    {
        '{' <sp>? <member_commalist> <sp>? '}'
    }

    token member_commalist
    {
        [<single_member> | <multiplied_member> | '']+ % [<sp>? ',' <sp>?]
    }

    token single_member
    {
        <member>
    }

    token multiplied_member
    {
        <member> <sp>? ':' <sp>? <multiplicity>
    }

    token member
    {
        <Any>
    }

    token multiplicity
    {
        <compact_nonsigned_int>
    }

###########################################################################

    token Mix
    {
        <mix_nonord_member_commalist>
    }

    token mix_nonord_member_commalist
    {
        '{' <sp>? <mix_member_commalist> <sp>? '}'
    }

    token mix_member_commalist
    {
        [<mix_single_member> | <mix_multiplied_member> | '']+ % [<sp>? ',' <sp>?]
    }

    token mix_single_member
    {
        <member>
    }

    token mix_multiplied_member
    {
        <member> <sp>? ':' <sp>? <mix_multiplicity>
    }

    token mix_multiplicity
    {
        <Fraction> | <Integer>
    }

###########################################################################

    token Interval
    {
        '\\..' <ws>? '{' <sp>? <interval_members> <sp>? '}'
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
        <interval_low>? <interval_boundary_kind> <interval_high>?
    }

    token interval_low
    {
        <Any>
    }

    token interval_high
    {
        <Any>
    }

    token interval_boundary_kind
    {
        '..' | '-..' | '..-' | '-..-'
    }

###########################################################################

    token Interval_Set
    {
        '\\?..' <ws>? <nonord_interval_commalist>
    }

###########################################################################

    token Interval_Bag
    {
        '\\+..' <ws>? <nonord_interval_commalist>
    }

    token nonord_interval_commalist
    {
        '{' <sp>? <interval_commalist> <sp>? '}'
    }

    token interval_commalist
    {
        [<single_interval> | <multiplied_interval> | '']+ % [<sp>? ',' <sp>?]
    }

    token single_interval
    {
        <interval_members>
    }

    token multiplied_interval
    {
        <interval_members> <sp>? ':' <sp>? <multiplicity>
    }

###########################################################################

    token Tuple
    {
        '(' <sp>? <attr_commalist> <sp>? ')'
    }

    token attr_commalist
    {
        [<anon_attr> | <named_attr> | <nested_named_attr> | '']+ % [<sp>? ',' <sp>?]
    }

    token anon_attr
    {
        <attr_asset>
    }

    token named_attr
    {
        <attr_name> <sp>? ':' <sp>? <attr_asset>
    }

    token nested_named_attr
    {
        <nesting_attr_names> <sp>? ':' <sp>? <attr_asset>
    }

    token attr_asset
    {
        <Any>
    }

###########################################################################

    token Tuple_Array
    {
        '\\~%' <ws>? [<heading_attr_names> | <ord_member_commalist>]
    }

###########################################################################

    token Relation
    {
        '\\?%' <ws>? [<heading_attr_names> | <nonord_member_commalist>]
    }

###########################################################################

    token Tuple_Bag
    {
        '\\+%' <ws>? [<heading_attr_names> | <nonord_member_commalist>]
    }

###########################################################################

    token Calendar_Time
    {
        '\\@%' <ws>? '(' <ws>? <time_ymdhms> <ws>? ')'
    }

    token time_ymdhms
    {
        <time_ymd> <ws>? ',' <ws>? <time_hms>
    }

    token time_ymd
    {
        <year>? <ws>? ',' <ws>? <month>? <ws>? ',' <ws>? <day>?
    }

    token time_hms
    {
        <hour>? <ws>? ',' <ws>? <minute>? <ws>? ',' <ws>? <second>?
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
        '\\@+' <ws>? '(' <ws>? <time_ymdhms> <ws>? ')'
    }

###########################################################################

    token Calendar_Instant
    {
        '\\@' <ws>?
        '(' <ws>?
            <instant_base> [<ws>? '@' <ws>? [<instant_offset> | <instant_zone>]]?
        <ws>? ')'
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
        '\\@@' <ws>?
        '(' <ws>?
            [[<longitude> | <latitude> | <elevation>]* % [<ws>? ',' <ws>?]]
        <ws>? ')'
    }

    token longitude
    {
        '>' <ws>? <loc_multiplicity>
    }

    token latitude
    {
        '^' <ws>? <loc_multiplicity>
    }

    token elevation
    {
        '+' <ws>? <loc_multiplicity>
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
        '\\*' <ws>? <nesting_attr_names>
    }

###########################################################################

    token Excuse
    {
        <generic_excuse> | <singleton_excuse>
    }

    token generic_excuse
    {
        '\\!' <ws>? <label_attrs_pair>
    }

    token singleton_excuse
    {
        '\\!' <ws>? <nesting_attr_names>
    }

###########################################################################

    token Ignorance
    {
        '\\!!' <ws>? Ignorance
    }

###########################################################################

    token Nesting
    {
        '\\' <ws>? <nesting_attr_names>
    }

    token nesting_attr_names
    {
        <attr_name>+ % [<ws>? '::' <ws>?]
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
        '\\\$' <ws>? <heading_attr_names>
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
        '\\\$:' <ws>?
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
