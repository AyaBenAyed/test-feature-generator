@smoke @62x @00x @dx8000 @ex8000 @dx4000 @rx5000 @rx7000

Feature: Generated Feature File
"""
 
 TestLink test case link: 
"""

Scenario: Validate EMV Contactless Optimized Quick Chip Transaction

Given Latest ARC build should be loaded into the terminal. Latest RBATT installed on the system. Terminal is connected to RBATT over any of the valid comm type. Enable Cless 0008_0001=9, Enable EMV Cless OQC 0008_0024=1


When I send offline


Then The terminal displays ‘’This Lane is Closed’’


When I send valid amount with 13.x command


Then ARC return 13.0 response


When I send 23.x card read command


Then ARC displays "Please insert card" message and enable the cless card reader


When Tap an EMV Cless card


Then ARC return 23.0q response with track2 data. Prompts for PIN if the transaction amount is greater than CVM limit.


When Enter valid PIN if prompted


Then ARC displays "Please wait..." message and returns 33.05 response


When Validate the tags and values returned in 33.05 response


Then ARC return valid tags and values in 33.05 response, 

| Tag | Value |
| 1003 | D |
| 07 | hA0000001523010 |
| T50 | 0B |
| T57 | 13 |
| 08 | h6510000000000216 |
| T82 | 02 |
| T84 | 07 |
| 02 | aZ3 |
| T95 | 05 |
| T99 | 24 |
| 03 | h221206 |
| 02 | h4800 |
| 01 | h00 |
| 03 | h231231 |
| 02 | h0840 |
| 02 | h0840 |
| 02 | aen |
| 01 | h01 |
| 06 | h000000001600 |
| 06 | h000000000000 |
| 07 | hA0000001523010 |
| 02 | hFF00 |
| 02 | h0001 |
| 02 | h0001 |
| 05 | h0000000000 |
| 05 | h0000000000 |
| 05 | h0000000000 |
| 01 | h01 |
| 02 | h0840 |
| 04 | h00002710 |
| 08 | a00000000 |
| 03 | h150741 |
| 08 | hC25666D74640C4A2 |
| 01 | h80 |
| 03 | hE0E808 |
| 01 | h22 |
| 02 | h0249 |
| 04 | h1A1220DE |
| 01 | h07 |
| 05 | hF800F0A001 |
| 04 | h00000036 |
| 04 | h36E0C000 |
| 02 | h800F |
| 05 | hDC4000A800 |
| 05 | h0010000000 |
| 05 | hDC4004F800 |
| D1002 | 01 |
| D1003 | 01 |
| D1005 | 02 |
| 02 | aen |
| 01 | a1 |
| D1012 | 02 |
| D1013 | 01 |
| 01 | a1 |
| 01 | a0 |
| 01 | a0 |
| 01 | a0 |
| D9000 | 01 |
| D9001 | 01 |
| 10 | a6510000000000216 |
| 77 | a65100002161612312000026UAT |
| 02 | a02 |



