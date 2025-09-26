defmodule Foo do
  def foo do
    bar(:atom)
    |> baz()
  end

  defp bar(atom), do: atom
  defp baz(atom), do: atom
end
