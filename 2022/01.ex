{_, data} = File.read("01_input")

data = String.split(data, "\n\n")

data =
  Enum.map(data, fn x ->
    x
    |> String.split("\n")
    |> Enum.map(&if(&1 != "", do: String.to_integer(&1), else: 0))
    |> Enum.sum()
  end)

# part 1
data |> Enum.max() |> IO.inspect()
# part 2
data |> Enum.sort(:desc) |> Enum.take(3) |> Enum.sum() |> IO.inspect()
