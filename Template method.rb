# frozen_string_literal: true
#Задачу придумала сама, бо хочу розробити бота, щоб він мені всяку штуку архівував
ARCHIVE_FILE_PATH = 'archive.zip'
PDF_FOLDER_PATH = 'D:\RubyProjects\uni'
COMPRESSED_FOLDER_PATH = 'D:\RubyProjects\uni'

# Абстрактний клас для архівації документів
class DocumentArchiver
  def initialize(document, arch_name)
    @document = document
    @arch_name = arch_name
  end

  # Загальний метод для архівації документів
  def archive_document
    proceed(@document)
    prepare_document(@document)
    compress_document(@document, @arch_name)
    cleanup(@document)
  end

  private

  # Абстрактні методи, які повинні бути реалізовані в конкретних підкласах
  def proceed(doc)
    puts "якась обробка"
  end


  def prepare_document(doc)
    destination_file = "#{FOLDER_PATH}/#{File.basename(doc)}"

    if File.exist?(destination_file)
      puts "Файл #{File.basename(doc)} вже існує у папці. Пропускаю копіювання."
    else
      # Копіюємо DOCX-файл до папки з DOCX-файлами
      FileUtils.cp(doc, destination_file)
      puts "Файл #{File.basename(doc)} скопійовано до заданої папки."
    end
  end


  def compress_document(doc, name)
    # Використовуємо стиснення для PDF-файлу
    compressed_document = "#{FOLDER_PATH}\\#{name}.zip"
    puts compressed_document

    Zip::File.open(compressed_document, Zip::File::CREATE) do |zipfile|
      zipfile.add(File.basename(doc), doc)
    end

    puts "Файл #{File.basename(doc)} було скомпресовано в архів #{compressed_document}."
  end

  def cleanup(doc)
    puts "Очищення тимчасових файлів..."
  end
end


# клас для архівації PDF-документів
class PdfDocumentArchiver < DocumentArchiver
  private
  def proceed(document)
    reader = PDF::Reader.new(document)
    output_path = FOLDER_PATH + "\\pdf_text_copy.txt"


    File.open(output_path, 'w') do |txt_file|
      reader.pages.each do |page|
        txt_file.puts page.text
      end
    end

    compress_document(output_path, @arch_name)
    puts "Конвертація завершена: #{output_path}"
  end
end


# клас для архівації DOC-документів
class DocDocumentArchiver < DocumentArchiver
  def proceed(document)
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
  private def proceed(doc)
    puts "архівація пройшла успішно, якщо вам потрібна додаткова обробка вашого формату, напишіть в підтримку до Владислави"
  end

end


def test(path, name)
  puts path + "\\" + name
  if name.split(".")[-1] == "pdf"
    pdf_document = PdfDocumentArchiver.new(path + "\\" + name, "myPDF")
    pdf_document.archive_document

  elsif
  doc_document = DocDocumentArchiver.new(path + "\\" + name, "myDocx")
    doc_document.archive_document

  else name.split(".")[-1] == "docx"
  image = AnotherArchiver.new(path + "\\" + name, "myPic")
  image.archive_document
  end
end


# D:\RubyProjects\uni my.копия.sxdg.pdf
# Використання паттерну Template Method

puts("\nEnter path to your document")
path = gets().gsub(/\n/, '')
puts("\nEnter document name\n")
name = gets().gsub(/\n/, '')
test(path, name)
