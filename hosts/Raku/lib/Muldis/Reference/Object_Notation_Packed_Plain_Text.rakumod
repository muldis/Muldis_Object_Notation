###########################################################################
###########################################################################

module Muldis::Reference::Object_Notation_Packed_Plain_Text
{
    sub extract_MUON_from_Text(Str:D $text)
    {
        return Muldis::Reference::Object_Notation_Packed_Plain_Text::Grammar.parse(
            $text,
            :token<Muldis_Object_Notation_Packed_Plain_Text>,
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
        <[ \x[0]..\x[FF] ] - [`]>*
        '`'
        <!before Muldis_Object_Notation_Sync_Mark '`'>
    }

###########################################################################

    token Any
    {
          <Ignorance>
        | <Boolean>
        | <Integer>
        | <Fraction>
        | <Bits>
        | <Blob>
        | <Text>
        | <Nesting>
        | <Duo>
        | <Lot>
        | <Kit>
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
          <Integer_nonsigned>
        | <Integer_negative_one>
        | <Integer_unlimited_negative>
        | <Integer_limited_signed_1_octet>
        | <Integer_limited_signed_2_octets>
        | <Integer_limited_signed_4_octets>
        | <Integer_limited_signed_8_octets>
    }

    token Integer_nonsigned
    {
          <Integer_zero>
        | <Integer_positive_one_thru_nine>
        | <Integer_positive_ten>
        | <Integer_positive_eleven>
        | <Integer_positive_twelve>
        | <Integer_positive_one_hundred>
        | <Integer_positive_one_thousand>
        | <Integer_unlimited_positive>
        | <Integer_limited_nonsigned_1_octet>
        | <Integer_limited_nonsigned_2_octets>
        | <Integer_limited_nonsigned_4_octets>
        | <Integer_limited_nonsigned_8_octets>
    }

    token Integer_zero
    {
        0
    }

    token Integer_positive_one_thru_nine
    {
        <Integer_positive_one_thru_eight> | 9
    }

    token Integer_positive_one_thru_eight
    {
        <[ 1..8 ]>
    }

    token Integer_positive_ten
    {
        '$'
    }

    token Integer_positive_eleven
    {
        q
    }

    token Integer_positive_twelve
    {
        r
    }

    token Integer_positive_one_hundred
    {
        '%'
    }

    token Integer_positive_one_thousand
    {
        '&'
    }

    token Integer_negative_one
    {
        '#'
    }

    token Integer_unlimited_positive
    {
        '+' <sp>? <quoted_octet_string>
    }

    token Integer_unlimited_negative
    {
        '-' <sp>? <quoted_octet_string>
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
          <Fraction_zero>
        | <Fraction_positive_one>
        | <Fraction_negative_one>
        | <Fraction_2_tuple_numerator_denominator>
        | <Fraction_4_tuple_num_den_radix_exponent>
    }

    token Fraction_zero
    {
        '='
    }

    token Fraction_positive_one
    {
       '>'
    }

    token Fraction_negative_one
    {
        '<'
    }

    token Fraction_2_tuple_numerator_denominator
    {
        '/' <sp>? <numerator> <sp>? <denominator>
    }

    token Fraction_4_tuple_num_den_radix_exponent
    {
        '^' <sp>? <numerator> <sp>? <denominator> <sp>? <radix> <sp>? <exponent>
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
        <Bits_zero> | <Bits_unlimited> | <Bits_limited_1_octet>
    }

    token Bits_zero
    {
        s
    }

    token Bits_unlimited
    {
        S <sp>? <significant_final_octet_bits_count> <sp>? <quoted_octet_string>
    }

    token Bits_limited_1_octet
    {
        p <significant_final_octet_bits_count> <aescaped_octet>
    }

    token significant_final_octet_bits_count
    {
        <Integer_positive_one_thru_eight>
    }

###########################################################################

    token Blob
    {
        <Blob_zero> | <Blob_unlimited> | <Blob_limited_1_octet>
    }

    token Blob_zero
    {
        b
    }

    token Blob_unlimited
    {
        B <sp>? <quoted_octet_string>
    }

    token Blob_limited_1_octet
    {
        o <aescaped_octet>
    }

    token quoted_octet_string
    {
        <single_segment_quoted_octet_string> | <multi_segment_quoted_octet_string>
    }

    token multi_segment_quoted_octet_string
    {
        ['[' <sp>?] ~ [<sp>? ']'] <single_segment_quoted_octet_string>+ % <sp>?
    }

    token single_segment_quoted_octet_string
    {
        '"' ~ '"' <aescaped_octet>*
    }

    token aescaped_octet
    {
          <restricted_nonescaped_octet>
        | <escaped_octet_simple>
        | <restricted_escaped_octet_base_16_pair>
    }

    token restricted_nonescaped_octet
    {
        <[ \x[0]..\x[FF] ] - [ \t \n \r " \\ ` ]>
    }

    token escaped_octet_simple
    {
        '\\' <[tnrqkg]>
    }

    token restricted_escaped_octet_base_16_pair
    {
        '\\'
        <!before [09|0A|0D|22|5C|60]>
        <[ 0..9 A..F ]> ** 2
    }

###########################################################################

    token Text
    {
          <Text_zero>
        | <Text_positional_attr_name_zero_thru_thirty_one>
        | <Text_unlimited>
        | <Text_limited_1_octet>
        | <Text_limited_2_octets>
        | <Text_limited_3_octets>
        | <Text_limited_4_octets>
        | <Text_limited_5_octets>
        | <Text_limited_6_octets>
    }

    token Text_zero
    {
        t
    }

    token Text_positional_attr_name_zero_thru_thirty_one
    {
        <[ \x[0]..\x[1F] ] - [ \t\n\r ] + [ ,;: ]>
    }

    token Text_unlimited
    {
        T <sp>? <quoted_octet_string>
    }

    token Text_limited_1_octet
    {
        u <aescaped_octet>
    }

    token Text_limited_2_octets
    {
        v <aescaped_octet> ** 2
    }

    token Text_limited_3_octets
    {
        w <aescaped_octet> ** 3
    }

    token Text_limited_4_octets
    {
        x <aescaped_octet> ** 4
    }

    token Text_limited_5_octets
    {
        y <aescaped_octet> ** 5
    }

    token Text_limited_6_octets
    {
        z <aescaped_octet> ** 6
    }

###########################################################################

    token Nesting
    {
        <Nesting_unlimited> | <Nesting_limited_1_element>
    }

    token Nesting_unlimited
    {
        N <sp>? [['[' <sp>?] ~ [<sp>? ']'] <Text>+ % <sp>?]
    }

    token Nesting_limited_1_element
    {
        n <Text>
    }

###########################################################################

    token Duo
    {
        D <sp>? <this_and_that>
    }

    token this_and_that
    {
        <this> <sp>? <that>
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
          <Lot_zero>
        | <Lot_unlimited>
        | <Lot_unlimited_non_multiplied>
        | <Lot_limited_1_member>
    }

    token Lot_zero
    {
        l
    }

    token Lot_unlimited
    {
        L <sp>? [['[' <sp>?] ~ [<sp>? ']'] <multiplied_member>* % <sp>?]
    }

    token Lot_unlimited_non_multiplied
    {
        M <sp>? [['[' <sp>?] ~ [<sp>? ']'] <member>* % <sp>?]
    }

    token Lot_limited_1_member
    {
        m <member>
    }

    token multiplied_member
    {
        <member> <sp>? <multiplicity>
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
          <Kit_zero>
        | <Kit_unlimited>
        | <Kit_unlimited_positional>
        | <Kit_limited_1_attr>
    }

    token Kit_zero
    {
        k
    }

    token Kit_unlimited
    {
        K <sp>? [['[' <sp>?] ~ [<sp>? ']'] <kit_attr>* % <sp>?]
    }

    token Kit_unlimited_positional
    {
        J <sp>? [['[' <sp>?] ~ [<sp>? ']'] <attr_asset>* % <sp>?]
    }

    token Kit_limited_1_attr
    {
        a <kit_attr>
    }

    token kit_attr
    {
        <attr_name> <sp>? <attr_asset>
    }

    token attr_name
    {
        <Text>
    }

    token attr_asset
    {
        <Any>
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
