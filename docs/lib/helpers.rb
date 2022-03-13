module SiteHelpers
  def chapters
    data = YAML.load(File.read("./content/index.yml"))
    data["chapters"]
  end

  def first_chapter
    chapters[0]
  end
end

use_helper SiteHelpers
