defmodule AdventOfCode do
  def solve(filename) do
    File.read!(filename)
    |> String.split("\n")
    |> Enum.map(&parse_line/1)
    |> Enum.reject(&is_nil/1)
    |> Enum.reduce({[],[]}, fn {left, right}, {left_acc, right_acc} ->
      {
        [left | left_acc],
        [right | right_acc]
      }
    end)
    |> then(fn {left, right} ->
      frequencies = Enum.frequencies(right)
      Enum.map(left, fn num -> {num, Map.get(frequencies, num, 0)} end)
    end)
    |> Enum.map(fn {left, right} -> left * right end)
    |> Enum.sum()
  end

  defp parse_line(line) do
    case String.split(line) do
      [left, right] ->
        {String.to_integer(left), String.to_integer(right)}
      _ ->
        nil
    end
  end
end

solution = AdventOfCode.solve("input.txt")

IO.puts(solution)
