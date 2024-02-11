# frozen_string_literal: true

class Dataset
  attr_accessor :sequences

  def initialize(sequence)
    @sequences = generate_sequences(sequence)
  end

  def generate_sequences(sequence)
    equilibrium_reached = false

    sequences = [sequence]

    until equilibrium_reached
      sequence = Dataset.next_sequence(sequence)
      sequences << sequence
      equilibrium_reached = true if sequence.all?(&:zero?)
    end

    sequences
  end

  def get_next_prediction
    reversed_sequences = @sequences.reverse

    next_number = 0

    reversed_sequences.each_with_index do |sequence, index|
      unless index == reversed_sequences.length - 1
        next_number = sequence.last + reversed_sequences[index + 1].last
        reversed_sequences[index + 1] << next_number
      end
    end

    next_number
  end

  def get_previous_prediction
    reversed_sequences = @sequences.reverse

    previous_number = 0

    reversed_sequences.each_with_index do |sequence, index|
      unless index == reversed_sequences.length - 1
        previous_number = reversed_sequences[index + 1].first - sequence.first
        reversed_sequences[index + 1].unshift(previous_number)
      end
    end

    previous_number
  end

  def self.next_sequence(sequence)
    new_sequence = []

    sequence.each_with_index do |number, index|
      new_sequence << (sequence[index + 1] - number) unless index == sequence.length - 1
    end

    new_sequence
  end
end
