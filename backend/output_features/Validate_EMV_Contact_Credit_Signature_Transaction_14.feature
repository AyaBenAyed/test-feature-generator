@smoke @62x @00x @dx8000 @ex8000 @dx4000 @rx5000 @rx7000

Feature: Generated Feature File
"""
 This test case validates On-demand EMV Contact Credit Signature Transaction
 TestLink test case link: 
"""

Scenario: Validate EMV Contact Credit Signature Transaction

Given Load the latest ARC build into terminal via Axtoolkit. Connect the terminal to RBA Testapp. Set 0019_0001=1 & 0008_0001=9. Use a Physical EMV Contact card which supports Signature-CVM.


When I send offline command.


Then ARC displays offline form with "This Lane Closed" prompt.


When I send 15.9


Then Clears the Previous card data, Disables all the readers. and preserves the state by displaying the previous form.


When I send "Set Transaction Type" to Purchase/Sale i.e Send "14.01"


Then Purchase/Sale transaction initiated.


When I send 13.x Amount i.e 13.1300[GS]


Then Amount Sent from POS to terminal. i.e 13.0


When I send 23.x Card read request message with all readers enable i.e 23.3[FS][FS][FS]CMS


Then Terminal displays "Insert, Swipe or Tap Card" screen with all readers enabled


When I send 28. Set variable 104 with "Total amount -------- $13.00" i.e 28.10000104Total Amount.........................................................................................$13.00


Then Terminal should display "Total Amount ..............$13.00 Terminal sends the response "28.20000110"with : 2 (successful) 000104 (Scrolling line display)


When Insert EMV Contact card into SCR reader


Then Terminal sends the response 23.0S for good read of EMV card. Terminal displays "Processing ....Please wait" message


When I send EMV Initiation Message 33.00.0000[FS][FS]U[FS][FS][FS] with Suspend step "U"


Then Terminal sends the response 33.00.0000 for successful EMV initiation.


When Wait for ARC sending 33.02.0000 message to POS/ECR. Validate all the tags in 33.02 message.


Then Terminal sends 33.02 message to ECR/POS. Tag 4F, Tag 50, Tag 57, Tag 5A, Tag 84, Tag 5F20, Tag 5F24, Tag 5F28, Tag 5F2D, Tag 5F30, Tag 5F34, Tag 9F07, Tag 9F09, Tag 9F11 ,Tag 9F12 , Tag 9F1A, Tag 9F1B, Tag 9F1E, Tag 9F1F, Tag 100E , Tag FF25


When I send 04.x "Set Payment Type" and select  Payment Type "Credit" --> 04.1B000


Then Wait for the response 04.0B0000


When I send second 13.x amount message i.e Send 13.1300


Then Terminal displays amount confirmation message "Amount OK? 13.00 with YES, NO , CANCEL options.


When I select YES on Amount Confirmation screen


Then I select YES on Amount Confirmation screen


When Wait for Terminal sending 33.03.0000 (Authorization request Incoming) message to ECR/POS


Then Terminal sends 33.03.0000 (Authorization request Incoming) message to ECR/POS with all the required tags for Host Authorization. Terminal displays " Authorizing ..Please wait...Do not remove card" message.


When ARC waits for 33.04.0000 ( Host/RBA Testapp Authorization reponse) message. Send 33.04.0000 message with Tag 8A=00( Online Approval) from the RBA Testapp to ARC


Then Terminal keeps displaying "Authorizing ...Please wait ..Do not remove card" messge. ARC send 33.05.000 (Authorization Confirmation Incoming" with all the tags and the Terminal suspends the EMV flow after sending 33.05 message. ARC sends the status to POS 33.01.0000[FS]00ISEAA--SA---STS---------S1DU-----[FS]


When Validate 33.03 and  33.05 message with all the tags


Then ARC should transmit all the necessary & required EMV tags to POS/Testapp.


When I verify the 1002 Tag  in 33.05 message.


Then For the Signature-CVM EMV credit cards Tag 1002 = 1 (Signature Required)


When I send 20.165[FS]SIGN.K3Z ( signature request) from testapp  to terminal


Then Terminal displays Signature form with prompt "Please sign and tap OK" with OK & CLEAR buttons.


When Perform the signature and hit OK button


Then ARC should send the response msg "20.0x" 0 - Enter Key Pressed x* - Data Input field ( Data field should vary depending on the size of the signature )


When I send 29.x Get variable 700 to get Signature Block 1 -->29.00000700


Then Terminal sends the successful Signature Block1 data. <-- 29.20000700`]](\^Z\]_\]#[\FZ[5Z[G]^0]]>Z\P__"\]1[\W\]#^^&^_J]^F__W]_]_ !_ @_!$_ Z_": #*  ! $N "^ "@!$W !B!#J"##  5"#(!!#! '!!^  2! F! ;  A! X  H!_="_1   !^]!_  _K!^8 _<!^%!^& _.!^! _A ^G!^!   !]+ ^C _3 ]E _* ^3


When I send 29.x Get variable 701 to get Signature Block 2 --> 29.00000701


Then If the data input field of 20.x response is 2, then Terminal sends the successful Signature Block2 data. <-- 29.20000701]6 _' ]5 ^, _  ]- _$ ^* ^4 _& ^9 _) _2 ^9    ^J ^F _3 ]U _2 _;!]%    ^R _9!\9   p Else Sends empty data. i.e <--29.20000701


When I send all the below Ondemand messages one after another from Testapp. DO NOT perform any action on the terminal 20.165[FS]SIGN.K3Z 27.0004016[FS]1[FS]Input_alpha 21.00040216[FS]14[FS]input_numeric


Then Each respective Ondemand message should keep display on the terminal with respective Forms and prompts until next on-demand message. Terminal should NOT reboot.Transaction should NOT be cancelled.


When I send 33.09 message with command type "R" (Resume and run build-in screens)


Then Terminal sends the response "33.09.000". Terminal displays "Approved...Please RemoveCard" and Beeps for Card removal


When Remove the EMV Contact card


Then Beep stops and Terminal keeps display "Approved" message. Terminal sends Card removal response  09.020201R to POS




