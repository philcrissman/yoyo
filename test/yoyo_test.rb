require 'minitest/autorun'

require 'yoyo'
require 'mocha/mini_test'

class YoyoTest < Minitest::Test
  def setup
    @test_connection = Faraday.new do |builder|
      builder.adapter :test do |stub|
        stub.post('/yo/') { [200, {}, "{\"result\": \"OK\"}"] }
        stub.post('/yoall/') { [201, {}, "{}"] }
      end
    end

    Yoyo::Yo.any_instance.stubs(:api_connection).returns(@test_connection)
  end
  
  def test_yo_initialization
    yo = Yoyo::Yo.new("some-token")
    assert_equal "some-token", yo.api_token
  end

  def test_yo_initialization_with_no_token
    assert_raises ArgumentError do
      yo = Yoyo::Yo.new
    end
  end

  def test_saying_yo
    yo = Yoyo::Yo.new("some-token")

    response = yo.yo("PHILCRISSMAN")
    assert_equal "{\"result\": \"OK\"}", response.body
  end

  def test_saying_yo_all
    yo = Yoyo::Yo.new("some-token")

    response = yo.yo_all
    assert_equal "{}", response.body
  end
end
