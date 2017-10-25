# letters, space and points
# word is 1 or more letters, no more than 20
# one or more spaces
# all sentences terminated by a point
# read from first letter through to, including, the points
# output: words separated by single space, last word terminated by single point
# odd words copied in reverse, even words kept the same
# bonus: read/print characters one at a time

# algorithm 1
# - strip out the period
# - split into array
# - loop through array, creating new string
# - add period

# algorithm 2 (bonus)
# - split string into array of individual chars
# - create an odd.even flag; alternate when encountering a space
# - skip 2nd or more spaces
# - loop through array printing as we go

# algorithm 1
def oddify(string)
  words = string.split(/[ .]+/)

  words.map.with_index do |word, idx|
    idx.odd? ? word.reverse : word
  end.join(' ') << '.'
end

# algorithm 2
def oddify(string)
  is_odd = false
  new_string = ''
  chars = string.split('')

  counter = -1
  chars.each do |char|
    if is_odd && char != ' '
      new_string.insert(counter, char)
      counter -= 1
    elsif char == ' '
      is_odd ? is_odd = false : is_odd = true
      counter = -1
      new_string << ' '
    else
      new_string << char
    end
  end
  new_string.each_char { |char| print char }
end


string1 = 'whats the matter with kansas.'
p oddify(string1) == 'whats eht matter htiw kansas.'

string2 = 'whats the matter  with    kansas.'
p oddify(string2) == 'whats eht matter htiw kansas.'
