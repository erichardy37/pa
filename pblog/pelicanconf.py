#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals

AUTHOR = 'Eric Hardy'
SITENAME = 'Done Is Better Than Perfect'
SITEURL = 'http://erichardy.pythonanywhere.com/blog'

PATH = 'content'

# added 02/11/2016
STATIC_PATHS = ['blog', 'downloads']
ARTICLE_PATHS = ['blog']
# ARTICLE_SAVE_AS = '{date:%Y}/{slug}.html
# ARTICLE_URL = '{date:%Y}/{slug}.html

TIMEZONE = 'America/New_York'

DEFAULT_LANG = 'en'

# Feed generation is usually not desired when developing
FEED_ALL_ATOM = None
CATEGORY_FEED_ATOM = None
TRANSLATION_FEED_ATOM = None
AUTHOR_FEED_ATOM = None
AUTHOR_FEED_RSS = None

# Blogroll
LINKS = (('Pelican', 'http://getpelican.com/'),
         ('Python.org', 'http://python.org/'),
         ('Jinja2', 'http://jinja.pocoo.org/'),
         ('You can modify those links in your config file', '#'),)

# Social widget
SOCIAL = (('You can add links in your config file', '#'),
          ('Another social link', '#'),)

DEFAULT_PAGINATION = False

# Uncomment following line if you want document-relative URLs when developing
#RELATIVE_URLS = True

##########
# Added 01/13/2016
# see https://github.com/getpelican/pelican-themes to adjust themes
# see http://www.pelicanthemes.com/ to view themes
THEME = "./current-theme/elegant"

