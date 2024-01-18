class ExtendedPDFConverter < (Asciidoctor::Converter.for 'pdf')
  register_for 'pdf'

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
