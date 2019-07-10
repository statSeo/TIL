
# coding: utf-8

# In[1]:


from bs4 import BeautifulSoup
import requests
from selenium import webdriver
from selenium.webdriver.firefox.firefox_binary import  FirefoxBinary
from selenium.webdriver.common.desired_capabilities import  DesiredCapabilities
import time
from selenium.webdriver.common.keys import Keys
import datetime as dt


# In[54]:


binary=FirefoxBinary('C:/Program Files (x86)/Mozilla Firefox/firefox.exe')
browser=webdriver.Firefox(executable_path='C:/Users/Jiwan/Desktop/geckodriver-v0.23.0-win64/geckodriver.exe',firefox_binary=binary)


# In[55]:


startdate=dt.date(year=2018,month=4,day=1)
untildate=dt.date(year=2018,month=4,day=2)
enddate=dt.date(year=2018,month=7,day=1)

# startdate=dt.date(year=2018,month=7,day=1)
# untildate=dt.date(year=2018,month=7,day=2)
# enddate=dt.date(year=2018,month=10,day=1)

# startdate=dt.date(year=2018,month=10,day=1)
# untildate=dt.date(year=2018,month=10,day=2)
# enddate=dt.date(year=2019,month=1,day=1)


# In[56]:


totalfreq=[]
while not enddate==startdate:
    url='https://twitter.com/search?q=슬립온%20since%3A'+str(startdate)+'%20until%3A'+str(untildate)+'&amp;amp;amp;amp;amp;amp;lang=ko'
    browser.get(url)
    html = browser.page_source
    soup=BeautifulSoup(html,'html.parser')
    
    lastHeight = browser.execute_script("return document.body.scrollHeight")
    while True:
            dailyfreq={'Date':startdate}
    #     i=0 i는 페이지수
            wordfreq=0
            tweets=soup.find_all("p", {"class": "TweetTextSize"})
            wordfreq+=len(tweets)

            browser.execute_script("window.scrollTo(0, document.body.scrollHeight);")
            time.sleep(1)

            newHeight = browser.execute_script("return document.body.scrollHeight")
            print(newHeight)
            if newHeight != lastHeight:
                html = browser.page_source
                soup=BeautifulSoup(html,'html.parser')
                tweets=soup.find_all("p", {"class": "TweetTextSize"})
                wordfreq=len(tweets)
            else:
                dailyfreq['Frequency']=wordfreq
                wordfreq=0
                totalfreq.append(dailyfreq)
                startdate=untildate
                untildate+=dt.timedelta(days=1)
                dailyfreq={}
                break
    #         i+=1
            lastHeight = newHeight


# In[57]:


import pandas as pd
df=pd.DataFrame(totalfreq)
# df.head()


# In[58]:


df.to_csv('slipon1.csv')


# In[7]:


# import matplotlib.pyplot as plt

# plt.figure(figsize=(20,10))
# plt.xticks(rotation=90)
# plt.scatter(df.Date,df.Frequency)


# In[52]:


startdate=dt.date(year=2018,month=7,day=1)
untildate=dt.date(year=2018,month=7,day=2)
enddate=dt.date(year=2018,month=10,day=1)

totalfreq=[]
while not enddate==startdate:
    url='https://twitter.com/search?q=슬립온%20since%3A'+str(startdate)+'%20until%3A'+str(untildate)+'&amp;amp;amp;amp;amp;amp;lang=ko'
    browser.get(url)
    html = browser.page_source
    soup=BeautifulSoup(html,'html.parser')
    
    lastHeight = browser.execute_script("return document.body.scrollHeight")
    while True:
            dailyfreq={'Date':startdate}
    #     i=0 i는 페이지수
            wordfreq=0
            tweets=soup.find_all("p", {"class": "TweetTextSize"})
            wordfreq+=len(tweets)

            browser.execute_script("window.scrollTo(0, document.body.scrollHeight);")
            time.sleep(1)

            newHeight = browser.execute_script("return document.body.scrollHeight")
            print(newHeight)
            if newHeight != lastHeight:
                html = browser.page_source
                soup=BeautifulSoup(html,'html.parser')
                tweets=soup.find_all("p", {"class": "TweetTextSize"})
                wordfreq=len(tweets)
            else:
                dailyfreq['Frequency']=wordfreq
                wordfreq=0
                totalfreq.append(dailyfreq)
                startdate=untildate
                untildate+=dt.timedelta(days=1)
                dailyfreq={}
                break
    #         i+=1
            lastHeight = newHeight
        
df=pd.DataFrame(totalfreq)
df.to_csv('slipon2.csv')


# In[53]:


startdate=dt.date(year=2018,month=10,day=1)
untildate=dt.date(year=2018,month=10,day=2)
enddate=dt.date(year=2019,month=1,day=1)

totalfreq=[]
while not enddate==startdate:
    url='https://twitter.com/search?q=슬립온%20since%3A'+str(startdate)+'%20until%3A'+str(untildate)+'&amp;amp;amp;amp;amp;amp;lang=ko'
    browser.get(url)
    html = browser.page_source
    soup=BeautifulSoup(html,'html.parser')
    
    lastHeight = browser.execute_script("return document.body.scrollHeight")
    while True:
            dailyfreq={'Date':startdate}
    #     i=0 i는 페이지수
            wordfreq=0
            tweets=soup.find_all("p", {"class": "TweetTextSize"})
            wordfreq+=len(tweets)

            browser.execute_script("window.scrollTo(0, document.body.scrollHeight);")
            time.sleep(1)

            newHeight = browser.execute_script("return document.body.scrollHeight")
            print(newHeight)
            if newHeight != lastHeight:
                html = browser.page_source
                soup=BeautifulSoup(html,'html.parser')
                tweets=soup.find_all("p", {"class": "TweetTextSize"})
                wordfreq=len(tweets)
            else:
                dailyfreq['Frequency']=wordfreq
                wordfreq=0
                totalfreq.append(dailyfreq)
                startdate=untildate
                untildate+=dt.timedelta(days=1)
                dailyfreq={}
                break
    #         i+=1
            lastHeight = newHeight
        
df=pd.DataFrame(totalfreq)
df.to_csv('slipon3.csv')

