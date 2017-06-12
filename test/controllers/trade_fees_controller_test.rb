require 'test_helper'

class TradeFeesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @trade_fee = trade_fees(:one)
  end

  test "should get index" do
    get trade_fees_url
    assert_response :success
  end

  test "should get new" do
    get new_trade_fee_url
    assert_response :success
  end

  test "should create trade_fee" do
    assert_difference('TradeFee.count') do
      post trade_fees_url, params: { trade_fee: { fee_id: @trade_fee.fee_id, trade_id: @trade_fee.trade_id } }
    end

    assert_redirected_to trade_fee_url(TradeFee.last)
  end

  test "should show trade_fee" do
    get trade_fee_url(@trade_fee)
    assert_response :success
  end

  test "should get edit" do
    get edit_trade_fee_url(@trade_fee)
    assert_response :success
  end

  test "should update trade_fee" do
    patch trade_fee_url(@trade_fee), params: { trade_fee: { fee_id: @trade_fee.fee_id, trade_id: @trade_fee.trade_id } }
    assert_redirected_to trade_fee_url(@trade_fee)
  end

  test "should destroy trade_fee" do
    assert_difference('TradeFee.count', -1) do
      delete trade_fee_url(@trade_fee)
    end

    assert_redirected_to trade_fees_url
  end
end
