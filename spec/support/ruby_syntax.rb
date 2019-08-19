require 'ripper'

RSpec::Matchers.define :be_valid_as_ruby do
  match do |actual|
    !!Ripper.sexp(actual)
  end
end
