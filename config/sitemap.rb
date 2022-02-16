# frozen_string_literal: true

require 'aws-sdk-s3'
# Set the host name for URL creation

SitemapGenerator::Sitemap.default_host = 'https://recreation.everyplus.jp'
if Rails.env.production?
  SitemapGenerator::Sitemap.default_host = 'https://recreation.everyplus.jp'
  SitemapGenerator::Sitemap.sitemaps_host = "https://s3-ap-northeast-1.amazonaws.com/#{ENV['AWS_BUCKET']}"
  SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'

  SitemapGenerator::Sitemap.adapter = SitemapGenerator::AwsSdkAdapter.new(
    ENV['AWS_BUCKET'],
    aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
    aws_region: ENV['AWS_REGION']
  )

  SitemapGenerator::Sitemap.create do
    add root_path, priority: 1.0, changefreq: 'daily'

    add customers_recreations_path, priority: 0.8, changefreq: 'weekly'
    Recreation.find_each do |rec|
      add customers_recreation_path(rec.id), lastmod: rec.updated_at, priority: 0.8
    end
  end
end
