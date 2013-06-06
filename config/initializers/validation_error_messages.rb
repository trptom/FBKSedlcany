# coding:utf-8

VALIDATION_ERROR_MESSAGE = YAML::load_file(File.open(Rails.root.join('config', 'validation_error_messages.yml')))
#
#VALIDATION_ERROR_MESSAGE = {
#  :article => {
#    :title => "špatná délka titulku (musí mít 3-50 znaků)",
#    :annotation => "špatná délka stručného popisu (prázdné nebo 50-255 znaků)",
#    :content => "špatná délka obsahu (musí mít alespoň 100 znaků)",
#    :user_id => "chybný uživatel"
#  },
#  :comment => {
#    :content => "obsah nesmí být prázdný",
#    :user_id => "chybný uživatel"
#  },
#  :ingredience => {
#    :name => {
#      :length => "špatná délka názvu (musí mít 3-50 znaků)",
#      :uniqueness => "ingredience s daným názvem již existuje"
#    },
#    :annotation => "špatná délka stručného popisu (může být prázdné nebo 50-255 znaků)",
#    :content => "špatná délka obsahu (musí mít alespoň 100 znaků)",
#    :avaliability => "chybná dostupnost (musí být v rozmezí 1-1000)",
#    :activation_state => "chybný aktivační status (musí být v rozmezí 0-1)",
#    :units => "špatný název jednotek (nesmí být prázdný)",
#    :user_id => "chybný uživatel"
#  },
#  :ingredience_category => {
#    :name => "špatná délka názvu (musí mít 3-255 znaků)",
#    :description => "špatná délka popisu (musí být prázdný nebo mít alespoň 20 znaků)",
#    :category_type => "chybná kategorie (musí být > 0)",
#    :user_id => "chybný uživatel"
#  },
#  :ingredience_recipe_connector => {
#    :importance => "chybná důležitost (musí být v rozmezí 1-1000)",
#    :quantity => "chybné množství (musí být > 0)"
#  },
#  :mark => {
#    :value => "chybná hodnota (musí být v rozmezí 1-5)"
#  },
#  :recipe => {
#    :name => "špatná délka názvu (musí mít 3-50 znaků)",
#    :annotation => "špatná délka stručného popisu (musí být prázdné nebo mít 50-255 znaků)",
#    :content => "špatná délka obsahu (musí mít alespoň 100 znaků)",
#    :level => "náročnost není celé číslo v povoleném intervalu",
#    :estimated_time => "špatný odhadovaný čas (musí být celé číslo > 0)",
#    :user_id => "chybný uživatel"
#  },
#  :recipe_category => {
#    :name => "špatná délka názvu (musí mít 3-255 znaků)",
#    :description => "špatná délka popisu (musí být prázdný nebo mít alespoň 20 znaků)",
#    :category_type => "chybná kategorie (musí být > 0)",
#    :user_id => "chybný uživatel"
#  },
#  :recipe_recipe_connector => {
#    # neni zadna validace
#  },
#  :user => {
#    :username => {
#      :format => "chybný formát uživatelského jména (může obsahovat znaky A-Z (bez diakritiky), čísla a znaky ._-, délka 3-30)",
#      :uniqueness => "uživatel s daným uživatelským jménem již existuje"
#    },
#    :email => {
#      :format => "chybný formát emailu",
#      :uniqueness => "uživatel s daným emailem již existuje"
#    },
#    :password => {
#      :length => "špatná délka hesla (musí mít 3-255 znaků)",
#      :confirmation => "heslo a kontrola hesla jsou různé"
#    },
#    :first_name => "chybný formát jména (musí mít alespoň 2 znaky)",
#    :second_name => "chybný formát příjmení (musí mít alespoň 2 znaky)",
#    :age => "chybný věk (musí být v rozmezí 1-100)",
#    :self_ruleset => "ruleset (self) není celé číslo",
#    :others_ruleset => "ruleset (others) není celé číslo"
#  }
#}