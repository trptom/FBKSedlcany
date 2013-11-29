class Article < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :atricle_categories
  has_many :comments, dependent: :destroy
  has_many :marks, dependent: :destroy
  
  attr_accessible(
    :title,
    :annotation,
    :content,
    :comments,
    :user,
    :atricle_categories,
    :markings,
    :image,
    :image_cache
  )

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
  
  scope :contains_text, ->(phrase) {
    phrase = phrase.downcase
    where("(lower(title) LIKE ?)OR(lower(title) LIKE ?)", "%#{phrase}%", "%#{phrase}%")
  }
  
  scope :published_between, ->(min_date, max_date) {
    published_before(max_date).published_after(min_date)
  }
  
  scope :published_before, ->(max_date) {
    where('(created_at <= ?)', max_date)
  }
  
  scope :published_after, ->(min_date) {
    where('(created_at >= ?)', min_date)
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
  
  def get_image_or_default_url(type = :small)
    if image_url != nil
      return image_url(type)
    else
      return DEFAULT_IMAGES[:article_image][type]
    end
  end
end
