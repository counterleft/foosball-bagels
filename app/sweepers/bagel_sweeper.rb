class BagelSweeper < ActionController::Caching::Sweeper
  observe Bagel
  
  def after_create(bagel)
    expire_cache_for(bagel)
  end

  def after_update(bagel)
    expire_cache_for(bagel)
  end

  def after_destroy(bagel)
    expire_cache_for(bagel)
  end

  private
  def expire_cache_for(bagel)
    expire_page :controller => 'players', :action => 'index'
    expire_page :controller => 'bagels', :action => 'index'
  end
end