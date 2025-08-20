@smoke @62x @00x @dx8000 @ex8000 @dx4000 @rx5000 @rx7000

Feature: Generated Feature File
"""
 Validate if  the T&C is Accepted/Declines  with correct response msg
 TestLink test case link: 
"""

Scenario: Validate 25.x Terms and Conditions Request Message

Given Latest ARC build loaded into the terminal. Latest RBATT installed on the system. Terminal is connected to RBATT over any of the valid comm type.


When I send 00.0000 Offline command


Then Terminal displays " This Lane Closed" on the screen.


When I send 25.01 command


Then Terminal displays Terms and Conditions screen , with "ACCEPT" & "DECLINE" options.


When Click on ACCEPT button


Then Terminal sends the response 25.0@ Parse the "25.0@ response message" Signature on accept- 0 (OK) ID of key pressed to exit - @ (ACCEPT)


When I send 25.01 command


Then Terminal displays Terms and Conditions, with "ACCEPT"  & "DECLINE" options


When Click on DECLINE button


Then Terminal send the response 25.0B to the POS/RBA test app Parse the "25.0B response message" should have the below values. Signature on accept-  0 (OK-Accept ot Decline key was pressed) ID of key pressed to exit - B (Decline)




