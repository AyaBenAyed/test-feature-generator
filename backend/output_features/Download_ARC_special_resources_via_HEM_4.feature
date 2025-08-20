@smoke @62x @00x @dx8000 @ex8000 @dx4000 @rx5000 @rx7000

Feature: Generated Feature File
"""
 The test will verify the EFT 67.1 message that manage the apk download
 TestLink test case link: 
"""

Scenario: Download ARC special resources via HEM

Given Latest ARC build loaded into the terminal. Latest RBATT installed on the system. Terminal is connected to RBATT over any of the valid comm type. Download ARC special resources from this confluence page [ https://ussnprdevapp5:8443/pages/viewpage.action?pageId=145752205 ]. Follow the steps mentioned in this confluence page [ https://ussnprdevapp5:8443/pages/viewpage.action?spaceKey=PRJRPT&title=How+to+Download+ARC+Using+Estate+Manager ] to Download the apk file using the state manager.


When I send 00.0000 Offline command


Then Terminal displays " This Lane Closed" on the screen.


When I send 67.1 For Configure sub-command Contract Number (or Signature) (optional) Network Type: (Ethernet, WIFI or PCL) (required) TMS Address (required) TCP Port (required) SSL Profile (optional) i.e -->67.1[FS]1[FS]{"ContractNumber":"216MCU800575","NetworkType":"wifi","TMSAddress":"temterminalsnar01.preprod.icloud.ingenico.com","TCPPort":"7002","SSLProfile":""}


Then Terminal send the response 67.1[FS]1[FS]0 Parse the " 67.1[FS]1[FS]0 response message": Result: 1 (Estate Manager) Encrypted Card Data: 1 (Configure) Status: 0 (Success)


When I send 67.2 to Start the download based on the defined configuration (with a "Background" option).


Then Terminal sends the response 67.1[FS]2[FS]0[FS]{"detailedStatus":"Success"} Parse the response message : Result: 1 (Estate Manager) Encrypted Card Data: 2 (Start Download) Status: 0 (Success) Data: {"detailedStatus":"Success"}


When I send 67.4 to Get the current download status.


Then Terminal sends the response 67.1[FS]4[FS]0[FS]{"detailedStatus":"ReadyToInstall"} Parse the response message: Result: 1 (Estate Manager) Encrypted Card Data: 4 (Get Download Status) Status: 0 (Success) Data: {"detailedStatus":"ReadyToInstall"}


When I send 67.5  to Install the downloaded resources.


Then Terminal sends the response 67.1[FS]5[FS]2[FS]{"detailedStatus":"Success"} Parse the response message : Result: 1 (Estate Manager) Encrypted Card Data: 5 (Unknown value) Status: 0 (Success) Data: {"detailedStatus":"Success"}




