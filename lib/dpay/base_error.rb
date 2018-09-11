module DPay
  class BaseError < StandardError
    def initialize(error = nil, cause = nil)
      @error = error
      @cause = cause
    end
    
    def to_s
      detail = {}
      detail[:error] = @error if !!@error
      detail[:cause] = @cause if !!@cause
      
      JSON[detail] rescue detai.to_s
    end
    
    def self.build_error(error, context)
      if error.message == 'Unable to acquire database lock'
        raise DPay::RemoteDatabaseLockError, error.message, build_backtrace(error)
      end
      
      if error.message.include? 'Internal Error'
        raise DPay::RemoteNodeError.new, error.message, build_backtrace(error)
      end
      
      if error.message.include? 'Server error'
        raise DPay::RemoteNodeError.new, error.message, build_backtrace(error)
      end
      
      if error.message.include? 'plugin not enabled'
        raise DPay::PluginNotEnabledError, error.message, build_backtrace(error)
      end
      
      if error.message.include? 'argument'
        raise DPay::ArgumentError, "#{context}: #{error.message}", build_backtrace(error)
      end
      
      if error.message.include? 'Invalid params'
        raise DPay::ArgumentError, "#{context}: #{error.message}", build_backtrace(error)
      end
      
      if error.message.start_with? 'Bad Cast:'
        raise DPay::ArgumentError, "#{context}: #{error.message}", build_backtrace(error)
      end
      
      if error.message.include? 'prefix_len'
        raise DPay::ArgumentError, "#{context}: #{error.message}", build_backtrace(error)
      end
      
      if error.message.include? 'Parse Error'
        raise DPay::ArgumentError, "#{context}: #{error.message}", build_backtrace(error)
      end
      
      if error.message.include? 'unknown key'
        raise DPay::ArgumentError, "#{context}: #{error.message} (or content has been deleted)", build_backtrace(error)
      end
      
      if error.message.include? 'Comment is not in account\'s comments'
        raise DPay::ArgumentError, "#{context}: #{error.message}", build_backtrace(error)
      end
      
      if error.message.include? 'Could not find comment'
        raise DPay::ArgumentError, "#{context}: #{error.message}", build_backtrace(error)
      end
      
      if error.message.include? 'unable to convert ISO-formatted string to fc::time_point_sec'
        raise DPay::ArgumentError, "#{context}: #{error.message}", build_backtrace(error)
      end
      
      if error.message.include? 'Input data have to treated as object.'
        raise DPay::ArgumentError, "#{context}: #{error.message}", build_backtrace(error)
      end
      
      if error.message.include? 'base.amount > share_type(0)'
        raise DPay::ArgumentError, "#{context}: #{error.message}", build_backtrace(error)
      end
      
      if error.message.include? 'blk->transactions.size() > itr->trx_in_block'
        raise DPay::VirtualOperationsNotAllowedError, "#{context}: #{error.message}", build_backtrace(error)
      end
      
      if error.message.include? 'A transaction must have at least one operation'
        raise DPay::EmptyTransactionError, "#{context}: #{error.message}", build_backtrace(error)
      end
      
      if error.message.include? 'transaction expiration exception'
        raise DPay::TransactionExpiredError, "#{context}: #{error.message}", build_backtrace(error)
      end
      
      if error.message.include? 'Duplicate transaction check failed'
        raise DPay::DuplicateTransactionError, "#{context}: #{error.message}", build_backtrace(error)
      end
      
      if error.message.include? 'signature is not canonical'
        raise DPay::NonCanonicalSignatureError, "#{context}: #{error.message}", build_backtrace(error)
      end
      
      if error.message.include? 'attempting to push a block that is too old'
        raise DPay::BlockTooOldError, "#{context}: #{error.message}", build_backtrace(error)
      end
      
      if error.message.include? 'irrelevant signature'
        raise DPay::IrrelevantSignatureError, "#{context}: #{error.message}", build_backtrace(error)
      end
      
      if error.message.include? 'missing required posting authority'
        raise DPay::MissingPostingAuthorityError, "#{context}: #{error.message}", build_backtrace(error)
      end
      
      if error.message.include? 'missing required active authority'
        raise DPay::MissingActiveAuthorityError, "#{context}: #{error.message}", build_backtrace(error)
      end
      
      if error.message.include? 'missing required owner authority'
        raise DPay::MissingOwnerAuthorityError, "#{context}: #{error.message}", build_backtrace(error)
      end
      
      if error.message.include? 'missing required other authority'
        raise DPay::MissingOtherAuthorityError, "#{context}: #{error.message}", build_backtrace(error)
      end
      
      if error.message.include? 'Upstream response error'
        raise DPay::UpstreamResponseError, "#{context}: #{error.message}", build_backtrace(error)
      end
      
      if error.message.include? 'Bad or missing upstream response'
        raise DPay::BadOrMissingUpstreamResponseError, "#{context}: #{error.message}", build_backtrace(error)
      end
      
      if error.message.include? 'operator has disabled operation indexing by transaction_id'
        raise DPay::TransactionIndexDisabledError, "#{context}: #{error.message}", build_backtrace(error)
      end
      
      if error.message.include? 'is_valid_account_name'
        raise DPay::InvalidAccountError, "#{context}: #{error.message}", build_backtrace(error)
      end
      
      if error.message.include?('Method') && error.message.include?(' does not exist.')
        raise DPay::UnknownMethodError, "#{context}: #{error.message}", build_backtrace(error)
      end
      
      if error.message.include? 'Invalid operation name'
        raise DPay::UnknownOperationError, "#{context}: #{error.message}", build_backtrace(error)
      end
      
      if error.message =~ /Invalid object name: .+_operation/
        raise DPay::UnknownOperationError, "#{context}: #{error.message}", build_backtrace(error)
      end
      
      if error.message.include? 'Author not found'
        raise DPay::AuthorNotFoundError, "#{context}: #{error.message}", build_backtrace(error)
      end
      
      if error.message.include? ' != fc::time_point_sec::maximum()'
        raise DPay::ReachedMaximumTimeError, "#{context}: #{error.message}", build_backtrace(error)
      end
      
      if error.message.include? 'Cannot transfer a negative amount (aka: stealing)'
        raise DPay::TheftError, "#{context}: #{error.message}", build_backtrace(error)
      end
      
      if error.message.include? 'Must transfer a nonzero amount'
        raise DPay::NonZeroRequiredError, "#{context}: #{error.message}", build_backtrace(error)
      end
      
      if error.message.include? 'is_asset_type'
        raise DPay::UnexpectedAssetError, "#{context}: #{error.message}", build_backtrace(error)
      end
      
      puts JSON.pretty_generate(error) if ENV['DEBUG']
      raise UnknownError, "#{context}: #{error.message}", build_backtrace(error)
    end
  private
    def self.build_backtrace(error)
      backtrace = Thread.current.backtrace.reject{ |line| line =~ /base_error/ }
      JSON.pretty_generate(error) + "\n" + backtrace.join("\n")
    end
  end
  
  class UnsupportedChainError < BaseError; end
  class ArgumentError < BaseError; end
  class TypeError < BaseError; end
  class EmptyTransactionError < ArgumentError; end
  class InvalidAccountError < ArgumentError; end
  class AuthorNotFoundError < ArgumentError; end
  class ReachedMaximumTimeError < ArgumentError; end
  class VirtualOperationsNotAllowedError < ArgumentError; end
  class TheftError < ArgumentError; end
  class NonZeroRequiredError < ArgumentError; end
  class UnexpectedAssetError < ArgumentError; end
  class TransactionExpiredError < BaseError; end
  class DuplicateTransactionError < TransactionExpiredError; end
  class NonCanonicalSignatureError < TransactionExpiredError; end
  class BlockTooOldError < BaseError; end
  class IrrelevantSignatureError < BaseError; end
  class MissingAuthorityError < BaseError; end
  class MissingPostingAuthorityError < MissingAuthorityError; end
  class MissingActiveAuthorityError < MissingAuthorityError; end
  class MissingOwnerAuthorityError < MissingAuthorityError; end
  class MissingOtherAuthorityError < MissingAuthorityError; end
  class IncorrectRequestIdError < BaseError; end
  class IncorrectResponseIdError < BaseError; end
  class RemoteNodeError < BaseError; end
  class UpstreamResponseError < RemoteNodeError; end
  class RemoteDatabaseLockError < UpstreamResponseError; end
  class PluginNotEnabledError < UpstreamResponseError; end
  class BadOrMissingUpstreamResponseError < UpstreamResponseError; end
  class TransactionIndexDisabledError < BaseError; end
  class NotAppBaseError < BaseError; end
  class UnknownApiError < BaseError; end
  class UnknownMethodError < BaseError; end
  class UnknownOperationError < BaseError; end
  class JsonRpcBatchMaximumSizeExceededError < BaseError; end
  class TooManyTimeoutsError < BaseError; end
  class TooManyRetriesError < BaseError; end
  class UnknownError < BaseError; end
end
