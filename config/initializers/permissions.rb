# coding:utf-8

# inicializator opravneni

ROLES = [
  :root, # prvni ucet
  :admin, # kompletni kontrola

  :articles_editor,
  :comments_editor, # muze pridavat a mazat komentare (ne komentovat)
  :users_editor,
  :players_editor,
  :teams_editor, # vztahuje se na oddily i tymy

  :commenter # muze komentovat
]

ROLE_MESSAGES = Hash.new
for key in ROLES
  ROLE_MESSAGES[key] = "messages.roles." + key.to_s
end

DEFAULT_ROLE = [
  :commenter
]