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

  # pair
  def pair(cards) do
    count_faces(cards)
    |> Map.values
    |> Enum.filter(&(&1 == 2))
    |> length == 1
  end

  # Two pair
  def two_pair(cards) do
    count_faces(cards)
    |> Map.values
    |> Enum.filter(&(&1 == 2))
    |> length == 2
  end

  # Three of the same face value
  #
  # Input: [{2, :H},{3, :D}, {4, :C}, {5, :S}, {6, :H}]
  # Output: true if straight and false othesize
  def three_of_a_kind(cards) do
    count_faces(cards)
    |> Map.values
    |> Enum.member?(3)
  end

  # Full house
  def full_house(cards) do
    count_faces(cards)
    |> Map.values
    |> fn(values) -> 
         Enum.member?(values, 3) && Enum.member?(values, 2) 
       end.()
  end

  # Four of the same face value
  #
  # Input: [{2, :H},{3, :D}, {4, :C}, {5, :S}, {6, :H}]
  # Output: true if straight and false othesize
  def four_of_a_kind(cards) do
    count_faces(cards)
    |> Map.values
    |> Enum.member?(4)
  end

  # Compare card with next card
  # No tail recursing
  #
  # Input: [{2, :H},{3, :D}, {4, :C}, {5, :S}, {6, :H}]
  # Output: true if straight and false othesize
  def straight(cards) do
    match?(
      [_, [1,1,1,1]],
        Enum.sort(cards, fn({ face1,_ },{ face2,_ }) -> face1 < face2 end)
        |> straight([])
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

  # Subtract face values of cards
  defp subtract({face1,_}, {face2,_}) do
    face2 - face1
  end

  # Are all the suits the same
  #
  # Input: [{2, :H},{3, :H},{4, :H},{8, :H}, {10, :H}]
  # Output: true if flush and false otherwise
  def flush(cards) do
    count_suits(cards)
    |> Map.size == 1
  end

  # Both a straight and a flush
  def straight_flush(cards) do
    straight(cards) && flush(cards)
  end

  # Count faces
  defp count_faces(cards) do
    count_cards(cards, &(elem(&1,0) ), %{})
  end

  # Count faces
  defp count_suits(cards) do
    count_cards(cards, &(elem(&1,1) ), %{})
  end

  # Count repeating parts of a card, either face of the suit.
  defp count_cards([], _, faces), do: faces
  defp count_cards([card|remaining], card_part, faces) do
    count_cards(remaining, card_part, Map.update(faces, card_part.(card), 1, &(&1 + 1)) )
  end

  defp report(hand, true),  do: IO.puts "#{inspect(hand)},  WINNER"
  defp report(hand, false), do: IO.puts "#{inspect(hand)}"
end

