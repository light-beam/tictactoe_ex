defmodule Tictactoe.UI.CommandLineRunnerTest do
  use ExUnit.Case

  import Tictactoe.UI.CommandLineRunner
  import Tictactoe.Mark
  import Tictactoe.Helpers

  @board      Tictactoe.Board
  @human      Tictactoe.HumanPlayer
  @game_state Tictactoe.GameState
  @ui             Tictactoe.Doubles.UIStub
  @game           Tictactoe.Doubles.GameDummy
  @game_spy       Tictactoe.Doubles.GameSpy
  @game_state_spy Tictactoe.Doubles.GameStateSpy
  @greet_ui_spy       Tictactoe.UI.CommandLineRunnerTest.GreetUISpy
  @game_option_ui_spy Tictactoe.UI.CommandLineRunnerTest.GameOptionUISpy
  @replay_ui_spy      Tictactoe.UI.CommandLineRunnerTest.ReplayUISpy
  @farewell_ui_spy    Tictactoe.UI.CommandLineRunnerTest.FarewellUISpy
  @clear_screen_ui_spy Tictactoe.Doubles.ClearScreenUISpy

  test "greets" do
    start(@game, @game_state, @greet_ui_spy)
    invoked = invocation_details

    assert invoked.name == :greet
    assert invoked.args == []
  end

  test "gets game option" do
    start(@game, @game_state, @game_option_ui_spy)
    invoked = invocation_details

    assert invoked.name == :get_game_option
    assert invoked.args == []
  end

  test "sets up new game state with correct players" do
    start(@game, @game_state_spy, @ui)
    invoked = invocation_details

    assert invoked.name == :new_state
    assert invoked.args == [@human, @human]
  end

  test "plays game" do
    start(@game_spy, @game_state, @ui)
    invoked = invocation_details

    assert invoked.name == :play
    assert invoked.args == [fresh_game_state, @ui]
  end

  test "gets replay option" do
    start(@game, @game_state, @replay_ui_spy)
    invoked = invocation_details

    assert invoked.name == :get_replay_option
    assert invoked.args == []
  end

  test "bids farewell" do
    start(@game, @game_state, @farewell_ui_spy)
    invoked = invocation_details

    assert invoked.name == :astelavista
    assert invoked.args == []
  end

  test "clears screen" do
    start(@game, @game_state, @clear_screen_ui_spy)
    invoked = invocation_details

    assert invoked.name == :clear_screen
    assert invoked.args == []
  end

  defp fresh_game_state do
    @game_state.make_state(@board.new_board, [@human, @human], x)
  end

  defmodule GreetUISpy do
    def greet do
      echo_invoked(%{name: :greet, args: []})
    end

    def clear_screen do end
    def get_replay_option do end
    def astelavista do end
    def get_game_option do
      :hvh
    end
  end

  defmodule GameOptionUISpy do
    def get_game_option do
      echo_invoked(%{name: :get_game_option, args: []})
      :hvh
    end

    def greet do end
    def clear_screen do end
    def get_replay_option do end
    def astelavista do end
  end

  defmodule ReplayUISpy do
    def get_replay_option do
      echo_invoked(%{ name: :get_replay_option, args: [] })
    end

    def greet do end
    def clear_screen do end
    def astelavista do end
    def get_game_option do
      :hvh
    end
  end

  defmodule FarewellUISpy do
    def astelavista do
      echo_invoked(%{name: :astelavista, args: []})
      "no"
    end

    def greet do end
    def clear_screen do end
    def get_replay_option do end
    def get_game_option do
      :hvh
    end
  end
end
