#!/usr/bin/env python

import os, urllib, time
import selenium.webdriver as webdriver
from selenium.webdriver.common.proxy import *

def main():
  os.environ['DISPLAY'] = ':99'
  myProxy = "squid:80"

  proxy = Proxy({
    'proxyType': ProxyType.MANUAL,
    'httpProxy': myProxy,
    'ftpProxy': myProxy,
    'sslProxy': myProxy,
    'noProxy': 'qt-jenkins' # set this value as desired
  })
  browser = webdriver.Firefox(proxy=proxy)
  browser.set_window_size(1120, 550)

  try:
    browser.get("http://qt-jenkins:8080")
    print browser.title
    browser.get("http://www.google.com")
    print browser.title

  finally:
    browser.quit()

if __name__ == "__main__":
    main()
