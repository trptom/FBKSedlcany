# coding:utf-8

# kam ma byt presmerovavano pri not_found
NOT_FOUND_PAGE_URL = "/404.html"

# nastaveni napr. pro textace
TEAM_NAME = "TJ Tatran Sedlčany florbal"
TEAM_NAME_SHORT = "Florbal Sedlčany"
TEAM_NAME_SHORTCUT = "SED"

# pole tymu, u kterych muze byt zobrazena soupiska beznym uzivatelem; porovnava
# se s nazvem, kratkym nazvem i zkratkou
TEAMS_WITH_VIEWABLE_SQUAD = [
  /^.*Sedlčany.*$/
]
TEAMS_WITH_VIEWABLE_GAMES = [
  /^.*Sedlčany.*$/
]

# pocet clanku na stranku
ARTICLES_LIST_PAGE_LIMIT = 10

# max. delka anotace, parsovane z contentu (ve znacich)
ARTICLE_PARSED_ANNOTATION_LENGTH = 500

# razeni komentaru - pouzito v order funkci activerecord
COMMENTS_ORDER = :updated_at
# datum z timestamps, tere bude zobrazeno v hlavicce komentare
COMMENT_PRESENTED_DATE = :updated_at

#nastaveni defaultniho admin uctu
ROOT_ACCOUNT_USERNAME = "admin"
ROOT_ACCOUNT_PASSWORD = "root"
ROOT_ACCOUNT_EMAIL = "admin@fbksedlcany.com"

# zaokrouhlovani
ROUND_MARK_TO_DECIMAL = 2 # vypis znamky - pocet desetinnych mist

# znamkovani
MARK_MIN = 1; # minimalni znamka (vcetne)
MARK_MAX = 5; # maximalni znamka (vcetne)

# drzeni hokejky
STICK_HOLDING_LEFT = 0
STICK_HOLDING_RIGHT = 1

# vyska
MIN_HEIGHT = 150
MAX_HEIGHT = 220

# vaha
MIN_WEIGHT = 40
MAX_WEIGHT = 150

# informace o soutezi
MIN_COMPETITION_LEVEL = 1
MAX_COMPETITION_LEVEL = 10
MIN_COMPETITION_GROUP = 1
MAX_COMPETITION_GROUP = 20

# informace o zapase
GAME_SEASON_MAX_BACK = 10 # o kolik let muzu jit pri vytvareni/editaci zapasu max. nazpatek

# defaultni obrazky
DEFAULT_IMAGES = {
  :article_image => "default/no_photo.jpg",
  :player_icon => "default/no_photo.jpg"
}

# panel na prave strane app
RIGHTSIDE_PANEL = {
  :random_players_count => 3,
  :last_games_count => 3,
  :next_games_count => 3
}