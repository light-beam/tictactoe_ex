defmodule Tictactoe.GameLoop do
  alias Tictactoe.GameState

  def run(game_state, game_updater) do
    cond do
      GameState.final?(game_state) -> game_state
      true -> game_updater.update(game_state)
              |> run(game_updater)
    end
  end
end
