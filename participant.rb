class Participant
  include PrimeNumbers

  def initialize(name:, high_prime_number:)
    @name = name
    @secret_number = generate_prime_number(
      eq_or_less_than: rand((high_prime_number / 2)..high_prime_number) - 1
    )
  end

  def partial_shared_secret(low_prime_number, high_prime_number)
    @partial_shared_secret ||= (low_prime_number ** secret_number) % high_prime_number
  end

  private

  attr_reader :secret_number

  def shared_secret(partial_shared_secret_of_other_participant, high_prime_number)
    (partial_shared_secret_of_other_participant ** secret_number) % high_prime_number
  end
end
