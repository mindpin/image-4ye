require "image-4ye/version"
require "rest_client"
require "tempfile"
require "securerandom"

class Image4ye
  BASE       = "http://img.4ye.me"
  UPLOAD_URL = File.join(BASE, "api/upload")

  # 上传图片文件并返回包装类实例
  #
  # @param file [File] 待上传图片的`File'对象
  # @return [Image4ye]
  def self.upload(file)
    res = RestClient.post(UPLOAD_URL, :file => file)

    self.new(JSON.parse(res)["url"])
  end

  # 实例化Image
  #
  # @param url [String] 图片url
  # @return [Image4ye]
  def initialize(url)
    @url = url
  end

  # 生成带参数的url
  #
  # @param config 图片尺寸控制参数
  #    :height [Integer] 图片高
  #    :width [Integer] 图片宽
  #    :crop [Boolean] 是否裁切
  #    如果传 width 参数，url 中包含 xxxw 部分
  #    如果传 height 参数，url 中包含 xxxh 部分
  #    如果传 :crop => true，url 末尾包含 1e_1c
  #    不指定 width 和 height 的情况下，不可指定 :crop => true
  #    最后生成的 url 参数是:
  #    @{:width}w_{:height}h{:crop?'_1e_1c':''}.{文件扩展名 png/jpg 等}
  # 具体的 URL 规则参考 https://github.com/mindpin/image-service/wiki
  # @return [String] 图片url
  def url(config = {})
    return @url if config.empty?

    h = config[:height] ? "#{config[:height]}h" : ""
    w = config[:width]  ? "#{config[:width]}w"  : ""
    c = config[:crop]   ? "1e_1c"               : ""

    "#{url}@#{[h, w, c].join("_")}"
  end

  # 下载指定参数的图片并保存在一个`Tempfile'对象
  #
  # config 参数作用同 url 方法
  # @yield [file] 参数为`Tempfile'对象的block
  # @return [Tempfile] 返回`Tempfile(closed)'对象
  def download(config, &block)
    file = Tempfile.new(SecureRandom.hex(4))
    file.write(RestClient.get(url(config)))
    block.call(file)
    file.close
    file
  ensure
    file.close if file
  end
end
