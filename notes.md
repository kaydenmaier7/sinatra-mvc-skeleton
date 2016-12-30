Authentication Steps:

1. Create User model:
  be rake generate:model NAME-USER
2. Include Bcrypt format:
  https://github.com/codahale/bcrypt-ruby
3. Write Validations:
  validates_presence_of
  validates_uniqueness_of
4. Update password_hash

