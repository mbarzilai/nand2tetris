class Parser
  attr_reader :hasMoreCommands, :commandType, :symbol, :dest, :comp, :jump

  # Opens the input file/stream and gets ready to parse it
  def initialize(filename)
    @commands = IO.readlines(filename, chomp: true)
      .collect{|c| c.gsub(/(\s*)/, '').gsub(/\/\/.*/, '')}
      .select{|c| c != ''}
    @i = 0
  end


  # Reads the next command from the input and makes it the current command.
  # Should be called only if hasMoreCommands() is true.
  # Initially there is no current command.
  def advance
    @command = @commands.fetch(@i)
    @commandType = nil
    @symbol = nil
    @dest = nil
    @comp = nil
    @jump = nil
    parse()
    @i += 1
  end

  def hasMoreCommands
    @i < @commands.length
  end

private
  def parse
    if @command[0] == '@'
      @commandType = 'A_COMMAND'
      @symbol = @command[1..-1]
    elsif @command[0] == '('
      @commandType = 'L_COMMAND'
      @symbol = @command[1...-1]
    else
      @commandType = 'C_COMMAND'
      c = @command.match /(?<dest>[AMD]*)=?(?<comp>[AMD+-01!&|]*);*(?<jump>.*)/
      @dest = c[:dest]
      @comp = c[:comp]
      @jump = c[:jump]

      if @comp == ''
        @comp = @dest
        @dest = ''
      end

    end
  end
end

# a=Parser.new('../pong/PongL.asm')
# a.advance
# a.advance
# a.advance
# a.advance
# a.advance
# a.advance
# a.advance
# a.advance
# a.advance
# a.advance
# a.advance
# a.advance
# a.advance
# a.advance
# a.advance
# a.advance
# a.advance
# a.advance
# a.advance
# a.advance
