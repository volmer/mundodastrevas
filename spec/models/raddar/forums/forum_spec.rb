require 'rails_helper'

describe Raddar::Forums::Forum do
  it { should belong_to(:universe) }
end
