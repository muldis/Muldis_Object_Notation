###########################################################################
###########################################################################

module Muldis::Object_Notation_Grammar_Reference::Plain_Text
{
    sub extract_MUON_from_Text(Str:D $text)
    {
        return Muldis::Object_Notation_Grammar_Reference::Plain_Text::Grammar.parse(
            $text,
            :token<Muldis_Object_Notation_Plain_Text>,
            :actions(Muldis::Object_Notation_Grammar_Reference::Plain_Text::Actions.new())
        );
    }
}

###########################################################################
###########################################################################

grammar Muldis::Object_Notation_Grammar_Reference::Plain_Text::Grammar
{

###########################################################################

    token Muldis_Object_Notation_Plain_Text
    {
        <sp>? ~ <sp>? <Any>
    }

###########################################################################

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
        '`'
        <!before Muldis_Object_Notation_Sync_Mark '`'>
        <-[`]>*
        '`'
        <!before Muldis_Object_Notation_Sync_Mark '`'>
    }

###########################################################################

    token Any
    {
          <Ignorance>
        | <Boolean>
        | <Integer>
        | <Rational>
        | <Binary>
        | <Decimal>
        | <Bits>
        | <Blob>
        | <Text>
        | <Nesting>
        | <Pair>
        | <Lot>
        | <Kit>
    }

###########################################################################

    token Ignorance
    {
        0iIGNORANCE
    }

###########################################################################

    token Boolean
    {
        0bFALSE | 0bTRUE
    }

###########################################################################

    token Integer
    {
        <[+-]>? <sp>? <Integer_nonsigned>
    }

    token Integer_nonsigned
    {
          [ 0b <sp>?   [0 | [   1            [[_ | <sp>]? <[ 0..1      ]>+]*]]]
        | [ 0o <sp>?   [0 | [<[ 1..7      ]> [[_ | <sp>]? <[ 0..7      ]>+]*]]]
        | [[0d <sp>?]? [0 | [<[ 1..9      ]> [[_ | <sp>]? <[ 0..9      ]>+]*]]]
        | [ 0x <sp>?   [0 | [<[ 1..9 A..F ]> [[_ | <sp>]? <[ 0..9 A..F ]>+]*]]]
    }

###########################################################################

    token Rational
    {
        <Rational_with_radix_point> | <Rational_with_num_den>
    }

    token Rational_with_radix_point
    {
        <[+-]>? <sp>? <Rational_with_radix_point_nonsigned>
    }

    token Rational_with_radix_point_nonsigned
    {
          [
            0b <sp>?
            [0 | [1 [[_ | <sp>]? <[ 0..1 ]>+]*]]
            [_ | <sp>]? '.'
            [[_ | <sp>]? <[ 0..1 ]>+]+
          ]
        | [
            0o <sp>?
            [0 | [<[ 1..7 ]> [[_ | <sp>]? <[ 0..7 ]>+]*]]
            [_ | <sp>]? '.'
            [[_ | <sp>]? <[ 0..7 ]>+]+
          ]
        | [
            [0d <sp>?]?
            [0 | [<[ 1..9 ]> [[_ | <sp>]? <[ 0..9 ]>+]*]]
            [_ | <sp>]? '.'
            [[_ | <sp>]? <[ 0..9 ]>+]+
          ]
        | [
            0x <sp>?
            [0 | [<[ 1..9 A..F ]> [[_ | <sp>]? <[ 0..9 A..F ]>+]*]]
            [_ | <sp>]? '.'
            [[_ | <sp>]? <[ 0..9 A..F ]>+]+
          ]
    }

    token Rational_with_num_den
    {
        <numerator> <sp>? '/' <sp>? <denominator>
    }

    token numerator
    {
        <Integer>
    }

    token denominator
    {
        <Integer_nonsigned>
    }

###########################################################################

    token Binary
    {
        <significand> <sp>? '*' <sp>? <radix_two> <sp>? '^' <sp>? <exponent>
    }

    token significand
    {
        <Rational_with_radix_point> | <Integer>
    }

    token radix_two
    {
        2
    }

    token exponent
    {
        <Integer>
    }

###########################################################################

    token Decimal
    {
        <significand> <sp>? '*' <sp>? <radix_ten> <sp>? '^' <sp>? <exponent>
    }

    token radix_ten
    {
        10
    }

###########################################################################

    token Bits
    {
          [ 0bb <sp>? [<[ 0..1      ]>+]* % [_ | <sp>]]
        | [ 0bo <sp>? [<[ 0..7      ]>+]* % [_ | <sp>]]
        | [ 0bx <sp>? [<[ 0..9 A..F ]>+]* % [_ | <sp>]]
    }

###########################################################################

    token Blob
    {
          [ 0xb <sp>? [[<[ 0..1      ]> ** 8]+]* % [_ | <sp>]]
        | [ 0xx <sp>? [[<[ 0..9 A..F ]> ** 2]+]* % [_ | <sp>]]
        | [ 0xy <sp>? [[<[ A..Z a..z 0..9 + / = ]> ** 4]+]* % [_ | <sp>]]
    }

###########################################################################

    token Text
    {
        <quoted_char_seq> | <nonquoted_alphanumeric_text> | <code_point_text>
    }

    token Text_nonqualified
    {
        <quoted_char_seq> | <nonquoted_alphanumeric_char_seq> | <code_point>
    }

    token quoted_char_seq
    {
        <quoted_char_seq_segment>+ % <sp>?
    }

    token quoted_char_seq_segment
    {
        '"' ~ '"' <aescaped_char>*
    }

    token aescaped_char
    {
          <restricted_nonescaped_char>
        | <escaped_char_simple>
        | <escaped_char_code_point>
        | <escaped_char_utf32_code_point>
        | <escaped_char_utf16_code_point>
    }

    token restricted_nonescaped_char
    {
        <-[ \x[0]..\x[1F] " \\ ` \x[7F] \x[80]..\x[9F] ]>
    }

    token escaped_char_simple
    {
        '\\' <[abtnvfreqkg]>
    }

    token escaped_char_code_point
    {
        '\\' ['(' ~ ')' <code_point>]
    }

    token code_point
    {
          [0b    [0 | [   1            <[ 0..1      ]> ** 0..20]]]
        | [0o    [0 | [<[ 1..7      ]> <[ 0..7      ]> ** 0..6 ]]]
        | [[0d]? [0 | [<[ 1..9      ]> <[ 0..9      ]> ** 0..6 ]]]
        | [0x    [0 | [<[ 1..9 A..F ]> <[ 0..9 A..F ]> ** 0..5 ]]]
    }

    token escaped_char_utf32_code_point
    {
        '\\' U00 [<[ 0..9 A..F a..f ]> ** 6]
    }

    token escaped_char_utf16_code_point
    {
        '\\' u [<[ 0..9 A..F a..f ]> ** 4]
    }

    token nonquoted_alphanumeric_text
    {
        ':' <sp>? <nonquoted_alphanumeric_char_seq>
    }

    token nonquoted_alphanumeric_char_seq
    {
        <[ A..Z _ a..z ]> <[ 0..9 A..Z _ a..z ]>*
    }

    token code_point_text
    {
        ':' <sp>? <code_point>
    }

###########################################################################

    token Nesting
    {
        <nesting_unary> | <nesting_nary>
    }

    token nesting_unary
    {
        ['::' <sp>? <Text_nonqualified>]
    }

    token nesting_nary
    {
        ['::' <sp>?]?
        [<Text_nonqualified> ** 2..* % [<sp>? '::' <sp>?]]
    }

###########################################################################

    token Pair
    {
        ['(' <sp>?] ~ [<sp>? ')'] <this_and_that>
    }

    token this_and_that
    {
        <this> <sp>? [':'|'->'] <sp>? <that>
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

    token Lot
    {
        ['[' <sp>?] ~ [<sp>? ']']
            [
                [',' <sp>?]?
                [<multiplied_member>+ % [<sp>? ',' <sp>?]]
                [<sp>? ',']?
            ]?
    }

    token multiplied_member
    {
        [<member> <sp>? [':'|'->'] <sp>? <multiplicity>] | <member>
    }

    token member
    {
        <Any>
    }

    token multiplicity
    {
        <Any>
    }

###########################################################################

    token Kit
    {
        ['{' <sp>?] ~ [<sp>? '}']
            [
                [',' <sp>?]?
                [
                      [
                        [<kit_attr_a> ** 1..32 % [<sp>? ',' <sp>?]?]
                        [<sp>? ',' <sp>? <kit_attr_na>+ % [<sp>? ',' <sp>?]]?
                      ]
                    | [<kit_attr_na>+ % [<sp>? ',' <sp>?]]
                ]
                [<sp>? ',']?
            ]?
    }

    token kit_attr_na
    {
        <attr_name> <sp>? [':'|'->'] <sp>? <attr_asset>
    }

    token kit_attr_a
    {
        <attr_asset>
    }

    token attr_name
    {
        <Text_nonqualified>
    }

    token attr_asset
    {
        <Any>
    }

###########################################################################

}

###########################################################################
###########################################################################

class Muldis::Object_Notation_Grammar_Reference::Plain_Text::Actions
{
}

###########################################################################
###########################################################################
