###########################################################################
###########################################################################

module Muldis::Reference::Object_Notation_Packed_Plain_Text
{
    sub extract_MUON_from_Text(Str:D $text)
    {
        return Muldis::Reference::Object_Notation_Packed_Plain_Text::Grammar.parse(
            $text,
            :token<MUON>,
            :actions(Muldis::Reference::Object_Notation_Packed_Plain_Text::Actions.new())
        );
    }
}

###########################################################################
###########################################################################

grammar Muldis::Reference::Object_Notation_Packed_Plain_Text::Grammar
{

###########################################################################

    token Muldis_Object_Notation_Packed_Plain_Text
    {
        <sp>? ~ <sp>? <Any>
    }

###########################################################################

    token sp
    {
        '`' ~ '`' <[ \x[0]..\x[FF] ] - [`]>*
    }

###########################################################################

    token Any
    {
        <simple_primary> | <collective_primary>
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
        _
    }

###########################################################################

    token Boolean
    {
        <Boolean_false> | <Boolean_true>
    }

    token Boolean_false
    {
        '!'
    }

    token Boolean_true
    {
        '?'
    }

###########################################################################

    token Integer
    {
          <Integer_zero>
        | <Integer_positive_one_thru_nine>
        | <Integer_negative_one>
        | <Integer_unlimited_positive>
        | <Integer_unlimited_negative>
        | <Integer_limited_nonsigned_1_octet>
        | <Integer_limited_signed_1_octet>
        | <Integer_limited_nonsigned_2_octets>
        | <Integer_limited_signed_2_octets>
        | <Integer_limited_nonsigned_4_octets>
        | <Integer_limited_signed_4_octets>
        | <Integer_limited_nonsigned_8_octets>
        | <Integer_limited_signed_8_octets>
    }

    token Integer_zero
    {
        0
    }

    token Integer_positive_one_thru_nine
    {
        <[ 1..9 ]>
    }

    token Integer_negative_one
    {
        '.'
    }

    token Integer_unlimited_positive
    {
        '+' <quoted_octet_string>
    }

    token Integer_unlimited_negative
    {
        '-' <quoted_octet_string>
    }

    token Integer_limited_nonsigned_1_octet
    {
        c <aescaped_octet>
    }

    token Integer_limited_signed_1_octet
    {
        d <aescaped_octet>
    }

    token Integer_limited_nonsigned_2_octets
    {
        e <aescaped_octet> ** 2
    }

    token Integer_limited_signed_2_octets
    {
        f <aescaped_octet> ** 2
    }

    token Integer_limited_nonsigned_4_octets
    {
        g <aescaped_octet> ** 4
    }

    token Integer_limited_signed_4_octets
    {
        h <aescaped_octet> ** 4
    }

    token Integer_limited_nonsigned_8_octets
    {
        i <aescaped_octet> ** 8
    }

    token Integer_limited_signed_8_octets
    {
        j <aescaped_octet> ** 8
    }

###########################################################################

    token Fraction
    {
        TODO
    }

###########################################################################

    token Bits
    {
        TODO
    }

###########################################################################

    token Blob
    {
        TODO
    }

    token quoted_octet_string
    {
        '"' ~ '"' <aescaped_octet>*
    }

    token aescaped_octet
    {
        <nonescaped_octet> | <escaped_octet>
    }

    token nonescaped_octet
    {
        <[ \x[0]..\x[FF] ] - [ "`\\ ]>
    }

    token escaped_octet
    {
        '\\' <[qgb]>
    }

###########################################################################

    token Text
    {
        TODO
    }

###########################################################################

    token Nesting
    {
        TODO
    }

###########################################################################

    token Duo
    {
        TODO
    }

###########################################################################

    token Lot
    {
        TODO
    }

###########################################################################

    token Kit
    {
        TODO
    }

###########################################################################

    token Article
    {
        TODO
    }

###########################################################################

    token Excuse
    {
        TODO
    }

###########################################################################

}

###########################################################################
###########################################################################

class Muldis::Reference::Object_Notation_Packed_Plain_Text::Actions
{
}

###########################################################################
###########################################################################
