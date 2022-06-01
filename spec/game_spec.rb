# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
  let(:board) { instance_double(Board) }
  subject(:game) { described_class.new(board) }

  describe '#end_game' do
    context 'when the game is a tie' do
      before do
        allow($stdout).to receive(:write)
        allow(board).to receive(:win?).and_return(false)
      end

      it 'sends message to print the board' do
        expect(board).to receive(:to_s)
        game.end_game
      end

      it 'sends message to check if game is won' do
        expect(board).to receive(:win?)
        game.end_game
      end

      it 'sends message to print the game over message' do
        expect(game).to receive(:game_over_message)
        game.end_game
      end

      it 'sends message to print the tie game message' do
        expect(game).to receive(:tie_message)
        game.end_game
      end
    end

    context 'when the game is a win' do
      before do
        allow($stdout).to receive(:write)
        allow(board).to receive(:win?).and_return(true)
        allow(game.instance_variable_get(:@active_player)).to receive(:declare_winner)
      end

      it 'sends message to print the board' do
        expect(board).to receive(:to_s)
        game.end_game
      end

      it 'sends message to check if game is won' do
        expect(board).to receive(:win?)
        game.end_game
      end

      it 'sends message to print the game over message' do
        expect(game).to receive(:game_over_message)
        game.end_game
      end

      it 'sends message to declare the winner' do
        expect(game.instance_variable_get(:@active_player)).to receive(:declare_winner)
        game.end_game
      end
    end
  end

  describe '#make_move' do
    context 'when a valid move is entered' do
      before do
        allow($stdout).to receive(:write)
        allow(game.instance_variable_get(:@active_player)).to receive(:input_move).and_return('4')
        allow(game).to receive(:calc_row_i).and_return(1)
        allow(game).to receive(:calc_col_i).and_return(0)
        allow(board).to receive(:valid_move?).and_return(true)
        allow(board).to receive(:update)
      end

      it 'sends message to get input from the active player two times' do
        expect(game.instance_variable_get(:@active_player)).to receive(:input_move)
        game.make_move
      end

      it 'sends message to check if the move is valid' do
        expect(board).to receive(:valid_move?)
        game.make_move
      end

      it "sends message to calculate the move's row index" do
        expect(game).to receive(:calc_row_i)
        game.make_move
      end

      it "sends message to calculate the move's column index" do
        expect(game).to receive(:calc_col_i)
        game.make_move
      end

      it 'sends message to update the board' do
        expect(board).to receive(:update)
        game.make_move
      end
    end

    context 'when two invaid moves are entered then a valid move is entered' do
      before do
        allow($stdout).to receive(:write)
        allow(game.instance_variable_get(:@active_player)).to receive(:input_move).and_return('x', '20', '4')
        allow(game).to receive(:calc_row_i).and_return(1)
        allow(game).to receive(:calc_col_i).and_return(0)
        allow(board).to receive(:valid_move?).and_return(false, false, true)
        allow(board).to receive(:update)
      end

      it 'sends message to get input from the active player three times' do
        expect(game.instance_variable_get(:@active_player)).to receive(:input_move).exactly(3).times
        game.make_move
      end

      it 'sends message to print the invalid move message twice' do
        expect(game).to receive(:invalid_move_message).exactly(2).times
        game.make_move
      end

      it 'sends message to check if the move is valid three times' do
        expect(board).to receive(:valid_move?).exactly(3).times
        game.make_move
      end

      it "sends message to calculate the move's row index" do
        expect(game).to receive(:calc_row_i)
        game.make_move
      end

      it "sends message to calculate the move's column index" do
        expect(game).to receive(:calc_col_i)
        game.make_move
      end

      it 'sends message to update the board' do
        expect(board).to receive(:update)
        game.make_move
      end
    end

    context 'when an invaid move is entered then a valid move is entered' do
      before do
        allow($stdout).to receive(:write)
        allow(game.instance_variable_get(:@active_player)).to receive(:input_move).and_return('x', '4')
        allow(game).to receive(:calc_row_i).and_return(1)
        allow(game).to receive(:calc_col_i).and_return(0)
        allow(board).to receive(:valid_move?).and_return(false, true)
        allow(board).to receive(:update)
      end

      it 'sends message to get input from the active player twice' do
        expect(game.instance_variable_get(:@active_player)).to receive(:input_move).exactly(2).times
        game.make_move
      end

      it 'sends message to print the invalid move message' do
        expect(game).to receive(:invalid_move_message).exactly(1).time
        game.make_move
      end

      it 'sends message to check if the move is valid twice' do
        expect(board).to receive(:valid_move?).exactly(2).times
        game.make_move
      end

      it "sends message to calculate the move's row index" do
        expect(game).to receive(:calc_row_i)
        game.make_move
      end

      it "sends message to calculate the move's column index" do
        expect(game).to receive(:calc_col_i)
        game.make_move
      end

      it 'sends message to update the board' do
        expect(board).to receive(:update)
        game.make_move
      end
    end
  end

  describe '#play' do
    context 'when the game is a tie' do
      before do
        allow($stdout).to receive(:write)
        allow(board).to receive(:win?).and_return(false, false, false, false, false, false, false, false, false)
        allow(game.instance_variable_get(:@active_player)).to receive(:input_move)
          .and_return('1', '2', '3', '4', '5', '6', '7', '8', '9')
        allow(board).to receive(:valid_move?).and_return(true, true, true, true, true, true, true, true, true)
        allow(board).to receive(:update)
        allow(game).to receive(:end_game)
      end

      it 'sends message to make a move 9 times' do
        expect(game).to receive(:make_move).exactly(9).times
        game.play
      end

      it 'sends message to check if game is won 9 times' do
        expect(board).to receive(:win?).exactly(9).times
        game.play
      end

      it 'sends message to end the game' do
        expect(game).to receive(:end_game)
        game.play
      end
    end

    context 'when a player wins after 4 rounds' do
      before do
        allow($stdout).to receive(:write)
        allow(board).to receive(:win?).and_return(false, false, false, true)
        allow(game.instance_variable_get(:@active_player)).to receive(:input_move).and_return('1', '2', '3', '4')
        allow(board).to receive(:valid_move?).and_return(true, true, true, true)
        allow(board).to receive(:update)
        allow(game).to receive(:end_game)
      end

      it 'sends message to make a move 4 times' do
        expect(game).to receive(:make_move).exactly(4).times
        game.play
      end

      it 'sends message to check if game is won 4 times' do
        expect(board).to receive(:win?).exactly(4).times
        game.play
      end

      it 'sends message to end the game' do
        expect(game).to receive(:end_game)
        game.play
      end
    end
  end

  describe '#calc_row_i' do
    before do
      allow($stdout).to receive(:write)
    end

    context 'when the move is 1' do
      it 'returns 0' do
        expect(game.calc_row_i(1)).to be_zero
      end
    end

    context 'when the move is 5' do
      it 'returns 1' do
        expect(game.calc_row_i(5)).to eql(1)
      end
    end

    context 'when the move is 9' do
      it 'returns 2' do
        expect(game.calc_row_i(9)).to eql(2)
      end
    end
  end

  describe '#calc_col_i' do
    before do
      allow($stdout).to receive(:write)
    end

    context 'when the move is 1' do
      it 'returns 0' do
        expect(game.calc_col_i(1)).to be_zero
      end
    end

    context 'when the move is 5' do
      it 'returns 1' do
        expect(game.calc_col_i(5)).to eql(1)
      end
    end

    context 'when the move is 9' do
      it 'returns 2' do
        expect(game.calc_col_i(9)).to eql(2)
      end
    end
  end
end
