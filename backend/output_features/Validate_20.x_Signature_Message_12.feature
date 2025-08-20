@smoke @62x @00x @dx8000 @ex8000 @dx4000 @rx5000 @rx7000

Feature: Generated Feature File
"""
 
 TestLink test case link: 
"""

Scenario: Validate 20.x Signature Message

Given Latest ARC build should be loaded into the terminal. Latest RBATT installed on the system. Terminal is connected to RBATT over any of the valid comm type.


When I send offline


Then The terminal displays ‘’This Lane is Closed’’


When I send 20.x signature request message


Then The terminal displays signature form with: OK, CLEAR and CANCEL buttons


When Perform signature and click on OK/Enter Key (Physical Green Button for RX7000 device)


Then Terminal should send the response msg ''20.0x'' to the POS. 0_ Enter Key Pressed x_ Data Input field (Data field should vary depending on the size of the signature)


When I send 29.x Get variable 700 to get Signature Block 1 --> 29.00000700


Then Terminal sends the successful Signature Block1 data


When I send 29.x Get variable 700 to get Signature Block 2 --> 29.00000701


Then If the data input field of 20.x response is 2, then Terminal sends the successful Signature Block2 data. Else Sends empty data. i.e <-- 29.00000701


When I send 29.x Get variable 700 to get Signature Block 3 --> 29.00000702


Then If the data input field of 20.x response is 2, then Terminal sends the successful Signature Block3 data. Else Sends empty data. i.e <-- 29.00000702


When I send 20.x Signature request message


Then The terminal displays signature form.


When Perform signature and click on CLEAR/Enter Key(Physical Yellow key for RX7000 device)


Then Terminal clear the signature. No response sent. Terminal keeps display Signature form.


When I send 20.x Signature request message


Then The terminal displays signature form.


When I press CANCEL/Enter Key(Physical RED key for RX7000) with/without performing signature.


Then 20.1 command is received and the signature process is interrupted.


When I send 20.x Signature request message


Then The terminal displays signature form.


When I send 70.Ttitle,New text


Then The title of signature form is changed to ''New title''.


When I send 20.x Signature request message


Then The terminal displays signature form.


When I send (15.1 , 00. , 21.x , 23.x , 24.x , 25.x , 27.x , 35.x or 31.x (message function is in progress)


Then 20.a commad is received and signature form was aborted.




