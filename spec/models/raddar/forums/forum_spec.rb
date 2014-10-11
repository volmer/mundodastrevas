require 'rails_helper'

describe Raddar::Forums::Forum do
  it { is_expected.to belong_to(:universe) }
end
