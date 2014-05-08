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

    backtrace = alignments(backtrace)

    backtrace.each do |row|
      p row
    end
    
    print "     #   " + b.split("").join("   ") + "\n\n"
    matrix.each_with_index do |row, i|
      print "#{("#" + a)[i]} "
      row.each { |j| print "#{ Array.new(4 - j.to_s.length) { " " }.join }#{j}" }
      puts "\n"
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
      paths
    end

end



NeedlemanWunsch.align("atcgt", "tggtg")

#         j
#   - t g g t g------b
#   a 
#   t
# i c
#   g
#   t
#   |
#   |
#   a