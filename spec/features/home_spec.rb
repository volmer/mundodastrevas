require 'rails_helper'

describe 'Home', type: :feature do
  it 'is available' do
    visit root_path

    expect(page).to have_content('Mundo das Trevas')
    expect(page).to have_content('Nos fóruns')
    expect(page).to have_content('Posts recentes')
    expect(page).to have_content('Comentários')
  end
end
