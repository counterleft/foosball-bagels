class PlayerSweeper < ActionController::Caching::Sweeper
  observe Player

  def after_create(player)
    expire_cache_for(player)
  end

  def after_update(player)
    expire_cache_for(player)
  end

  def after_destroy(player)
    expire_cache_for(player)
  end

  private
  def expire_cache_for(player)
    expire_page :controller => 'players', :action => 'index'
    expire_page :controller => 'bagels', :action => 'index'
  end
end