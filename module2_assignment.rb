#Implement all parts of this assignment within (this) module2_assignment2.rb file

#Implement a class called LineAnalyzer.
class LineAnalyzer
  #Implement the following read-only attributes in the LineAnalyzer class.
  #* highest_wf_count - a number with maximum number of occurrences for a single word (calculated)
  #* highest_wf_words - an array of words with the maximum number of occurrences (calculated)
  #* content          - the string analyzed (provided)
  #* line_number      - the line number analyzed (provided)
  attr_reader :highest_wf_count, :highest_wf_words, :content, :line_number
  #Add the following methods in the LineAnalyzer class.
  #* initialize() - taking a line of text (content) and a line number
  #* calculate_word_frequency() - calculates result

  #Implement the initialize() method to:
  #* take in a line of text and line number
  #* initialize the content and line_number attributes
  #* call the calculate_word_frequency() method.
  def initialize (text, line_number)
    @content = text
    @line_number = line_number
    self.calculate_word_frequency
  end

  #Implement the calculate_word_frequency() method to:
  #* calculate the maximum number of times a single word appears within
  #  provided content and store that in the highest_wf_count attribute.
  #* identify the words that were used the maximum number of times and
  #  store that in the highest_wf_words attribute.
  def calculate_word_frequency
    # Create a an empty Hash to store word frequency
    word_counter = Hash.new(0)
    # Set the frequency and highest word counts to defaults
    @highest_wf_count = 0
    @highest_wf_words = []
    # Split the content and count the number of repeated words in the hash
    @content.split.each {|word| word_counter[word.downcase] += 1}
    # Iterate through the hash to find the most repeated words
    word_counter.each {|word, frequency|
      if frequency > @highest_wf_count
        @highest_wf_count = frequency
        @highest_wf_words = [word]
      # if the frequency is the same as the previous word, add that to the array as well
      elsif frequency == @highest_wf_count
        @highest_wf_words.push(word)
      end
    }
  end
end

#  Implement a class called Solution.
class Solution

  # Implement the following read-only attributes in the Solution class.
  #* analyzers - an array of LineAnalyzer objects for each line in the file
  #* highest_count_across_lines - a number with the maximum value for highest_wf_words attribute in the analyzers array.
  #* highest_count_words_across_lines - a filtered array of LineAnalyzer objects with the highest_wf_words attribute
  #  equal to the highest_count_across_lines determined previously.

  # Implement the following methods in the Solution class.
  #* analyze_file() - processes 'test.txt' intro an array of LineAnalyzers and stores them in analyzers.
  #* calculate_line_with_highest_frequency() - determines the highest_count_across_lines and
  #  highest_count_words_across_lines attribute values
  #* print_highest_word_frequency_across_lines() - prints the values of LineAnalyzer objects in
  #  highest_count_words_across_lines in the specified format

  # Implement the analyze_file() method() to:
  #* Read the 'test.txt' file in lines
  #* Create an array of LineAnalyzers for each line in the file

  # Implement the calculate_line_with_highest_frequency() method to:
  #* calculate the maximum value for highest_wf_count contained by the LineAnalyzer objects in analyzers array
  #  and stores this result in the highest_count_across_lines attribute.
  #* identifies the LineAnalyzer objects in the analyzers array that have highest_wf_count equal to highest_count_across_lines
  #  attribute value determined previously and stores them in highest_count_words_across_lines.

  #Implement the print_highest_word_frequency_across_lines() method to
  #* print the values of objects in highest_count_words_across_lines in the specified format
  attr_reader :analyzers, :highest_count_across_lines, :highest_count_words_across_lines

  def initialize
    @analyzers = []
  end

  def analyze_file
    # Iterate through the file and pass each line into the LineAnalysers class
    File.foreach('test.txt').with_index {|line, idx| @analyzers.push(LineAnalyzer.new(line, idx))}
  end

  def calculate_line_with_highest_frequency
    # Set default values for the attributes
    @highest_count_across_lines = 0
    @highest_count_words_across_lines = []
    # Loop through the LineAnalysers objects in the analysers array
    @analyzers.each {|lineAnalyser|
      if lineAnalyser.highest_wf_count > @highest_count_across_lines
        # If the line has the highest frequency store the word count and push the
        # lineAnalyser to a separate array
        @highest_count_across_lines = lineAnalyser.highest_wf_count
        @highest_count_words_across_lines = [lineAnalyser]
      elsif lineAnalyser.highest_wf_count == @highest_count_across_lines
        @highest_count_words_across_lines.push(lineAnalyser)
      end
    }
  end

  def print_highest_word_frequency_across_lines
    # Display the word frequencies
    puts "The following words have the highest word frequency per line:"
    @highest_count_words_across_lines.each {|lineAnalyser| puts "#{lineAnalyser.highest_wf_words} appears in line #{lineAnalyser.line_number}"}
  end
end

