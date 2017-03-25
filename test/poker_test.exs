defmodule PokerTest do
  use ExUnit.Case
  doctest Poker

  test "runs game" do
    {hand1, hand2, winner} = Poker.play()

    assert hand1
    assert hand2
    assert hand1 == winner || hand2 == winner
  end
end

