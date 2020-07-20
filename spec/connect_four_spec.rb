require './lib/connect_four.rb'

describe Player do
    describe "#is_filled_below?" do
        it "check last row cell if the \'cells\' below it are filled" do
            Player.empty()
            user = Player.new('X')
            expect(user.is_filled_below?(3,5)). to eq(true)
        end

        it "check a cell that have all filled cells below" do
            user = Player.new('X')
            board = Player.class_variable_get(:@@board)
            board[0][3] = 'X'
            board[0][4] = 'X'
            board[0][5] = 'X'
            expect(user.is_filled_below?(0,2)). to eq(true)
        end

        it "check a cell that don't have all filled cells below" do
            user = Player.new('X')
            expect(user.is_filled_below?(0,1)). to eq(false)
        end
    end

    describe "#drop" do
        it "notify a sucessful drop" do
            user = Player.new('X')
            board = Player.class_variable_get(:@@board)
            board[1][5] = 'X'
            expect(user.drop(1,4)).to eq(true)
        end

        it "notify a failed drop" do
            user = Player.new('X')
            expect(user.drop(0,1)).to eq(false)
        end
    end

    describe "#isInside?" do
        it "returns true for a win comnbination that is inside the board" do
            user = Player.new('X')
            expect(user.isInside?(0,5)).to eq(true)
        end

        it "returns false for a win comnbination that is not inside the board" do
            user = Player.new('X')
            expect(user.isInside?(0,6)).to eq(false)
        end
    end

    describe "#vertical_win?" do
        it "returns true for a win vertiacally" do
            user = Player.new('X')
            board = Player.class_variable_get(:@@board)
            board[1][2] = 'X'
            board[1][3] = 'X'
            board[1][4] = 'X'
            board[1][5] = 'X'
            expect(user.vertical_win?(1)).to eq(true)
        end

        it "returns false for no win vertiacally" do
            user = Player.new('X')
            expect(user.vertical_win?(3)).to eq(false)
        end
    end

    describe "#horizontal_win?" do
        it "returns true for a win horizontally" do
            user = Player.new('X')
            board = Player.class_variable_get(:@@board)
            board[0][5] = 'X'
            board[1][5] = 'X'
            board[2][5] = 'X'
            board[3][5] = 'X'
            expect(user.horizontal_win?(5)).to eq(true)
        end
        
        it "returns false for no win horizontally" do
            user = Player.new('X')
            board = Player.class_variable_get(:@@board)
            expect(user.horizontal_win?(4)).to eq(false)
        end
    end

    describe "#diagonal_win?" do
        it "returns true for a win diagonally" do
            user = Player.new('X')
            board = Player.class_variable_get(:@@board)
            board[2][4] = 'X'
            board[0][2] = 'X'
            expect(user.diagonal_win?(3,5)).to eq(true)
        end
        
        it "returns false for no win diagonally" do
            user = Player.new('X')
            board = Player.class_variable_get(:@@board)
            expect(user.diagonal_win?(2,5)).to eq(false)
        end
    end
end
