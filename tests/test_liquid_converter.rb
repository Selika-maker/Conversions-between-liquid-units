# test_liquid_converter.rb

require 'minitest/autorun'
require './liquid_converter'

class TestLiquidConverter < Minitest::Test
  def setup
    @converter = LiquidConverter.new(1, :cup, :quart)
  end

  def test_initialization
    assert_equal 1, @converter.amount
    assert_equal :cup, @converter.from_unit
    assert_equal :quart, @converter.to_unit
  end

  def test_conversion_factors
    # Test some key conversion factors
    assert_equal 8, LiquidConverter::CONVERSION_FACTORS[:cup][:factor]
    assert_equal 16, LiquidConverter::CONVERSION_FACTORS[:pint][:factor]
    assert_equal 32, LiquidConverter::CONVERSION_FACTORS[:quart][:factor]
    assert_equal 128, LiquidConverter::CONVERSION_FACTORS[:gallon][:factor]
  end

  def test_convert_cups_to_quarts
    assert_in_delta 0.25, @converter.convert(1, :cup, :quart), 0.001
    assert_in_delta 1.0, @converter.convert(4, :cup, :quart), 0.001
  end

  def test_convert_gallons_to_pints
    assert_in_delta 8, LiquidConverter.new.convert(1, :gallon, :pint), 0.001
  end

  def test_convert_quarts_to_cups
    assert_in_delta 4, LiquidConverter.new.convert(1, :quart, :cup), 0.001
  end

  def test_convert_tablespoons_to_teaspoons
    assert_in_delta 3, LiquidConverter.new.convert(1, :tablespoon, :teaspoon), 0.001
  end

  def test_convert_ml_to_liters
    assert_in_delta 1, LiquidConverter.new.convert(1000, :ml, :liter), 0.001
  end

  def test_convert_with_string_units
    assert_in_delta 2, LiquidConverter.new.convert(1, 'quart', 'pint'), 0.001
  end

  def test_convert_with_mixed_case_units
    assert_in_delta 4, LiquidConverter.new.convert(1, 'Quart', 'Cup'), 0.001
  end

  def test_invalid_unit_raises_error
    assert_raises(ArgumentError) { LiquidConverter.new.convert(1, :quart, :invalid) }
    assert_raises(ArgumentError) { LiquidConverter.new.convert(1, :invalid, :cup) }
  end

  def test_available_units
    units = LiquidConverter.available_units
    assert units.key?(:cup)
    assert units.key?(:gallon)
    assert_equal "fluid ounce", units[:fluid_ounce]
  end
end
