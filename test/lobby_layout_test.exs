defmodule LobbyLayoutTest do
  use ExUnit.Case

  setup _context do
    {:ok,
     input: """
     sesenwnenenewseeswwswswwnenewsewsw
     neeenesenwnwwswnenewnwwsewnenwseswesw
     seswneswswsenwwnwse
     nwnwneseeswswnenewneswwnewseswneseene
     swweswneswnenwsewnwneneseenw
     eesenwseswswnenwswnwnwsewwnwsene
     sewnenenenesenwsewnenwwwse
     wenwwweseeeweswwwnwwe
     wsweesenenewnwwnwsenewsenwwsesesenwne
     neeswseenwwswnwswswnw
     nenwswwsewswnenenewsenwsenwnesesenew
     enewnwewneswsewnwswenweswnenwsenwsw
     sweneswneswneneenwnewenewwneswswnese
     swwesenesewenwneswnwwneseswwne
     enesenwswwswneneswsenwnewswseenwsese
     wnwnesenesenenwwnenwsewesewsesesew
     nenewswnwewswnenesenwnesewesw
     eneswnwswnwsenenwnwnwwseeswneewsenese
     neswnwewnwnwseenwseesewsenwsweewe
     wseweeenwnesenwwwswnew
     """}
  end

  test "part 1", %{input: input} do
    assert 10 ==
             input
             |> String.split()
             |> LobbyLayout.place_tiles()
             |> LobbyLayout.count_black_tiles()
  end

  test "part 2", %{input: input} do
    assert 2208 ==
             input
             |> String.split()
             |> LobbyLayout.place_tiles()
             |> LobbyLayout.flip()
             |> LobbyLayout.count_black_tiles()
  end
end
