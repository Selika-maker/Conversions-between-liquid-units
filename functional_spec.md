#Intro:
This Ruby application is a unit conversion tool that helps users quickly convert between different liquid volume measurements, including:

US Customary Units (cups, teaspoons, gallons, quarts, pints, etc.)

Metric System Units (milliliters, liters, centiliters, cubic centimeters, etc.)

It solves the problem of manual calculation errors when converting recipes, scientific measurements, or any other scenario requiring liquid volume conversions.
#User Stories:
As a chemist, I want to have a software on hand that I can use to convert between different liquid units of measurement in both imperial and metric systems, so that I can measure the amount of any given chemical precisely for usage in scientific experiments.
#Functional Requirements:
1. Unit Conversion
The system shall convert between US customary (cups, tsp, gallons) and metric (ml, liter, cl) liquid volume units.
Conversions shall be accurate to at least 6 decimal places.
Base unit: milliliters (ml) for metric precision.
2. Supported Units
The system shall support 30+ units (e.g., tsp, cup, ml, liter, m3, cc).
  Full list: teaspoons, tablespoons, fluid ounces, cups, pints, quarts, gallons, milliliters, centiliters, deciliters, liters, cubic meters, cubic centimeters.
3. Input Handling
The system shall accept:
  Abbreviations (tbsp, fl oz).
  Full names (tablespoon, fluid ounce).
  Plural forms (teaspoons, ounces).
  Case-insensitive input (e.g., "CUP" = "cup").
  The system shall reject invalid units with an error message listing valid options.
4. Output
Results shall be rounded to 6 decimal places by default.
  Output format: {value} {from_unit} = {result} {to_unit} (e.g., 2 cups = 473.176 ml).
5. Error Handling
The system shall validate inputs and display errors for:
  Unsupported units.
  Non-numeric values.
  Negative values (if applicable).
