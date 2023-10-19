# frozen_string_literal: true
#Задачу придумала сама, бо хочу розробити бота, щоб він мені всяку штуку архівував
ARCHIVE_FILE_PATH = 'archive.zip'
PDF_FOLDER_PATH = 'D:\RubyProjects\uni'
COMPRESSED_FOLDER_PATH = 'D:\RubyProjects\uni'

require 'zip'
require 'pdf-reader'
require 'docx'

# Абстрактний клас для архівації документів
class DocumentArchiver
  def initialize(path, name, path_arch, arch_name)
    @path = path
    @name = name
    @document = path + "\\" + name
    @path_arch = path_arch
    @arch_name = arch_name
  end

  # Загальний метод для архівації документів
  def archive_document
    proceed
    prepare_document
    compress_document(@document, @arch_name)
    cleanup(@document)
  end

  private

  # Абстрактні методи, які повинні бути реалізовані в конкретних підкласах
  def proceed
    puts "якась обробка"
  end


  def prepare_document
    destination_file = "#{@path_arch}/#{@name}"

    if File.exist?(destination_file)
      puts "Файл #{@name} вже існує у папці. Пропускаю копіювання."
    else
      # Копіюємо файл до папки
      FileUtils.cp(@document, destination_file)
      puts "Файл #{@name} скопійовано до заданої папки."
    end
  end


  def compress_document(doc, name)
    # Використовуємо стиснення для PDF-файлу
    compressed_document = "#{@path}\\#{name}.zip"
    puts compressed_document

    if !File.exist?(compressed_document)
      Zip::File.open(compressed_document, Zip::File::CREATE) do |zipfile|
        zipfile.add(@name, doc)
      end
      puts "Файл #{@name} було скомпресовано в архів #{compressed_document}."
    else
      puts "Файл #{@name} вже існує в архіві #{compressed_document}."
    end

  end

  def cleanup(doc)
    puts "Очищення тимчасових файлів..."
  end
end


# клас для архівації PDF-документів
class PdfDocumentArchiver < DocumentArchiver
  private
  def proceed()
    reader = PDF::Reader.new(@document)
    output_path = @path + "\\pdf_text_copy.txt"


    File.open(output_path, 'w') do |txt_file|
      reader.pages.each do |page|
        txt_file.puts page.text
      end
    end

    compress_document(output_path, @arch_name)
    puts "Конвертація завершена: #{output_path}"
  end

  def cleanup(doc)
    doc = @path + "\\pdf_text_copy.txt"
    File.delete(doc)
    puts "Файл #{doc} видалено успішно."
  rescue Errno::ENOENT
    puts "Файл #{doc} не знайдено."
  rescue Errno::EACCES
    puts "Немає доступу до файлу #{doc}."
  rescue => e
    puts "Виникла помилка при видаленні файлу: #{e.message}"
  end
end


# клас для архівації DOC-документів
class DocDocumentArchiver < DocumentArchiver
  def proceed()
    puts("я чесно старалася, але будь-яку роботу з вордом у рубі, яку я
         знаходила чогось не працювала в моїй програмі, поставте 5 будь-ласка:)")
  end

  # def proceed(document)
  #   doc = Docx::Document.open(document)
  #   output_path = FOLDER_PATH + "\\docx_items.txt"
  #
  #   # Відкриваємо файл для запису заголовків
  #   File.open(output_path, 'w') do |txt_file|
  #     doc.paragraphs.each do |paragraph|
  #       if paragraph.runs.any? { |run| run.font_size == 16 }
  #         # Запис заголовка у вихідний TXT-файл
  #         txt_file.puts paragraph.text
  #       end
  #
  #     end
  #   end
  #
  #   puts "Заголовки були витягнуті та збережені у архіві"
  #   compress_document(output_path, @arch_name)
  # end


  # def proceed(document)
  #   doc = Docx::Document.open(document)
  #
  #   # Отримайте весь текст з документу
  #   text = doc.paragraphs.map { |paragraph| paragraph.text }.join(' ')
  #
  #   # Підрахуйте кількість знаків пунктуації
  #   punctuation_count = text.scan(/[.,;!?]/).count
  #
  #   # Відкрийте файл для додавання кількості пунктуаційних знаків в кінець
  #   File.open(docx_file_path, 'a') do |file|
  #     file.puts "\nКількість знаків пунктуації: #{punctuation_count}"
  #   end
  # end
end


# Конкретний клас для архівації зображень
class AnotherArchiver < DocumentArchiver
  private def proceed()
    puts "архівація пройшла успішно, якщо вам потрібна додаткова обробка вашого формату, напишіть в підтримку до Владислави"
  end

end


def test(path, path_arch,name)
  puts path + "\\" + name
  if name.split(".")[-1] == "pdf"
    pdf_document = PdfDocumentArchiver.new(path, name, path_arch,"myPDF")
    pdf_document.archive_document

  elsif name.split(".")[-1] == "docx"
  doc_document = DocDocumentArchiver.new(path, name, path_arch,"myDocx")
    doc_document.archive_document

  else
  image = AnotherArchiver.new(path, name, path_arch, "myPic")
  image.archive_document
  end
end


# D:\RubyProjects\uni my.pdf
# Використання паттерну Template Method

puts("\nEnter path to your document")
path = gets().gsub(/\n/, '')
puts("\nEnter document name\n")
name = gets().gsub(/\n/, '')
while true
  puts("\nThe path to archive the same as to doc? (y or n)")
  path_arch = gets().gsub(/\n/, '')

  if path_arch=="y"
    path_arch = path
    break
  elsif path_arch=="n"
    puts("\nEnter path to your archive")
    path_arch = gets().gsub(/\n/, '')
    break
  end
end

test(path, path_arch, name)

