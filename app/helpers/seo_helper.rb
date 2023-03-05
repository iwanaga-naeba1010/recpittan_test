# frozen_string_literal: true

module SeoHelper
  SITE_NAME = I18n.t('site.name')
  SITE_TITLE = I18n.t('site.title')
  SITE_DESCRIPTION = I18n.t('site.description')
  SITE_KEYWORDS = I18n.t('site.keywords')

  def default_meta_tags
    {
      title: SITE_TITLE,
      charset: 'utf-8',
      description: SITE_DESCRIPTION,
      keywords: SITE_KEYWORDS,
      canonical: request.original_url,
      og: {
        site_name: SITE_NAME,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        # TODO: 後で画像を設定
        image: "#{root_url}/about.png",
        local: 'ja-JP',
      },
      twitter: {
        title: :title,
        description: :description,
        card: 'summary_large_image',
        # site: '@gimejob',
        # image: "#{root_url}/about.png"
      }
    }
  end

  def meta_tags_each_page(title, description, keywords, image_src)
    title ||= SITE_TITLE if title.blank?
    description ||= SITE_DESCRIPTION if description.blank?
    keywords ||= SITE_KEYWORDS if keywords.blank?
    image_src ||= "#{root_url}/about.png" if image_src.blank?
    set_meta_tags(
      title:, description:, keywords:, image_src:,
      og: { image: image_src }, twitter: { image: image_src }
    )
  end
end
