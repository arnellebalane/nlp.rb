class NeedlemanWunsch

  def self.align(a, b, options = {})
    matrix = [[0] + Array.new(b.length) { |i| -i * 2 - 2 }]
    matrix += Array.new(a.length) { |i| [-i * 2 - 2] + b.chars.map { 0 } }
    backtrace = [["-"] + Array.new(b.length) { "L" }]
    backtrace += Array.new(a.length) { ["U"] + Array.new(b.length) { "" } }

    for i in 0...a.length
      for j in 0...b.length
        d = [matrix[i][j] + (a[i] == b[j] ? 1 : -1), matrix[i + 1][j] - 2, matrix[i][j + 1] - 2]
        matrix[i + 1][j + 1] = d.max
        backtrace[i + 1][j + 1] += "D" if matrix[i + 1][j + 1] == d[0]
        backtrace[i + 1][j + 1] += "L" if matrix[i + 1][j + 1] == d[1]
        backtrace[i + 1][j + 1] += "U" if matrix[i + 1][j + 1] == d[2]
      end
    end

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

    alignments = alignments(backtrace)
    alignments.each do |alignment|
      x = []
      y = []
      z = []
      previous = alignment.delete_at(0)
      alignment.each do |cell|
        if cell[0] == previous[0]
          x.push("*")
          y.push(b[cell[1] - 1])
          z.push(" ")
        elsif cell[1] == previous[1]
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

    def self.alignments(backtrace, i = nil, j = nil)
      i = i || backtrace.length - 1
      j = j || backtrace[i].length - 1
      return [[[0, 0]]] if i == 0 and j == 0

      paths = []
      directions = backtrace[i][j].split("")
      directions.each do |direction|
        if direction == "L"
          paths += alignments(backtrace, i, j - 1).map { |path| path + [[i, j]] }
        elsif direction == "U"
          paths += alignments(backtrace, i - 1, j).map { |path| path + [[i, j]] }
        elsif direction == "D"
          paths += alignments(backtrace, i - 1, j - 1).map { |path| path + [[i, j]] }
        end
      end
      return paths
    end

end



NeedlemanWunsch.align("ctg", "acct")