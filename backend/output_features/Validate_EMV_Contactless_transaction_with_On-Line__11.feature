@smoke @62x @00x @dx8000 @ex8000 @dx4000 @rx5000 @rx7000

Feature: Generated Feature File
"""
 This testcase validates EMV Contactless transaction with On-line PIN verification.
 TestLink test case link: 
"""

Scenario: Validate EMV Contactless transaction with On-Line PIN verification

Given Latest ARC build loaded into the terminal. Keys are injected. Latest RBATT installed on the system. Terminal is connected to RBATT over any of the valid comm type. Enable Cless (8_1=9).


When I send 15.9 command


Then This commands Clears the Previous card data,and preserves the state by displaying the previous form.


When I send 13.x amount i.e Send 13.1700


Then I receive 13.0 response


When I send 23.x Card read request with Contactless reader enable ( or All readers enable). i.e -->23.311[FS][FS][FS]C or 23.311[FS][FS][FS]CMS


Then Terminal displays "Insert, Swipe or Tap Card" with Contactless reader enable (or all readers enable).


When Tap any Physical Online-PIN CVM B2-DI card or Run Collis Online PIN-CVM test case


Then Terminal sends 23. Card response with 0= Good Read E =EMV Contactless Track 1 and/or 2 and/or 3 data. <-- 23.0E[FS]6510000000000133=23122011000074900000[FS]


When Wait for Terminal sending 33.02 message Validate all the tags in 33.02 message


Then Terminal sends 33.02 message to ECR/POS with tags Tag50, Tag 57, Tag 5A, Tag 84, Tag 5F24, Tag 5F28, Tag 5F34, Tag 9F07, Tag 9F1A, Tag 9F1E, Tag 9F42, Tag 9F6E, D-Tags 1002,101B,101C,101D


When I verify if terminal prompts for PIN.


Then Terminal displays "Please enter your PIN", Becase the transaction amount is greater than CVM required limit


When Input the valid PIN and press ENTER


Then Terminal accepts the PIN.


When Wait for Terminal sending 33.03.0000 (Authorization request Incoming) message to ECR/POS


Then Terminal sends 33.03.0000 (Authorization request Incoming) message to ECR/POS with all the required tags for Host Authorization. Terminal displays " Authorizing ..Please wait...Do not remove card" message.


When Terminal waits for 33.04.0000 ( Host/RBA Testapp Authorization reponse) message. Send 33.04.0000 message with Tag 8A=00( Online Approval) from the RBA Testapp to the terminal .


Then Terminal send 33.05.000 (Authorization Confirmation Incoming" with all the tags and the Terminal displays "Approved" message.


When Validate 33.03 & 33.05 message with all the tags


Then Pinpad should transmit all the necessary & required EMV tags to POS/Testapp. Refer conflunce page [https://ussnprdevapp5:8443/display/DIV351459REV503/Tags+Transmitted+in+Host+Interface+Messages]


When Validate Tag 101B for Contactless Online PIN CVM Tag 9F02 for Total Transaction Amount


Then Tag 101B present only for Contactless Online PIN CVM Tag 9F02 for Total Transaction Amount




