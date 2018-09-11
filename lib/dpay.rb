# encoding: UTF-8
require 'json' unless defined?(JSON)
require 'net/https'

require 'hashie'
require 'dpay/version'
require 'dpay/utils'
require 'dpay/base_error'
require 'dpay/mixins/retriable'
require 'dpay/chain_config'
require 'dpay/type/base_type'
require 'dpay/type/amount'
require 'dpay/transaction_builder'
require 'dpay/rpc/base_client'
require 'dpay/rpc/http_client'
require 'dpay/rpc/thread_safe_http_client'
require 'dpay/api'
require 'dpay/jsonrpc'
require 'dpay/block_api'
require 'dpay/formatter'
require 'dpay/broadcast'
require 'dpay/stream'

module DPay
  def self.api_classes
    @api_classes ||= {}
  end
  
  def self.const_missing(api_name)
    api = api_classes[api_name]
    api ||= Api.clone(freeze: true) rescue Api.clone
    api.api_name = api_name
    api_classes[api_name] = api
  end
end

Hashie.logger = Logger.new(ENV['HASHIE_LOGGER'])
