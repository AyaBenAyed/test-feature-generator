@smoke @62x @00x @dx8000 @ex8000 @dx4000 @rx5000 @rx7000

Feature: Generated Feature File
"""
 This test is to validate that EMV Contact Optimized Quick Chip (OQC) transaction is successful.
 TestLink test case link: 
"""

Scenario: Validate EMV Contact Optimized Quick Chip Transaction

Given Latest ARC build loaded into the terminal. Keys are injected. Latest RBATT installed on the system. Terminal is connected to RBATT over any of the valid comm type. Enable Contact EMV (19_1=1), EMV Contact OQC (19_21=1), Enable Cless (8_1=9), Enable Manual Entry (7_29=1). Terminal floor limit set to 0.


When I send offline command.


Then ARC displays offline form with "This Lane Closed" prompt.


When I send amount in 13.x command.


Then ARC doen't return any response and keeps displays "This Lane Closed".


When I send 23.x Card read request. i.e  23.3[FS][FS][FS]CMS


Then ARC displays "Insert, Tap and Swipe Card" message and enables all the card readers.


When Insert EMV contact card. Visa, MasterCard, Amex or Discover.


Then ARC returns 23.0Q response and displays "Processing ...Please wait" message. ARC prompts for PIN only if card supports PIN.


When Enter valid PIN and press ENTER key.


Then 33.05 message contains all the tags from 33.02/33.03/33.05 of Normal EMV transaction with specific values in: 8A=Z3 9F27=80 1003=D

| Tag | Value |
| 1003 | D |

When I verify that the total time for OQC transaction completion doesn't exceed ~2.2 secs.


Then The OQC transaction turn around time is less than ~2.2 secs.




