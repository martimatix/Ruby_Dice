=begin
@return [String]
@author Zachary Perlmutter <zrp200@gmail.com>
@param int [Integer]
@example Usage
	double_digit 5 #=> "05"
	double_digit 10 #=> 10
=end
def double_digit(int)
	if number < 10 then return "0#{number}"
	else; return number.to_s
end
end
alias dd double_digit
