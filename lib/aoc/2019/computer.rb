class Computer
  def self.run(data)
    Ractor.new(data) do |data|
      Computer.new(data).run
    end
  end

  def initialize(data)
    @data = data
    @pos = 0
    @instructions = software
  end

  def software
    [nil, add, multiply, input, output, jump_if_true, jump_if_false, less_than, equals]
  end

  def run
    loop do
      modes, opcode = @data[@pos].divmod 100
      instruction = @instructions[opcode] || break
      @pos = instruction.call(*modes.digits) || (@pos + instruction.arity + 1)
    end

    @data[0]
  end

  private

  # Instruction set

  # Return a number to jump, nil to advance

  def add = proc { write 3, _3, read(1, _1) + read(2, _2) }

  def multiply = proc { write 3, _3, read(1, _1) * read(2, _2) }

  def input = proc { write 1, _1, Ractor.receive }

  def output = proc { Ractor.yield read(1, _1) }

  def jump_if_true = proc { read(2, _2) unless read(1, _1).zero? }

  def jump_if_false = proc { read(2, _2) if read(1, _1).zero? }

  def less_than = proc { write 3, _3, read(1, _1) < read(2, _2) ? 1 : 0 }

  def equals = proc { write 3, _3, read(1, _1) == read(2, _2) ? 1 : 0 }

  # Memory access

  def write(position, _mode, value)
    @data[@data[@pos + position]] = value
    nil
  end

  def read(position, mode)
    if mode.nil? || mode.zero?
      @data[@data[@pos + position]]
    else
      @data[@pos + position]
    end
  end
end
