defmodule Palindrome do
  def run do
    str = "never odd or even"
    palindrome(String.replace(str, " ", ""))
  end

  def palindrome(str) do
    palindrome(str, 0, String.length(str) - 1)
  end

  def palindrome(_, first, last) when first == last - 1, do: true
  def palindrome(str, first, last) do
    case String.at(str, first) == String.at(str, last) do
      true -> palindrome(str, first + 1 , last - 1)
      _ -> false
    end
  end
end
