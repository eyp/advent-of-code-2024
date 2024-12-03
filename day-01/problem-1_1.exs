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
      {Enum.sort(left), Enum.sort(right)}
    end)
    |> calculate_distance()
  end

  defp parse_line(line) do
    case String.split(line) do
      [left, right] ->
        {String.to_integer(left), String.to_integer(right)}
      _ ->
        nil
    end
  end

  defp calculate_distance({left_numbers, right_numbers}) do
    Enum.zip_reduce(left_numbers, right_numbers, 0, fn left, right, acc ->
      sum = abs(right - left)
      acc + sum
    end)
  end
end

solution = AdventOfCode.solve("input.txt")

IO.puts(solution)
