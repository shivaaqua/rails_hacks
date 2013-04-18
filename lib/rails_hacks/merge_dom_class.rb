# allows you to merge the :class option without overwriting what classes were passed
# 
# Example:
#   def menu_item(text, options = {})
#     options.merge_dom_class!('will-be-merged')
#     content_tag :li, text, options
#   end
#
#   menu_item 'foo', :class => 'bar' # => <li class="bar will-be-merged">foo</li>
#
# NOTE: merge_dom_class! does not check for duplicates. try this: hash[:class] = hash.merge_dom_class!('foo bar')[:class].split.uniq.join ' '
module MergeDomClass
  def merge_dom_class!(dom_class)
    self.merge! :class => (self[:class] ? self[:class] + ' ' : '') + dom_class.to_s
  end
end

Hash.send :include, MergeDomClass
HashWithIndifferentAccess.send :include, MergeDomClass

