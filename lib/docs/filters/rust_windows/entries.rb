module Docs
  class RustWindows
    class EntriesFilter < Docs::EntriesFilter
      def get_name
        name = at_css("h1.fqn .in-band").content.remove(/\A.+\s/).remove("⎘")
        mod = slug.split("/").first
        path = name.split("::")

        # puts "get_name: " + path.last
        path.last
      end

      PRIMITIVE_SLUG = /\A(\w+)\/(primitive)\./

      def get_type
        heading = at_css("h1.fqn .in-band").content.strip
        path = heading.split("::")[1..]
        if path.length > 1
          # if heading.start_with?("Module")
          # else
          #   result = path[..-2].join("::")
          # end
          result = "Module - " + path[..-2].join("::")

          # puts "2: " + result
          result
        else
          result = "windows"

          # puts "3: " + result
          result
        end
      end

      def additional_entries
        css(".method")
          .each_with_object({}) { |node, entries|
          name = node.at_css(".fnname").try(:content)
          next unless name
          name.prepend "#{self.name}::"
          entries[name] ||= [name, node["id"]]
        }.values
      end
    end
  end
end
