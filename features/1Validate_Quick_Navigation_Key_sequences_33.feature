Feature: Generated Feature File
"""
 This test is to validate that quick navigation works with different key sequence as listed below: 1-1-1-1 : Info Screen 1-4-2-2 : Communication Configuration settings 4-4-4-4 : Bluetooth settings
 TestLink test case link: 
"""

Scenario: 1Validate Quick Navigation Key sequences

Given Latest ARC build should be loaded into the terminal. Latest RBATT installed on the system. Terminal is connected to RBATT over any of the valid comm type.


When I send "Offline" Command


Then ARC displays "This Lane Closed" layout.


When I press key sequence 1-1-1-1 on Offline Layout


Then ARC navigates to Info Screen with all the below detais. Verify all the below components are displayed correctly. ARC Version PCI Validated Terminal Information Firmware Version Hardware SN & Injected SN USDK Version UX-Server APK & API Version SPS version NSDS Version DX Mobile Version ARC Comm Config Version Communications


When I press Ok button.


Then ARC displays Offline Layout with "This Lane Closed" prompt.


When I press key sequence 1-4-2-2 on Offline Layout.


Then ARC navigates to Comm Config application screen correctly. * Verify the CommConfig version displayed correctly. * Verify Hardware Configuration and Connection Configuration icons are displayed. * By clicking on Connection Configuration/Primary - able to navigate to different communication methods


When I press the Exit button then click on 'Yes' to save your modifications or 'No' to exit without saving modifications


Then ARC returns to Offline Layout


When Query the default value of communication configuration shortcut with the command : 61.Arc/keySequences/commsConfig[FS]


Then ARC returns the default value configured in commsConfig parameter as 61.2Arc/keySequences/commsConfig[GS]1422[FS]


When Configure a new value for Comm Config shortcut with the command : 60.Arc/keySequences/commsConfig[GS]3131


Then ARC updates keySequences/commsConfig to a new value 3131 and returns 60.2 (success) response


When Reboot the terminal in order to to make the new value of  CommConfig Shortcut to be effective


Then Terminal reboots. The new configured value of keySequence/commsConfig should be effctive only after reboot.


When I press 3-1-3-1 key sequence at offline layout


Then ARC navigates to Comm Config application where you are able to modify communication type.


When I press the Exit button then click on 'Yes' to save your modifications or 'No' to exit without saving modifications


Then ARC returns to Offline screen


When Configure back  to the DEFAULT value for Comm Config shortcut with the command : 60.Arc/keySequences/commsConfig[GS]1422


Then ARC updates keySequences/commsConfig to its DEFAULT value 1422 and returns 60.2 (success) response


When Reboot the terminal in order to to make the new(Default) value of  CommConfig Shortcut to be effective


Then Terminal reboots. The new (DEFAULT) configured value of keySequence/commsConfig should be effctive only after reboot.


When I press key sequence 4-4-4-4


Then ARC navigates to Bluetooth settings and requires a password to be able to access the settings


When Enter 350000 and press 'Ok'


Then Blutooth settings are now accessible where you can pair your device to your ECR


When I press the return button


Then ARC retuns to Offline screen




