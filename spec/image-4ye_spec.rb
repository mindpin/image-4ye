require "spec_helper"

describe Image4ye do
  let(:file)    {File.open("./spec/lambda.png", "rb")}
  let(:string)  {Base64.encode64 file.read}
  let(:pattern) {"http://img.teamkn.com/i"}
  let(:options) {{height: 100, width: 200, crop: true}}
  let(:url)     {"http://img.teamkn.com/i/NVQtmbKb.png"}

  describe "::upload" do
    context "when input is a File object" do
      subject {Image4ye.upload(file)}

      it {
        expect(subject).to be_an Image4ye
        expect(subject.url).to include pattern
      }
    end

    context "when input is a Base64 String" do
      subject {Image4ye.upload(string)}

      it {
        expect(subject).to be_an Image4ye
        expect(subject.url).to include pattern
      }
    end
  end

  describe "#url" do
    subject {Image4ye.new(url)}

    it {expect(subject.url(options)).to include "@100h_200w_1e_1c"}
  end

  describe "#download" do
    subject {Image4ye.new(url)}

    it {
      tempfile = subject.download(options) do |file|
        @file = file
        expect(file).to be_a Tempfile
      end

      expect(tempfile.closed?).to be true
    }
  end
end
