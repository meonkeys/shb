class ExtendedPDFConverter < (Asciidoctor::Converter.for 'pdf')
  register_for 'pdf'

  # see https://docs.asciidoctor.org/pdf-converter/latest/extend/use-cases/#chapter-image
  def ink_chapter_title sect, title, opts
    image_attrs = { 'target' => 'chapter-break.png', 'pdfwidth' => '100%' }
    image_block = ::Asciidoctor::Block.new sect.document, :image, content_model: :empty, attributes: image_attrs
    convert_image image_block, relative_to_imagesdir: true, pinned: true
    super
  end

  # Add one invisible character to pages only containing running content.
  # This allows using `media: prepress` with some printers that don't like these sorta empty pages (e.g. Lulu).
  #
  # per Dan Allen:
  # > The likely culprit is the running content on otherwise empty pages.
  # > It's possible their analyzer thinks that is invalid for some reason (if it only sees a PDF stamp, which is what the running content is).
  #
  # See also:
  # * discussion https://asciidoctor.zulipchat.com/#narrow/stream/288690-users.2Fasciidoctor-pdf/topic/syntax.20error.20with.20prepress.20PDF.20on.20Lulu
  # * https://github.com/asciidoctor/asciidoctor-pdf/issues/2476
  # * https://github.com/asciidoctor/asciidoctor-pdf/issues/2477
  def ink_running_content(*)
    (1..page_count).each do |pgnum|
      go_to_page pgnum
      update_colors if graphic_state.color_space.empty?
    end
    super
  end
end

# Allow long words to wrap at slashes.
#
# See: https://asciidoctor.zulipchat.com/#narrow/stream/288690-users.2Fasciidoctor-pdf/topic/.E2.9C.94.20wrapping.20long.20words.3A.20break.20at.20slash
Prawn::Text::Formatted::LineWrap.prepend (Module.new do
  def break_chars(*)
    '/' + super
  end

  def word_division_scan_pattern(*)
    Regexp.union super, /\//
  end

  def scan_pattern(*)
    Regexp.union super, /\//
  end
end)
