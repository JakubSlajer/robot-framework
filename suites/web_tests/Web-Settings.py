# This file contains some important settings for WEB UI tests such as host url and page names.
# Note that this file is meant to be used as a variable file and you should not need to copy it
# to folder in python path.
#
# newSocietyId field:
# set / created during test executions
# id of new society, set to test society 1 by default

import os

class EnvDependantConfiguration:
    """
    Class used to specify environment-dependant configuration.
    """

    def __init__(self, seleniumTimeout, hostUrl, testUsername, testPassword, testSubscriberName, testSubscriberBusinessId):
        self.seleniumTimeout = seleniumTimeout
        self.hostUrl = hostUrl
        self.testUsername = testUsername
        self.testPassword = testPassword
        self.testSubscriberName = testSubscriberName
        self.testSubscriberBusinessId = testSubscriberBusinessId


# configuration set for localhost
localConf = EnvDependantConfiguration(
    30,
    'https://www.python.org/',
    'robot.official@gmail.com',
    '123456789',
    'Test subscriber',
    '6260660-6'
)

# configuration set for demo env
demoConf = EnvDependantConfiguration(
    30,
    'https://www.python.org/',
    'robot.official@gmail.com',
    '123456789',
    'Test Subscriber Oy',
    '3331648-2'
)


# configuration set for prod env
prodConf = EnvDependantConfiguration(
    30,
    'https://www.python.org/',
    'robot.official@gmail.com',
    '123456789',
    'Test subscriber',
    '3331648-2'
)


# configuration common for all hosts
commonConf = {

    # basics
    'browser':                      os.getenv('BROWSER', 'headlessfirefox'),
    'dateFormat':                   '%d/%m/%Y',
    'localhostTimeout':             '50 seconds',
    'seleniumTimeout':              15,

    # page names
    'homePageName':                 'home',
    'loginPageName':                'login',
    'customerMgmtPageName':         'customerManagement',
    'participantMgmtPageName':      'participantManagement',
    'subscriberMgmtPageName':       'subscriberManagement',
    'salaryMgmtPageName':           'salaryManagement',
    'newSubscriberPage':            'subscribers/bookmarks/new',
    'newParticipantPage':           'participants/add',
    'newAssignmentPage':            'assignment/new',

    # ui elem names (only the most common ones)
    'usernameElemName':             'username',
    'passwordElemName':             'password'
}


# Returns host-specific variables merged with variables common for all hosts
def get_variables(host):
    variables = commonConf.copy()

    if host == 'local':
        variables.update(localConf.__dict__)
    elif host == 'demo':
        variables.update(demoConf.__dict__)
    elif host == 'prod':
        variables.update(prodConf.__dict__)

    return variables