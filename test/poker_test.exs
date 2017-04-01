defmodule PokerTest do
  use ExUnit.Case
  doctest Poker

  test "runs game" do
    {hand1, hand2, winner} = Poker.play()

    assert hand1
    assert hand2
    assert hand1 == winner || hand2 == winner || false == winner
  end

  #test "winner" do
    #hand1 = [{2, :H},{2, :D}, {8, :C}, {8, :S}, {6, :H}]
    #hand2 = [{2, :H},{6, :D}, {5, :C}, {8, :S}, {6, :H}]

    #assert hand1 == Poker.winner(hand1, hand2)
  #end

  test "rank pair" do
    assert [2,2,13] == Poker.rank_pair [{2,:H},{2,:D},{3,:H},{7,:H},{13,:H}]
  end

  test "rank two pair" do
    assert [3,6,5] == Poker.rank_two_pair [{2, :H},{2, :D}, {5, :C}, {6, :S}, {6, :H}]
  end

  test "rank three of a kind" do
    assert [4,2] == Poker.rank_three_of_a_kind([{2, :H},{2, :D}, {2, :C}, {6, :S}, {6, :H}])
  end

  test "rank full house" do
    assert [7,3] == Poker.rank_full_house([{3, :H},{3, :S}, {3, :D}, {2, :H}, {2, :D}])
    assert [7,2] == Poker.rank_full_house([{2, :H},{2, :S}, {3, :D}, {3, :H}, {2, :D}])
  end

  test "rank straight" do
    assert [5,6] == Poker.rank_straight([{2, :H},{3, :D}, {4, :C}, {5, :S}, {6, :H}])
  end

  test "rank flush" do
    assert [6,10] == Poker.rank_flush( [{2, :H},{3, :H},{4, :H},{8, :H}, {10, :H}])
  end

  test "rank four of a kind" do
    assert [8,2] == Poker.rank_four_of_a_kind([{2, :H},{2, :D}, {2, :C}, {2, :S}, {6, :H}])
  end

  test "rank straight flush" do
    assert [9,6] == Poker.rank_straight_flush( [{2, :H},{3, :H},{4, :H},{5, :H}, {6, :H}])
  end

  test "pair" do
    assert Poker.pair([{2, :H},{2, :D}, {5, :C}, {8, :S}, {6, :H}])
    assert Poker.pair([{2, :H},{6, :D}, {5, :C}, {8, :S}, {6, :H}])

    assert !Poker.pair([{2, :H},{3, :D}, {8, :C}, {10, :S}, {6, :H}])
    assert !Poker.pair([{4, :H},{11, :D}, {8, :C}, {9, :S}, {2, :H}])
  end

 test "two pair" do
    assert Poker.two_pair([{2, :H},{2, :D}, {5, :C}, {6, :S}, {6, :H}])
    assert Poker.two_pair([{2, :H},{6, :D}, {5, :C}, {2, :S}, {6, :H}])

    assert !Poker.two_pair([{2, :H},{3, :D}, {8, :C}, {3, :S}, {6, :H}])
    assert !Poker.two_pair([{4, :H},{4, :D}, {8, :C}, {9, :S}, {2, :H}])
  end

  test "three of a kind" do
    assert Poker.three_of_a_kind([{2, :H},{2, :D}, {2, :C}, {6, :S}, {6, :H}])
    assert Poker.three_of_a_kind([{2, :H},{6, :D}, {2, :C}, {2, :S}, {6, :H}])

    assert !Poker.three_of_a_kind([{4, :H},{2, :D}, {2, :C}, {3, :S}, {6, :H}])
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

  test "full house" do
    assert Poker.full_house([{3, :H},{3, :S}, {3, :D}, {2, :H}, {2, :D}])

    assert !Poker.full_house([{4, :H},{2, :H}, {2, :C}, {2, :H}, {6, :H}])
    assert !Poker.full_house([{4, :H},{4, :D}, {3, :C}, {2, :S}, {2, :H}])
  end

  test "four of a kind" do
    assert Poker.four_of_a_kind([{2, :H},{2, :D}, {2, :C}, {2, :S}, {6, :H}])

    assert !Poker.four_of_a_kind([{4, :H},{2, :D}, {2, :C}, {2, :S}, {6, :H}])
    assert !Poker.four_of_a_kind([{4, :H},{4, :D}, {2, :C}, {2, :S}, {2, :H}])
  end

  test "straight flush" do
    assert Poker.straight_flush( [{2, :H},{3, :H},{4, :H},{5, :H}, {6, :H}])

    assert !Poker.straight_flush( [{2, :H},{3, :D},{4, :H},{5, :H}, {6, :H}])
    assert !Poker.straight_flush( [{2, :H},{9, :D},{4, :H},{5, :H}, {6, :H}])
  end
end

