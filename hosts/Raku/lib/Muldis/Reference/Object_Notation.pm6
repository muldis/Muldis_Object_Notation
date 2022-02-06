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
        '`' ~ '`' <-[`]>*
    }

###########################################################################

    token Any
    {
        <generic_group> | <simple_primary> | <collective_primary>
    }

    token generic_group
    {
        ['(' <sp>?] ~ [<sp>? ')'] <Any>
    }

    token simple_primary
    {
          <Ignorance>
        | <Boolean>
        | <Integer>
        | <Fraction>
        | <Bits>
        | <Blob>
        | <Text>
        | <Nesting>
    }

    token collective_primary
    {
          <Duo>
        | <Lot>
        | <Kit>
        | <Article>
        | <Excuse>
    }

###########################################################################

    token Ignorance
    {
        0sIGNORANCE
    }

###########################################################################

    token Boolean
    {
        0b [FALSE | TRUE]
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
        <Integer_nonsigned>
    }

    token radix
    {
        <Integer_nonsigned>
    }

    token exponent
    {
        <Integer>
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
        <quoted_text> | <nonquoted_alphanumeric_text> | <code_point_text>
    }

    token quoted_text
    {
        <quoted_text_segment>+ % <sp>?
    }

    token quoted_text_segment
    {
        '"' ~ '"' [<restricted_inside_char> | <escaped_char>]*
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
          [0tb  [0 | [   1            <[ 0..1      ]>+]]]
        | [0to  [0 | [<[ 1..7      ]> <[ 0..7      ]>+]]]
        | [0td? [0 | [<[ 1..9      ]> <[ 0..9      ]>+]]]
        | [0tx  [0 | [<[ 1..9 A..F ]> <[ 0..9 A..F ]>+]]]
    }

###########################################################################

    token Nesting
    {
        <nesting_unary> | <nesting_nary>
    }

    token nesting_unary
    {
        ['::' <sp>? <Text>]
    }

    token nesting_nary
    {
        ['::' <sp>?]?
        [<Text> ** 2..* % [<sp>? '::' <sp>?]]
    }

###########################################################################

    token Duo
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

    token Lot
    {
        ['{' <sp>?] ~ [<sp>? '}']
            [',' <sp>?]?
            [[<this> | <this_and_that>]* % [<sp>? ',' <sp>?]]
            [<sp>? ',']?
    }

###########################################################################

    token Kit
    {
        ['(' <sp>?] ~ [<sp>? ')'] <kit_ml_attrs>
    }

    token kit_ml_attrs
    {
        <kit_nullary> | <kit_unary> | <kit_nary>
    }

    token kit_nullary
    {
        ''
    }

    token kit_unary
    {
          [          <kit_ml_attr> <sp>? ',']
        | [',' <sp>? <kit_ml_attr> <sp>? ',']
        | [',' <sp>? <kit_ml_attr>          ]
    }

    token kit_nary
    {
        [',' <sp>?]?
        [<kit_ml_attr> ** 2..* % [<sp>? ',' <sp>?]]
        [<sp>? ',']?
    }

    token kit_ml_attr
    {
        [<ml_attr_name> <sp>? ':' <sp>?]? <ml_attr_asset>
    }

    token ml_attr_name
    {
        <Nesting> | <Text>
    }

    token ml_attr_asset
    {
        <Any>
    }

###########################################################################

    token Article
    {
        <label> <sp>? '::' <sp>? <attrs>
    }

    token label
    {
        <Nesting> | <Text>
    }

    token attrs
    {
        <Kit>
    }

###########################################################################

    token Excuse
    {
        <label> <sp>? '!!' <sp>? <attrs>
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
