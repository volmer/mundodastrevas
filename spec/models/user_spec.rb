require 'rails_helper'

describe Raddar::User do
  it { is_expected.to have_many(:zines).class_name('Zine').dependent(:destroy) }
  it { is_expected.to have_many(:posts).class_name('Post').dependent(:destroy) }
  it { is_expected.to have_many(:comments).class_name('Comment').dependent(:destroy) }
end
