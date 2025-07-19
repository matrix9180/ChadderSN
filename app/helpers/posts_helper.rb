module PostsHelper
  def content_with_hashtag_links(content)
    content.gsub(/(?:^|\s)#(\w+)/) do |match|
      hashtag_name = $1.downcase
      if Hashtag.exists?(name: hashtag_name)
        # Preserve the original whitespace or beginning of line
        prefix = match.start_with?("#") ? "" : match[0]
        "#{prefix}#{link_to("##{hashtag_name}", hashtag_path(hashtag_name), class: 'text-primary hover:text-primary-focus')}"
      else
        match
      end
    end.html_safe
  end
end
