# frozen_string_literal: true
#Задачу придумала сама, бо хочу розробити бота, щоб він мені всяку штуку архівував
ARCHIVE_FILE_PATH = 'archive.zip'
PDF_FOLDER_PATH = 'D:\RubyProjects\uni'
COMPRESSED_FOLDER_PATH = 'D:\RubyProjects\uni'

# Абстрактний клас для архівації документів
class DocumentArchiver
  def initialize(document)
    @document = document
  end

  # Загальний метод для архівації документів
  def archive_document
    prepare_document(@document)
    compress_document(@document)
    store_document(@document)
    cleanup(@document)
  end

  private

  # Абстрактні методи, які повинні бути реалізовані в конкретних підкласах
  def prepare_document(doc)
    raise NotImplementedError, "#{self.class} має реалізувати метод prepare_document"
  end

  def compress_document(doc)
    raise NotImplementedError, "#{self.class} має реалізувати метод compress_document"
  end

  def store_document(doc)
    raise NotImplementedError, "#{self.class} має реалізувати метод store_document"
  end

  def cleanup(doc)
    puts "Очищення тимчасових файлів..."
  end
end


# клас для архівації PDF-документів
class PdfDocumentArchiver < DocumentArchiver
  private

  def prepare_document(doc)
    destination_file = "#{PDF_FOLDER_PATH}/#{File.basename(doc)}"

    if File.exist?(destination_file)
      puts "Файл #{File.basename(doc)} вже існує у папці. Пропускаю копіювання."
    else
      FileUtils.cp(doc, destination_file)
      puts "Файл #{File.basename(doc)} скопійовано до папки з PDF-файлами."
    end
  end

  def compress_document(doc)
    # Використовуємо стиснення для PDF-файлу
    compressed_document = "#{COMPRESSED_FOLDER_PATH}/#{File.basename(doc, '.pdf')}.zip"

    Zip::File.open(compressed_document, Zip::File::CREATE) do |zipfile|
      zipfile.add(File.basename(document), document)
    end

    compressed_document
  end

  def store_document(doc)
    puts "Збереження архівованого PDF-документа..."
  end
end


# клас для архівації DOC-документів
class DocDocumentArchiver < DocumentArchiver
  private

  def prepare_document
    puts "Підготовка DOC-документа для архівації..."
  end

  def compress_document
    puts "Стискання DOC-документа..."
  end

  def store_document
    puts "Збереження архівованого DOC-документа..."
  end
end


# Конкретний клас для архівації зображень
class ImageArchiver < DocumentArchiver
  private

  def prepare_document
    puts "Підготовка зображення для архівації..."
  end

  def compress_document
    puts "Стискання зображення..."
  end

  def store_document
    puts "Збереження архівованого зображення..."
  end
end


# Використання паттерну Template Method
pdf_document = PdfDocumentArchiver.new("my.pdf")
pdf_document.archive_document

doc_document = DocDocumentArchiver.new("my.doc")
doc_document.archive_document

image = ImageArchiver.new("image.png")
image.archive_document
