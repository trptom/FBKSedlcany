# coding:utf-8

# inicializator opravneni

ROLES = [
  :root, # prvni ucet
  :admin, # kompletni kontrola

  :articles_editor,
  :comments_editor, # muze pridavat a mazat komentare (ne komentovat)
  :users_editor,
  :leagues_editor,
  :players_editor,
  :halls_editor,
  :games_editor,
  :teams_editor, # vztahuje se na oddily i tymy
  :images_uploader,
  :wikis_editor, # muze editovat veskere wiki stranky

  :commenter, # muze komentovat
  :marker # muze znamkovat
]

ROLE_MESSAGES = Hash.new
for key in ROLES
  ROLE_MESSAGES[key.to_s] = "messages.roles." + key.to_s
end

DEFAULT_ROLE = [
  :commenter,
  :marker
]