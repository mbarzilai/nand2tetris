require('./Parser.rb');
require('./Code.rb');
require('./SymbolTable.rb')


class Main
  include Code

  def initialize(filename)
    new_file_name = filename + '.hack'
    @newfile = open(new_file_name, "w")
    @newfile.truncate(0)

    @parser = Parser.new(filename + '.asm')
    @symbol_table = SymbolTable.new

    createLabels()
    parse()
  end

  def createLabels
    cur_addr = 0
    while @parser.hasMoreCommands
      @parser.advance()
      if @parser.commandType == 'L_COMMAND'
        @symbol_table.addEntry(@parser.symbol, cur_addr)
      else
        cur_addr += 1
      end
    end
    @parser.i = 0
  end

  def parse
    next_open = 16
    while @parser.hasMoreCommands
      @parser.advance()
      if @parser.commandType == 'A_COMMAND'
        if @parser.symbol[0].match(/\d/)
          new_command = '0' + createAddress(@parser.symbol)
        else
          if !@symbol_table.contains(@parser.symbol)
            @symbol_table.addEntry(@parser.symbol, next_open)
            next_open += 1
          end
          new_command = '0' + createAddress(@symbol_table.getAddress(@parser.symbol))
        end
      elsif @parser.commandType == 'C_COMMAND'
        new_command = '111' + comp(@parser.comp) + dest(@parser.dest) + jump(@parser.jump)
      else
        next
      end
      @newfile.write(new_command)
      @newfile.write("\n")
    end
    @newfile.close()
  end

end
