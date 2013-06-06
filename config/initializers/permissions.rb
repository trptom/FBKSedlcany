# coding:utf-8

# inicializator opravneni

ROLES = [
  :root, # prvni ucet
  :admin, # kompletni kontrola

  :articles_editor,
  :comments_editor, # muze pridavat a mazat komentare (ne komentovat)
  :users_editor,

  :commenter # muze komentovat
]