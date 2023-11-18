namespace :book do
  book_source = 'steadfast.asciidoc'
  # Can add --timings, --verbose, etc. here.
  # See https://docs.asciidoctor.org/asciidoctor/latest/cli/man1/asciidoctor/
  params = "--attribute build_date_time='#{ENV["BUILD_DATE_TIME"]}' --attribute build_git_commit='#{ENV["BUILD_GIT_COMMIT"]}' --attribute build_os_release='#{ENV["BUILD_OS_RELEASE"]}' --warnings --trace"

  desc 'build and check all book outputs'
  task :build => [:build_html, :build_epub, :build_fb2, :build_mobi, :build_pdf] do
	# TODO: re-enable. - disabled at Thu Nov 16 01:36:29 PM PST 2023
	#Rake::Task['book:check'].invoke
	
	# Rescue to ignore checking errors
	rescue => e
	puts e.message
	puts 'Error when checking books (ignored)'
  end

  desc 'build HTML output'
  task :build_html => book_source do
	sh "bundle exec asciidoctor #{params} -a data-uri #{book_source}"
  end

  desc 'build Epub output'
  task :build_epub => book_source do
	sh "bundle exec asciidoctor-epub3 #{params} #{book_source}"
  end

  desc 'build FB2 output'
  task :build_fb2 => book_source do
	sh "bundle exec asciidoctor-fb2 #{params} #{book_source}"
  end

  desc 'build Mobi output'
  task :build_mobi => book_source do
	# Mobi (kf8)
	sh "bundle exec asciidoctor-epub3 #{params} -a ebook-format=kf8 #{book_source}"
  end

  desc 'build PDF output'
  task :build_pdf => book_source do
	sh "bundle exec asciidoctor-pdf #{params} #{book_source}"
  end

  desc 'Check generated books'
  task :check => [:build_html, :build_epub] do
	sh 'htmlproofer steadfast.html'
	sh 'epubcheck steadfast.epub'
  end

end

task :default => 'book:build'