module DeviseHelper
  def devise_error_messages!
   return '' if resource.errors.empty?
 
    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg, class: 'text-red-500 list-none') }.join
    sentence = I18n.t('errors.messages.not_saved',
    count: resource.errors.count,
    resource: resource.class.model_name.human.downcase)
 
    html = <<-HTML
    <div class="p-4 mb-4 text-sm text-gray-500 bg-white rounded-lg shadow dark:text-gray-400 dark:bg-gray-600 border-2 border-rose-500" role="alert">
     #{messages}
    </div>
    HTML
 
    html.html_safe
  end
 end 