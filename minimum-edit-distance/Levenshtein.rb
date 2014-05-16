class Levenshtein

  def self.between(a, b, options = {})
    insertion_cost = options[:insertion_cost] || 1
    deletion_cost = options[:deletion_cost] || 1
    match_cost = options[:match_cost] || 0
    mismatch_cost = options[:mismatch_cost] || 2

    grid = [(0..b.length).to_a]
    grid += Array.new(a.length) { |i| [i + 1] + b.chars.map { 0 } }
    backtrace = [["-"] + Array.new(b.length) { "I" }]
    backtrace += Array.new(a.length) { ["D"] + Array.new(b.length) { "-" } }

    for i in 0...a.length
      for j in 0...b.length
        d = [grid[i][j + 1] + deletion_cost, grid[i + 1][j] + 1, grid[i][j] + (a[i] == b[j] ? match_cost : mismatch_cost)]
        grid[i + 1][j + 1] = d.min
        backtrace[i + 1][j + 1] = "D" if grid[i + 1][j + 1] == d[0]
        backtrace[i + 1][j + 1] = "I" if grid[i + 1][j + 1] == d[1]
        backtrace[i + 1][j + 1] = "S" if grid[i + 1][j + 1] == d[2]
      end
    end

    if options.has_key?(:visualize) and options[:visualize]
      print "    #  " + b.split("").join("  ") + "\n\n"
      grid.each_with_index do |row, i|
        print "#{("#" + a)[i]} "
        row.each { |j| print "#{ Array.new(3 - j.to_s.length) { " " }.join }#{j}" }
        puts "\n"
      end
    end

    if options.has_key?(:backtrace) and options[:backtrace]
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

      print "\n  # " + b.split("").join(" ") + "\n"
      backtrace.each_with_index { |row, i| puts "#{("#" + a)[i]} #{row.join(" ")}" }

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

      print "\n" + [x.join(" "), Array.new(path.length) { "|" }.join(" "), y.join(" ")].join("\n") + "\n\n"
    end

    grid.last.last
  end

end