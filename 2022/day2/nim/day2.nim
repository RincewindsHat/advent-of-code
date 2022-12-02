import strutils

let file = readFile("../input.txt")

let games = file.splitlines()

var sum = 0

# Part one
for game in games:
    case game
    of "A X":
      sum += 3 + 1
    of "B X":
      sum += 0 + 1
    of "C X":
      sum += 6 + 1
    of "A Y":
      sum += 6 + 2
    of "B Y":
      sum += 3 + 2
    of "C Y":
      sum += 0 + 2
    of "A Z":
      sum += 0 + 3
    of "B Z":
      sum += 6 + 3
    of "C Z":
      sum += 3 + 3

echo $sum

# Part two

var sum2 = 0

for game in games:
    case game
    of "A X":
      sum2 += 0 + 3
    of "B X":
      sum2 += 0 + 1
    of "C X":
      sum2 += 0 + 2
    of "A Y":
      sum2 += 3 + 1
    of "B Y":
      sum2 += 3 + 2
    of "C Y":
      sum2 += 3 + 3
    of "A Z":
      sum2 += 6 + 2
    of "B Z":
      sum2 += 6 + 3
    of "C Z":
      sum2 += 6 + 1

echo $sum2
