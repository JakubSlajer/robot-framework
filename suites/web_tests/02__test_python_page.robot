*** Settings ***
Documentation	Tests to verify that the customer management is displayed correctly and the basic functionality works as expected.

Resource	Web-Common.robot

Force Tags 	customer-management

Test Setup		Open Web Page       ${hostUrl}      Python
Suite Teardown	Close Browser


*** Test Cases ***
Display Homepage Take Screenshot
	[Documentation]		Display python.org home page and take screenshot
	Capture Page Screenshot


Display About Page
	[Documentation]		Display about page
	Goto Web Page       about                   Python is powerful... and fast


Display Success Stories Page
	[Documentation]		Display downloads page
	Goto Web Page       downloads               Download the latest version for Windows


Display Documentation Page
	[Documentation]		Display documentation page
	Goto Web Page       doc                     Browse the docs online or download a copy of your own


Display Community Page
	[Documentation]		Display community page
	Goto Web Page       community               Python’s community is vast


Display Success Stories Page
	[Documentation]		Display success stories
	Goto Web Page       success-stories         Newest success stories


Display News Page
	[Documentation]		Display news
	Goto Web Page       blogs                   Welcome to the Python Insider


Display Events Page
	[Documentation]		Display events
	Goto Web Page       events                  Upcoming Events

