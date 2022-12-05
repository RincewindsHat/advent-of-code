defmodule Day3 do
  def solve() do
    input =  readInput()
    |> Enum.map(fn x -> String.to_charlist(x) end)

    [{:part1, part1(input)}, {:part2, solvePart2(input)}]

  end

  def part1(val) do
      #|> IO.inspect(label: "Input")
      #|> IO.inspect(label: "Charlists")
      val
      |> Enum.map(fn x -> Day3.splitEntry(x) end)
      #|> IO.inspect(label: "Splitted")
      |> Enum.map(fn x -> Day3.findCommons(x) end)
      #|> IO.inspect(label: "Commons")
      |> List.foldl(0, fn x, acc -> if x != [] do Day3.getValue(hd(x)) + acc else acc end end)
  end

  def solvePart2(list) do
    case list do
      [a, b, c | rest ] ->
        tmp = getValue(Day3.findCommons(a, b, c))
        tmp2 = Day3.solvePart2(rest)
        if tmp2 == [] do
          tmp
        else
          tmp + tmp2
        end
      _ -> []
    end
  end

  def readInput() do
      tmp = IO.read(:stdio, :line)
      case tmp do
        :eof -> [ "" ]
        _ -> [ String.trim(tmp, "\n") ] ++ Day3.readInput()
      end
  end

  def findCommons(val) do
    Day3.findCommonsInternal(val, [])
    #|> IO.inspect(label: "Find commons")
  end

  def findCommons(a, b, c) do
    foo = findCommons({a, b})
    foo = findCommons({foo, c})
    hd(foo)
  end

  def findCommonsInternal(val, present) do
    case val do
      {_, []} -> []
      {[], _} -> []
      {[w | x], y } ->
        case w in y do
          true ->
            if !Enum.member?(present, w) do
              present = present ++ [w]
              Day3.findCommonsInternal({x, y}, present) ++ [w]
            else
              Day3.findCommonsInternal({x, y}, present)
            end
          false -> Day3.findCommonsInternal({x, y}, present)
        end
    end
  end


  def splitEntry(a) do
    case a do
      [] -> {[], []}
      [x] -> {[x], []}
      [x|y] -> Day3.splitEntryInternal([x], y)
    end
  end

  def getValue(char) do
    #IO.inspect(char, label: "getValue" ,pretty: true)
    #IO.inspect(IEx.Info.info(char))
    case char do
      char when char >= 97 and char <= 122 -> char - 96
      char when char >= 65 and char <= 90 -> char - 64 + 26
    end
  end

  def splitEntryInternal(a, b) do
      if length(a) < length(b) do
          splitEntryInternal([ hd(b) | a ], tl(b))
      else
          {a, b}
      end
  end
end

foo = Day3.solve()
IO.inspect(foo)
