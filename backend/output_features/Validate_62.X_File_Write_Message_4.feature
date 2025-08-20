@smoke @62x @00x @dx8000 @ex8000 @dx4000 @rx5000 @rx7000

Feature: Generated Feature File
"""
 The test will verify the 62.x File Write Message
 TestLink test case link: 
"""

Scenario: Validate 62.X File Write Message

Given Latest ARC build should be loaded into the terminal. Latest RBATT installed on the system. Terminal is connected to RBATT over any of the valid comm type.


When I send offline message 00.0000


Then Terminal displays "This Lane Closed" and returns the response 00.0000


When I select 62 File Write message from RBA Test App


Then 62.x: File Write box should appear


When Click browse, and select the file that needs to be downloaded Encoding Format : 7-bit encoding or Base64 Unpack Option : Unpack, verify signature and apply files Chunk Size : Default Upload Speed : Fast speed


Then File and all the parameters are selcted


When I select " Write " button


Then Download progress starts and once the download process has been completed, "Upload has been completed successfully" message appears <-- 62.08548 0 : Successful 8548 : File length




