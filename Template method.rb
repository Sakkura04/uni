# frozen_string_literal: true
#Задачу придумала сама, бо хочу розробити бота, щоб він мені всяку штуку архівував


# Абстрактний клас для архівації документів
class DocumentArchiver
  def initialize(document)
    @document = document
  end

  # Загальний метод для архівації документів
  def archive_document
    prepare_document
    compress_document
    store_document
    cleanup
  end

  private

  # Абстрактні методи, які повинні бути реалізовані в конкретних підкласах
  def prepare_document
    raise NotImplementedError, "#{self.class} має реалізувати метод prepare_document"
  end

  def compress_document
    raise NotImplementedError, "#{self.class} має реалізувати метод compress_document"
  end

  def store_document
    raise NotImplementedError, "#{self.class} має реалізувати метод store_document"
  end

  def cleanup
    puts "Очищення тимчасових файлів..."
  end
end


# клас для архівації PDF-документів
class PdfDocumentArchiver < DocumentArchiver
  private

  def prepare_document
    puts "Підготовка PDF-документа для архівації..."
  end

  def compress_document
    puts "Стискання PDF-документа..."
  end

  def store_document
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
