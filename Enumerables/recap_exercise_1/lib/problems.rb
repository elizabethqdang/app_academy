# Write a method, all_vowel_pairs, that takes in an array of words and returns all pairs of words
# that contain every vowel. Vowels are the letters a, e, i, o, u. A pair should have its two words
# in the same order as the original array. 
#
# Example:
#
# all_vowel_pairs(["goat", "action", "tear", "impromptu", "tired", "europe"])   # => ["action europe", "tear impromptu"]

def 
    all_vowel_pairs(words)
    vowels = ("aeiou").split("")
    pairs = [] 
    vowel_pairs = []

    words.each_with_index do |word1, idx1|
        words.each_with_index do |word2, idx2|
            if idx1 < idx2 && vowels.all? { |vowel| (word1 + word2).include?(vowel) }
                pair = word1 + " " + word2
                pairs << pair
            end
        end
    end
    pairs
end



# Write a method, composite?, that takes in a number and returns a boolean indicating if the number
# has factors besides 1 and itself

def composite?(num)
    (2...num).each { |fact| return true if num % fact == 0 }
    false
end

p composite?(9)     # => true
p composite?(13)    # => false



# A bigram is a string containing two letters.
# Write a method, find_bigrams, that takes in a string and an array of bigrams.
# The method should return an array containing all bigrams found in the string.
# The found bigrams should be returned in the the order they appear in the original array.

def find_bigrams(str, bigrams)
    answer = []
    bigrams.each do |bigram|
        answer << bigram if str.include?(bigram)
    end
    answer
end

p find_bigrams("the theater is empty", ["cy", "em", "ty", "ea", "oo"])  # => ["em", "ty", "ea"]
p find_bigrams("to the moon and back", ["ck", "oo", "ha", "at"])        # => ["ck", "oo"]


class Hash
    # Write a method, Hash#my_select, that takes in an optional proc argument
    # The method should return a new hash containing the key-value pairs that return
    # true when passed into the proc.
    # If no proc is given, then return a new hash containing the pairs where the key is equal to the value.
   
    def my_select(&prc)
        hash = {}
            
        self.each do |k, v|
            if prc == nil
                hash[k] = v if k == v
            else
                hash[k] = v if (prc||=Proc.new{k == v}).call(k, v)
            end
        end 
        hash
    end
    
     hash_1 = {x: 7, y: 1, z: 8}
    p hash_1.my_select { |k, v| v.odd? }          # => {x: 7, y: 1}
    #
     hash_2 = {4=>4, 10=>11, 12=>3, 5=>6, 7=>8}
    p hash_2.my_select { |k, v| k + 1 == v }      # => {10=>11, 5=>6, 7=>8})
    # p hash_2.my_select                            # => {4=>4}
   
end

class String
    # Write a method, String#substrings, that takes in a optional length argument
    # The method should return an array of the substrings that have the given length.
    # If no length is given, return all substrings.
    
    def substrings(length = nil)
        substrings = []
        self.each_char.with_index do |char, i|
            self.each_char.with_index do |char2, i2|
                if i2 >= i
                    substrings << self[i] + self[i + 1..i2]
                end
            end
        end
        
        if length != nil
            substrings.select { |substring| substring.length == length}
        else
            substrings
        end
    end

    p "cats".substrings     # => ["c", "ca", "cat", "cats", "a", "at", "ats", "t", "ts", "s"]
    p "cats".substrings(2)  # => ["ca", "at", "ts"]
    


    # Write a method, String#caesar_cipher, that takes in an a number.
    # The method should return a new string where each char of the original string is shifted
    # the given number of times in the alphabet.
   
    def caesar_cipher(num)
        alpha = ("a".."z").to_a
        newstr = ""
        self.each_char.with_index do |char, i|
            oldi = alpha.index(char)
            newi = oldi + num
            newstr += alpha[newi % 26]
        end
        newstr
    end
    
    p "apple".caesar_cipher(1)    #=> "bqqmf"
    p "bootcamp".caesar_cipher(2) #=> "dqqvecor"
    p "zebra".caesar_cipher(4)    #=> "difve"
    
end
