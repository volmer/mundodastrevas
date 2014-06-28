require 'rails_helper'

describe Raddar::Zines::Zine do
  it { should belong_to(:universe) }
end
