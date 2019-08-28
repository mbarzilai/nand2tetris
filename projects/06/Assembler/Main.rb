require('./Parser.rb');
require('./Code.rb');


class Main
  include Code

  def initialize(filename)
    @parser = Parser.new(filename + '.asm')
    new_file_name = filename + '.hack'
    @newfile = open(new_file_name, "w")
    @newfile.truncate(0)
  end

  def parse
    while @parser.hasMoreCommands
      @parser.advance()
      if @parser.commandType == 'A_COMMAND'
        new_command = '0' + createAddress(@parser.symbol)
      else
        new_command = '111' + comp(@parser.comp) + dest(@parser.dest) + jump(@parser.jump)
      end
      @newfile.write(new_command)
      @newfile.write("\n")
    end
    @newfile.close()
  end

end


