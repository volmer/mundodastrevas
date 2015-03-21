module SharedHelpers
  def path_to(page_name)
    send(page_name.split(/\s+/).push('path').join('_').to_sym)
  end
end

World(SharedHelpers)
