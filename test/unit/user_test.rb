require 'test_helper'

class UserTest < ActiveSupport::TestCase
	test "a user should enter a first name" do
		user = User.new
		assert !user.save #user shouldn't be saved into database
		assert !user.errors[:first_name].empty?
	end

	test "a user should enter a last name" do
		user = User.new
		assert !user.save #user shouldn't be saved into database
		assert !user.errors[:last_name].empty?
	end

	test "a user should enter a profile name" do
		user = User.new
		assert !user.save #user shouldn't be saved into database
		assert !user.errors[:profile_name].empty?
	end

	test "a user should have a unique profile name" do
		user = User.new
		user.profile_name = users(:antonio).profile_name
		assert !user.save
		puts user.errors.inspect
		assert !user.errors[:profile_name].empty?
	end

	test "a user should have a profile name without spaces" do
		user = User.new(first_name: 'Antonio', last_name: 'Zdelican', email: 'anotnio1@gmail.com')
		user.password = user.password_confirmation = 'asdfasdf'

		user.profile_name = "My Profile Spaces"

		assert !user.save
		assert !user.errors[:profile_name].empty?
		assert user.errors[:profile_name].include?("Must be formatted correctly.")
	end

	test "a user can have a correctly formatted profile name" do
		user = User.new(first_name: 'Antonio', last_name: 'Zdelican', email: 'anotnio1@gmail.com')
		user.password = user.password_confirmation = 'asdfasdf'

		user.profile_name = 'anotnio_1'
		assert user.valid?
	end
end
