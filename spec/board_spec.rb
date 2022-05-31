# frozen_string_literal: true

require_relative '../lib/board'

describe Board do 
  describe '#win?' do
    context 'when there are three Xs in the top row' do
      values = [%w[X X X], [nil, nil, nil], [nil, nil, nil]]
      subject(:top_row_win_board_x) { described_class.new(values) }
      it 'is a win' do
        expect(top_row_win_board_x).to be_win
      end
    end

    context 'when there are three Xs in the middle row' do
      values = [[nil, nil, nil], %w[X X X], [nil, nil, nil]]
      subject(:middle_row_win_board_x) { described_class.new(values) }
      it 'is a win' do
        expect(middle_row_win_board_x).to be_win
      end
    end

    context 'when there are three Xs in the bottom row' do
      values = [[nil, nil, nil], [nil, nil, nil], %w[X X X]]
      subject(:bottom_row_win_board_x) { described_class.new(values) }
      it 'is a win' do
        expect(bottom_row_win_board_x).to be_win
      end
    end

    context 'when there are three Xs in the left column' do
      values = [['X', nil, nil], ['X', nil, nil], ['X', nil, nil]]
      subject(:left_col_win_board_x) { described_class.new(values) }
      it 'is a win' do
        expect(left_col_win_board_x).to be_win
      end
    end

    context 'when there are three Xs in the middle column' do
      values = [[nil, 'X', nil], [nil, 'X', nil], [nil, 'X', nil]]
      subject(:middle_col_win_board_x) { described_class.new(values) }
      it 'is a win' do
        expect(middle_col_win_board_x).to be_win
      end
    end

    context 'when there are three Xs in the right column' do
      values = [[nil, nil, 'X'], [nil, nil, 'X'], [nil, nil, 'X']]
      subject(:right_col_win_board_x) { described_class.new(values) }
      it 'is a win' do
        expect(right_col_win_board_x).to be_win
      end
    end

    context 'when there are three Xs in the left diagonal' do
      values = [['X', nil, nil], [nil, 'X', nil], [nil, nil, 'X']]
      subject(:left_diag_win_board_x) { described_class.new(values) }
      it 'is a win' do
        expect(left_diag_win_board_x).to be_win
      end
    end

    context 'when there are three Xs in the right diagonal' do
      values = [[nil, nil, 'X'], [nil, 'X', nil], ['X', nil, nil]]
      subject(:right_diag_win_board_x) { described_class.new(values) }
      it 'is a win' do
        expect(right_diag_win_board_x).to be_win
      end
    end

    context 'when there are three Os in the top row' do
      values = [%w[O O O], [nil, nil, nil], [nil, nil, nil]]
      subject(:top_row_win_board_o) { described_class.new(values) }
      it 'is a win' do
        expect(top_row_win_board_o).to be_win
      end
    end

    context 'when there are three Os in the middle row' do
      values = [[nil, nil, nil], %w[O O O], [nil, nil, nil]]
      subject(:middle_row_win_board_o) { described_class.new(values) }
      it 'is a win' do
        expect(middle_row_win_board_o).to be_win
      end
    end

    context 'when there are three Os in the bottom row' do
      values = [[nil, nil, nil], [nil, nil, nil], %w[O O O]]
      subject(:bottom_row_win_board_o) { described_class.new(values) }
      it 'is a win' do
        expect(bottom_row_win_board_o).to be_win
      end
    end

    context 'when there are three Os in the left column' do
      values = [['O', nil, nil], ['O', nil, nil], ['O', nil, nil]]
      subject(:left_col_win_board_o) { described_class.new(values) }
      it 'is a win' do
        expect(left_col_win_board_o).to be_win
      end
    end

    context 'when there are three Os in the middle column' do
      values = [[nil, 'O', nil], [nil, 'O', nil], [nil, 'O', nil]]
      subject(:middle_col_win_board_o) { described_class.new(values) }
      it 'is a win' do
        expect(middle_col_win_board_o).to be_win
      end
    end

    context 'when there are three Os in the right column' do
      values = [[nil, nil, 'O'], [nil, nil, 'O'], [nil, nil, 'O']]
      subject(:right_col_win_board_o) { described_class.new(values) }
      it 'is a win' do
        expect(right_col_win_board_o).to be_win
      end
    end

    context 'when there are three Os in the left diagonal' do
      values = [['O', nil, nil], [nil, 'O', nil], [nil, nil, 'O']]
      subject(:left_diag_win_board_o) { described_class.new(values) }
      it 'is a win' do
        expect(left_diag_win_board_o).to be_win
      end
    end

    context 'when there are three Os in the right diagonal' do
      values = [[nil, nil, 'O'], [nil, 'O', nil], ['O', nil, nil]]
      subject(:right_diag_win_board_o) { described_class.new(values) }
      it 'is a win' do
        expect(right_diag_win_board_o).to be_win
      end
    end

    context 'when the board is empty' do
      subject(:empty_board) { described_class.new }
      it 'is not a win' do
        expect(empty_board).not_to be_win
      end
    end

    context 'when there is a tie' do
      values = [%w[X O X], %w[O O X], %w[X X O]]
      subject(:tie_board) { described_class.new(values) }
      it 'is not a win' do
        expect(tie_board).not_to be_win
      end
    end

    context 'when the board is in the middle of a game but there is no 3 in a row' do
      values = [['X', 'O', nil], [nil, 'O', 'X'], ['X', nil, 'O']]
      subject(:mid_board) { described_class.new(values) }
      it 'is not a win' do
        expect(mid_board).not_to be_win
      end
    end
  end

  describe '#valid_move?' do
    values = [[nil, 'O', 'X'], [nil, 'O', 'X'], ['O', 'X', nil]]
    subject(:valid_move_board) { described_class.new(values) }

    context "when the move is '1' and '1' is empty" do
      it 'is a valid move' do
        expect(valid_move_board).to be_valid_move('1')
      end
    end

    context "when the move is '9' and '9' is empty" do
      it 'is a valid move' do
        expect(valid_move_board).to be_valid_move('9')
      end
    end

    context "when the move is '4' and '4' is empty" do
      it 'is a valid move' do
        expect(valid_move_board).to be_valid_move('4')
      end
    end

    context "when the move is '2' and '2' is not empty" do
      it 'is not a valid move' do
        expect(valid_move_board).not_to be_valid_move('2')
      end
    end

    context "when the move is '-1'" do
      it 'is not a valid move' do
        expect(valid_move_board).not_to be_valid_move('-1')
      end
    end

    context "when the move is '0'" do
      it 'is not a valid move' do
        expect(valid_move_board).not_to be_valid_move('0')
      end
    end

    context "when the move is '10'" do
      it 'is not a valid move' do
        expect(valid_move_board).not_to be_valid_move('10')
      end
    end

    context "when the move is 'two'" do
      it 'is not a valid move' do
        expect(valid_move_board).not_to be_valid_move('two')
      end
    end
  end

  describe '#update' do
    subject(:update_board) { described_class.new }

    context 'when updating row 0, column 0 to X' do
      it 'will change the value at row 0, column 0 to X' do
        expect { update_board.update(0, 0, 'X') }
          .to change { update_board.instance_variable_get(:@values)[0][0] }.to('X')
      end
    end

    context 'when updating row 0, column 0 to O' do
      it 'will change the value at row 0, column 0 to O' do
        expect { update_board.update(0, 0, 'O') }
          .to change { update_board.instance_variable_get(:@values)[0][0] }.to('O')
      end
    end

    context 'when updating row 2, column 2 to X' do
      it 'will change the value at row 2, column 2 to X' do
        expect { update_board.update(2, 2, 'X') }
          .to change { update_board.instance_variable_get(:@values)[2][2] }.to('X')
      end
    end

    context 'when updating row 2, column 2 to O' do
      it 'will change the value at row 2, column 2 to O' do
        expect { update_board.update(2, 2, 'O') }
          .to change { update_board.instance_variable_get(:@values)[2][2] }.to('O')
      end
    end

    context 'when updating row 1, column 2 to X' do
      it 'will change the value at row 1, column 2 to X' do
        expect { update_board.update(1, 2, 'X') }
          .to change { update_board.instance_variable_get(:@values)[1][2] }.to('X')
      end
    end

    context 'when updating row 1, column 2 to O' do
      it 'will change the value at row 1, column 2 to O' do
        expect { update_board.update(1, 2, 'O') }
          .to change { update_board.instance_variable_get(:@values)[1][2] }.to('O')
      end
    end
  end

  describe '#to_s' do
    context 'when getting a string for an empty board' do
      subject(:empty_board) { described_class.new }
      it 'will return a board with squares labeled 1-9' do
        empty_board_string = "\n 1 | 2 | 3 \n---+---+---\n 4 | 5 | 6 \n---+---+---\n 7 | 8 | 9 \n"
        expect(empty_board.to_s).to eql(empty_board_string)
      end
    end

    context 'when getting a string for a board mid-game' do
      values = [['X', 'O', nil], [nil, 'O', 'X'], ['X', nil, 'O']]
      subject(:mid_board) { described_class.new(values) }
      it 'will return a board with empty squares labeled with 1-9 and occupied squares with Xs or Os' do
        mid_board_string = "\n X | O | 3 \n---+---+---\n 4 | O | X \n---+---+---\n X | 8 | O \n"
        expect(mid_board.to_s).to eql(mid_board_string)
      end
    end

    context 'when getting a string for a full board' do
      values = [%w[X O X], %w[O O X], %w[X X O]]
      subject(:full_board) { described_class.new(values) }
      it 'will return a board with occupied squared with Xs or Os' do
        full_board_string = "\n X | O | X \n---+---+---\n O | O | X \n---+---+---\n X | X | O \n"
        expect(full_board.to_s).to eql(full_board_string)
      end
    end
  end
end
