require 'prime'
require 'pry'
require_relative './prime_numbers.rb'
require_relative './session.rb'
require_relative './participant.rb'

lambda do
  session = Session.new
  alice = Participant.new(name: 'Alice', high_prime_number: session.high_prime_number)
  bob = Participant.new(name: 'Bob', high_prime_number: session.high_prime_number)
  session.participant1 = alice
  session.participant2 = bob

  partial_shared_secret_of_alice = alice.partial_shared_secret(
    session.low_prime_number,
    session.high_prime_number
  )

  partial_shared_secret_of_bob = bob.partial_shared_secret(
    session.low_prime_number,
    session.high_prime_number
  )

  secret_number_of_alice = nil
  secret_number_of_bob = nil
  brute_force_begin_time = Time.now

  Prime.each(Session::MAX_SECRET_NUMBER) do |tried_participant_secret_number|
    partial_shared_secret = (session.low_prime_number ** tried_participant_secret_number) % session.high_prime_number

    if partial_shared_secret == partial_shared_secret_of_alice
      secret_number_of_alice = tried_participant_secret_number
    end

    if partial_shared_secret == partial_shared_secret_of_bob
      secret_number_of_bob = tried_participant_secret_number
    end

    break if secret_number_of_alice || secret_number_of_bob
  end

  puts "\nBrute force seconds: #{Time.now - brute_force_begin_time}"

  shared_secret = if secret_number_of_alice
    (partial_shared_secret_of_bob ** secret_number_of_alice) % session.high_prime_number
  end

  shared_secret ||= if secret_number_of_bob
    (partial_shared_secret_of_alice ** secret_number_of_bob) % session.high_prime_number
  end

  puts "Brute forced shared secret: #{shared_secret}"
  puts "Alice's shared secret: #{alice.send(:shared_secret, partial_shared_secret_of_bob, session.high_prime_number)}"
  puts "Bob's shared secret: #{bob.send(:shared_secret, partial_shared_secret_of_alice, session.high_prime_number)}"
end.call
