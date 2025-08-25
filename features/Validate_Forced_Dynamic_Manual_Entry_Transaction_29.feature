@smoke @62x @00x @dx8000 @ex8000 @dx4000 @rx5000 @rx7000

Feature: Generated Feature File
"""
 This test will validate forced dynamic manual entry transaction
 TestLink test case link: 
"""

Scenario: Validate Forced Dynamic Manual Entry Transaction

Given Latest ARC build should be loaded into the terminal. Latest RBATT installed on the system. Terminal is connected to RBATT over any of the valid comm type. Set 0007_0029 = 5 OR 0007_0029 = 6


When I send offline message 00.0000


Then Terminal displays "This Lane Closed" and returns the response 00.0000


When I send 13.x amount


Then Amount sent to terminal and 13.0 received


When I send 23.x Card read request message with Force Manual Entry field enabled --> 23.3[FS][FS][FS]H


Then Terminal displays "Enter card details" screen with prompt for card number


When Enter valid card number followed by selecting "CONFIRM" button.


Then 19.X received and new prompt displayed on RBATT <-- 19.T011000116[FS]476173[FS]0119


When Choose one of the liste of value : w = Expiration date and CVV required x = Expiration date required y = CVV required z = No expiration date or CVV required Based on the selected value in RBATT, the terminal will show the prompt for Expiration Date and CVV and the flow continue as normal -->19. w 000216[FS]476173[FS]0119 (Select w )


Then Terminal displayed prompt for "Expiration Date" and "CVV"


When Enter valid  Expiration Date and CVV followed by selecting "CONFIRM" button


Then Terminal sends the successful card data to POS <--  23.0H4761739001010119^MANUALLY/ENTERED^2212000000123000000[FS]4761739001010119=2212000000123000[FS]


When I send offline message 00.0000


Then Terminal displays "This Lane Closed" and returns the response 00.0000




