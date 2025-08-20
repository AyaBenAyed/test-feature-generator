@smoke @62x @00x @dx8000 @ex8000 @dx4000 @rx5000 @rx7000

Feature: Generated Feature File
"""
 This test case validates On-demand EMV Contact DEBIT-PIN CVM with Cashback transaction
 TestLink test case link: 
"""

Scenario: Validate EMV Contact Debit-PIN CVM with Cashback transaction

Given Use a Physical EMV Contact card which supports  PIN-CVM and CASHBACK ( Tag 9F07 -Application Usage Control = FFC0)


When I send Offline message 00.0000


Then Terminal displays "This Lane Closed" and returns the response 00.0000


When I send "Set Transaction Type" to Purchase/Sale i.e Send "14.01"


Then Purchase/Sale transaction initiated.


When I send 13.x amount --> 13.1000[GS]


Then Amount sent to terminal and 13.0 received


When I send 23.x Card read request message with contact reader enable --> 23.100[FS][FS][FS]S


Then Terminal displays "Please insert card" screen with contact reader enabled


When I send 28. Set variable 104 with "Total amount -------- $10.00" --> 28.10000104Item 1........................................................................................$10,00


Then Terminal should display "Total Amount ..............$10.00 Terminal sends the response "28.20000104" with 2 (successful) amd 000104 (Scrolling line display)


When Insert EMV Contact card into SCR reader


Then Terminal sends the response 23.0S for good read of EMV card. Terminal displays "Processing ....Please wait" message


When I send EMV Initiation Message 33.00.0000[FS][FS]J[FS][FS][FS] With Suspend step "J"


Then Terminal sends the response 33.00.0000 for successful EMV initiation. Because of the setting 0019_0002=1, terminal should auto select the language (mutually supported language of Card and Terminal) during EMV transaction. Because of the setting 0019_0003="2" terminal will prompt for select application via menu, without subsequent confirmation. Terminal displays "Application Label ( For ex...Discover) Please wait ...Do not remove card"


When Wait for Terminal sending 33.02.0000 message to POS/ECR. Validate the 33.02 tags


Then Terminal sends 33.02 message to ECR/POS with tags Tag 4F, Tag 50, Tag 57, Tag 5A, Tag 84, Tag 5F20, Tag 5F24, Tag 5F28, Tag 5F2D, Tag 5F30, Tag 5F34, Tag 9F07, Tag 9F09, Tag 9F1A, Tag 9F1B, Tag 9F1E, Tag 9F1F,Tag 100E


When I send "04.x Set Payment Type "Debit" message --> 04.1A


Then Wait for the response 04.0A0000


When Wait for Terminal going to suspend mode at step"J"


Then After POS/Testapp sets the payment type, terminal goes to Suspend mode at step "Get Cash back amount (J)" and sends the status <-- 33.01.0000[FS]00IS-AA--S----------------S1-J-----[FS]


When I send menu_select_cashback_amount form via 35.x and put different amounts as items -->35.menu_select_cashback_amount[FS]15[FS]1[FS]$20[FS]$40[FS]$80[FS]$100[FS]Other [FS]


Then Terminal displays Cashback ? $20 $40 $80 $100 with 'OK', 'NO' and 'CANCEL' buttons


When I select $20


Then Terminal sends the response 35.01


When I send --> 33.09.0000[FS]R[FS][FS]9 message with command type "R" (Resume and run build-in screens)


Then Terminal sends the response "33.09.000" and resumes from the Suspend flow.


When I send Amount confirmation (Second 13.x amount) with Cashback Amount. --> 13.1000[GS]2000


Then Terminal displays amount confirmation message "$10.00 + $20.00 = $30.00 Amount OK? 10.25 with YES, NO , CANCEL options


When I select YES on Amount Confirmation screen


Then Card holder conformed the amount by selecting YES


When Terminal prompts for PIN : " Please enter your PIN" Enter/Input a valid PIN


Then Terminal accepts the pin.


When Wait for Terminal sending 33.03.0000 (Authorization request Incoming) message to ECR/POS


Then Terminal sends 33.03.0000 (Authorization request Incoming) message to ECR/POS with all the required tags for Host Authorization. Terminal displays " Authorizing ..Please wait...Do not remove card" message.


When Terminal waits for 33.04.0000 ( Host/RBA Testapp Authorization reponse) message. Send 33.04.0100[FS]T8A:0002:a00[FS]


Then Pinpad send 33.05.000 (Authorization Confirmation Incoming" with all the tags and the Terminal displays "Approved" message.


When Validate 33.03 & 33.05 message with all the tags  and confirm the amount of cashback in tag 9F03


Then Terminal should transmit all the necessary & required EMV tags to POS/Testapp. Tag 9F03 value should be 000000002000




