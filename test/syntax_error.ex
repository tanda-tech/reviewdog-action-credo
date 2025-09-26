defmodule SyntaxError do
  # This will create compilation errors which should be ERROR level

  def duplicate_function_name do
    "first definition"
  end

  # Duplicate function definition - should be compilation error
  def duplicate_function_name do
    "second definition - this should cause ERROR"
  end

  def pattern_match_error do
    # Duplicate patterns in case statement
    case :ok do
      :ok -> "first"
      :error -> "second"
      :ok -> "duplicate pattern - ERROR"
    end
  end
end
