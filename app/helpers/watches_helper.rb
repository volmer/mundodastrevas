module WatchesHelper
  def watch_button(watchable, user, watchable_path = nil)
    watch = watchable.watches.find_or_initialize_by(user: user)
    watchable_path = url_for(watchable) if watchable_path.blank?
    watch.active = !watch.active if watch.persisted?

    render 'watches/form',
           watchable: watchable,
           watchable_path: watchable_path,
           watch: watch
  end

  def fields_for_watch(form, watchable, user, label = nil)
    watch = watchable.watches.find_or_initialize_by(user: user)

    render 'watches/fields',
           form: form,
           watchable: watchable,
           label: label,
           watch: watch
  end
end
