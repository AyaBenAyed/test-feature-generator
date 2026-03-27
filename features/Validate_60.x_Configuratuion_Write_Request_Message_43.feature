Feature: Generated Feature File
"""
 Validate 60.x Configuratuion Write Request Message
 TestLink test case link: 
"""

Scenario: Validate 60.x Configuratuion Write Request Message

Given Last ARC build should be loaded


When I send offline


Then The terminal displays "This Lane is Closed" and sends "00.0000"


When I send 61.7[GS]29[FS]


Then The terminal response is 61.27[GS]29[GS]0[FS]


When I send 60.x Configuration whith batch command 0007_0029=1 (Manual entry enable) 0008_0001=9 (Contactless enable) 0019_0001=1 (EMV contact enable) 0021_0002=Enable PIN bypass with Mastercard AID 60.7[GS]29[GS]1[FS]8[GS]1[GS]9[FS]19[GS]1[GS]1[FS]21[GS]2[GS]A0000000041010   55 1 01 0 0 0 0 0 0 0 0 0 0 1 * 0 0


Then ARC sends 60.2 for the succesful confirmation write message


When I send 23.x card read request


Then The terminal displays "Please insert card" with ENTER CARD button. EMV Contact, CLESS, MSR readers are enable


When I verify whether Manual Entry (ENTER CARD) button is displayed


Then Manual Entry option should be available


When I send 60.x configuration write 0007_0029=0 60.7[GS]29[GS]0


Then ARC sends 60.2 for the succesful confirmation write message


When I send 23.x card read request


Then The terminal displays "Please insert card"


When I verify if Manual Entry (ENTER CARD) button is present or not


Then Manual Entry (ENTER CARD) button is absent




