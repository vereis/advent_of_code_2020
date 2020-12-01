defmodule AdventOfCode.DayOne do
  @expenses_path "./input.txt"

  def run() do
    expenses = import_expenses()

    {:ok, solution_1} = solution_1(expenses)
    {:ok, solution_2} = solution_2(expenses)

    IO.puts("Answer to part 1: #{solution_1}")
    IO.puts("Answer to part 2: #{solution_2}")
  end

  # There is definitely a more optimal way to do this, but since the problem set
  # is pretty small I didn't see the point in further optimising this.
  #
  # What's nice is that Elixir's `for` macro takes multiple inputs and runs
  # through every permutation of arguments from said inputs.
  #
  # If we were to sort these expenses in an efficient way (and provide an
  # efficient way to traverse the list backwards (possibly just reversing the
  # sorted list again...)) we could cut down on how much searching we need to
  # do, but since these are all pretty expensive and the problem space is small,
  # this naive implementation does the job fine.
  defp solution_1(expenses) do
    try do
      for a <- expenses, b <- expenses do
        if a + b == 2020, do: throw({:result, {a, b}})
      end

      {:error, :no_solution_found}
    catch
      {:result, {a, b}} ->
        {:ok, a * b}
    end
  end

  defp solution_2(expenses) do
    try do
      for a <- expenses, b <- expenses, c <- expenses do
        if a + b + c == 2020, do: throw({:result, {a, b, c}})
      end

      {:error, :no_solution_found}
    catch
      {:result, {a, b, c}} ->
        {:ok, a * b * c}
    end
  end

  defp import_expenses() do
    @expenses_path
    |> File.read!()
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn expense ->
      {as_integer, _} = Integer.parse(expense)
      as_integer
    end)
  end
end

AdventOfCode.DayOne.run()
