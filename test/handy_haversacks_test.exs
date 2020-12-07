defmodule HandyHaversacksTest do
  use ExUnit.Case

  setup _context do
    {:ok,
     input: [
       "light red bags contain 1 bright white bag, 2 muted yellow bags.",
       "dark orange bags contain 3 bright white bags, 4 muted yellow bags.",
       "bright white bags contain 1 shiny gold bag.",
       "muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.",
       "shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.",
       "dark olive bags contain 3 faded blue bags, 4 dotted black bags.",
       "vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.",
       "faded blue bags contain no other bags.",
       "dotted black bags contain no other bags."
     ]}
  end

  test "count the bags that can eventually contain gold", %{input: input} do
    assert 4 == HandyHaversacks.number_of_bags_covering_gold(input)
  end

  test "size of shiny gold bags", %{input: input} do
    assert 32 = HandyHaversacks.number_of_bags_in_gold(input)

    assert 126 =
             HandyHaversacks.number_of_bags_in_gold([
               "shiny gold bags contain 2 dark red bags.",
               "dark red bags contain 2 dark orange bags.",
               "dark orange bags contain 2 dark yellow bags.",
               "dark yellow bags contain 2 dark green bags.",
               "dark green bags contain 2 dark blue bags.",
               "dark blue bags contain 2 dark violet bags.",
               "dark violet bags contain no other bags."
             ])
  end
end
