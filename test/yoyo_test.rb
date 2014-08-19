require 'minitest/autorun'

require 'yoyo'
require 'mocha/mini_test'

class YoyoTest < Minitest::Test
  def yo
    @yo ||= Yoyo::Yo.new("some-token")
  end

  def setup
    @test_connection = Faraday.new do |builder|
      builder.adapter :test do |stub|
        stub.post('/yo/') { [200, {}, "{\"result\": \"OK\"}"] }
        stub.post('/yoall/') { [201, {}, "{}"] }
        stub.get('/subscribers_count/') { [200, {}, "{\"result\": 9001}"] }
      end
    end

    Yoyo::Yo.any_instance.stubs(:api_connection).returns(@test_connection)
  end

  def test_yo_initialization
    assert_equal "some-token", yo.api_token
  end

  def test_yo_initialization_with_no_token
    assert_raises ArgumentError do
      Yoyo::Yo.new
    end
  end

  def test_saying_yo
    yo.yo("PHILCRISSMAN")
    assert_equal "{\"result\": \"OK\"}", yo.result.response.body
    assert_equal({'result' => "OK"}, yo.result.parsed)
    assert_equal "OK", yo.result.result
    assert_equal nil, yo.result.error
  end

  def test_rate_limited
    @rate_limited_test_connection = Faraday.new do |builder|
      builder.adapter :test do |stub|
        stub.post('/yo/') { [400, {}, "\"Rate limit exceeded. Only one Yo per recipient per minute.\""] }
      end
    end

    Yoyo::Yo.any_instance.stubs(:api_connection).returns(@rate_limited_test_connection)

    yo.yo("PHILCRISSMAN")
    assert_equal "\"Rate limit exceeded. Only one Yo per recipient per minute.\"", yo.result.response.body
    assert_equal "Rate limit exceeded. Only one Yo per recipient per minute.", yo.result.error

    Yoyo::Yo.any_instance.unstub(:api_connection)
  end

  def test_saying_yo_all
    yo.yo_all
    assert_equal "{}", yo.result.response.body
  end

  def test_get_subscriber_count
    assert_equal 9001, yo.subscribers_count
  end

  def test_yo_with_link
    yo.yo("PHILCRISSMAN", link: "http://justyo.co")
    assert_equal({'result' => "OK"}, yo.result.parsed)
  end

  def test_yo_all_with_link
    yo.yo_all link: "http://justyo.co"
    assert_equal "{}", yo.result.response.body
  end
end
