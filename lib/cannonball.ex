defmodule Cannonball do
  def run(height) do
    handle_layer(0, height, 0)
  end

  def handle_layer(result, height, current_level) when current_level == height do
    result
  end

  def handle_layer(result, height, current_level) do
    result_at_level = current_level * current_level
    handle_layer(result + result_at_level, height, current_level + 1)
  end


end
