@smoke @62x @00x @dx8000 @ex8000 @dx4000 @rx5000 @rx7000

Feature: Generated Feature File
"""
 Validate 61.x Configuration Read Request message.
 TestLink test case link: 
"""

Scenario: Validate Configuration Read Request Message

Given Latest ARC build should be loaded into the terminal. Latest RBATT installed on the system. Terminal is connected to RBATT over any of the valid comm type.


When I send offline command.


Then ARC displays offline layout with "This Lane Closed" prompt.


When I send  Configuration Read to query Cless reader 61.Arc/cless/mode[FS]


Then ARC response  61.2Arc/cless/mode[GS]0[FS]


When I send 60.x Configuration Write 0008_0001 to 9 --> 60.Arc/cless/mode[GS]9


Then ARC sends 60.2 for the Succesful confirmtaion Write message


When I send  Configuration Read to query Cless reader 61.Arc/cless/mode[FS]


Then ARC response ARC response  61.2Arc/cless/mode[GS]9[FS]


When I send 61.x configuration read of 0021_0001 parameter from RBATT --> 61.Arc/emv/aids/aid.01[FS]


Then ARC response : <-- 61.2Arc.emv/aids/aid.01[GS]A0000000031010   55 0 02 0 0 1 0 0 0 1 0 0 0 1 * 0 0[FS]


When I send 61.x configuration read 0092_SECBIN -->61.secbin/enabled[FS]


Then ARC  should return success response. <--  61.2secbin/enabled[GS]false[FS]


When I send 61.x configuration read of 0019_0002 parameter from RBATT --> 61.arc/emv/autoSelectLanguage[FS]


Then ARC return true , AutoSelectLanFlag is enabled <--61.2arc/emv/autoSelectLanguage[GS]true[FS]




