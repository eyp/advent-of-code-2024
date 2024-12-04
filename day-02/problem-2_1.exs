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
    step_differences = get_step_differences(numbers)
    are_step_increments_safe(step_differences) and are_steps_increasing_or_decreasing(step_differences)
  end

  defp get_step_differences(numbers) do
    numbers
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.map(fn [a, b] -> b - a end)
  end

  defp are_steps_increasing_or_decreasing(differences) do
    Enum.all?(differences, &(&1 > 0)) or Enum.all?(differences, &(&1 < 0))
  end

  def are_step_increments_safe(differences) do
    Enum.all?(differences, &(abs(&1) <= 3))
  end
end

solution = AdventOfCode.solve("input-full.txt")
#IO.inspect(solution)
IO.puts(length(solution))
