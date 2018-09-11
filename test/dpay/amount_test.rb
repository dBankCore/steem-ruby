require 'test_helper'

module DPay
  class AmountTest < DPay::Test
    def setup
      @amount = DPay::Type::Amount.new('0.000 BEX')
    end

    def test_to_s
      assert_equal '0.000 BBD', DPay::Type::Amount.to_s(['0', 3, '@@000000013'])
      assert_equal '0.000 BEX', DPay::Type::Amount.to_s(['0', 3, '@@000000021'])
      assert_equal '0.000000 VESTS', DPay::Type::Amount.to_s(['0', 6, '@@000000037'])

      assert_raises TypeError do
        DPay::Type::Amount.to_s(['0', 3, '@@00000000'])
      end
    end

    def test_to_h
      assert_equal({amount: '0', precision: 3, nai: '@@000000013'}, DPay::Type::Amount.to_h('0.000 BBD'))
      assert_equal({amount: '0', precision: 3, nai: '@@000000021'}, DPay::Type::Amount.to_h('0.000 BEX'))
      assert_equal({amount: '0', precision: 6, nai: '@@000000037'}, DPay::Type::Amount.to_h('0.000000 VESTS'))

      assert_raises TypeError do
        DPay::Type::Amount.to_h('0.000 BOGUS')
      end
    end

    def test_to_bytes
      assert @amount.to_bytes
    end
  end
end
