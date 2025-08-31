Feature: Generated Feature File
"""
 Validate 60.x Configuration Write Request Message for ARC.json parameters
 TestLink test case link: 
"""

Scenario: Validate Configuration write request message for activate /disactivate readers

Given Latest ARC build should be loaded into the terminal. Latest RBATT installed on the system. Terminal is connected to RBATT over any of the valid comm type.


When I send offline message 00.0000


Then The terminal displays Offline layout with the prompt  "This Lane Closed" and sends the response "00.0000"


When I send 61.uppeft/manualentry/mode[FS]


Then The terminal response:  61.2uppeft/manualentry/mode[GS]0[FS]


When I send 60.x Configuration Write with batch command : 60.Arc/emv/enabled[GS]true[FS]Arc/cless/mode[GS]9[FS]uppeft/manualentry/mode[GS]1[FS]Arc/emv/aids/aid.02[GS]A0000000041010   55 1 01 0 0 0 0 0 0 0 0 0 0 1 * Arc/emv/enabled =true (EMV contact enable) Arc/cless/mode=9 (Contaless enable) uppeft/manualentry/mode to 1 (manual entry enable) 0021_0002=Enable PIN bypass with Mastercard AID


Then ARC sends 60.2 for the Succesful confirmtaion Write message


When I send 23.x card read request with enabling all readers 23.312[FS][FS][FS]CMSH


Then The terminal displays "Insert, Swipe or Tap Card" with ENTER CARD button. EMV Contact, CLESS, MSR readers/leds are enable


When I verify whether Manul Entry [ENTER CARD] button is displayed


Then Manual Entry option should be available


When I send 60.x Configuration Write uppeft/manualentry/mode to 0 60.uppeft/manualentry/mode[GS]0


Then ARC sends 60.2 for the Succesful confirmtaion Write message


When I send 23.x card read request with enabling all readers 23.3[FS][FS][FS]CMS


Then The terminal displays "Please slide card" EMV Contact, CLESS, MSR readers/leds are enable


When I verify if Manual Entry (ENTER CARD)button is present or not


Then Manual Entry (ENTER CARD) button is absent because uppeft/manualentry/mode=0 i.e 00007_0029=0


When I send offline message 00.0000


Then The terminal displays "This Lane Closed" and sends the response "00.0000"




