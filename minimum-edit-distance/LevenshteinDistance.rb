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

  def self.backtrace(a, b, visualize = false)
    grid = [(0..b.length).to_a]
    grid += Array.new(a.length) { |i| [i + 1] + b.chars.map { 0 } }
    backtrace = [["-"] + Array.new(b.length) { "I" }]
    backtrace += Array.new(a.length) { ["D"] + Array.new(b.length) { "-" } }

    for i in 0...a.length
      for j in 0...b.length
        d = [grid[i][j + 1] + 1, grid[i + 1][j] + 1, grid[i][j] + (a[i] == b[j] ? 0 : 2)]
        grid[i + 1][j + 1] = d.min
        backtrace[i + 1][j + 1] = "D" if grid[i + 1][j + 1] == d[0]
        backtrace[i + 1][j + 1] = "I" if grid[i + 1][j + 1] == d[1]
        backtrace[i + 1][j + 1] = "S" if grid[i + 1][j + 1] == d[2]
      end
    end

    path = ""
    i = a.length
    j = b.length
    until backtrace[i][j] == "-"
      path += backtrace[i][j]
      backtrace[i][j] = "*"
      i -= 1 if ["D", "S"].include? path[-1]
      j -= 1 if ["I", "S"].include? path[-1]
    end
    backtrace[i][j] = "*"
    backtrace = backtrace.map { |i| i.map { |j| j == "*" ? "*" : "-" } }

    if visualize
      print "  # " + b.split("").join(" ") + "\n"
      backtrace.each_with_index { |row, i| puts "#{("#" + a)[i]} #{row.join(" ")}" }
    end

    i = 0
    j = 0
    x = []
    y = []
    path.reverse.chars.each do |letter|
      if letter == "D"
        x.push(a[i])
        y.push("*")
        i += 1
      elsif letter == "I"
        x.push("*")
        y.push(b[j])
        j += 1
      else
        x.push(a[i])
        y.push(b[j])
        i += 1
        j += 1
      end
    end

    print [x.join(" "), Array.new(path.length) { "|" }.join(" "), y.join(" ")].join("\n")
  end

end