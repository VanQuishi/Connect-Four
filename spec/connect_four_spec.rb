require './lib/connect_four.rb'

describe Player do
    describe "#is_filled_below?" do
        it "check last row cell if the \'cells\' below it are filled" do
            user = Player.new('X')
            expect(user.is_filled_below?(35)). to eq(false)
        end

        it "check a cell that have all filled cells below" do
            user = Player.new('X')
            expect(user.is_filled_below?(21)). to eq(true)
        end

        it "check a cell that don't have all filled cells below" do
            user = Player.new('X')
            expect(user.is_filled_below?(29)). to eq(false)
        end
    end

    describe "#drop" do
        it "notify a sucessful drop" do
            user = Player.new('X')
            expect(user.drop('X', 21)).to eq(true)
        end

        it "notify a failed drop" do
            user = Player.new('X')
            expect(user.drop('X', 29)).to eq(false)
        end
    end

    describe "#isInside?" do
        it "returns true for a win comnbination that is inside the board" do
            user = Player.new('X')
            expect(user.isInside?(8,9,10,11)).to eq(true)
        end

        it "returns false for a win comnbination that is not inside the board" do
            user = Player.new('X')
            expect(user.isInside?(8,9,10,11)).to eq(true)
        end
    end
end