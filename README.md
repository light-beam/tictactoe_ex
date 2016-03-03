# Tictactoe

This is a command line Tic Tac Toe game, written in Elixir.

**To run the game:**

If you have pulled down this repo and would like to play the game, you need to

- have Elixir installed:
  short version: brew update
  brew install elixir
  long version: http://elixir-lang.org/install.html

- navigate to the root of the project in your terminal and run the following:
  `mix deps.get` + `mix compile` - this will compile and will install dependencies
  NOTE: you may get a prompt to install Hex, you would have to say yes, as you cannot install dependencies without it

- to run the game:
  mix ttt and then follow on screen instructions

**For tests:**

- to run tests:
  `mix test`

- to get test coverage summary:
  `mix test —cover` - This will print to the command line

- to get test coverage details:
  `mix coveralls.detail` - This will print to the command line

- to get test coverage as html file:
  `mix coveralls.html` - This will create cover/excoveralls.html in the root of the project

  NOTE for the test enthusiasts: there seems to be a limitation in how coveralls evaluates the lines where a delegation call (with side effects only) is made. For example, I have spies in tests to confirm that the call to collaborator is made, and the method itself is tested within relevant module. This, however seems to not be sifficient for coveralls and these lines appear red. (CommandLineRunner is the main offender)
