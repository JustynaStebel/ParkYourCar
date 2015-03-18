require 'minitest/autorun'
require './example'

class ArticleTest < Minitest::Test

  def setup
    @article = Article.new("test_title", "test_body", "test_author")
  end

  def test_initialization
    assert_equal "test_title", @article.title
    assert_equal "test_body", @article.body
    assert_equal "test_author", @article.author
    assert_in_delta Time.now, @article.created_at
    assert_equal 0, @article.likes
    assert_equal 0, @article.dislikes
  end

  def test_initialization_with_anonymous_author
    test_article = Article.new("test_title", "test_body")
    assert_nil test_article.author 
  end

  def test_liking
    3.times { @article.like! }

    assert_equal(3, @article.likes)
  end

  def test_disliking
    3.times { @article.dislike! }

    assert_equal(3, @article.dislikes)
  end

  def test_points
    @article.likes = 5
    @article.dislikes = 4

    assert_equal(1, @article.points)
  end

  def test_long_lines
    long_line = "1" * 100 + "\n" + "a" * 11
    article = Article.new("title1", long_line)
    assert_equal([long_line], article.long_lines)
  end

  def test_truncate
    assert_equal("tes...", @article.truncate(6))
  end

  def test_truncate_when_limit_is_longer_then_body
    assert_equal("test_body", @article.truncate(10))
  end

  def test_truncate_when_limit_is_same_as_body_length
    assert_equal("test_body", @article.truncate(9))
  end

  def test_length
    assert_equal(9, @article.length)
  end

  def test_votes
    @article.dislikes = 4
    @article.likes = 5

    assert_equal(9, @article.votes)
  end

  def test_contain
    assert_equal(true, @article.contain?("body"))
    assert_equal(true, @article.contain?(/body/))
    assert_equal(false, @article.contain?("domek"))
    assert_equal(false, @article.contain?(/domek/))
  end
end

class ArticlesFileSystemTest < Minitest::Test

  def setup
    @article_file_system = Article_File_System.new("dir_name")
  end

  def test_saving
  end

  def test_loading
  end

  def teardown
  end

end
