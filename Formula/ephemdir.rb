class Ephemdir < Formula
  include Language::Python::Virtualenv

  desc "Temporary directories that clean themselves up after a lifetime or on restart"
  homepage "https://github.com/vindfjur/ephemdir"
  url "https://files.pythonhosted.org/packages/d2/a8/7eafcf6da659e5c30483fd678da38e71be89546d1fdf0580024ae96a15c3/ephemdir-0.6.0.tar.gz"
  sha256 "1f202c198f54755117d807a9da3758b151d918145b768cfde0478e7b13f83c92"
  license "MIT"

  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "0.6.0", shell_output("#{bin}/ephemdir --version")
    created = shell_output("#{bin}/ephemdir new --lifetime 1h").strip
    assert_predicate Pathname.new(created), :directory?
    name = Pathname.new(created).basename.to_s
    assert_equal created, shell_output("#{bin}/ephemdir path #{name}").strip
    assert_match created, shell_output("#{bin}/ephemdir keep #{name}")
  end
end
