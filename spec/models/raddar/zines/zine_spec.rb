require 'rails_helper'

describe Raddar::Zines::Zine do
  it { is_expected.to belong_to(:universe) }
end
