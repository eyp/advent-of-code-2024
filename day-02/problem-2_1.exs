defmodule AdventOfCode do
  def solve(filename) do
    File.read!(filename)
    |> String.split("\n")
    |> Enum.map(&parse_line/1)
    |> Enum.reject(&is_nil/1)
    |> Enum.reject(&length(&1) == 0/1)
    |> Enum.filter(&is_safe/1)
  end

  defp parse_line(line) do
    line
    |> String.split()
    |> Enum.map(&String.to_integer/1)
  end

  defp is_safe(numbers) when length(numbers) <= 1, do: true

  defp is_safe(numbers) do
    numbers
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.all?(fn [a, b] -> abs(b - a) <= 3 end)
    |> case do
      false -> false
      true ->
        diffs = numbers
                |> Enum.chunk_every(2, 1, :discard)
                |> Enum.map(fn [a, b] -> b - a end)

        Enum.all?(diffs, &(&1 > 0)) or Enum.all?(diffs, &(&1 < 0))
    end
  end
end

solution = AdventOfCode.solve("input-full.txt")
#IO.inspect(solution)
IO.puts(length(solution))
