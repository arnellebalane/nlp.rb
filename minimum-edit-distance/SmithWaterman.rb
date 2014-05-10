class SmithWaterman

  def self.align(a, b, options = {})
    matrix = Array.new(a.length + 1) { Array.new(b.length + 1) { 0 } }
    backtrace = [Array.new(b.length + 1) { "-" }] + Array.new(a.length) { ["-"] + Array.new(b.length) { "" } }
    highest_score = 0
    highest_scoring_cells = []

    for i in 0...a.length
      for j in 0...b.length
        d = [0, matrix[i][j] + (a[i] == b[j] ? 2 : -1), matrix[i][j + 1] - 2, matrix[i + 1][j] - 2]
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
  end

end



SmithWaterman.align("acctaagg", "ggctcaatca", visualize: true)