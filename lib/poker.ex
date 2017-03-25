defmodule Poker do
  @moduledoc """
  The game of Poker (recursive)
  """

  def main(args) do
    IO.puts("Welcome to Poker: #{args}")

    {hand1, hand2, winner} = play()

    report(hand1, hand1 == winner)
    report(hand2, hand2 == winner)
  end

  def play do
    {1, 2, 1}
  end

  defp report(hand, true),  do: IO.puts "#{inspect(hand)},  WINNER"
  defp report(hand, false), do: IO.puts "#{inspect(hand)}, "
end

