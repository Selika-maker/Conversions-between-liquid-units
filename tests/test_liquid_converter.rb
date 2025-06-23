require 'minitest/autorun'
require './liquidvolumeconverter'  # Assuming your class is in this file

class TestLiquidVolumeConverter < Minitest::Test
  def setup
    @converter = LiquidVolumeConverter
  end

  # Test valid conversions
  def test_basic_conversions
    assert_in_delta 236.588, @converter.convert(1, 'cup', 'ml'), 0.001
    assert_in_delta 3.78541, @converter.convert(1, 'gallon', 'l'), 0.001
    assert_in_delta 29.5735, @converter.convert(1, 'fl-oz', 'ml'), 0.001
    assert_in_delta 14.7868, @converter.convert(1, 'tbsp', 'ml'), 0.001
  end

  def test_metric_conversions
    assert_in_delta 1000, @converter.convert(1, 'l', 'ml'), 0.001
    assert_in_delta 0.1, @converter.convert(100, 'ml', 'cl'), 0.001
    assert_in_delta 10, @converter.convert(1, 'dl', 'cl'), 0.001
  end

  def test_unit_aliases
    assert_in_delta 236.588, @converter.convert(1, 'CUP', 'milliliter'), 0.001
    assert_in_delta 29.5735, @converter.convert(1, 'fluid-ounce', 'ml'), 0.001
    assert_in_delta 14.7868, @converter.convert(1, 'Tablespoons', 'ml'), 0.001
  end

  def test_reverse_conversions
    assert_in_delta 1, @converter.convert(236.588, 'ml', 'cup'), 0.001
    assert_in_delta 1, @converter.convert(1000, 'ml', 'l'), 0.001
    assert_in_delta 1, @converter.convert(29.5735, 'ml', 'fl-oz'), 0.001
  end

  # Test error handling
  def test_invalid_units
    assert_raises(ArgumentError) { @converter.convert(1, 'foo', 'cup') }
    assert_raises(ArgumentError) { @converter.convert(1, 'cup', 'bar') }
  end

  def test_non_numeric_values
    assert_raises(ArgumentError) { LiquidVolumeConverter.new('abc', 'cup', 'ml') }
  end

  def test_supported_units
    assert_includes @converter.supported_units, 'tsp'
    assert_includes @converter.supported_units, 'l'
    assert_includes @converter.supported_units, 'gallon'
    refute_includes @converter.supported_units, 'kilogram'  # Not a volume unit
  end

  def test_instance_methods
    conv = LiquidVolumeConverter.new(2, 'cup', 'ml')
    assert_in_delta 473.176, conv.convert, 0.001
    assert_equal "2.0 cup = 473.176 ml", conv.to_s
  end
end
