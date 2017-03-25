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

  defp take_hand({cards, hand1, hand2}, player) do
    {cards, new_hand} = { Enum.drop(cards, 5), Enum.take(cards, 5) }
    case player do
      1 -> {cards, new_hand, hand2} 
      2 -> {cards, hand1, new_hand} 
    end
  end

  defp cards() do
    {
      (
        Enum.shuffle(
          for face <- [2,3,4,5,6,7,8,9,10,11,12,13,14], suit <- [:H,:D,:C,:S], do: {face, suit}
        )
      ),
      {},
      {}
    }
  end

  defp winner(hand1, hand2) do
    Enum.random([hand1, hand2])
  end

  # Compare card with next card
  # No tail recursing
  #
  # Input: [{2, :H},{3, :D}, {4, :C}, {5, :S}, {6, :H}]
  # Output: true if straight and false othesize
  def straight(cards) do
    match?(
      [_, [1,1,1,1]],
      Enum.sort(cards, fn({ face1,_ },{ face2,_ }) -> face1 < face2 end)|> straight([])
    )
  end

  def straight([card|remaining], differences) do
    case remaining do
      [] -> [card, differences]
      _  -> 
        [next_card,differences] = straight(remaining,differences)
        [card, differences ++ [subtract(card,next_card)]]
    end
  end

  defp subtract({face1,_}, {face2,_}) do
    face2 - face1
  end

  defp report(hand, true),  do: IO.puts "#{inspect(hand)},  WINNER"
  defp report(hand, false), do: IO.puts "#{inspect(hand)}"
end

