require 'test_helper'

module DPay
  class WitnessApiTest < DPay::Test
    def setup
      @api = DPay::WitnessApi.new(url: TEST_NODE)
      @jsonrpc = Jsonrpc.new(url: TEST_NODE)
      @methods = @jsonrpc.get_api_methods[@api.class.api_name]
    end

    def test_api_class_name
      assert_equal 'WitnessApi', DPay::WitnessApi::api_class_name
    end

    def test_inspect
      assert_equal "#<WitnessApi [@chain=dpay, @methods=<2 elements>]>", @api.inspect
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

    def test_get_account_bandwidth
      vcr_cassette('witness_api_get_account_bandwidth', record: :once) do
        options = {
          account: 'dsite',
          type: 'forum'
        }

        @api.get_account_bandwidth(options) do |result|
          assert_equal Hashie::Mash, result.class
        end
      end
    end

    def test_get_reserve_ratio
      vcr_cassette('witness_api_get_reserve_ratio', record: :once) do
        @api.get_reserve_ratio do |result|
          assert_equal Hashie::Mash, result.class
        end
      end
    end
  end
end
