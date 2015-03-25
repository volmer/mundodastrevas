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

  describe '#admin_thead' do
    before do
      params[:controller] = 'admin/zines'
      params[:action] = 'index'
    end

    it 'is a link to the current page with order params' do
      expect(helper.admin_thead(Zine, 'description')).to eq(
        '<a href="/admin/zines?order%5Bdescription%5D=asc">Descrição</a>'
      )
    end

    it 'inverts the order direction if the param is already in use' do
      params[:order] = { 'description' => 'asc' }
      expect(helper.admin_thead(Zine, 'description')).to eq(
        '<a href="/admin/zines?order%5Bdescription%5D=desc">Descrição</a>'
      )

      params[:order] = { 'description' => 'desc' }
      expect(helper.admin_thead(Zine, 'description')).to eq(
        '<a href="/admin/zines?order%5Bdescription%5D=asc">Descrição</a>'
      )
    end
  end
end
