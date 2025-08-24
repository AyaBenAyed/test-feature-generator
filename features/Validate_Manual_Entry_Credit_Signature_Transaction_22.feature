@smoke @62x @00x @dx8000 @ex8000 @dx4000 @rx5000 @rx7000

Feature: Generated Feature File
"""
 This test case validates On-demand Manual Entry Credit Signature Transaction
 TestLink test case link: 
"""

Scenario: Validate Manual Entry Credit Signature Transaction

Given Latest ARC build should be loaded into the terminal. Latest RBATT installed on the system. Terminal is connected to RBATT over any of the valid comm type. Set 0007_0029 = 1


When I send Offline message 00.0000


Then Terminal displays "This Lane Closed" and returns the response 00.0000


When I send 13.x amount --> 13.1000[GS]


Then Amount sent to terminal and 13.0 received


When I send 23.x Card read request message with MSR and SCR enabled --> 23.312[FS][FS][FS]MS


Then Terminal displays "Insert, Swipe or Tap Card" screen with all readers enabled and with ENETR CARD button enable for manual entry


When I send 28. Set variable 104 with "Total amount -------- $10.00" --> 28.10000104Item 1........................................................................................$10,00


Then Terminal should display "Total Amount ..............$10.00 Terminal sends the response "28.20000104" with 2 (successful) amd 000104 (Scrolling line display)


When Click on ENTER CARD button


Then Terminal should display "Enter Card Number" with Input text box.


When Input a valid card number, expty date and cvv then press Enter button on the terminal


Then Terminal sends the successful card data to POS <-- 23.0H4566896388521456^MANUALLY/ENTERED^2812000000123000000[FS]4566896388521456=2812000000123000[FS]


When I send 29.x Get variable 398 ( Card read On-demand Account Number) -->  29.00000398


Then Terminal successfully responds with "On-demand Account number data" for 23.x message. <-- [09:24:43] 29.200003984566896388521456

| Tag | Value |
| 09 | 24 |

When I send 29.x Get variable 400 ( Card read On-demand Expiration Date) -->  29.00000400


Then Terminal successfully responds with "On-demand Expiration Date)" for 23.x message. <-- 29.200004002812


When I send 15.8 command


Then Line item display should be cleared on the terminal.


When I send Confirmation_amout form via 24.x command --> 24.confirmation_amount[FS]Ttitle,10


Then Terminal displays "Amount OK ?  $10.00" message with YES, NO and CANCEL buttons


When Click on YES button


Then Terminal returns 24.0[US]btn_enter response


When I send 20.165[FS]SIGN.K3Z


Then Terminal displays Signature form "Please sign and press OK "with CANCEL and CLEAR buttons.


When Preform a signature


Then Button 'OK' will appear


When I press 'Ok' button


Then Terminal sends the response "20.0x" 0 - Enter Key Pressed x* - Data Input field ( Data field should vary depending on the size of the signature )


When I send 29.x Get variable 712 to get Signature number of blocks <-- 29.20000712


Then Terminal sends the nuber of blocks of signature performed <-- 29.200007122


When I send 29.x Get variable 700 to get Signature Block 1 --> 29.00000700


Then Terminal sends the successful Signature Block1 data. <-- 29.20000700`&TA \? ^3_!Y _& _'  , "X !@!&I  !!$$ #, !+ " _"Z  !_"Z !!_ Q_ ]  !_ \  "__]__9_^<   _]>_^J_^W ]( _# ]? ]M _,!]3 ^G!^%!]V   "^  _Z!^/"^- _E!_B!_Q _?"_1 _]!_/"_&  (" !! 2  R" .  J! 6!!H  1!!T  U!!"!"9




