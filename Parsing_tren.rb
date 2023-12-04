# frozen_string_literal: true
require 'nokogiri'
require 'open-uri'
require 'csv'

def google_search(link)
  begin
    doc = Nokogiri::HTML(URI.open(link))
    puts "Page Title: #{doc.title}"

    puts "Header Columns"
    doc.css(".column").each_with_index do |column, index|
      headings = column.css(".heading").text
      if headings.empty?
        break
      end
      puts "#{index+1} heading: " + headings

      titles = column.css("li a")
      titles.each_with_index do |title, index|
        puts "    #{index+1} subheading: " + title.text
      end
    end

    puts "\n\nPage links:"
    data = []
    doc.css(".column1 ul li a").each_with_index do |l, index|
      puts "#{index+1}. " + l.content
      puts "link: " + l['href'] + "\n\n"
      data << [index + 1, l.content, l['href']]
    end

    # Write data to CSV file
    CSV.open('output.csv', 'w') do |csv|
      csv << ['Index', 'Content', 'Link']
      data.each { |row| csv << row }
    end

  rescue StandardError => e
    puts "Error: #{e.message}"
  end
end

google_search("https://www.hospitalsafetygrade.org/all-hospitals")
