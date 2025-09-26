defmodule Foo do
  # Missing @moduledoc - should be error level with strict mode

  def foo do
    bar(:atom)
    |> baz()
  end

  def unused_enum_operation do
    # This should be a WARNING level issue
    [1, 2, 3] |> Enum.map(&(&1 * 2))
    :ok
  end

  def with_debug_code do
    result = calculate_something()
    # This should trigger Warning.IoInspect
    IO.inspect(result)
    result
  end

  defp calculate_something do
    42
  end

  defp bar(atom), do: atom
  defp baz(atom), do: atom
end
