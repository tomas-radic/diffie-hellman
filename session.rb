class Session
  include PrimeNumbers

  attr_accessor :participant1, :participant2
  attr_accessor :low_prime_number, :high_prime_number
  MAX_SECRET_NUMBER = (2 ** 16) - 1

  def initialize
    @low_prime_number = generate_prime_number(eq_or_less_than: rand(5..20))
    @high_prime_number = generate_prime_number(eq_or_less_than: MAX_SECRET_NUMBER)
  end
end
