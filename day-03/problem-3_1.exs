defmodule AdventOfCode do
  def solve(file_name) do
    file_name
    |> File.read!()
    |> String.split("\n")
    |> Enum.reject(&String.length(&1) == 0)
    |> Enum.map(&Regex.scan(~r/mul\(\d{1,3}\,\d{1,3}\)/, &1))
    |> Enum.flat_map(fn x -> x end)
    |> Enum.flat_map(fn x -> x end)
    |> Enum.map(&Regex.scan(~r/\d{1,3}\,\d{1,3}/, &1))
    |> Enum.flat_map(fn [x] -> x end)
    |> Enum.map(&String.split(&1, ","))
    |> Enum.flat_map(fn [x, y] -> [String.to_integer(x) * String.to_integer(y)] end)
    |> Enum.sum()
  end
end

solution = AdventOfCode.solve("input-full.txt")
IO.inspect(solution)
