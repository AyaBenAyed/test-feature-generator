Feature: Validate 60.x Configuratuion Write Request Message
'''
Validate 60.x Configuratuion Write Request Message
TestLink test case link: 
'''

Scenario: Validate 60.x Configuratuion Write Request Message
Given Last ARC build should be loaded
When I send a 00.x Offline message to the terminal with params:
Then The terminal displays "This Lane is Closed" and sends "00.0000"
| p00_req_reason_code | 00.0000 |
When I Send 61.7[GS]29[FS]
| 61.7 | 29 |
Then The terminal response is 61.27[GS]29[GS]0[FS]
| 29 | 0 |
When I Send 60.x Configuration whith batch command 0007_0029=1 (Manual entry enable) 0008_0001=9 (Contactless enable) 0019_0001=1 (EMV contact enable) 0021_0002=Enable PIN bypass with Mastercard AID 60.7[GS]29[GS]1[FS]8[GS]1[GS]9[FS]19[GS]1[GS]1[FS]21[GS]2[GS]A0000000041010 55 1 01 0 0 0 0 0 0 0 0 0 0 1 * 0 0
| 29 | 1 |
| 1 | 9 |
| 1 | 1 |
Then ARC sends 60.2 for the succesful confirmation write message
| p60_req_status | 60.2 |
When I Send 23.x card read request
Then The terminal displays "Please insert card" with ENTER CARD button. EMV Contact, CLESS, MSR readers are enable
When I Verify whether Manual Entry (ENTER CARD) button is displayed
Then Manual Entry option should be available
When I send a 60.x Configuration Write message with batch params:
| 29 | 0 |
Then ARC sends 60.2 for the succesful confirmation write message
| p60_req_status | 60.2 |
When I Send 23.x card read request
Then The terminal displays "Please insert card"
When I check that Element "btn_manual_entry" is not visible
Then Manual Entry (ENTER CARD) button is absent

