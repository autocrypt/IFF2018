#!/usr/bin/env python3

import logging
import lxml.etree as etree


logging.basicConfig(level=logging.DEBUG)
logger = logging.getLogger(__name__)

ACCCOUNTS_PATH = 'accounts.txt'
HANDOUT_PATH = 'burner-credentials.svg'
HANDOUT_OUT_PATH = 'burner-credentials_out{}.svg'
NS = {'svg': "http://www.w3.org/2000/svg"}
EMAIL_XPATH = "//svg:text[@id='account{}']"
PASS_XPATH = "//svg:text[@id='password{}']"

def main():
    with open(ACCCOUNTS_PATH) as fp:
        accounts = fp.readlines()
    logger.debug(accounts)
    tree = etree.parse(HANDOUT_PATH)
    for s in range(0, len(accounts) / 5):
        out = HANDOUT_OUT_PATH.format(s)
        for i in range(1, 6):
            j = s * 5  + i
            logger.debug(i)
            account = accounts[j - 1]
            email, password = account.split(' ')
            xpath_email = EMAIL_XPATH.format(i)
            logger.debug(xpath_email)
            elements_email = tree.xpath(xpath_email, namespaces=NS)
            logger.debug(elements_email)
            if elements_email:
                elements_email[0].getchildren()
                elements_email[0].text = email
                logger.debug('Added email %s', email)
            xpath_pass = PASS_XPATH.format(i)
            elements_pass = tree.xpath(xpath_pass, namespaces=NS)
            if elements_pass:
                elements_pass[0].getchildren()[0]
                elements_pass[0].text = password
                logger.debug('Added password %s', password)
        tree.write(out)
        logger.info('Generated %s', out)
    return tree


if __name__ == "__main__":
    main()
