defmodule Bob do
  @spec hey(String.t()) :: String.t()
  def hey(input) do
    cond do
      Regex.match?(~r/^[\n\s]*$/, input) -> "Fine. Be that way!"
      Regex.match?(~r/^[[:upper:]\s']+\?\s*$/, input) -> "Calm down, I know what I'm doing!"
      Regex.match?(~r/[[:upper:]]{2,}/u, input) 
        and not Regex.match?(~r/[[:lower:]]/, input)-> "Whoa, chill out!"
      Regex.match?(~r/\?\s*$/, input) -> "Sure."
      true -> "Whatever."
    end
  end
end
