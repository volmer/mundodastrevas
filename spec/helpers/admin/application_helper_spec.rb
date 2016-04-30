require 'rails_helper'

describe Admin::ApplicationHelper, type: :helper do
  describe '#admin_list_item' do
    it 'is a li element with a link for the given domain' do
      expect(helper.admin_list_item(:users)).to eq(
        '<li><a href="/admin/users">Usuários</a></li>'
      )
    end

    it 'adds the active class if the given domain is the current' do
      params[:controller] = 'admin/zines'
      expect(helper.admin_list_item(:zines)).to include('class="active"')
    end
  end
end
