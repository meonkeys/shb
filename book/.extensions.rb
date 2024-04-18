class ExtendedPDFConverter < (Asciidoctor::Converter.for 'pdf')
  register_for 'pdf'

  # Add an image at the start of each chapter.
  # see https://docs.asciidoctor.org/pdf-converter/latest/extend/use-cases/#chapter-image
  def ink_chapter_title sect, title, opts
    image_attrs = { 'target' => 'chapter-break.svg', 'pdfwidth' => '100%' }
    image_block = ::Asciidoctor::Block.new sect.document, :image, content_model: :empty, attributes: image_attrs
    convert_image image_block, relative_to_imagesdir: true, pinned: true
    super
  end
end
