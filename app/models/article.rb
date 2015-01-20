class Article < ActiveRecord::Base

  @@alchemy_url ||= ENV["ALCHEMY_URL"]

  belongs_to :user

  has_many :tags
  
  validates_presence_of :title
  
  validates_presence_of :content
  
  after_save :get_keywords

  def author
   "#{user[:last_name]}, #{user[:first_name]}"
  end


  def owned_by?(user)
    self.user_id == user.id
  end

  def get_keywords
    if content.length > 500
      res = Typhoeus.get(@@alchemy_url, params: {
        apikey: ENV["ALCHEMY_APIKEY"],
        text: content,
        maxRetrieve: 10,
        outputMode: "json"
      })
      words = JSON.parse(res.body)["keywords"].map do |w|
        tags.create({ text: w['text'] })
      end

    end

  end

  def keywords
    unless @keywords
      words = tags.map {|t| t.text }
      @keywords = words.join(" | ")
    else
      @keywords
    end
  end

end
