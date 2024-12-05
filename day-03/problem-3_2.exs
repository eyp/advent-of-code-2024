defmodule AdventOfCode do
  def solve(file_name) do
    file_name
    |> File.read!()
    |> String.split("\n")
    |> Enum.reject(&String.length(&1) == 0)
    |> Enum.map(&Regex.scan(~r/mul\(\d{1,3}\,\d{1,3}\)|do\(\)|don't\(\)/, &1))
    |> List.flatten()
    |> calculate_result(0, true)
  end

  defp calculate_result([head | tail], accumulator, multiplying) do
    # IO.puts("head: #{head}")
    # IO.puts("tail: #{tail}")
    # IO.puts("accumulator: #{accumulator}")
    # IO.puts("multiplying: #{multiplying}")
    cond do
      Regex.match?(~r/don't\(\)/, head) ->
        calculate_result(tail, accumulator, false)
      Regex.match?(~r/do\(\)/, head) ->
        calculate_result(tail, accumulator, true)
      true ->
        # IO.puts("processing multiplication...")
        if multiplying do
          # IO.puts("multiplying enabled")
          calculate_result(tail, accumulator + multiply(head), multiplying)
        else
          # IO.puts("multiplying disabled")
          calculate_result(tail, accumulator, multiplying)
        end
      end
  end

  defp calculate_result([], accumulator, _multiplying) do
    accumulator
  end

  defp multiply(multiplication) do
    Regex.scan(~r/\d{1,3}\,\d{1,3}/, multiplication)
          |> List.flatten()
          |> Enum.map(&String.split(&1, ","))
          |> Enum.flat_map(fn [x, y] -> [String.to_integer(x) * String.to_integer(y)] end)
          |> hd
  end
end

solution = AdventOfCode.solve("input-full.txt")
IO.inspect(solution)
