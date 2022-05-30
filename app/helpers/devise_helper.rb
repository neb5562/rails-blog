module DeviseHelper
  def devise_error_messages!
   return '' if resource.errors.empty?
 
    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg, class: 'text-red-700 list-none') }.join
    sentence = I18n.t('errors.messages.not_saved',
    count: resource.errors.count,
    resource: resource.class.model_name.human.downcase)
 
    html = <<-HTML
    <div class="p-4 mb-4 text-sm text-red-700 bg-red-100 rounded-lg dark:bg-red-200 dark:text-red-800" role="alert">
     #{messages}
    </div>
    HTML
 
    html.html_safe
  end
 end