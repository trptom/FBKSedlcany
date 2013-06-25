# coding:utf-8

# kam ma byt presmerovavano pri not_found
NOT_FOUND_PAGE_URL = "/404.html"

# nastaveni napr. pro textace
TEAM_NAME = "TJ Tatran Sedlčany florbal"
TEAM_NAME_SHORT = "Florbal Sedlčany"
TEAM_NAME_SHORTCUT = "SED"

# pocet clanku na stranku
ARTICLES_LIST_PAGE_LIMIT = 10

# razeni komentaru - pouzito v order funkci activerecord
COMMENTS_ORDER = :updated_at
# datum z timestamps, tere bude zobrazeno v hlavicce komentare
COMMENT_PRESENTED_DATE = :updated_at

#nastaveni defaultniho admin uctu
ROOT_ACCOUNT_USERNAME = "admin"
ROOT_ACCOUNT_PASSWORD = "root"
ROOT_ACCOUNT_EMAIL = "admin@fbksedlcany.com"