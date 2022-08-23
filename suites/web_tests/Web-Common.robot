*** Settings ***
Documentation	Resource file which contains keywords common to MN UI tests.

# To load host configuration set, use one of 'local', 'demo', 'prod' in run parameter: "--variable TEST_ENV:local"
Variables	Web-Settings.py              ${TEST_ENV}

Library		SeleniumLibrary
Library		DateTime
Library     String
Library		Collections
Library		OperatingSystem
Library		libs/WebUtils.py

*** Variables ***
${screenWidth}			1920
${screenHeight}			1080

*** Keywords ***
# open/goto page keywords
Create ChromeOptions
	[Arguments]			${lang}
	${chromeOptions}=	Evaluate	sys.modules['selenium.webdriver'].ChromeOptions()	sys, selenium.webdriver
	Call Method			${chromeOptions}	add_argument	--lang\=${lang}
	[Return]			${chromeOptions}


Create FirefoxProfile
	[Arguments]			${lang}
	${firefoxProfile}=	Evaluate	sys.modules['selenium.webdriver'].FirefoxProfile()	sys, selenium.webdriver
	Call Method			${firefoxProfile}	set_preference	intl.accept_languages	${lang}
	[Return]			${firefoxProfile}


Open Chrome
	[Arguments]			${url}	${lang}
	# set language as environment variable for Linux: https://bugs.chromium.org/p/chromium/issues/detail?id=755338
	Set Environment Variable	LANG	${lang}
	${chromeOptions}=	Create ChromeOptions	${lang}
	Open Browser		${url}		chrome		options=${chromeOptions}


Open Firefox
	[Arguments]			${url}	${lang}
	${firefoxProfile}=	Create FirefoxProfile	${lang}
	Open Browser		${url}		firefox		ff_profile_dir=${firefoxProfile}


Open Headless Chrome
	[Arguments]			${url}	${lang}
	# set language as environment variable for Linux: https://bugs.chromium.org/p/chromium/issues/detail?id=755338
	Set Environment Variable	LANG	${lang}
	${chromeOptions}=	Create ChromeOptions	${lang}
	Call Method			${chromeOptions}	add_argument	--no-sandbox
	Call Method			${chromeOptions}	add_argument	--window-size\=${screenWidth},${screenHeight}
	Open Browser		${url}		headlesschrome		options=${chromeOptions}


Open Headless Firefox
	[Arguments]			${url}	${lang}
	# set headless firefox window size using environment variables; https://github.com/mozilla/geckodriver/issues/1354
	Set Environment Variable	MOZ_HEADLESS_WIDTH		${screenWidth}
	Set Environment Variable	MOZ_HEADLESS_HEIGHT		${screenHeight}
	${firefoxProfile}=	Create FirefoxProfile	${lang}
	Open Browser		${url}		headlessfirefox


Open Web Page
	[Documentation]		Opens browser on given Stagent page with url ${hostUrl}${page}.
	[Arguments]			${page}		${lang}=fi      ${controlString}=Etusivu
	Run Keyword If		'${browser}' == 'chrome'	Open Chrome		${hostUrl}		${lang}
	...		ELSE IF		'${browser}' == 'firefox'	Open Firefox	${hostUrl}		${lang}
	...		ELSE IF		'${browser}' == 'headlesschrome'	Open Headless Chrome	${hostUrl}		${lang}
	...		ELSE IF		'${browser}' == 'headlessfirefox'	Open Headless Firefox	${hostUrl}		${lang}
	...		ELSE		Open Browser	${hostUrl}		${browser}
	Maximize Browser Window
	Set Selenium Timeout	${seleniumTimeout}
	Go To		        ${page}


Goto Web Page
	[Documentation]		Goes to given web page.
	[Arguments]		    ${page}     ${controlString}
	Go To			    ${hostUrl}${page}
	Wait Until Page Contains	${controlString}


Click Submit Button
    [Documentation]     Clicks on a component with name 'submitButton'
    Click Element       name=submitButton


Debug Log
    [Documentation]     Logs message with DEBUG level
    [Arguments]         ${message}
    Log                 ${message}  DEBUG   console=yes

