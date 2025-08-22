@smoke @62x @00x @dx8000 @ex8000 @dx4000 @rx5000 @rx7000

Feature: Generated Feature File
"""
 This test is to validate all On-demand messages.
 TestLink test case link: 
"""

Scenario: Validate On-Demand messages

Given Latest ARC build should be loaded into the terminal. Latest RBATT installed on the system. Terminal is connected to RBATT over any of the valid comm type.


When I send offline message 00.0000


Then Terminal displays "This Lane Closed" and returns the response 00.0000


When I send  24.activity_main from RBA testapp


Then Terminal will display "This Lane Closed" Screen


When I send 21.00110214[FS]1[FS]input_numeric


Then Terminal displays "Home phone Number" with input text box.


When Input the Phone number and press Enter key.


Then Negative Validation-User input of less than Minimum length and more than Maximum length should show in-line message. Positive Validation - Phone number of 1-10 digits should be accepted (with more than minimum input length and less than or equal to maximum input length) should be accepted. Terminal should send the 21.x response to POS 0 : Enter Pressed XXXX : Data input Terminal keeps display the same form until next command.


When I send 23.x Card read request with all readers enable i.e --> 23.3[FS][FS][FS]CMS


Then Terminal displays "Please slide card" prompt with all readers enable .


When DO NOT swipe/Insert/Tap. Send 24.activity_main .


Then All readers should be disabled. All LEDs should be off. Terminal should not send the response by Swiping/Inserting/Tapping the card. Terminal displaying the Prompt "Welcome"


When I send 27.ALPHA INPUT Request message with Prompt Index 16 with : Minimum input length =0 Maximum input length=40 Prompt index number = 16 format specifier1 --> 27.0004016[FS]1[FS]Input_alpha


Then Terminal displays alpha-nuemric key board with ptompt "Please Enter Cashback" .


When Input the cashback amount ( with digits and characters ) and press Enter key.


Then User should be able to enter digits and Characters of within the Min/Max limits. Terminal should send the 27.x response to POS with 0 (Enter Pressed) and Data Input. i.e 27.0XXXXXXXXX. Terminal keeps display the same form until next command.


When I send 23.x Card read request with all readers enable i.e --> 23.3[FS][FS][FS]CMS


Then Terminal displays "Please slide card" prompt with all readers enable .


When Swipe an MSR card


Then Terminal send 23.0M response with Track data  for Good MSR read. i.e  <-- 23.0MB4506445006931933^UAT USA/TEST CARD 11      ^2212220162907400001000000000000[FS]4506445006931933=22122200162907400001[FS] Terminal sends 23.1M for Bad MSR read i.e <--  23.1M[FS][FS]


When I send 31.x Pin Entry request message with previous swiped account number. --> 31.**1[FS]6510000000000331


Then Terminal displays Pin Entry input box with prompt " Please enter PIN"


When Input the PIN and press Enter


Then Terminal sends 31.x response to POS with 0 ( PIN entered) and PIN data <-- 31.0DCCA90D4C414BB02FFFF12345678000000B3 Terminal keeps display the PIN Entry form with Clear text box until next command.


When I send all the below Ondemand messages one after another from Testapp. DO NOT perform any action on the terminal 24.activity_main 21.00040214[FS]1[FS]input_numeric 23.3[FS][FS][FS]CMS 24.activity_main 27.0004016[FS]1[FS]Input_alpha 23.3[FS][FS][FS]CMS


Then Each respective Ondemand message should keep display on the terminal with respective Forms and prompts until next on-demand message. Terminal should NOT reboot.




