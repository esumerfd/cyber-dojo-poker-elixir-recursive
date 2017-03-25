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
    {_, hand1, hand2} = cards() 
    |> take_hand(1)
    |> take_hand(2)

    { hand1, hand2, winner(hand1, hand2) }
  end

  defp take_hand({cards, _, hand2}, 1) do
    {cards, hand} = take_hand(cards)
    {cards, hand, hand2} 
  end

  defp take_hand({cards, hand1, _}, 2) do
    {cards, hand} = take_hand(cards)
    {cards, hand1, hand} 
  end

  defp take_hand(cards) do
    { Enum.drop(cards, 5), Enum.take(cards, 5) }
  end

  defp cards() do
    cards = for face <- [ 2,3,4,5,6,7,8,9,10,11,12,13 ], suit <- [ :H, :D, :C, :S ], do: {face, suit}
    {cards, nil, nil}
  end

  defp winner(hand1, hand2) do
    case :rand.uniform(2) do
      1 -> hand1
      2 -> hand2
    end
  end

  defp report(hand, true),  do: IO.puts "#{inspect(hand)},  WINNER"
  defp report(hand, false), do: IO.puts "#{inspect(hand)}"
end

