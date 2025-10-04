Feature: Validate Configuration write request message for activate /disactivate readers
'''
Validate 60.x Configuration Write Request Message for ARC.json parameters
TestLink test case link: 
'''

Scenario: Validate Configuration write request message for activate /disactivate readers
Given Latest ARC build should be loaded into the terminal
And Latest RBATT installed on the system
And Terminal is connected to RBATT over any of the valid comm ty
When I send a 00.x Offline message to the terminal with params:
| p00_req_reason_code | 00.0000 |
Then I Wait until Element "title" contains "The terminal displays Offline layout with the prompt  "This Lane Closed" and sends the response "00.0000""
| p00_req_reason_code | 00.0000 |
When I Send 61.uppeft/manualentry/mode[FS]
Then The terminal response: 61.2uppeft/manualentry/mode[GS]0[FS]
| 61.2uppeft/manualentry/mode | 0 |
When I send a 60.x Configuration Write message with batch params:
| 60.Arc/emv/enabled | true |
| Arc/cless/mode | 9 |
| uppeft/manualentry/mode | 1 |
Then ARC sends 60.2 for the Succesful confirmtaion Write message
| p60_req_status | 60.2 |
When I Send 23.x card read request with enabling all readers 23.312[FS][FS][FS]CMSH
| p23_req_status | 23.312 |
Then I Wait until Element "title" contains "The terminal displays "Insert, Swipe or Tap Card" with ENTER CARD button. EMV Contact, CLESS, MSR readers/leds are enable"
When I Verify whether Manul Entry [ENTER CARD] button is displayed
Then Manual Entry option should be available
When I send a 60.x Configuration Write message with batch params:
| 60.uppeft/manualentry/mode | 0 |
Then ARC sends 60.2 for the Succesful confirmtaion Write message
| p60_req_status | 60.2 |
When I Send 23.x card read request with enabling all readers 23.3[FS][FS][FS]CMS
| p23_req_status | 23.3 |
Then I Wait until Element "title" contains "The terminal displays "Please slide card" EMV Contact, CLESS, MSR readers/leds are enable"
When I check that Element "btn_manual_entry" is not visible
Then Manual Entry (ENTER CARD) button is absent because uppeft/manualentry/mode=0 i.e 00007_0029=0
When I send a 00.x Offline message to the terminal with params:
| p00_req_reason_code | 00.0000 |
Then I Wait until Element "title" contains "The terminal displays "This Lane Closed" and sends the response "00.0000""
| p00_req_reason_code | 00.0000 |

