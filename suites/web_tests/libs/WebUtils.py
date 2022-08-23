# This library contains methods to make testing easier.

import datetime
import random
import re
import selenium.common.exceptions
import time
from robot.api import logger
from robot.libraries.BuiltIn import BuiltIn
from selenium.common.exceptions import WebDriverException


class WebUtils:
    @staticmethod
    def generateSemiRandomGoogleEmail(base):
        """
        Generates email by appending random number to base and then appending the 'gmail.com' domain.
        E.g. base = robot, email = robot123@gmail.com

        :param base: Base of the email.
        :return: Semi-random email
        """
        return base + str(random.randint(0,10000)) + '@gmail.com'


    @staticmethod
    def generateRandomName(base):
        """
        Generates random name by appending random number to the base.
        :param base: Base of the random name.
        :return: Random name.
        """

        return base + str(random.randint(0,10000))


    @staticmethod
    def generateRandomBirthdate(start, end):
        """
        Generates random birthdate for foreigner user registration.
        :return: Random birthdate (ddmmyyyy)
        """
        time_format = '%m/%d/%Y'
        output_time_format = '%d%m%Y'

        start_date = time.mktime(time.strptime(start, time_format))

        end_date = time.mktime(time.strptime(end, time_format))

        generated_date = start_date + random.random() * (end_date - start_date)

        return time.strftime(output_time_format, time.localtime(generated_date))


    @staticmethod
    def parameterFromUrl(url, paramName):
        """
        This method takes url, tries to find parameter called
        paramName and returns its value. Expected format:
        paramName=value

        :param url: Url to parse
        :param paramName: Name of the parameter to be parsed
        :return: Param value
        """

        # this regexp will find paramName=value in givern url
        regex = paramName+"=([^&\s]*)&?"
        p = re.compile(regex)
        m = p.search(url)
        if(m):
            return m.group(1)


    @staticmethod
    def getFutureDate():
        """
        Returns a date that is in the future and is after now.
        :return: Date
        """
        today = datetime.date.today()
        d = datetime.date(today.year + 2, today.month, today.day)
        return d.strftime("%d.%m.%Y")


    @staticmethod
    def waitUntilInputContains(robotLocator, value):
        """
        Wait until input element located by robot attribute contains certain string.

        :param robotLocator: Robot attribute value.
        :param value: Desired value of the input.
        :return: Nothing
        """
        seleniumlib = BuiltIn().get_library_instance('SeleniumLibrary')
        driver = seleniumlib.driver
        # timeout is 20s. this will have to do until I find out how to get selenium timeout
        timeout = 20*1000
        oldTime = int(round(time.time() * 1000))
        inputElement = driver.find_element_by_xpath('//input[@robot-test="'+robotLocator+'"]')
        textContains = value in inputElement.get_attribute('value')
        timeoutExceeded = 0
        while (not (timeoutExceeded or textContains)):
            inputElement = driver.find_element_by_xpath('//input[@robot-test="'+robotLocator+'"]')
            textContains = value in inputElement.get_attribute('value')
            curTime = int(round(time.time() * 1000))
            timeoutExceeded = (curTime - oldTime) > timeout

        if (timeoutExceeded and (not textContains)):
            raise selenium.common.exceptions.TimeoutException('Input '+robotLocator+' does not contain '+value)


    @staticmethod
    def clickFirstTableRow(xpath):
        """
        Tries to locate and click the td//span//div in the first <tr> element in the <tbody>
        of table given by xpath and click on it.

        :param xpath: Xpath used to locate the <table>
        :return: Nothing
        """
        seleniumlib = BuiltIn().get_library_instance('SeleniumLibrary')
        driver = seleniumlib.driver

        index = 1
        clicked = False
        while not clicked:
            rowXpath = xpath + '//tbody//tr['+str(index)+']//td[1]//span[1]/div'
            row = driver.find_element_by_xpath(rowXpath)
            if row.is_displayed():
                try:
                    row.click()
                    clicked = True
                except WebDriverException as ex:
                    logger.warn("Unexpected exception while trying to click row: {0}. Exception: {1}".format(rowXpath, ex))
                    index = index + 1
            else:
                logger.warn("Row {0} is not displayed nor enabled.".format(rowXpath))
                index = index + 1

