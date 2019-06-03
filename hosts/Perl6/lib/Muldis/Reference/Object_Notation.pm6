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
        <sp>
            <Any>
        <sp>
    }

    token sp
    {
        [<whitespace> | <quoted_sp_comment_str> | <entity_marker>]*
    }

    token whitespace
    {
        [' ' | '\t' | '\n' | '\r']+
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
        ['\\?' <sp>]? [False | True]
    }

###########################################################################

    token Integer
    {
        ['\\+' <sp>]? <asigned_int>
    }

    token asigned_int
    {
        <[+-]>? <nonsigned_int>
    }

    token nonsigned_int
    {
          [0b    <sp> [<[ 0..1           ]>+]+ % [_ | <sp>]]
        | [0o    <sp> [<[ 0..7           ]>+]+ % [_ | <sp>]]
        | [[0d]? <sp> [<[ 0..9           ]>+]+ % [_ | <sp>]]
        | [0x    <sp> [<[ 0..9 A..F a..f ]>+]+ % [_ | <sp>]]
    }

###########################################################################

    token Fraction
    {
        ['\\/' <sp>]? <asigned_frac>
    }

    token asigned_frac
    {
        <significand> [<sp> '*' <sp> <radix> <sp> '^' <sp> <exponent>]?
    }

    token significand
    {
        <asigned_radix_point_sig> | <num_den_sig>
    }

    token asigned_radix_point_sig
    {
        <[+-]>? <nonsigned_radix_point_sig>
    }

    token nonsigned_radix_point_sig
    {
          [0b    <sp> [[<[ 0..1           ]>+]+ % [_ | <sp>]] ** 2 % [<sp> '.' <sp>]]
        | [0o    <sp> [[<[ 0..7           ]>+]+ % [_ | <sp>]] ** 2 % [<sp> '.' <sp>]]
        | [[0d]? <sp> [[<[ 0..9           ]>+]+ % [_ | <sp>]] ** 2 % [<sp> '.' <sp>]]
        | [0x    <sp> [[<[ 0..9 A..F a..f ]>+]+ % [_ | <sp>]] ** 2 % [<sp> '.' <sp>]]
    }

    token num_den_sig
    {
        <numerator> <sp> '/' <sp> <denominator>
    }

    token numerator
    {
        <asigned_int>
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
        <asigned_int>
    }

###########################################################################

    token Bits
    {
        '\\~?' <sp> [['"' <[ 0..1 _ ]>* '"']+ % <sp>]
    }

###########################################################################

    token Blob
    {
        '\\~+' <sp> [['"' [<[ 0..9 A..F a..f ]> ** 2 | _]* '"']+ % <sp>]
    }

###########################################################################

    token Text
    {
        <quoted_text> | <code_point_text>
    }

    token quoted_text
    {
        ['\\~' <sp>]? <quoted_text_no_pfx>
    }

    token quoted_text_no_pfx
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
        '\\~' <sp> <code_point>
    }

    token code_point
    {
        <nonsigned_int>
    }

###########################################################################

    token Array
    {
        ['\\~' <sp>]? <ord_member_commalist>
    }

    token ord_member_commalist
    {
        '[' <sp> <member_commalist> <sp> ']'
    }

###########################################################################

    token Set
    {
        ['\\?' <sp>]? <nonord_member_commalist>
    }

###########################################################################

    token Bag
    {
        ['\\+' <sp>]? <nonord_member_commalist>
    }

    token nonord_member_commalist
    {
        '{' <sp> <member_commalist> <sp> '}'
    }

    token member_commalist
    {
        [<single_member> | <multiplied_member> | '']+ % [<sp> ',' <sp>]
    }

    token single_member
    {
        <member>
    }

    token multiplied_member
    {
        <member> <sp> ':' <sp> <multiplicity>
    }

    token member
    {
        <Any>
    }

    token multiplicity
    {
        <nonsigned_int>
    }

###########################################################################

    token Mix
    {
        ['\\/' <sp>]? <mix_nonord_member_commalist>
    }

    token mix_nonord_member_commalist
    {
        '{' <sp> <mix_member_commalist> <sp> '}'
    }

    token mix_member_commalist
    {
        [<mix_single_member> | <mix_multiplied_member> | '']+ % [<sp> ',' <sp>]
    }

    token mix_single_member
    {
        <member>
    }

    token mix_multiplied_member
    {
        <member> <sp> ':' <sp> <mix_multiplicity>
    }

    token mix_multiplicity
    {
        <asigned_frac> | <asigned_int>
    }

###########################################################################

    token Interval
    {
        '\\..' <sp> '{' <sp> <interval_members> <sp> '}'
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
        '\\?..' <sp> <nonord_interval_commalist>
    }

###########################################################################

    token Interval_Bag
    {
        '\\+..' <sp> <nonord_interval_commalist>
    }

    token nonord_interval_commalist
    {
        '{' <sp> <interval_commalist> <sp> '}'
    }

    token interval_commalist
    {
        [<single_interval> | <multiplied_interval> | '']+ % [<sp> ',' <sp>]
    }

    token single_interval
    {
        <interval_members>
    }

    token multiplied_interval
    {
        <interval_members> <sp> ':' <sp> <multiplicity>
    }

###########################################################################

    token Tuple
    {
        ['\\%' <sp>]? '(' <sp> <attr_commalist> <sp> ')'
    }

    token attr_commalist
    {
        [<anon_attr> | <named_attr> | <nested_named_attr> | '']+ % [<sp> ',' <sp>]
    }

    token anon_attr
    {
        <attr_asset>
    }

    token named_attr
    {
        <attr_name> <sp> ':' <sp> <attr_asset>
    }

    token nested_named_attr
    {
        <nesting_attr_names> <sp> ':' <sp> <attr_asset>
    }

    token attr_asset
    {
        <Any>
    }

###########################################################################

    token Tuple_Array
    {
        '\\~%' <sp> [<delim_attr_name_commalist> | <ord_member_commalist>]
    }

###########################################################################

    token Relation
    {
        '\\?%' <sp> [<delim_attr_name_commalist> | <nonord_member_commalist>]
    }

###########################################################################

    token Tuple_Bag
    {
        '\\+%' <sp> [<delim_attr_name_commalist> | <nonord_member_commalist>]
    }

###########################################################################

    token Calendar_Time
    {
        '\\@%' <sp> <delim_time_ymdhms_commalist>
    }

    token delim_time_ymdhms_commalist
    {
        '(' <sp> <time_ymdhms_commalist> <sp> ')'
    }

    token delim_time_ymd_commalist
    {
        '(' <sp> <time_ymd_commalist> <sp> ')'
    }

    token delim_time_hms_commalist
    {
        '(' <sp> <time_hms_commalist> <sp> ')'
    }

    token time_ymdhms_commalist
    {
        <time_ymd_commalist> <sp> ',' <sp> <time_hms_commalist>
    }

    token time_ymd_commalist
    {
        <year>? <sp> ',' <sp> <month>? <sp> ',' <sp> <day>?
    }

    token time_hms_commalist
    {
        <hour>? <sp> ',' <sp> <minute>? <sp> ',' <sp> <second>?
    }

    token year
    {
        <mix_multiplicity>
    }

    token month
    {
        <mix_multiplicity>
    }

    token day
    {
        <mix_multiplicity>
    }

    token hour
    {
        <mix_multiplicity>
    }

    token minute
    {
        <mix_multiplicity>
    }

    token second
    {
        <mix_multiplicity>
    }

###########################################################################

    token Calendar_Duration
    {
        '\\@+' <sp> <delim_time_ymdhms_commalist>
    }

###########################################################################

    token Calendar_Instant
    {
        '\\@' <sp> <delim_instant_commalist>
    }

    token delim_instant_commalist
    {
        <instant_floating> | <instant_with_offset> | <instant_with_zone>
    }

    token instant_floating
    {
        <instant_base>
    }

    token instant_base
    {
        <delim_time_ymdhms_commalist>
    }

    token instant_with_offset
    {
        '(' <sp> <instant_base> <sp> '@' <sp> <instant_offset> <sp> ')'
    }

    token instant_offset
    {
        <delim_time_hms_commalist>
    }

    token instant_with_zone
    {
        '(' <sp> <instant_base> <sp> '@' <sp> <instant_zone> <sp> ')'
    }

    token instant_zone
    {
        <quoted_text_no_pfx>
    }

###########################################################################

    token Geographic_Point
    {
        '\\@@' <sp> <delim_point_commalist>
    }

    token delim_point_commalist
    {
        '(' <sp> <point_commalist> <sp> ')'
    }

    token point_commalist
    {
        [<longitude> | <latitude> | <elevation> | '']+ % [<sp> ',' <sp>]
    }

    token longitude
    {
        '>' <sp> <mix_multiplicity>
    }

    token latitude
    {
        '^' <sp> <mix_multiplicity>
    }

    token elevation
    {
        '+' <sp> <mix_multiplicity>
    }

###########################################################################

    token Article
    {
        <generic_article> | <singleton_article>
    }

    token generic_article
    {
        ['\\*' <sp>]? <label_attrs_pair>
    }

    token label_attrs_pair
    {
        '(' <sp> <label> <sp> ':' <sp> <attrs> <sp> ')'
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
        '\\*' <sp> <nesting_attr_names>
    }

###########################################################################

    token Excuse
    {
        '\\!' <sp> [<label_attrs_pair> | <nesting_attr_names>]
    }

###########################################################################

    token Ignorance
    {
        '\\!!' <sp> Ignorance
    }

###########################################################################

    token Nesting
    {
        '\\' <sp> <nesting_attr_names>
    }

    token nesting_attr_names
    {
        <attr_name>+ % [<sp> '::' <sp>]
    }

    token attr_name
    {
        <nonord_attr_name> | <ord_attr_name>
    }

    token nonord_attr_name
    {
        <nonord_nonquoted_attr_name> | <quoted_text_no_pfx>
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
        '\\\$' <sp> <delim_attr_name_commalist>
    }

    token delim_attr_name_commalist
    {
        '(' <sp> <attr_name_commalist> <sp> ')'
    }

    token attr_name_commalist
    {
        [<attr_name> | <ord_attr_name_range> | '']+ % [<sp> ',' <sp>]
    }

    token ord_attr_name_range
    {
        <min_ord_attr> <sp> '..' <sp> <max_ord_attr>
    }

    token min_ord_attr
    {
        <ord_attr_name>
    }

    token max_ord_attr
    {
        <ord_attr_name>
    }

###########################################################################

    token Renaming
    {
        '\\\$:' <sp> <delim_renaming_commalist>
    }

    token delim_renaming_commalist
    {
        '(' <sp> <renaming_commalist> <sp> ')'
    }

    token renaming_commalist
    {
        [<anon_attr_rename> | <named_attr_rename> | '']+ % [<sp> ',' <sp>]
    }

    token anon_attr_rename
    {
          ['->' <sp> <attr_name_after>]
        | [<attr_name_after> <sp> '<-']
        | [<attr_name_before> <sp> '->']
        | ['<-' <sp> <attr_name_before>]
    }

    token named_attr_rename
    {
          [<attr_name_before> <sp> '->' <sp> <attr_name_after>]
        | [<attr_name_after> <sp> '<-' <sp> <attr_name_before>]
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
