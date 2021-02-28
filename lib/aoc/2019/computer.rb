class Computer
  def self.run(data, **kw)
    Ractor.new(data, **kw) do |data|
      Computer.new(data).run
    end
  end

  def initialize(data)
    @data = data
    @pos = 0
  end

  def run
    loop do
      modes, opcode = @data[@pos].divmod 100
      break if opcode == 99

      send("opcode#{opcode}", *(modes.digits unless modes.zero?))
    end

    @data[0]
  end

  private

  def add(mode1 = 0, mode2 = 0)
    @data[@data[@pos + 3]] = read(@pos + 1, mode1) + read(@pos + 2, mode2)
    @pos += 4
  end
  alias opcode1 add

  def multiply(mode1 = 0, mode2 = 0)
    @data[@data[@pos + 3]] = read(@pos + 1, mode1) * read(@pos + 2, mode2)
    @pos += 4
  end
  alias opcode2 multiply

  # input
  def input
    @data[@data[@pos + 1]] = Ractor.receive
    @pos += 2
  end
  alias opcode3 input

  # output
  def output(mode1 = 0)
    Ractor.yield read(@pos + 1, mode1)
    @pos += 2
  end
  alias opcode4 output

  # jump_if_true
  def jump_if_true(mode1 = 0, mode2 = 0)
    if read(@pos + 1, mode1).zero?
      @pos += 3
    else
      @pos = read(@pos + 2, mode2)
    end
  end
  alias opcode5 jump_if_true

  # jump_if_false
  def jump_if_false(mode1 = 0, mode2 = 0)
    if read(@pos + 1, mode1).zero?
      @pos = read(@pos + 2, mode2)
    else
      @pos += 3
    end
  end
  alias opcode6 jump_if_false

  # less_than
  def less_than(mode1 = 0, mode2 = 0)
    @data[@data[@pos + 3]] = read(@pos + 1, mode1) < read(@pos + 2, mode2) ? 1 : 0
    @pos += 4
  end
  alias opcode7 less_than

  # equals
  def equals(mode1 = 0, mode2 = 0)
    @data[@data[@pos + 3]] = read(@pos + 1, mode1) == read(@pos + 2, mode2) ? 1 : 0
    @pos += 4
  end
  alias opcode8 equals


  def read(position, mode)
    if mode.zero?
      @data[@data[position]]
    else
      @data[position]
    end
  end
end
