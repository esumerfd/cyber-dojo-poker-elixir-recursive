defmodule PokerTest do
  use ExUnit.Case
  doctest Poker

  test "runs game" do
    {hand1, hand2, winner} = Poker.play()

    assert hand1
    assert hand2
    assert hand1 == winner || hand2 == winner
  end

  test "straight" do
    assert Poker.straight([{2, :H},{3, :D}, {4, :C}, {5, :S}, {6, :H}])
    assert Poker.straight([{4, :H},{3, :D}, {2, :C}, {5, :S}, {6, :H}])

    assert !Poker.straight([{3, :D}, {4, :C}, {5, :S}, {6, :H},{9, :H}])
  end

  test "flush" do
    assert Poker.flush( [{2, :H},{3, :H},{4, :H},{8, :H}, {10, :H}])

    assert !Poker.flush([{2, :C},{3, :H},{4, :H},{8, :H}, {10, :H}])
  end
end

