require 'test_helper'

module DPay
  class FollowApiTest < DPay::Test
    def setup
      @api = DPay::FollowApi.new(url: TEST_NODE)
      @jsonrpc = Jsonrpc.new(url: TEST_NODE)
      @methods = @jsonrpc.get_api_methods[@api.class.api_name]
    end
    def test_api_class_name
      assert_equal 'FollowApi', DPay::FollowApi::api_class_name
    end

    def test_inspect
      assert_equal "#<FollowApi [@chain=dpay, @methods=<10 elements>]>", @api.inspect
    end

    def test_method_missing
      assert_raises NoMethodError do
        @api.bogus
      end
    end

    def test_all_respond_to
      @methods.each do |key|
        assert @api.respond_to?(key), "expect rpc respond to #{key}"
      end
    end

    def test_get_account_reputations
      vcr_cassette('follow_api_get_account_reputations', record: :once) do
        options = {
          account_lower_bound: 'dsite',
          limit: 0
        }

        @api.get_account_reputations(options) do |result|
          assert_equal Hashie::Array, result.reputations.class
        end
      end
    end

    def test_get_blog
      vcr_cassette('follow_api_get_blog', record: :once) do
        options = {
          account: 'dsite',
          start_entry_id: 0,
          limit: 0
        }

        @api.get_blog(options) do |result|
          assert_equal Hashie::Array, result.blog.class
        end
      end
    end

    def test_get_blog_authors
      vcr_cassette('follow_api_get_blog_authors', record: :once) do
        options = {
          blog_account: 'dsite'
        }

        @api.get_blog_authors(options) do |result|
          assert_equal Hashie::Array, result.blog_authors.class
        end
      end
    end

    def test_get_blog_entries
      vcr_cassette('follow_api_get_blog_entries', record: :once) do
        options = {
          account: 'dsite',
          start_entry_id: 0,
          limit: 0
        }

        @api.get_blog_entries(options) do |result|
          assert_equal Hashie::Array, result.blog.class
        end
      end
    end

    def test_get_feed
      vcr_cassette('follow_api_get_feed', record: :once) do
        options = {
          account: 'dsite',
          start_entry_id: 0,
          limit: 0
        }

        @api.get_feed(options) do |result|
          assert_equal Hashie::Array, result.feed.class
        end
      end
    end

    def test_get_feed_entries
      vcr_cassette('follow_api_get_feed_entries', record: :once) do
        options = {
          account: 'dsite',
          start_entry_id: 0,
          limit: 0
        }

        @api.get_feed_entries(options) do |result|
          assert_equal Hashie::Array, result.feed.class
        end
      end
    end

    def test_get_follow_count
      vcr_cassette('follow_api_get_follow_count', record: :once) do
        options = {
          account: 'dsite'
        }

        @api.get_follow_count(options) do |result|
          assert_equal Hashie::Mash, result.class
          assert_equal 'dsite', result.account
          follower_count = result.follower_count
          following_count = result.following_count
          skip "Fixnum is deprecated." if follower_count.class.to_s == 'Fixnum'
          assert_equal Integer, follower_count.class
          assert_equal Integer, following_count.class
        end
      end
    end

    def test_get_followers
      vcr_cassette('follow_api_get_followers', record: :once) do
        options = {
          account: 'dsite',
          start: nil,
          type: 'blog',
          limit: 0
        }

        @api.get_followers(options) do |result|
          assert_equal Hashie::Array, result.followers.class
        end
      end
    end

    def test_get_following
      vcr_cassette('follow_api_get_following', record: :once) do
        options = {
          account: 'dsite',
          start: nil,
          type: 'blog',
          limit: 0
        }

        @api.get_following(options) do |result|
          assert_equal Hashie::Array, result.following.class
        end
      end
    end

    def test_get_reblogged_by
      vcr_cassette('follow_api_get_reblogged_by', record: :once) do
        options = {
          author: 'dsite',
          permlink: 'firstpost'
        }

        @api.get_reblogged_by(options) do |result|
          assert_equal Hashie::Array, result.accounts.class
        end
      end
    end
  end
end
