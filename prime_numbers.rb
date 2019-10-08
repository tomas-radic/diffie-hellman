require 'prime'

module PrimeNumbers
  def generate_prime_number(eq_or_less_than:)
    while eq_or_less_than > 0 && !Prime.prime?(eq_or_less_than) do
      eq_or_less_than -= 1
    end

    Prime.prime?(eq_or_less_than) ? eq_or_less_than : nil
  end
end
