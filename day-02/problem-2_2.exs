defmodule AdventOfCode do
  def solve(filename) do
    {all_accepted, all_rejected} = File.read!(filename)
                          |> String.split("\n")
                          |> Enum.map(&parse_line/1)
                          |> Enum.reject(&is_nil/1)
                          |> Enum.reject(&length(&1) == 0/1)
                          |> Enum.split_with(&is_safe/1)
    IO.puts("accepted: #{inspect(all_accepted)}")
    IO.puts("rejected: #{inspect(all_rejected)}")
    IO.puts("Checking rejected...")

    rejected_safe_counter = Enum.reduce(all_rejected, 0, fn rejected_line, acc ->
      has_safe = Enum.map(0..(length(rejected_line) - 1), fn index ->
        List.delete_at(rejected_line, index)
        |> is_safe()
      end)
       # this checks if the array of boolean values has any true values [true, false, false] -> true
      |> Enum.any?(fn x -> x == true end)

      IO.puts("Can rejected be safe?: #{has_safe}")
      acc + if has_safe, do: 1, else: 0
    end)

    IO.puts("accepted: #{length(all_accepted)}")
    IO.puts("rejected safe: #{rejected_safe_counter}")
    length(all_accepted) + rejected_safe_counter
  end

  defp parse_line(line) do
    line
    |> String.split()
    |> Enum.map(&String.to_integer/1)
  end

  defp is_safe(numbers) when length(numbers) <= 1, do: true

  defp is_safe(numbers) do
    IO.puts("numbers: #{inspect(numbers)}")
    step_differences = get_step_differences(numbers)
    IO.puts("step_differences: #{inspect(step_differences)}")
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

  defp are_step_increments_safe(differences) do
    Enum.all?(differences, &(abs(&1) <= 3))
  end
end

#solution = AdventOfCode.solve("input-small.txt")
solution = AdventOfCode.solve("input-full.txt")
#solution = AdventOfCode.solve("input-one-line.txt")
#solution = AdventOfCode.solve("input-one-line-rejected.txt")
#solution = AdventOfCode.solve("input-one-line-2.txt")
#IO.inspect(solution)
IO.puts(solution)
