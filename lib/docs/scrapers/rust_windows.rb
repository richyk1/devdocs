# frozen_string_literal: true

module Docs
  class RustWindows < UrlScraper
    self.type = "rust_windows"
    self.release = "1.58.1"
    self.base_url = "https://microsoft.github.io/windows-docs-rs/doc/windows/"
    self.root_path = "index.html"
    # self.initial_paths = %w(
    #   reference/introduction.html
    #   std/index.html
    #   error-index.html)
    self.links = {
      home: "https://www.rust-lang.org/",
      code: "https://github.com/rust-lang/rust",
    }

    html_filters.push "rust_windows/entries", "rust_windows/clean_html"

    # Limit amoutn of Windows packages to crawl
    # options[:only_patterns] = [
    #   /\A(Win32\/)(index.html|System\/index.html|System\/Threading\/index.html|System\/Threading\/fn.C)/,
    # ]
    options[:only_patterns] = [
      /\A(Win32\/)(index.html|System)/,
    ]

    options[:skip_patterns] = [/(all\.html)/]

    options[:attribution] = <<-HTML
      &copy; 2010 The Rust Project Developers<br>
      Licensed under the Apache License, Version 2.0 or the MIT license, at your option.
    HTML

    def get_latest_version(opts)
      doc = fetch_doc("https://www.rust-lang.org/", opts)
      label = doc.at_css(".button-download + p > a").content
      label.sub(/Version /, "")
    end

    private

    REDIRECT_RGX = /http-equiv="refresh"/i
    NOT_FOUND_RGX = /<title>Not Found<\/title>/

    def process_response?(response)
      !(response.body =~ REDIRECT_RGX || response.body =~ NOT_FOUND_RGX || response.body.blank?)
    end
  end
end
