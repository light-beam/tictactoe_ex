defmodule Tictactoe.Doubles do
  import Tictactoe.Helpers

  defmodule PlayerXFake do
    @board Tictactoe.Board

    def pick_position(board, _) do
      List.first(@board.vacant_positions(board))
    end
  end

  defmodule PlayerOFake do
    @board Tictactoe.Board

    def pick_position(board, _) do
      List.first(@board.vacant_positions(board))
    end
  end

  defmodule GameDummy do
    def play(_, _) do end
  end

  defmodule GameSpy do
    def play(game_state, ui) do
      echo_invoked(%{ name: :play, args: [game_state, ui]})
    end
  end

  defmodule GameStateSpy do
    alias Tictactoe.GameState
    import Tictactoe.Mark
    import Tictactoe.Board

    def new_state(players) do
      echo_invoked(%{ name: :new_state, args: players })
      %GameState{ board: new_board, players: players, mark: x }
    end
  end

  defmodule ClearScreenUISpy do
    def clear_screen do
      echo_invoked(%{name: :clear_screen, args: []})
    end

    def greet do end
    def display_result(_) do end
    def display_board(_) do end
    def astelavista do end

    def get_game_option do
      :hvh
    end

    def get_replay_option do
      "no"
    end
  end

  defmodule UIStub do
    def greet do end
    def display_board(_) do end
    def display_result(_) do end
    def clear_screen do end
    def astelavista do end

    def get_replay_option do
      "no"
    end

    def get_game_option do
      :hvh
    end
  end
end
