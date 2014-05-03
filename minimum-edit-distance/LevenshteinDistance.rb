class LevenshteinDistance

  def self.between(a, b, visualize = false)
    grid = [(0..b.length).to_a]
    grid += Array.new(a.length) { |i| [i + 1] + b.chars.map { 0 } }

    for i in 0...a.length
      for j in 0...b.length
        grid[i + 1][j + 1] = [grid[i][j + 1] + 1, grid[i + 1][j] + 1, grid[i][j] + (a[i] == b[j] ? 0 : 2)].min
      end
    end

    if visualize
      print "    #  " + b.split("").join("  ") + "\n\n"
      grid.each_with_index do |row, i|
        print "#{("#" + a)[i]} "
        row.each do |j|
          print "#{ Array.new(3 - j.to_s.length) { " " }.join }#{j}"
        end
        puts "\n"
      end
    end
    grid.last.last
  end

end