@smoke @62x @00x @dx8000 @ex8000 @dx4000 @rx5000 @rx7000

Feature: Generated Feature File
"""
 This test will validate whether terminal reboots after sending 97.x message
 TestLink test case link: 
"""

Scenario: Validate 97.x Reboot message

Given Latest ARC build should be loaded into the terminal Using latest AXTool Kit Latest RBATT installed on the system. Terminal is connected to RBATT over any of the valid comm type.


When Click on 97.x Reboot msg


Then 97.x: Reboot pop up window will display with a message "Confirm sending a reboot message to the terminal" with options SEND & CANCEL


When Click on Send button


Then Terminal will automatically reboots and works properly as before the reboot.




