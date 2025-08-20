@smoke @62x @00x @dx8000 @ex8000 @dx4000 @rx5000 @rx7000

Feature: Generated Feature File
"""
 This test case validates On-demand MSR Debit CashBack Transaction
 TestLink test case link: 
"""

Scenario: Validate MSR CashBack Transaction

Given Set 0019_0001=1 & 0008_0001=9 Use the card with PIN


When I send 13.x --> 13.5000[GS]


Then Amount Sent and 13.0 received


When I send 23.x Card read request message with all readers enable --> 23.312[FS][FS][FS]CMS


Then Terminal displays "Insert, Swipe or Tap Card" screen with all readers enabled


When I send 28. Set variable 104 with "Total amount -------- $50.00" --> 28.10000104Item 1........................................................................................$50,00


Then Terminal should display "Total Amount ..............$50.00 Terminal sends the response "28.20000104" with 2 (successful) amd 000104 (Scrolling line display)


When Perform Good Swipe with MSR card of all 3 track data


Then Terminal sends 23.0M with all 3 Track data for Good MSR read where 0 - Good Read , M - MSR, Track 1 data, Track 2 data, track 3 data.


When I send 29.x Get variable 398 ( Card read On-demand Account Number) --> 29.00000398


Then I send 29.x Get variable 398 ( Card read On-demand Account Number) --> 29.00000398


When I send 29.x Get variable 399 ( Card read On-demand Account NAME) --> 29.00000399


Then Terminal successfully responds with "On-demand Account NAME" for 23.x message.


When I send 29.x Get variable 400 ( Card read On-demand Expiration Date) --> 29.00000400


Then Terminal successfully responds with "On-demand Expiration Date)" for 23.x message.


When I send 15.8 command


Then Line item display should be cleared on the terminal.


When I send menu_select_cashback_amount form via 35.x and put different amounts as items --> 35.menu_select_cashback_amount[FS]15[FS]1[FS]$20[FS]$40[FS]$80[FS]$100[FS]Other [FS]


Then Terminal displays Cashback ? $20 $40 $80 $100 with 'OK', 'NO' and 'CANCEL' buttons


When I select one of the choice $20 / $40 / $80 / $100 /Other then press 'YES'


Then Terminal sends 35.0x response for the selection of cashback.


When I send 31.x with command with account number from variable 398. NOTE: Don't forget to change the card number below --> 31.**1[FS]5318031101556703


Then Terminal displays "Please Enter PIN"


When Input the PIN and click on the Green button


Then Terminal sends 31.x response to POS with 0 ( PIN entered) and PIN data <-- 31.00163341341C14FAAFFFF123456780000009D Terminal keeps display the " Pin Entry form with Clear text box" until next command.




