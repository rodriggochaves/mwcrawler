module Mwcrawler
  # Main api for crawling
  class Crawler
    include Mwcrawler

    SCRAPPERS = {
      courses: Courses,
      classes: Classes,
      departments: Departments
    }.freeze

    SCRAPPERS.keys.each do |method|
      define_method(method) do |campus = :darcy_ribeiro, options = { log: false }|
        Options.init(options)
        SCRAPPERS[method].scrap campus
      end
    end

    def semester
      page = Helpers.set_crawler(nil, 'graduacao/default.aspx', exact: true)
      page.css("a[title='Período Atual'] span").first.text
    end
  end
end
