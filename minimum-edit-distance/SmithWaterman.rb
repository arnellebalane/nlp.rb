class SmithWaterman

  def self.align(a, b, options = {})
    insertion_cost = options[:insertion_cost] || -1
    deletion_cost = options[:deletion_cost] || -1
    match_cost = options[:match_cost] || 1
    mismatch_cost = options[:mismatch_cost] || -1

    matrix = Array.new(a.length + 1) { Array.new(b.length + 1) { 0 } }
    backtrace = [Array.new(b.length + 1) { "-" }] + Array.new(a.length) { ["-"] + Array.new(b.length) { "" } }
    highest_score = 0
    highest_scoring_cells = []

    for i in 0...a.length
      for j in 0...b.length
        d = [0, matrix[i][j] + (a[i] == b[j] ? match_cost : mismatch_cost), matrix[i][j + 1] + insertion_cost, matrix[i + 1][j] + deletion_cost]
        matrix[i + 1][j + 1] = d.max
        if matrix[i + 1][j + 1] > 0
          backtrace[i + 1][j + 1] += "D" if matrix[i + 1][j + 1] == d[1]
          backtrace[i + 1][j + 1] += "U" if matrix[i + 1][j + 1] == d[2]
          backtrace[i + 1][j + 1] += "L" if matrix[i + 1][j + 1] == d[3]

          if matrix[i + 1][j + 1] > highest_score
            highest_score = matrix[i + 1][j + 1]
            highest_scoring_cells = [[i + 1, j + 1]]
          elsif matrix[i + 1][j + 1] == highest_score
            highest_scoring_cells.push([i + 1, j + 1])
          end
        end
      end
    end

    if options.has_key?(:visualize) and options[:visualize]
      print "    #  " + b.split("").join("  ") + "\n\n"
      matrix.each_with_index do |row, i|
        print "#{("#" + a)[i]} "
        row.each { |j| print "#{ Array.new(3 - j.to_s.length) { " " }.join }#{j}" }
        puts "\n"
      end
      puts "\n"

      print "    #  " + b.split("").join("  ") + "\n\n"
      backtrace.each_with_index do |row, i|
        print "#{("#" + a)[i]} "
        row.each { |j| print "#{ Array.new(3 - j.to_s.length) { " " }.join }#{j}" }
        puts "\n"
      end
      puts "\n"
    end

    alignments = []
    highest_scoring_cells.each do |cell|
      alignments += traceback(matrix, backtrace, cell[0], cell[1])
    end

    alignments.each do |alignment|
      x = []
      y = []
      z = []
      previous = nil
      alignment.each do |cell|
        if !previous.nil? and cell[0] == previous[0]
          x.push("*")
          y.push(b[cell[1] - 1])
          z.push(" ")
        elsif !previous.nil? and cell[1] == previous[1]
          x.push(a[cell[0] - 1])
          y.push("*")
          z.push(" ")
        else
          x.push(a[cell[0] - 1])
          y.push(b[cell[1] - 1])
          z.push(a[cell[0] - 1] == b[cell[1] - 1] ? "|" : " ")
        end
        previous = cell
      end
      print "#{x.join(" ")}\n#{z.join(" ")}\n#{y.join(" ")}\n\n"
    end
  end

  private

    def self.traceback(matrix, backtrace, i, j)
      return [[]] if matrix[i][j] == 0

      paths = []
      backtrace[i][j].chars.each do |direction|
        if direction == "L"
          paths += traceback(matrix, backtrace, i, j - 1).map { |path| path + [[i, j]] }
        elsif direction == "U"
          paths += traceback(matrix, backtrace, i - 1, j).map { |path| path + [[i, j]] }
        elsif direction == "D"
          paths += traceback(matrix, backtrace, i - 1, j - 1).map { |path| path + [[i, j]] }
        end
      end
      return paths
    end

end