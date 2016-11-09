module ApplicationHelper
	class CodeRayify < Redcarpet::Render::HTML
	  def block_code(code, language)
	    CodeRay.scan(code, language).div
	  end
	end

	def markdown(text, language)
	  coderayified = CodeRayify.new(:filter_html => true, 
	                                :hard_wrap => true)
	  options = {
	    :fenced_code_blocks => true,
	    :no_intra_emphasis => true,
	    :autolink => true,
	    :strikethrough => true,
	    :lax_html_blocks => true,
	    :superscript => true
	  }
	  markdown_to_html = Redcarpet::Markdown.new(coderayified, options)
	  markdown_to_html.render(choose_language(language, text)).html_safe
	end

	def choose_language(language, code)
		labeled_code = String(code)
		return "```" + match_name_to_language_tag(language) + "\n" + labeled_code + "\n```"
	end

	def match_name_to_language_tag(language)
		case language
		when "C++"
			return 'cpp'
		when "Python"
			return 'python'
		when "C"
			return 'c'
		when "Java"
			return 'java'
		when "JavaScript"
		 	return 'javascript'
		when "Objective-C"
		 	return 'obj-c'
		else
			return 'python'
		end
	end

	def get_tags_for_user(user)
		tags = Set.new
		user.posts.each do |post|
		  post.tags.each do |tag|
		  	tags.add(tag.name)
		  end
		end
		return tags
	end
end
