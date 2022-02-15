# frozen_string_literal: true

module Docs
  class RustWindows
    class CleanHtmlFilter < Filter
      def call
        if slug == "index"
          @doc = at_css("#main-content")
          css("button").remove

          windows_a_tag = css(".in-band").children[1]
          windows_a_tag.replace(windows_a_tag.text)

          css(".out-of-band").remove

          details_tag = css(".rustdoc-toggle.top-doc")[0]
          inner_p_tag = details_tag.children[1]
          details_tag.replace(inner_p_tag)

          css("#modules").children[0].replace(css("#modules").children[0].text)

          # css(".item-row:not(:first-child)").remove

          doc
        else
          @doc = at_css("#main-content")
          css("button").remove
          css("#modules").remove
          css("span.out-of-band").remove
          css("details.rustdoc-toggle.top-doc").attr("open", true)

          # css("pre > code").each do |node|
          #   node.parent["data-language"] = "rust" if node["class"] && node["class"].include?("rust")
          #   node.before(node.children).remove
          # end

          css("pre").each do |node|
            # node.content = node.content
            # node["data-language"] = "rust" if node["class"] && node["class"].include?("rust")
          end

          # doc.first_element_child.name = "h1" if doc.first_element_child.name = "h2"
          # at_css("h1").content = "Rust Documentation" if root_page?

          # css("code.content").each do |node|
          #   node.name = "pre"
          #   node.css(".fmt-newline").each do |line|
          #     line.inner_html = line.inner_html + "\n"
          #   end
          #   node.inner_html = node.inner_html.gsub("<br>", "\n")
          #   node.content = node.content
          # end

          doc
        end
      end
    end
  end
end
