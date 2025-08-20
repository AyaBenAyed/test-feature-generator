@smoke @62x @00x @dx8000 @ex8000 @dx4000 @rx5000 @rx7000

Feature: Generated Feature File
"""
 This test case validates On-demand MSR Credit Signature Transaction
 TestLink test case link: 
"""

Scenario: Validate MSR Signature Transaction

Given Latest ARC build should be loaded into the terminal. Latest RBATT installed on the system. Terminal is connected to RBATT over any of the valid comm type. Set Arc/emv/enabled = true  i,e Send command 60.Arc/emv/enabled[GS]true Set Arc/cless/mode=9 i.e Send command 60.Arc/cless/mode[GS]9


When I send 13.x amout --> 13.500[GS]


Then I receive 13.0


When I send 23.x Card read request message with Magnetic stripe reader enabled --> 23.312[FS][FS][FS]M


Then Terminal displays "Please slide card" screen with all readers enabled


When Perform Good Swipe with MSR card of all 3 track data


Then Terminal returns 23.0M with all 3 Track data for Good MSR read where 0 - Good Read , M - MSR, Track 1 data, Track 2 data, track 3 data.


When I send 29.x Get variable 398 ( Card read On-demand Account Number) --> 29.00000398


Then Terminal successfully responds with "On-demand Account number data" for 23.x message.


When I send 29.x Get variable 399 ( Card read On-demand Account NAME) --> 29.00000399


Then Terminal successfully responds with "On-demand Account NAME" for 23.x message.


When I send 29.x Get variable 400 ( Card read On-demand Expiration Date) --> 29.00000400


Then Terminal successfully responds with "On-demand Expiration Date)" for 23.x message.


When I send Confirmation_amout form via 24.x command --> 24.confirmation_amount[FS]Ttitle,10


Then Terminal displays "Amount OK ?  $5.00" message with YES, NO and CANCEL buttons


When Click on YES button (YES Button on the form/screen)


Then Terminal returns 24.0[US]btn_enter response


When I send 20.165[FS]SIGN.K3Z


Then Terminal displays Signature form "Please sign and press OK "with CANCEL and CLEAR buttons.


When Preform a signature


Then Button 'OK' will appear


When I press 'Ok' button


Then Terminal sends the response "20.0x" 0 - Enter Key Pressed x* - Data Input field ( Data field should vary depending on the size of the signature )


When I send 29.x Get variable 700 to get Signature Block 1 --> 29.00000700


Then Terminal sends the successful Signature Block1 data. <-- 29.20000700`&TA \? ^3_!Y _& _'  , "X !@!&I  !!$$ #, !+ " _"Z  !_"Z !!_ Q_ ]  !_ \  "__]__9_^<   _]>_^J_^W ]( _# ]? ]M _,!]3 ^G!^%!]V   "^  _Z!^/"^- _E!_B!_Q _?"_1 _]!_/"_&  (" !! 2  R" .  J! 6!!H  1!!T  U!!"!"9




