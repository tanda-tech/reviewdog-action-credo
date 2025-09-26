defmodule TestModule do
  @moduledoc false

  # This will trigger Credo.Check.Readability.LargeNumbers
  def bad_number do
    1234567890
  end

  # This will trigger Credo.Check.Design.AliasUsage
  def bad_alias do
    String.upcase("hello")
    String.downcase("WORLD")
  end

  # This will trigger Credo.Check.Readability.ModuleDoc (already handled by @moduledoc false)
  # This will trigger Credo.Check.Warning.UnusedEnumOperation
  def unused_enum do
    [1, 2, 3]
    |> Enum.map(&(&1 * 2))
    "not using the result"
  end

  # This will trigger Credo.Check.Readability.Specs
  def no_spec_function(x) do
    x + 1
  end

  # This will trigger Credo.Check.Warning.IExPry if we had IEx.pry
  def debug_code do
    result = 42
    # IEx.pry() # Commented out to avoid compilation issues
    result
  end
end
