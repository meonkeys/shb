AUTHOR = 'Adam'
SITENAME = 'Steadfast Self-Hosting'
SITESUBTITLE = 'Rapid-Rise Personal Cloud'
SITEDESCRIPTION = 'This book will free your data and empower your users.'
SITEURL = ""

PATH = "content"

TIMEZONE = 'US/Pacific'

# When set, I get this likely spurious warning: "Locale could not be set. Check the LOCALE setting, ensuring it is valid and available on your system."
#LOCALE = ('en_US')

# en is the default
#DEFAULT_LANG = 'en'

# I don't intend to post too often.
DEFAULT_DATE_FORMAT = '%B %Y'

# Feed generation is usually not desired when developing
FEED_ALL_ATOM = None
CATEGORY_FEED_ATOM = None
TRANSLATION_FEED_ATOM = None
AUTHOR_FEED_ATOM = None
AUTHOR_FEED_RSS = None

MENUITEMS = [
    ('🗞️ News', '/news/'),
]

DEFAULT_PAGINATION = 10

ARTICLE_URL = 'news/{date:%Y}/{date:%m}/{slug}/'
ARTICLE_SAVE_AS = 'news/{date:%Y}/{date:%m}/{slug}/index.html'

# https://deaddabe.fr/blog/2020/08/30/using-and-extending-the-attach-directive-in-pelican/
PAGE_URL = "{slug}/"
PAGE_SAVE_AS = "{slug}/index.html"

AUTHOR_URL = "author/{slug}/"
AUTHOR_SAVE_AS = "author/{slug}/index.html"

INDEX_URL = "news/"
INDEX_SAVE_AS = "news/index.html"

# Blogroll
#LINKS = (
#    ("Pelican", "https://getpelican.com/"),
#    ("Python.org", "https://www.python.org/"),
#    ("Jinja2", "https://palletsprojects.com/p/jinja/"),
#)

# Social widget
#SOCIAL = (
#    ("You can add links in your config file", "#"),
#    ("Another social link", "#"),
#)

DISPLAY_PAGES_ON_MENU = True
PAGE_ORDER_BY = 'menu_order_key'

DISPLAY_CATEGORIES_ON_MENU = False

THEME = "theme"

IGNORE_FILES = ['.#*', '.*.swp', '.*.swx', '.*.un~', '*~']

STATIC_PATHS = [
    'extra/android-chrome-192x192.png',
    'extra/android-chrome-512x512.png',
    'extra/apple-touch-icon.png',
    'extra/favicon-16x16.png',
    'extra/favicon-32x32.png',
    'extra/favicon-credit.txt',
    'extra/favicon.ico',
    'extra/robots.txt',
    'extra/site.webmanifest',
]

EXTRA_PATH_METADATA = {
    'extra/android-chrome-192x192.png': {'path': 'android-chrome-192x192.png'},
    'extra/android-chrome-512x512.png': {'path': 'android-chrome-512x512.png'},
    'extra/apple-touch-icon.png': {'path': 'apple-touch-icon.png'},
    'extra/favicon-16x16.png': {'path': 'favicon-16x16.png'},
    'extra/favicon-32x32.png': {'path': 'favicon-32x32.png'},
    'extra/favicon-credit.txt': {'path': 'favicon-credit.txt'},
    'extra/favicon.ico': {'path': 'favicon.ico'},
    'extra/robots.txt': {'path': 'robots.txt'},
    'extra/site.webmanifest': {'path': 'site.webmanifest'},
}

TYPOGRIFY = True
