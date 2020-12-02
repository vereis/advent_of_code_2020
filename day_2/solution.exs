defmodule AdventOfCode.DayTwo do
  @input_path "./input.txt"

  def run() do
    passwords = import_passwords()

    solution_1 = do_solution_1(passwords)
    solution_2 = do_solution_2(passwords)

    IO.puts("Answer to part 1: #{solution_1}")
    IO.puts("Answer to part 2: #{solution_2}")
  end

  defp do_solution_1(passwords) do
    Enum.count(passwords, fn {password, {a, b, char}} ->
      char_count =
        password
        |> String.codepoints()
        |> Enum.filter(&(&1 == char))
        |> length()

      char_count in a..b
    end)
  end

  defp do_solution_2(passwords) do
    Enum.count(passwords, fn {password, {a, b, char}} ->
      char_a = String.at(password, a - 1)
      char_b = String.at(password, b - 1)

      :erlang.xor(char_a == char, char_b == char)
    end)
  end

  defp import_passwords() do
    re = ~r/^(\d+)-(\d+) (\w)\: (\w+)$/

    @input_path
    |> File.read!()
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn password_with_spec_string ->
      [_, a_string, b_string, char, password] = Regex.run(re, password_with_spec_string)

      {a, _} = Integer.parse(a_string)
      {b, _} = Integer.parse(b_string)

      {password, {a, b, char}}
    end)
  end
end

AdventOfCode.DayTwo.run()
