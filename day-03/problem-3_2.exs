defmodule AdventOfCode do
  def solve(file_name) do
    list = file_name
    |> File.read!()
    |> String.split("\n")
    |> Enum.reject(&String.length(&1) == 0)
    |> Enum.map(&Regex.scan(~r/mul\(\d{1,3}\,\d{1,3}\)|do\(\)|don't\(\)/, &1))
    |> List.flatten()

    sum_list(list, 0, true)
  end

  defp sum_list([head | tail], accumulator, multiplying) do
    IO.puts("head: #{head}")
    IO.puts("tail: #{tail}")
    IO.puts("accumulator: #{accumulator}")
    IO.puts("multiplying: #{multiplying}")
    cond do
      Regex.match?(~r/don't\(\)/, head) ->
        sum_list(tail, accumulator, false)
      Regex.match?(~r/do\(\)/, head) ->
        sum_list(tail, accumulator, true)
      true ->
        IO.puts("processing multiplication...")
        if multiplying do
          IO.puts("multiplying enabled")
          result = Regex.scan(~r/\d{1,3}\,\d{1,3}/, head)
          |> List.flatten()
          |> Enum.map(&String.split(&1, ","))
          |> Enum.flat_map(fn [x, y] -> [String.to_integer(x) * String.to_integer(y)] end)
          |> Enum.sum()
          sum_list(tail, accumulator + result, multiplying)
        else
          IO.puts("multiplying disabled")
          sum_list(tail, accumulator, multiplying)
        end
      end
  end

  defp sum_list([], accumulator, multiplying) do
    accumulator
  end
end

solution = AdventOfCode.solve("input-full.txt")
IO.inspect(solution)
