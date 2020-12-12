from bs4 import BeautifulSoup
from splinter import Browser
from pprint import pprint
import pymongo
import pandas as pd
import requests
from flask import Flask, render_template
import time
import numpy as np
import json
from selenium import webdriver

def init_browser():
    executable_path = {'executable_path': 'chromedriver.exe'}
    return Browser('chrome', **executable_path, headless=False)

def scrape():
    browser = init_browser()
    mar_dict = {}

    #
    url = 'https://mars.nasa.gov/news/'
    
    #Retrieve page with the requests module
    response = requests.get(url)
    #Soup with an url html page
    soup = BeautifulSoup(response.text, 'html.parser')
    news_titles = soup.find('div', class_ ="content_title").text
    print(news_titles)

    mar_dict['Titles'] = news_titles
    #
    news_p = soup.find("div", class_="article_teaser_body")
    news_p 

    mar_dict['Paragraph'] = news_p
    #
    t_url = 'https://www.jpl.nasa.gov/spaceimages/?search=&category=Mars'
    browser.visit(t_url)
    html_w = browser.html
    soupy = BeautifulSoup(html_w, 'html.parser')
    all_images = soupy.find_all('a', class_= "fancybox")
    empty_list = []
    for image in all_images:
        jpg = image['data-fancybox-href']
        empty_list.append(jpg)

        featured_image_url = t_url + jpg
        featured_image_url
    
    mar_dict['Featured Image'] = featured_image_url
#
    table_url = "https://space-facts.com/mars/"
    table = pd.read_html(table_url)
    table[0]

    mar_dict['Table'] = table
#
    hemi_url = 'https://astrogeology.usgs.gov/search/results?q=hemisphere+enhanced&k1=target&v1=Mars'
    browser.visit(hemi_url)
    html_hemi = browser.html
    hemi_soup = BeautifulSoup(html_hemi, 'html.parser')
    hemisphere_image_urls = []

    for i in range (4):
        hemi_jpg = browser.find_by_tag('h3')
        hemi_jpg[i].click()
        html_hemi = browser.html
        hemi_soup = BeautifulSoup(html_hemi, 'html.parser')
        get_hemi_jpg = hemi_soup.find("img", class_="wide-image")["src"]
        hemi_title = hemi_soup.find("h2",class_="title").text
        jpg_url = 'https://astrogeology.usgs.gov'+ get_hemi_jpg
        dict= {"title":hemi_title,"img_url":jpg_url}
        hemisphere_image_urls.append(dict)
        browser.back()
    
    print(hemisphere_image_urls)

    mar_dict['Hemisphers'] = hemisphere_image_urls
    return mar_dict