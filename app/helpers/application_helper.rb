module ApplicationHelper
  def csrf_inject
    (<<-HTML).html_safe
    <input type="hidden"
           name="authenticity_token"
           value=#{form_authenticity_token}>
    HTML
  end

  def url_h(obj, prefix = nil, singular = false)
    class_name = obj.class.name.downcase # User => 'users'
    class_name = class_name.pluralize unless singular # 'users'
    method_name = :"#{prefix ? prefix + "_" : ''}#{class_name}_url" # 'new_users_url'
    Rails.application.routes.url_helpers.send method_name, obj.id
  end

  def owns?(item)
    item.try(:user_id) == current_user.id
  end

  def render_heirarchy(heirarchy)
   return unless heirarchy
   html_string = "Posted To: "
   heirarchy.each do |elem|
     html_string += link_to elem.title, url_h(elem, nil, true)
     html_string += " | "
   end
   html_string.html_safe
 end

 def comment_tree(commentable, post_comments)
   children = post_comments.select do |elem|
     (elem.commentable_id == commentable.id) && (elem.commentable_type = commentable.class.name)
   end
   html="<li><pre>#{commentable.content}</pre>#{reply(commentable)}</li>"
   if children.empty?
     return html.html_safe
   else
     children.each do |comment|
       html+="<ul>"
       html+= comment_tree(comment, post_comments)
       html+="</ul>"
     end
     html.html_safe
   end
 end

 def reply(comment)
   link_to 'reply', comment_url(comment)
 end
end