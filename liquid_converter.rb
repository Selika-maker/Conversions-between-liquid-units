# liquid_converter.rb

class LiquidConverter
  # Accurate conversion factors (all in terms of how many fluid ounces in 1 unit)
  CONVERSION_FACTORS = {
    ml: { 
      factor: 0.033814,   # 1 ml = 0.033814 fl oz
      name: "milliliter" 
    },
    teaspoon: { 
      factor: 1.0 / 6,     # 1 teaspoon = 1/6 fl oz
      name: "teaspoon" 
    },
    tablespoon: { 
      factor: 1.0 / 2,     # 1 tablespoon = 0.5 fl oz
      name: "tablespoon" 
    },
    fluid_ounce: { 
      factor: 1, 
      name: "fluid ounce" 
    },
    cup: { 
      factor: 8,          # 1 cup = 8 fl oz
      name: "cup" 
    },
    pint: { 
      factor: 16,         # 1 pint = 16 fl oz
      name: "pint" 
    },
    quart: { 
      factor: 32,         # 1 quart = 32 fl oz
      name: "quart" 
    },
    gallon: { 
      factor: 128,        # 1 gallon = 128 fl oz
      name: "gallon" 
    },
    liter: { 
      factor: 33.814,     # 1 liter = 33.814 fl oz
      name: "liter" 
    }
  }.freeze

  attr_reader :amount, :from_unit, :to_unit

  def initialize(amount = nil, from_unit = nil, to_unit = nil)
    @amount = amount
    @from_unit = from_unit&.downcase&.to_sym
    @to_unit = to_unit&.downcase&.to_sym
  end

  def convert(amount = @amount, from_unit = @from_unit, to_unit = @to_unit)
    from_unit = from_unit.downcase.to_sym
    to_unit = to_unit.downcase.to_sym

    validate_units(from_unit, to_unit)

    amount_in_fl_oz = amount.to_f * CONVERSION_FACTORS[from_unit][:factor]
    result = amount_in_fl_oz / CONVERSION_FACTORS[to_unit][:factor]
    result.round(4)
  end

  def self.available_units
    CONVERSION_FACTORS.each_with_object({}) do |(key, val), hash|
      hash[key] = val[:name]
    end
  end

  def self.run_cli
    puts "Liquid Measurement Converter"
    puts "Available units:"
    available_units.each { |k, v| puts "  #{k} = #{v}" }
    puts "-" * 40

    loop do
      begin
        print "Enter amount to convert (or 'q' to quit): "
        input = gets.chomp
        break if input.downcase == 'q'

        amount = input.to_f
        if amount <= 0
          puts "Please enter a positive number"
          next
        end

        print "Convert from unit: "
        from_unit = gets.chomp
        print "Convert to unit: "
        to_unit = gets.chomp

        converter = new(amount, from_unit, to_unit)
        result = converter.convert
        puts "\n#{amount} #{from_unit} = #{result} #{to_unit}\n\n"
        puts "-" * 40
      rescue ArgumentError => e
        puts "Error: #{e.message}"
        puts "Please try again"
        puts "-" * 40
      end
    end

    puts "Goodbye!"
  end

  private

  def validate_units(from_unit, to_unit)
    unless CONVERSION_FACTORS.key?(from_unit)
      raise ArgumentError, "Invalid source unit '#{from_unit}'. Available units: #{self.class.available_units.keys.join(', ')}"
    end

    unless CONVERSION_FACTORS.key?(to_unit)
      raise ArgumentError, "Invalid target unit '#{to_unit}'. Available units: #{self.class.available_units.keys.join(', ')}"
    end
  end
end

if __FILE__ == $0
  LiquidConverter.run_cli
end
