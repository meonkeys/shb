AUTHOR = 'Adam'
SITENAME = 'Steadfast Self-Hosting'
SITESUBTITLE = 'Rapid-Rise Personal Cloud'
SITEDESCRIPTION = 'This book will free your data and empower your users.'
SITEURL = ""

PATH = "content"

TIMEZONE = 'US/Pacific'

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

PAGE_URL = "{slug}/"
PAGE_SAVE_AS = "{slug}/index.html"

AUTHOR_URL = "author/{slug}/"
AUTHOR_SAVE_AS = "author/{slug}/index.html"

CATEGORY_URL = "category/{slug}/"
CATEGORY_SAVE_AS = "category/{slug}/index.html"

TAG_URL = "tag/{slug}/"
TAG_SAVE_AS = "tag/{slug}/index.html"

INDEX_URL = "news/"
INDEX_SAVE_AS = "news/index.html"

YEAR_ARCHIVE_SAVE_AS = 'news/{date:%Y}/index.html'
YEAR_ARCHIVE_URL = 'news/{date:%Y}/'

MONTH_ARCHIVE_SAVE_AS = 'news/{date:%Y}/{date:%m}/index.html'
MONTH_ARCHIVE_URL = 'news/{date:%Y}/{date:%m}/'

DISPLAY_PAGES_ON_MENU = True
PAGE_ORDER_BY = 'menu_order_key'

DISPLAY_CATEGORIES_ON_MENU = False

THEME = "theme"

IGNORE_FILES = ['.#*', '.*.swp', '.*.swx', '.*.un~', '*~']

STATIC_PATHS = [
    'extra/.htaccess',
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
    'extra/.htaccess': {'path': '.htaccess'},
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

MARKDOWN = {
    'extension_configs': {
        'markdown.extensions.codehilite': {'css_class': 'highlight'},
        'markdown.extensions.extra': {},
        'markdown.extensions.meta': {},
        'markdown.extensions.toc': {'permalink': True},
    },
    'output_format': 'html5',
}
