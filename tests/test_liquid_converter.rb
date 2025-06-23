class LiquidVolumeConverter
  # Conversion factors relative to milliliters (ml)
  CONVERSION_TABLE = {
    # US Customary Units
    'tsp'      => 4.92892,    # US teaspoon
    'tbsp'     => 14.7868,    # US tablespoon
    'fl-oz'    => 29.5735,    # US fluid ounce
    'cup'      => 236.588,    # US legal cup
    'pint'     => 473.176,    # US liquid pint
    'quart'    => 946.353,    # US liquid quart
    'gallon'   => 3785.41,    # US liquid gallon
    
    # Metric Units
    'ml'       => 1,
    'cl'       => 10,         # centiliter
    'dl'       => 100,        # deciliter
    'l'        => 1000,       # liter
    'm3'       => 1_000_000,  # cubic meter
    'cc'       => 1           # cubic centimeter (same as ml)
  }.freeze

  # Unit aliases for flexible input
  UNIT_ALIASES = {
    'teaspoon' => 'tsp', 'teaspoons' => 'tsp',
    'tablespoon' => 'tbsp', 'tablespoons' => 'tbsp',
    'fluid-ounce' => 'fl-oz', 'fluid-ounces' => 'fl-oz',
    'ounce' => 'fl-oz', 'ounces' => 'fl-oz',
    'milliliter' => 'ml', 'millilitre' => 'ml', 'milliliters' => 'ml',
    'centiliter' => 'cl', 'centilitre' => 'cl',
    'deciliter' => 'dl', 'decilitre' => 'dl',
    'liter' => 'l', 'litre' => 'l', 'liters' => 'l',
    'cubic-meter' => 'm3', 'cubic-centimeter' => 'cc'
  }.freeze

  attr_reader :value, :source_unit, :target_unit

  def initialize(value, source_unit, target_unit)
    @value = value.to_f
    @source_unit = normalize_unit(source_unit)
    @target_unit = normalize_unit(target_unit)
    validate_units!
  end

  def convert
    (value * ml_per_source_unit / ml_per_target_unit).round(6)
  end

  def to_s
    "#{value} #{source_unit} = #{convert} #{target_unit}"
  end

  class << self
    def supported_units
      CONVERSION_TABLE.keys.sort
    end

    def convert(value, from, to)
      new(value, from, to).convert
    end

    def interactive_converter
      puts "Liquid Volume Converter"
      puts "Supported units: #{supported_units.join(', ')}"
      puts "You can also use common names like 'teaspoon', 'liter', etc."
      puts "-" * 50

      loop do
        print "\nEnter value to convert (or 'q' to quit): "
        input = gets.chomp
        break if input.downcase == 'q'

        begin
          value = Float(input)
        rescue ArgumentError
          puts "Error: Please enter a valid number"
          next
        end

        print "Enter source unit (from): "
        from_unit = gets.chomp

        print "Enter target unit (to): "
        to_unit = gets.chomp

        begin
          converter = new(value, from_unit, to_unit)
          puts converter.to_s
        rescue ArgumentError => e
          puts "Error: #{e.message}"
        end
      end
      puts "Goodbye!"
    end
  end

  private

  def normalize_unit(unit)
    unit = unit.downcase.gsub(/\s+/, '-')
    UNIT_ALIASES.fetch(unit, unit)
  end

  def validate_units!
    unless valid_unit?(source_unit) && valid_unit?(target_unit)
      raise ArgumentError, "Invalid unit. Supported units: #{self.class.supported_units.join(', ')}"
    end
  end

  def valid_unit?(unit)
    CONVERSION_TABLE.key?(unit)
  end

  def ml_per_source_unit
    CONVERSION_TABLE[source_unit]
  end

  def ml_per_target_unit
    CONVERSION_TABLE[target_unit]
  end
end

# Start the interactive converter if run directly
LiquidVolumeConverter.interactive_converter if __FILE__ == $0
