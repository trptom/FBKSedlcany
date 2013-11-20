class Article < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :atricle_categories
  has_many :comments, dependent: :destroy
  has_many :marks, dependent: :destroy
  
  attr_accessible :annotation, :content, :title, :comments, :user, :atricle_categories, :markings, :image

  mount_uploader :image, ArticleImageUploader
  
  scope :newest, ->(limit = ARTICLES_LIST_PAGE_LIMIT) {
    order("created_at DESC")
        .limit(limit)
  }

  scope :most_commented, ->(limit = ARTICLES_LIST_PAGE_LIMIT) {
    select("articles.*, COUNT(comments.id) AS comments")
        .joins("LEFT OUTER JOIN comments ON articles.id = comments.article_id")
        .group("articles.id")
        .order("comments DESC, created_at DESC")
        .limit(limit)
  }

  scope :top_marked, ->(limit = ARTICLES_LIST_PAGE_LIMIT) {
    select("articles.*, AVG(marks.value) AS avg_marks")
        .joins("LEFT OUTER JOIN marks ON articles.id = marks.article_id")
        .group("articles.id")
        .order("avg_marks DESC, created_at DESC")
        .limit(limit)
  }

  def get_mark_points
    sum = 0
    for mark in marks
      sum += mark.value
    end
    return sum
  end

  def get_average_mark
    return marks.count > 0 ? get_mark_points / marks.count : nil
  end

  def get_average_mark_str
    mark = get_average_mark
    if mark == nil
      return I18n.t("messages.base.no_marks")
    else
      return mark.round(ROUND_MARK_TO_DECIMAL).to_s
    end
  end

  def get_annotation
    if annotation != nil && annotation != ""
      return annotation;
    end

    tmp = content.split(" ")
    str = ""
    a = 0

    while (a < tmp.length) && (str.length + tmp[a].length < ARTICLE_PARSED_ANNOTATION_LENGTH)
      str += (a > 0) ? (" " + tmp[a]) : tmp[a]
      a = a + 1
    end

    return str == content ? str : str + "..."
  end
end
