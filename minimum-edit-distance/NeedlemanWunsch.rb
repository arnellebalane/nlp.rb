class NeedlemanWunsch

  def self.align(a, b, options = {})
    matrix = [[0] + Array.new(b.length) { |i| -i * 2 - 2 }]
    matrix += Array.new(a.length) { |i| [-i * 2 - 2] + b.chars.map { 0 } }
    backtrace = [["-"] + Array.new(b.length) { "I" }]
    backtrace += Array.new(a.length) { ["D"] + Array.new(b.length) { "-" } }

    for i in 0...a.length
      for j in 0...b.length
        d = [matrix[i][j + 1] - 2, matrix[i + 1][j] - 2, matrix[i][j] + (a[i] == b[j] ? 1 : -1)]
        matrix[i + 1][j + 1] = d.max
        backtrace[i + 1][j + 1] = "D" if matrix[i + 1][j + 1] == d[0]
        backtrace[i + 1][j + 1] = "I" if matrix[i + 1][j + 1] == d[1]
        backtrace[i + 1][j + 1] = "S" if matrix[i + 1][j + 1] == d[2]
      end
    end
    
    print "     #   " + b.split("").join("   ") + "\n\n"
    matrix.each_with_index do |row, i|
      print "#{("#" + a)[i]} "
      row.each { |j| print "#{ Array.new(4 - j.to_s.length) { " " }.join }#{j}" }
      puts "\n"
    end
  end

end



NeedlemanWunsch.align("cat", "ata")