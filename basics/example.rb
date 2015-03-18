class Article
  attr_accessor :likes, :dislikes
  attr_reader :title, :body, :author, :created_at

  def initialize(title, body, author = nil )
    @title = title
    @body = body
    @author = author
    @created_at = Time.now
    @likes = 0
    @dislikes = 0
  end

  def like!
    @likes += 1
  end

  def dislike!
    @dislikes += 1
  end

  def points
    likes - dislikes
  end

  def votes
    likes + dislikes
  end

  def long_lines
    body.lines.select { |line| line.size > 80 }
  end

  def length
    body.length
  end

  def truncate(limit)
    length > limit ? body[0, limit - 3] + "..." : body
  end

  def contain?(pattern)
    !!body.index(pattern)
  end
end

class ArticlesFileSystem
  attr_reader :dir_name

  def initialize(dir_name)
    @dir_name = dir_name
  end

  def save(articles)
    articles.each do |article|
      file_name = article.title.downcase.tr(" ", "_") + ".article"
      file_body = [article.author, article.likes, article.dislikes, article.body].join("||")
      File.open(dir_name + "/" + file_name, "w") { |file| file.write(file_body) }
    end
  end

  def load
    article_file_names = Dir.glob(dir_name + "/*.article")
    article_file_names.map do |file_name|
      title = file_name.match(/(\w+)\.article$/)[1].tr("_", " ").capitalize
      contents = File.read(file_name).split("||")
      author = contents[0]
      likes = contents[1].to_i
      dislikes = contents[2].to_i
      body = contents[3]
      article = Article.new(title, body, author)
      article.likes = likes
      article.dislikes = dislikes
      article

    end
  end
end

class WebPage

  class NoArticlesFound < StandardError
  end

  attr_reader :articles

  def initialize(dir_name = "/")
    @file_system = ArticlesFileSystem.new(dir_name)
    load
  end

  def load
    @articles = @file_system.load
  end

  def save
    @file_system.save(@articles)
  end

  def new_article(title, body, author)
    @articles << Article.new(title, body, author) 
  end

  def longest_articles
    @articles.sort_by { |body| body.length }.reverse
  end

  def best_articles
    @articles.sort_by { |article| article.points }.reverse
  end

  def worst_articles
    best_articles.reverse
  end

  def best_article
    raise WebPage::NoArticlesFound if @articles.empty?
    best_articles.first
  end

  def worst_article
    raise WebPage::NoArticlesFound if @articles.empty?
    best_articles.last
  end

  def most_controversial_articles
    @articles.sort_by { |article| article.votes }.reverse
  end

  def votes
    @articles.inject(0) { |sum, article| sum + article.votes } 
  end

  def authors
    @articles.map { |article| article.author }.uniq
  end

  def authors_statistics
    statistics = Hash.new(0)
    @articles.each { |article| statistics[article.author] += 1 }
    statistics
  end

  def best_author
    authors_statistics.max_by { |_, v| v }.first
  end

  def search(query)
    @articles.select { |article| article.contain?(query) }
  end


end
