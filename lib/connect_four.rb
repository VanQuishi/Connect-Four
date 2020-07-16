class Player
    attr_accessor :marker
    @@board = [0,1,2,3,4,5,6,
               7,8,9,10,11,12,13,
               14,15,16,17,18,19,20,
               21,22,23,24,25,26,27,
               'X',29,30,31,32,33,34,
               'X',36,37,38,39,40,41]

    def initialize(marker)
        @marker  = marker
    end

    def is_filled_below?(position)
        #if the position belongs to the last row, return false
        if [35,36,37,38,39,40,41].include? position
            return false
        end

        temp_pos = position + 7

        while ![35,36,37,38,39,40,41].include? temp_pos do
            if @@board[temp_pos].is_a? Integer
                return false
            end
            temp_pos += 7
        end

        #check the last row
        if @@board[temp_pos].is_a? Integer
            return false
        end

        return true
    end

    def isInside?(a,b,c,d)  #seems hard to check for a win comb. Consider 2D array
        empty_board = [0,1,2,3,4,5,6,
                        7,8,9,10,11,12,13,
                        14,15,16,17,18,19,20,
                        21,22,23,24,25,26,27,
                        'X',29,30,31,32,33,34,
                        'X',36,37,38,39,40,41]

        if (empty_board.include? a) && (empty_board.include? b) 
            && (empty_board.include? c) && (empty_board.include? d)
            return true
        end
        
        return false
    end

    def drop(marker,position)
        #a target cell is available to be filled is when all the 
        #cell below it are filled and the target cell is empty

        if (@@board[position].is_a? Integer) && is_filled_below?(position)
            @@board[position] = marker
            return true
        end

        return false
    end
end

p Player.class_variables